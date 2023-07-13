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
9. 卸载 helmfile 里定义的全部 release：
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


<a id="change-bk-domain" name="change-bk-domain" ></a>

### 更改访问域名

修改配置文件 `environments/default/custom.yaml`：
``` yaml
domain:
  bkDomain: 新域名
  bkMainSiteDomain: 新域名
```

更新 DNS，把旧域名改为新域名：
1. 修改 coredns：
   ``` bash
   EDITOR=vim kubectl edit -n kube-system cm coredns
   ```
2. 修改 中控机 的 DNS 解析或 hosts 文件。
3. 修改 全部 node 的 DNS 解析或 hosts 文件。
4. 修改用户侧 DNS 或者个人 PC 上的 hosts 文件。


数据库变更
>**提示**
>
>MySQL 连接方法见 《[访问入口及账户密码汇总](access.md)》文档，操作前请 **备份数据库**。

>**提示**
>
>如下 SQL 语句中，会包含 `BK_DOMAIN`（**新域名**） 及 `BK_DOMAIN_OLD`（**当前域名**） 等变量，请自行赋值。

1. 修改权限中心的回调 url：
   ``` sql
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE bkiam;
   UPDATE saas_system_info SET provider_config = REPLACE(provider_config, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE provider_config LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```
2. 变更桌面中的应用访问地址及图标：
   ``` sql
   -- 如果没有退出过mysql shell，可以跳过变量赋值
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE open_paas;
   UPDATE paas_app SET external_url = REPLACE(external_url, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE external_url LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   UPDATE paas_app SET logo = REPLACE(logo, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE logo LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```
3. 修改 API 网关中记录的 SDK 下载地址：
   ``` sql
   -- 如果没有退出过mysql shell，可以跳过变量赋值
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE bk_apigateway;
   UPDATE support_api_sdk SET url = REPLACE(url, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE url LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```

按批次重启蓝鲸基础套餐。
1. 重启第一批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=first sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,bk.repo.scope=backend'  # bkrepo 部分 pod 不会重启，主动删除等重建
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-apigateway,app.kubernetes.io/component in (api-support-fe, dashboard-fe)'  # bk-apigateway 部分 pod 不会重启，主动删除等重建
   ```
2. 重启第二批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
   ```
3. 持续观察等 bk-repo-repository pod 全部 `Ready`：
   ``` bash
   kubectl get pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,app.kubernetes.io/component=repository' -w
   ```
   然后重启第三批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=third sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-paas,app.kubernetes.io/name=webfe'  # bk-paas-webfe-web pod 不会重启，主动删除等重建
   ```
4. 重启第四批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-job,app.kubernetes.io/component in (job-file-worker, job-frontend, job-gateway, job-logsvr)'  # bk-job 多个 pod 不会重启，主动删除等重建
   ```
5. 重启第五批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync
   ```

重启增强套餐。如果部署了这些平台，则执行对应的命令重启：
* 容器管理平台：`helmfile -f 03-bcs.yaml.gotmpl sync`，如果提示 `PASSWORDS ERROR`，请参考部署文档修改 helmfile 模板后重试。
* 监控平台：`helmfile -f 04-bkmonitor.yaml.gotmpl sync`。
* 日志平台：`helmfile -f 04-bklog-search.yaml.gotmpl sync`。
* 持续集成平台-蓝盾：`helmfile -f 03-bkci.yaml.gotmpl sync`。


重新部署 SaaS。
1. 调整 **全部 node** 上的 docker 配置，更新 insecure registry 数组里的域名： `docker.$BK_DOMAIN` 。并 reload dockerd，并检查配置是否生效。具体操作见 [调整 node 上的 docker 服务](install-bkce.md#k8s-node-docker-insecure-registries)。
2. 访问蓝鲸桌面，打开 “开发者中心”。如果页面提示 “服务异常”，说明未能成功重启 `bkpaas3-webfe` pod，请再重启一次试试。
3. 在首页选择 SaaS （如“标准运维”），进入 “应用概览” 界面。
4. 如果 SaaS 有配置 “环境变量” 或 “访问入口”，需检查配置项中域名进行更新。“标准运维” 默认无相关配置，可忽略本步骤。
5. 在左侧选择 “应用引擎” —— “部署管理”。切换到 “生产环境” tab，点击“部署至生产环境”。在弹窗中勾选 “总在创建进程实例前拉取镜像”，点击“确定”开始部署。如果未重新部署，则更新入口后，访问应用会报错 “404 Not Found”。
6. 部署 SaaS 的其他模块。点击顶部 “模块” 进行切换，然后重复步骤 5。“标准运维” 还有 3 个模块需要部署。如果未重新部署模块，会导致 SaaS 工作异常。
7. 如有用到“预发布环境”，可一并部署。
8. 在左上角切换应用为 “流程服务”，重复步骤 4-7。其他 SaaS 依此类推。

配置变更：
1. 节点管理全局配置中，接入点可能配置了域名，请检查替换为新域名，或者改用 IP 端口访问。
2. PaaS 服务实例。使用 `admin` 账户登录蓝鲸桌面，打开 “开发者中心”。然后访问 `http://bkpaas.新域名/backend/admin42/platform/plans/manage`。
   * 编辑 `default-bk-repo` 服务，更新 **方案配置** 字段中 `endpoint_url` 地址中的域名。然后点“确定”保存。

