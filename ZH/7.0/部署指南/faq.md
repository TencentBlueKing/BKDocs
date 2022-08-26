# 常见问题
## 常用排查命令（必知必会）
请先阅读官方文档：[应用故障排查 | Kubernetes](https://kubernetes.io/zh/docs/tasks/debug-application-cluster/debug-application/)
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
首先找到这些 pod 所属的 helmfile，此处为 `00-storage-elasticsearch.yaml.gotmpl`：
``` yaml
releases:
  - name: bk-elastic
    namespace: {{ .Values.namespace }}
    chart: ./charts/elasticsearch-{{ .Values.version.elasticsearch }}.tgz
    missingFileHandler: Warn
    version: {{ .Values.version.elasticsearch }}
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
然后卸载 release：
``` bash
helmfile -f 00-storage-elasticsearch.yaml.gotmpl destroy
```
然后重新创建：
``` bash
helmfile -f 00-storage-elasticsearch.yaml.gotmpl sync
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


## 错误案例

### helmfile 报错 Error: timed out waiting for the condition
在使用“一键脚本”或者 helmfile 命令时，出现报错：
``` bash
ERROR:
  exit status 1

EXIT STATUS
  1

STDERR:
  Error: timed out waiting for the condition

COMBINED OUTPUT:
  Release "bk-elastic" does not exist. Installing it now.
  Error: timed out waiting for the condition
```
这是因为 pod 启动超时。需要先在 中控机 执行如下命令查看哪些 pod 未能 Ready （取 `READY` 列含有 `0/`）：
``` bash
kubectl get pod -A | grep -wv Completed | grep -e "0/"
```

目前观察到如下类型的原因：
* pod 启动超时。
  * 表现：pod 为 `Running` 状态，但是 `RESTARTS` 列的计数大于 3 ，且 kubectl describe pod 显示的 Events 和 logs 均正常，helmfile destory 对应 release 后，再次 helmfile sync 问题依旧。
  * 解决办法： 手动修改 custom 文件，提高配额。详细步骤见 本文 “[调整 pod 的资源配额](faq.md#modify-pod-resources-limits)” 章节。
* pod 等待调度。
  * 表现：pod 一直为 `Pending` 状态。
  * 解决办法：kubectl describe pod 查看阻塞原因，然后逐层 kubectl describe 导致阻塞的资源追溯拥有。常见情况为资源（CPU、内存及 pvc 等）不足，可以通过扩容 node 解决此类问题。
* pod 启动失败。
  * 表现：pod 状态多次重启，状态为 `CrashLoopBackOff`。
  * 解决办法：一般为卸载不彻底，请参考 《[卸载](uninstall.md)》 文档操作。
* 镜像拉取超时。
  * 表现：在早期 kubectl describe pod 时可以看到 Events 显示 `Pulling image XXX`。如果发现较晚，则镜像可能拉取完毕，此时 kubectl get pod 无任何异常，且 pod 未曾重启过。
  * 解决办法：目前镜像策略都是复用现存镜像，可改用其他网络下载所需的镜像，然后导出为 tar 包，在上述 pod 所在的 node 导入。
* 拉取镜像失败。
  * 表现：kubectl get pod 显示 `ImagePullBackOff` 状态。kubectl describe pod 时可以看到 Events 显示 `Failed to pull image "镜像路径": rpc error: code = Unknown desc = Error response from daemon: manifest for 镜像路径 not found: manifest unknown: manifest unknown`。
  * 解决办法：此种情况请联系蓝鲸助手处理。


### 部署 SaaS 在“配置资源实例”阶段报错
首先查看 `engine-main` 这个应用对应 pod 的日志。根据错误日志提示，判断定位方向：
1. 检测 mysql，rabbitmq，redis 等「增强服务」的资源配置是否正确。`http://bkpaas.$BK_DOMAIN/backend/admin42/platform/plans/manage` （先登录才能访问）以及 `http://bkpaas.$BK_DOMAIN/backend/admin42/platform/pre-created-instances/manage` （先登录才能访问）。
2. 检查应用集群的 k8s 相关配置 token 是否正确。初次部署时会自动调用 `scripts/create_k8s_cluster_admin_for_paas3.sh` 脚本自动生成 token 等参数到 `./paas3_initial_cluster.yaml` 文件中。如果不正确，可以删除后这些账号和绑定后重建。

<a id="saas-deploy-prehook" name="saas-deploy-prehook"></a>

### 部署 SaaS 在“执行部署前置命令”阶段报错
检查对应 `app_code` 的日志。“执行部署前置命令” 对应着 `pre-release-hook` 容器。（如果容器不存在，则说明已经被自动清理，需重新开始部署才会出现。）

如下以 `bk_itsm` 为例：
``` bash
# kubectl logs -n bkapp-bk0us0itsm-prod pre-release-hook
Error from server (BadRequest): container "pre-release-hook" in pod "pre-release-hook" is waiting to start: trying and failing to pull image
```
可以看到失败原因是无法拉取镜像，然后我们可以检查容器：
``` bash
# kubectl describe pod -n bkapp-bk0us0itsm-prod pre-release-hook
Events:
  Type     Reason     Age                    From               Message
  ----     ------     ----                   ----               -------
  Normal   Scheduled  3m56s                  default-scheduler  Successfully assigned bkapp-bk0us0itsm-prod/pre-release-hook to node-10-0-1-3
  Normal   Pulling    2m24s (x4 over 3m56s)  kubelet            Pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.0-rc.399"
  Warning  Failed     2m24s (x4 over 3m55s)  kubelet            Failed to pull image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.0-rc.399": rpc error: code = Unknown desc = Error response from daemon: Get https://docker.bkce7.bktencent.com/v2/: dial tcp: lookup docker.bkce7.bktencent.com on 10.0.1.1:53: no such host
  Warning  Failed     2m24s (x4 over 3m55s)  ku：wqbelet            Error: ErrImagePull
  Normal   BackOff    2m10s (x6 over 3m55s)  kubelet            Back-off pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.0-rc.399"
  Warning  Failed     119s (x7 over 3m55s)   kubelet            Error: ImagePullBackOff
```
此处的报错是 `node-10-0-1-3` 解析 `docker.bkce7.bktencent.com` 失败。因此需要配置所用的 DNS 服务或者配置对应机器的 `/etc/hosts` 文件。


### node(s) didn't find available persistent volumes to bind
describe pod 发现报错：
``` plain
Volumes:
  storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  略
略
 Warning  FailedScheduling  3m  default-scheduler  0/5 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate, 4 node(s) didn't find available persistent volumes to bind.
```
先检查状态异常的 pvc：
``` bash
kubectl get pvc -A | grep -vw Bound
```
然后 describe pvc 了解异常原因：
``` bash
kubectl describe pvc -n 命名空间 pvc名称
```
然后我们需要根据 pvc 的错误信息查找对应的错误案例。


### waiting for pod to be scheduled
describe pvc 发现报错：
``` plain
 Normal  WaitForPodScheduled  32s (×15 over 4m)  persistentvolume-controller  waiting for pod 名称略 to be scheduled
```
需要 describe pod 检查不调度的原因，一般为目的 node 的 CPU 或 内存 配额不足。


### unbound immediate PersistentVolumeClaims
describe pod 发现报错：
``` plain
 Warning  FailedScheduling  3m  default-scheduler  0/5 nodes are available: 2 node(s) were unscheduledulable, 3 pod has unbound immediate PersistentVolumeClaims
```
需要 describe 异常 pvc 查看具体原因。


### no persistent volumes available for this claim and no storage class is set
describe pvc 发现报错：
``` plain
 Normal  FailedBinding  78s (×62 over 16m)  persistentvolume-controllor  no persistent volumes available for this claim and no storage class is set
```
请检查有无配置 `storageClass`：
``` bash
kubectl get sc
```
蓝鲸默认提供了 `localpv`:
``` bash
helmfile -f 00-localpv.yaml.gotmpl sync
```


### 无法查看 SaaS 日志

确认所使用的 k8s 集群，node 节点上，docker 的容器日志路径，和 values 中配置的是否相匹配。请参考前面文档。

### ImagePullBackOff 问题

pod 无法启动，状态是 `ImagePullBackOff`，一般是 image 地址问题。可以先查看各个 manifest 的 image 地址是否正确。

``` bash
helm get manifest release名 | grep image:
```


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
