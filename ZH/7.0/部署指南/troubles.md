# 问题案例

本文仅用于汇总用户反馈的问题，并提供解决方案。如需学习问题排查思路，或者一些调试方法，可以参考 《[FAQ](faq.md)》 文档。

>**提示**
>
>请直接搜索错误关键词或短句，不要整行粘贴，这样可能匹配不到。

## 部署前的报错

## 部署基础套餐时的报错

### 一键脚本 在显示 generate custom.yaml 后报错 timed out waiting for the condition

在你运行“一键脚本”安装基础套餐（ `./scripts/setup_bkce7.sh -i base --domain 你配置的域名` ）时，屏幕输出如下：
``` bash
时间略 [INFO] multinode mode deploy
时间略 [INFO] INSTALL:base
时间略 [INFO] generate custom.yaml
时间略 [INFO] create pod to get path of Docker Root Dir
error: timed out waiting for the condition
```

这是来自 `kubectl` 命令的报错，意为等待超时。

在报错出现后，之前的错误 Pod 很可能已经被自动清理。请重新运行刚才的脚本，然后新开窗口执行 `kubectl get pod -A | grep -v -e Runn -e Comp` 命令，可以看到有个异常的 Pod。
``` bash
blueking    nsenter-随机字符串   0/1  ErrImagePull   0  6s
```
当 `nsenter` pod 状态为 `ErrImagePull`，说明无法正常拉取镜像，你需要使用 `kubectl describe pod -n blueking nsenter-补全名字` 查看镜像拉取失败的具体原因。一般为你的网络环境有限制所致，请解决网络问题后重试。

如为其他情况，请联系助手排查。

### 一键脚本 或 helmfile 输出大段报错 timed out waiting for the condition

在使用“一键脚本”安装任意套餐，或者直接执行 helmfile 命令时，出现大段报错，其输入如下
``` bash
ERROR:
  exit status 1

EXIT STATUS
  1

STDERR:
  Error: timed out waiting for the condition

COMBINED OUTPUT:
  Release "release名字" does not exist. Installing it now.
  Error: timed out waiting for the condition
```

因为这是一个笼统的报错，因此我们需要检查出问题的 `release名字` 对应的 pod，然后才能排查出问题所在。

``` bash
kubectl get pod -A | grep -wv Completed | grep -e "0/"
```

目前观察到如下类型的原因：
* pod 启动超时。
  * 表现：pod 为 `Running` 状态，但是 `RESTARTS` 列的计数大于 3 ，且 kubectl describe pod 显示的 Events 和 logs 均正常，helmfile destory 对应 release 后，再次 helmfile sync 问题依旧。
  * 解决办法： 手动修改 custom 文件，提高配额。详细步骤见本文“调整 pod 的资源配额”章节。
* pod 等待调度。
  * 表现：pod 一直为 `Pending` 状态。
  * 解决办法：kubectl describe pod 查看阻塞原因，然后逐层 kubectl describe 导致阻塞的资源追溯拥有。常见情况为资源（CPU、内存及 pvc 等）不足，可以通过扩容 node 解决此类问题。
* pod 启动失败。
  * 表现：pod 状态多次重启，状态为 `CrashLoopBackOff`。
  * 解决办法：请先找到 pod 的报错，并在本文搜索报错的核心关键词。如果本文没有处理案例，可咨询客服，或参考 《[卸载](uninstall.md)》 文档卸载后重新部署。
* 镜像拉取超时。
  * 表现：在早期 kubectl describe pod 时可以看到 Events 显示 `Pulling image XXX`。如果发现较晚，则镜像可能拉取完毕，此时 kubectl get pod 无任何异常，且 pod 未曾重启过。
  * 解决办法：目前镜像策略都是复用现存镜像，可改用其他网络下载所需的镜像，然后导出为 tar 包，在上述 pod 所在的 node 导入。
* 拉取镜像失败。
  * 表现：kubectl get pod 显示 `ImagePullBackOff` 状态。kubectl describe pod 时可以看到 Events 显示 `Failed to pull image "镜像路径": rpc error: code = Unknown desc = Error response from daemon: manifest for 镜像路径 not found: manifest unknown: manifest unknown`。
  * 解决办法：此种情况请联系蓝鲸助手处理。


### Service call failed
基础套餐部署到 `bk-paas` 时超时，检查 `bkpaas3-apiserver-migrate-db` pod 的状态为 `CrashLoopBackoff` ，检查发现 `apiserver-bkrepo-init` 容器内出现日志：
``` plain
blue_krill.storages.blobstore.exceptions.RequestError: Service call failed
```
因为日志上方提示请求 bkrepo 创建项目，故先检查 bkrepo-repository 的日志：
``` plain
2022-10-29 02:01:14.887 ERROR 9 --- [  XNIO-1 task-1] ExceptionLogger                          [TID: N/A] : User[anonymous] GET [/service/project/info/bkpaas] from [Api] failed[SystemErrorException]: [250115]Service unauthenticated, reason: Expired token
```
而 bkrepo-auth 中此 url 的最早日志为：
``` plain
2022-10-28 18:02:16.723 ERROR 9 --- [  XNIO-1 task-2] ExceptionLogger                          [TID: N/A] : User[admin] POST [/api/user/create/project] from [Api] failed[NoFallbackAvailableException]: No fallback available. Cause: [500 Internal Server Error] during [GET] to [http://bk-repo-bkrepo-repository/service/project/info/bkpaas] [ProjectClient#getProjectInfo(String)]: [{
  "code" : 250115,
  "message" : "Service unauthenticated, reason: Expired token",
  "data" : null,
  "traceId" : ""
}]
```
排除时区干扰，时间相差 62s，为时间同步问题所致。启用 NTP 服务，各 node 时间一致后，请求恢复正常。