最终检查。通过后则通知用户访问入口发生变更。
1. 检查 k8s ingress 注册的域名： `kubectl get ingress -A | grep -F 旧域名`，预期结果为空。
2. 使用新域名访问蓝鲸桌面，预期所有应用的图标可正常显示，点击应用也会是新域名的地址。
3. 检查 “权限中心” 能否打开。如果地址栏显示为旧域名，可能遗漏了重启 `bkpaas3-webfe` pod 操作。
4. 检查 “配置平台” 能否打开。如果地址栏显示为旧域名，可能没有变更 `open_paas` 数据库且重启 console pod。
5. 检查 “作业平台” 能否打开，以及历史任务查看有无异常。如果提示 `jobapi.新域名` 访问异常（HTTP 403），可能没有变更 `bkiam` 数据库并重启 job pod。
6. 检查“节点管理”能否正常安装 agent。
7. 检查“标准运维”及“流程服务”能否正常执行任务。
8. 检查其他平台访问是否正常。如果依旧存在旧域名，请在社区反馈。


### 添加用户为 PaaS Admin 角色
若接入了自定义登录后没有 admin 账号，或者禁用了内置的 `admin` 账户。导致访问 PaaS Admin 界面（地址以 `http://bkpaas.$BK_DOMAIN/backend/admin42/` 开头）时浏览器显示 403 Forbidden。

此时可以将其他用户设置为 PaaS 的 admin 角色。

在 中控机 执行如下命令进入 `paas-apiserver` 组件的 Django shell：
``` bash
kubectl exec -it -n blueking deploy/bkpaas3-apiserver-web web -- python manage.py shell
```
成功后会显示 `(InteractiveConsole)`，并出现 `>>>` 提示开始输入内容。

请分段粘贴如下代码，回车执行：
``` python
username="admin"  # 请先设置为要添加 paas admin 权限的用户名

from bkpaas_auth.core.constants import ProviderType
from bkpaas_auth.core.encoder import user_id_encoder
from paasng.accounts.models import UserProfile

user_id = user_id_encoder.encode(ProviderType.BK.value, username)
UserProfile.objects.update_or_create(user=user_id, defaults={'role':4, 'enable_regions':'default'})
```
最终显示 `(<UserProfile: 刚才填写的用户名-4>, True 或者 False)`，即为变更成功。如果抛出异常，可临时新建其他用户重试，或联系助手排查。

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

这些配置项在腾讯云 `SA2.2XLARGE32` 实例上测试可用。当你的服务器 CPU 性能不足时，可能遇到无法启动的问题，此时需手动调整配额。

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
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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

然后重新创建（此处以 `bk-elastic` 所在的 `base-storage.yaml.gotmpl` 文件为例）：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-elastic sync
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
2. helmfile 安装时增加 `--debug` 参数。
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
