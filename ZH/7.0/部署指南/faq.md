# 常见问题
## 问题排查
请务必先查看 k8s 官方文档：
* [集群故障排查](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-cluster/) | 英文版：[Troubleshooting Clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/)
* [应用故障排查](https://kubernetes.io/zh-cn/docs/tasks/debug/debug-application/) | 英文版：[Troubleshooting Applications](https://kubernetes.io/docs/tasks/debug/debug-application/)

常用排查命令：
1. 切换当前 context 的 namespace 到 `blueking` 。切换后，后面排查需要指定 `-n blueking` 的命令就可以省略了。
   ``` bash
   kubectl config set-context --current --namespace=blueking
   ```
2. 部署过程中，查看 pod 的变化情况：
	``` bash
	kubectl get pods -w
   ```
3. 查看 pod `PODNAME` 的日志：（如果 pod 日志非常多，加上 `--tail=行数` 防止刷屏）
	``` bash
	kubectl logs PODNAME -f --tail=20
	```
4. 删除 Completed 状态的 pod；然后查看 pod 状态不等于 `Running` 的：
	``` bash
   kubectl delete pod --field-selector=status.phase==Succeeded
	kubectl get pods --field-selector 'status.phase!=Running'
	```
	注意 job 任务生成的 pod，没有自动删除的且执行完毕的 pod，处于 `Completed` 状态。
5. pod 状态不是 `Running`，需要了解原因：
	``` bash
	kubectl describe pod PODNAME
	```
6. 有些 pod 的日志没有打印到 stdout，需要进入容器查看：
	``` bash
	kubectl exec -it PODNAME -- bash
	```
7. 为当前 bash 会话临时开启 `kubectl` 命令行补全：（标准配置方法请查阅 《[部署前置工作](prepare.md)》 里的 “配置 kubectl 命令行补全” 章节）
	``` bash
	source <(kubectl completion bash)
	```
8. 列出 base.yaml.gotmpl 这个 helmfile 里定义的 release：
   ``` bash
   helmfile -f base.yaml.gotmpl list
   ```
9.  卸载 helmfile 里定义的全部 release：
   ``` bash
   helmfile -f 00-BK_TEST.yaml.gotmpl destroy
   ```


## 调试及维护

### 安装 metrics-server

``` bash
helmfile -f 00-metrics-server.yaml.gotmpl sync
```

### 使用 ksniff 抓包

1. 安装 krew 插件包 https://krew.sigs.k8s.io/docs/user-guide/setup/install/
2. 使用 krew 安装 sniff 插件包 `kubectl krew install sniff`
3. 抓包。由于 apigateway 的 pod 默认没用开启特权模式，需要加上`-p`参数。
    ``` bash
    kubectl sniff -n blueking bk-apigateway-bk-esb-5655747b67-llnqj -p -f "port 80" -o esb.pcap
    ```


### 更改 BK_DOMAIN 后需要手动修改的地方

paas3 中的资源分配的域名：http://bkpaas.$BK_DOMAIN/backend/admin42/platform/plans/manage 修改 bkrepo 对应的域名地址。


### bkpaas3 里增加用户为管理员身份
若接入了自定义登录后没有 admin 账号，可以进入 `bkpaas3-apiserver-web` pod 执行如下命令添加其他管理员账号：
``` python
from bkpaas_auth.constants import ProviderType
from bkpaas_auth.models import user_id_encoder
from paasng.accounts.models import UserProfile

username="admin"
user_id = user_id_encoder.encode(ProviderType.BK.value, username)
UserProfile.objects.update_or_create(user=user_id, defaults={'role':4, 'enable_regions':'default'})
```


### bkpaas3 修改日志级别
apiserver 和 engine 模块都支持通过环境变量设置日志级别。

apiserver-main、apiserver-celery、engine-main、engine-celery ：编辑这些 Deployment，如：
``` bash
kubectl edit deployment apiserver-main
```
将 `DJANGO_LOG_LEVEL` 的值改为 `DEBUG`。


<a id="modify-pod-resources-limits" name="modify-pod-resources-limits" ></a>

### 调整 pod 的资源配额
蓝鲸为所有 Pod 设置了资源配额（ 见 `kubectl get pod -n NS POD_NAME -o json` 的 `.spec.containers[].resources.limits` 字段）。

这些配置项在腾讯云 `SA2.2XLARGE32` 实例上测试可用。当您的服务器 CPU 性能不足时，可能遇到无法启动的问题，此时需手动调整配额。

修改方法概述（详细操作见下方排查示例）：
1. 先找出疑似资源配额问题的 pod，规则为：kubectl get pod 显示的状态为 `Running` 但 `READY`列为 “0/N”，且 `RESTARTS` 列的值大于 3。
2. 找到 pod 所在的 helmfile 编排文件，确定 `values 文件` 和 `custom-values 文件` 的路径。
3. 基于 `values 文件` 中的模板，在 `custom-values 文件` 中覆盖 `.resources.limits` 的值。
4. 使用 helmfile destroy 命令卸载 release，然后 helmfile sync 命令创建。
5. 确认 pod 的资源配额已经生效： `kubectl get pod -n NS POD_NAME -o json | jq .spec.containers[].resources.limits`。如果 pod 依旧未能启动，可调整步骤 3 的值重试几次。

具体排查过程示例

假设 es 无法启动，初步检查发现 coordinating、master 和 data 运行了一段时间却未能 Ready ，且已重启多次：
``` text
bk-elastic-elasticsearch-coordinating-only-0       0/1  Running  4  4h56m
bk-elastic-elasticsearch-data-0                    0/1  Running  4  4h56m
bk-elastic-elasticsearch-master-0                  0/1  Running  4  4h56m
```
首先找到这些 pod 所属的 release（此处为 `bk-elastic`），然后在工作目录搜索 release 所在的 helmfile：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
grep *.yaml.gotmpl -we bk-elastic
```

可以发现是在 `base-storage.yaml.gotmpl` 中定义的：
``` yaml
releases:
略
  - name: bk-elastic
    namespace: {{ .Values.namespace }}
    chart: ./charts/elasticsearch-{{ .Values.version.elasticsearch }}.tgz
    missingFileHandler: Warn
    version: {{ .Values.version.elasticsearch }}
    condition: bitnamiElasticsearch.enabled
    values:
    - ./environments/default/elasticsearch-values.yaml.gotmpl
    - ./environments/default/elasticsearch-custom-values.yaml.gotmpl
```
可以看到 `.releases[].values` 里定义了 2 个文件，我们一般称为 `values 文件` 和 `custom-values 文件`。我们通过写入 custom-values 文件 实现对 values 的覆盖。

先检查 values 文件（`environments/default/elasticsearch-values.yaml.gotmpl` ），可以发现如下的片段：
``` yaml
master:
  resources:
    limits:
      cpu: 1000m
      memory: 1024Mi
#其他内容略
data:
  resources:
    limits:
      cpu: 1000m
      memory: 2048Mi
#其他内容略
coordinating:
  resources:
    limits:
      cpu: 1000m
      memory: 512Mi
```
将对应 pod 的 limits 值翻倍，在 中控机 工作目录 执行如下命令创建 custom-values 文件(`environments/default/elasticsearch-custom-values.yaml.gotmpl`)：
``` bash
cat > environments/default/elasticsearch-custom-values.yaml.gotmpl <<EOF
master:
  resources:
    limits:
      cpu: 2000m
      memory: 2048Mi
data:
  resources:
    limits:
      cpu: 2000m
      memory: 4096Mi
coordinating:
  resources:
    limits:
      cpu: 2000m
      memory: 1024Mi
EOF
```
然后卸载 release（此处以 `bk-elastic` 所在的 `base-storage.yaml.gotmpl` 文件为例）：
``` bash
helmfile -f base-storage.yaml.gotmpl destroy
```
然后重新创建（此处以 `bk-elastic` 所在的 `base-storage.yaml.gotmpl` 文件为例）：
``` bash
helmfile -f base-storage.yaml.gotmpl sync
```
检查 pod 是否生效：
``` bash
kubectl get pod -n blueking bk-elastic-elasticsearch-data-0 -o json | jq '.spec.containers[].resources.limits'
```
输出为下，与配置的值相符。
``` json
{
  "cpu": "2",
  "memory": "4Gi"
}
```
说明配置成功且已经生效。此时 pod 也成功启动，说明此前为资源不足所致。如果依旧未能启动，可以尝试继续扩大配额。


## 排查思路

### 模板渲染问题

使用 `helmfile` / `helm` 工具都是对原生 k8s 的描述文件的渲染封装。如果部署的结果不符合预期，需要定位，查看中间结果，有几种手段：

1. 先看 helmfile 合并各层 values 后生成的 values 文件：
   ``` bash
   helmfile -f 03-bkjob.yaml.gotmpl write-values --output-file-template bkjob-values.yaml
   ```
2. helmfile 安装时增加 `--debug` 参数
3. 查看已经部署的 release 的渲染结果：
   ``` bash
   helm get manifest release名
   helm get hooks release名
   ```

### Delete 删除资源卡住无响应时

查看 apiserver 的日志：
``` bash
kubectl logs -n kube-system kube-controller-manager-xxxxx | grep 资源名
```

如果是因为某个 pod 处于 `Terminating` 状态，可以强制删除：
``` bash
kubectl delete pod PODNAME --grace-period=0 --force --namespace NAMESPACE
```

### Pod 没有 Ready 如何查看
先查看 `readiness` 的探测命令（搜索 `readinessProbe` 段落，`podIP`，`containerPort` 字段）：
```bash
kubectl get pod PODNAME -o yaml
```
使用带 `curl` 命令的 pod 来模拟探测，观察输出。由于 pod 没有 `Ready`，所以不能通 k8s service name 来。需要用第一步的 podIP 来探测。
```bash
curl http://$POD_IP:$containerPort/health_check_path
```