## 部署 SaaS 时的报错
### 部署 SaaS 在“配置资源实例”阶段报错
首先查看 `engine-main` 这个应用对应 pod 的日志。根据错误日志提示，判断定位方向：
1. 如报错 `DeployError: 部署失败, 配置资源实例异常: unable to provision instance for services<redis>`，则为没有配置 redis 资源所致。在中控机工作目录执行 `./scripts/setup_bkce7.sh -u redis`。
2. 检测 mysql、rabbitmq 等「增强服务」的资源配置是否正确。`http://bkpaas.$BK_DOMAIN/backend/admin42/platform/plans/manage` （先登录才能访问）以及 `http://bkpaas.$BK_DOMAIN/backend/admin42/platform/pre-created-instances/manage` （先登录才能访问）。
3. 检查应用集群的 k8s 相关配置 token 是否正确。初次部署时会自动调用 `scripts/create_k8s_cluster_admin_for_paas3.sh` 脚本自动生成 token 等参数到 `./paas3_initial_cluster.yaml` 文件中。如果不正确，可以删除后这些账号和绑定后重建。

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


## 使用问题
### 蓝鲸桌面点击图标后提示 应用已经下载，正在为您卸载该应用
表现：在蓝鲸桌面点击应用图标，结果提示 ”应用已经下载，正在为您卸载该应用……”。

结论：PaaS 初始化异常，具体原因待查，推荐先行卸载重装 PaaS。

后续用户如有遇到，请收集 `bkpaas3-apiserver-migrate-db` Pod 的 2 次日志供助手排查：
``` bash
kubectl logs -n blueking bkpaas3-apiserver-migrate-db-补全名字
kubectl logs -p -n blueking bkpaas3-apiserver-migrate-db-补全名字
```

问题原因：点击桌面的 “添加” 按钮，发现应用商店中只有 “配置平台”、“作业平台” 和 新安装的 SaaS，并没有 “权限中心”、“用户管理” 等应用。怀疑为 PaaS 初始化数据库异常，用户暂未提供日志，无法找到初始化失败的原因。


### 配置平台循环登录
表现：当访问 配置平台（CMDB）时，一直不断提示登录。但是其他系统均正常访问（最多仅提示登录一次），且隐私窗口中只需登录一次即可访问配置平台。

结论：此问题为用户同时存在多套蓝鲸环境且域名后缀相同所致，可以临时清空浏览器 cookie 解决。

问题原因：蓝鲸 V6 的默认部署域名为 `bktencent.com`，而蓝鲸 V7 的默认域名为 `bkce7.bktencent.com`。当用户已经成功登录 V6 环境后，则会在浏览器存储 `bk_token`，此时访问 V7 环境，因为域名后缀相同，则 `bktencent.com` 域名里的 `bk_token` cookie 也会发给 V7 环境，导致登录校验失败。此问题涉及同名 cookie 读取逻辑调整，待配置平台评估解决方案。

### 监控平台 观测场景 kubernetes 访问报错 resource is unauthorized
表现：访问 “监控平台” —— “观测场景” —— “kubernetes” 界面。页面提示 报错 “resource is unauthorized”。

结论：
1. 如果是未曾 [配置容器监控](install-co-suite.md#bkmonitor-install-operator)，请先完成。
2. 如果已经配置过，需要核对 bcs token 是否正确。在工作目录执行 `bash -x scripts/config_monitor_bcs_token.sh`，检查输出的 `GATEWAY_TOKEN` 和 `./environments/default/bkmonitor-custom-values.yaml.gotmpl` 内容是否一致。
   1. 如果不一致，请替换文件内容，并部署一次监控平台：`helmfile -f 04-bkmonitor.yaml.gotmpl sync`。
   2. 如果一致，也请 **先尝试部署一次监控平台**。如果问题依旧，请联系助手排查。

问题原因：
1. 用户漏看了“部署监控平台”章节末尾的提示。
2. 用户曾经卸载过蓝鲸，但是没有严格参考卸载文档操作，导致配置文件残留。

## 安装 agent 时的报错
### 执行日志里显示 

### 执行日志里显示 agent is not connect to gse server
执行日志显示：
``` plain
[时间略 INFO] [script] setup agent. (extract, render config)
[script] request agent config file(s)
[script] gse agent is setup successfully.
[时间略 ERROR] agent(PID: 略) is not connect to gse server
```

请选择其中一台安装失败的机器。登录到此机器，检查 agent 日志文件： `/var/log/gse/agent-err.log`。

如果日志中大量提示：
``` plain
时间略 (略):ZOO_ERROR@getaddrs@599: getaddrinfo: No such file or directory
```
此报错为无法解析 zk 服务器地址所致，需检查配置文件：`/usr/local/gse/agent/etc/gse_agent.conf`。
* 如果配置文件中 `.zkhost` 的值是 `"bk-zookeeper:2181"`，说明你遗漏了部署步骤，请在 “节点管理”——“全局配置” 中 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env) 。
* 如果为其他域名，则请自行解决 DNS 解析问题，建议使用 IP。

如有其他情况，请联系助手排查。

## k8s 通用的问题案例

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
