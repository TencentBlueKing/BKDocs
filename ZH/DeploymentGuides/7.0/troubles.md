# 问题案例

本文仅用于汇总用户反馈的问题，并提供相关的排查确认操作及解决方案。如需学习问题排查思路，或者一些调试方法，可以参考 《[FAQ](faq.md)》 文档。

>**提示**
>
>请直接搜索错误关键词或短句，不要整行粘贴，这样可能匹配不到。

本文按部署节奏组织内容：
* 部署前的报错
* 部署基础套餐时的报错
* 部署 SaaS 时的报错
* 安装 agent 及插件时的报错
* 部署容器管理平台时的报错
* 部署监控日志套餐时的报错
* 部署持续集成套餐时的报错

也收集了一些使用问题：
* 浏览器访问时的报错 （主要为界面访问的报错）
* 蓝盾使用问题 （主要为插件报错等）

并在末尾提供了一些基础软件的问题案例：
* docker 问题案例
* k8s 问题案例

<a id="prepare" name="prepare"></a>

## 部署前的报错
待用户反馈。

<a id="install-bkce" name="install-bkce"></a>

## 部署基础套餐时的报错

### 一键脚本 在显示 generate custom.yaml 后报错 timed out waiting for the condition
**表现**

在运行“一键脚本”安装基础套餐（ `./scripts/setup_bkce7.sh -i base --domain 你配置的域名` ）时，屏幕输出如下：
``` bash
时间略 [INFO] multinode mode deploy
时间略 [INFO] INSTALL:base
时间略 [INFO] generate custom.yaml
时间略 [INFO] create pod to get path of Docker Root Dir
error: timed out waiting for the condition
```

**结论**

目前常见为网络限制或异常导致镜像拉取失败，解决网络问题即可。

**问题分析**

这是来自 `kubectl` 命令的报错，意为等待超时。

在报错出现后，之前的错误 Pod 很可能已经被自动清理。请重新运行刚才的脚本，然后新开窗口执行 `kubectl get pod -A | grep -v -e Runn -e Comp` 命令，可以看到有个异常的 Pod。
``` bash
blueking    nsenter-随机字符串   0/1  ErrImagePull   0  6s
```
当 `nsenter` pod 的状态为 `ErrImagePull`，说明无法正常拉取镜像，你需要使用 `kubectl describe pod -n blueking nsenter-补全名字` 查看镜像拉取失败的具体原因。一般为你的网络环境有限制所致，请解决网络问题后重试。

如为其他情况，请联系助手排查。

### 一键脚本报错 helmfile command not found
**表现**

在运行“一键脚本”安装基础套餐时，出现报错：
``` bash
时间略 [INFO] multinode mode deploy
时间略 [INFO] INSTALL:base
略
时间略 [INFO] installing localpv
scripts/setup_bkce7.sh: line 568: helmfile: command not found
时间略 [ERROR] fail to install local-pv
```

**结论**

用户 `PATH` 中丢失了 `/usr/local/bin/`，补回后解决。

**问题分析**

检查脚本逻辑发现会把 `helmfile` 安装到 `/usr/local/bin/`。
使用 `file` 命令检查文件 ABI 正常。测试文件执行权限也通过。

发现安装逻辑在显示帮助信息时也能触发，故告知用户执行 `bash -x scripts/setup_bkce7.sh -h`，发现 `command -v helmfile` 不通过，然后成功触发了文件复制。

故检查 `PATH` 变量，发现存在 `/usr/local/sbin/`，但是没有 `/usr/local/bin/`，判定为用户修改错误所致，补回后问题解决。

### 一键脚本 或 helmfile 输出大段报错 failed to download at version
**表现**

在使用 “一键脚本” 安装任意套餐，或者直接执行 `helmfile` 命令时，出现大段报错，内容如下：
``` bash
STDERR:
  Error: failed to download "名称" at version "版本号"
```

**结论**

检查 `hub.bktencent.com` 解析到的 IP 是否正确。

可以临时修改中控机的 hosts 文件解决：
``` plain
49.234.165.79 hub.bktencent.com
```

如果后续拉取镜像失败，同理修改 node 的 hosts 文件。

**问题分析**

海外用户会解析到我们的新加坡节点。目前镜像同步有些问题，待解决。请临时配置 hosts 使用上海节点。


### 一键脚本 或 helmfile 输出大段报错 timed out waiting for the condition
**表现**

在使用 “一键脚本” 安装任意套餐，或者直接执行 `helmfile` 命令时，出现大段报错，内容如下：
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

**结论**

这是一个笼统的报错，请先参考本章节的**问题分析**做初筛，然后根据关键词搜索本文的已知案例。

如果没有找到案例，请提交如下信息给助手：
1. 全部 Pod 的概况： `kubectl get pod -A`。
2. 全部 Pod 的详情： `kubectl describe pod -A`。
3. 提交异常 Pod 的日志： `kubectl logs -n 命名空间 POD名`。
4. 如果 Pod 概况中 `RESTART` 列的值大于 3，需要额外提交上次日志： `kubectl logs -p -n 命名空间 POD名`。

**问题分析**

我们需要检查出问题的 `release名字` 对应的 pod，然后才能排查出问题所在。

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
* 镜像不存在。
  * 表现：kubectl get pod 显示 `ImagePullBackOff` 状态。kubectl describe pod 时可以看到 Events 显示 `Failed to pull image "镜像路径": rpc error: code = Unknown desc = Error response from daemon: manifest for 镜像路径 not found: manifest unknown: manifest unknown`。
  * 解决办法：请联系蓝鲸助手处理。


### elasticsearch 及 redis-cluster 部署超时
**表现**

使用一键脚本部署时，报错 bk-elastic 部署超时：
``` plain
STDERR:
  Error: timed out waiting for the condition

COMBINED OUTPUT:
  Release "bk-elastic" does not exist. Installing it now.
  Error: timed out waiting for the condition
```

检查 pod 状态，发现 elastic 和 redis-cluster pod 出现 crash：
``` plain
blueking  bk-elastic-elasticsearch-coordinating-only-0  0/1  Running           3  12m
blueking  bk-elastic-elasticsearch-data-0               0/1  CrashLoopBackOff  2  11m
blueking  bk-elastic-elasticsearch-master-0             1/1  Running           0  11m
blueking  bk-redis-cluster-0                            0/1  CrashLoopBackOff  3  11m
blueking  bk-redis-cluster-1                            0/1  CrashLoopBackOff  4  11m
blueking  bk-redis-cluster-2                            0/1  Running           0  11m
blueking  bk-redis-master-0                             1/1  Running           0  11m
```

**结论**

网络限制导致虚拟网络不通，解除限制后 bk-elastic 自动恢复正常。

bk-redis-cluster 在删除 pvc 后重新部署，恢复正常：
``` bash
kubectl delete pvc -n blueking -l app.kubernetes.io/instance=bk-redis-cluster  # 删除磁盘数据
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis-cluster sync  # 重新部署
```

**问题分析**

首先检查 elasticsearch-coordinating pod 的日志：
``` plain
[时间略][WARN ][o.e.d.SeedHostsResolver  ] [bk-elastic-elasticsearch-coordinating-only-0] failed to resolve host [bk-elastic-elasticsearch-master.blueking.svc.cluster.local]
java.net.UnknownHostException: bk-elastic-elasticsearch-master.blueking.svc.cluster.local
```
发现为无法解析服务域名。检查 elasticsearch-data pod 的日志，为相同原因。

因为 elasticsearch-master 为 Ready，故先检查服务注册状态：
``` bash
kubectl get svc -A |grep bk-elastic
```
可以发现存在 bk-elastic-elasticsearch-master，故服务注册正常。

检查 DNS 服务：
``` bash
kubectl get svc -A |grep dns
```
仅有 kube-dns，地址为 `10.96.0.10`。

然后在 master 及 各 node 测试能否访问 `10.96.0.10` 解析：
``` bash
nslookup bk-elastic-elasticsearch-master.blueking.svc.cluster.local 10.96.0.10
```
测试发现 master 能正常解析，全部 node 解析超时。

推测为网络策略限制，导致虚拟网络不通。

用户解除网络策略后，发现 elastic 可以自动恢复，但是 redis-cluster 依旧未能自动恢复。尝试清除数据，可以正常启动了。


### bk-repo 部署超时，bk-repo-gateway 日志显示 Address family not supported by protocol
**表现**

使用一键脚本部署时，报错 bk-repo 部署超时：
``` plain
STDERR:
  Error: timed out waiting for the condition

COMBINED OUTPUT:
  Release "bk-repo" does not exist. Installing it now.
  Error: timed out waiting for the condition
```
检查 pod 状态，发现 `bk-repo-bkrepo-gateway` pod 的状态为 `CrashLoopBackOff`，且 `RESTART` 计数持续增长，检查上次日志 `kubectl logs -p` 发现报错：
``` plain
nginx: [emerg] socket() [::]:80 failed (97: Address family not supported by protocol)
```

**结论**

1. 用户内核未启用 IPv6，启用后恢复。
2. bk-repo 不应该强制监听 IPv6 地址，已经向开发提单： https://github.com/TencentBlueKing/bk-repo/issues/119

**问题分析**

检查 nginx 报错，为系统不支持 IPv6 所致。

检查配置文件发现硬编码了 IPv6 地址监听，故只能推动用户启用系统 IPv6 功能，同时提单给开发避免此类硬编码。


### bk-apigateway 部署报错 Snippet directives are disabled by the Ingress administrator
**表现**

使用一键脚本部署时，部署到 bk-apigateway 时报错：
``` plain
ERROR:
  exit status 1
略

COMBINED OUTPUT:
  Release "bk-apigateway" does not exist. Installing it now.
  Error: admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: nginx.ingress.kubernetes.io/configuration-snippet annotation cannot be used. Snippet directives are disabled by the Ingress administrator
```

**结论**

ingress-nginx 在 0.49.1 启用的安全策略。临时解决方案：
1. 编辑 configmap： `kubectl edit configmap -n ingress-nginx ingress-nginx-controller`。
2. 在编辑界面中修改 `allow-snippet-annotations` 为 `"true"`。
3. 重新开始部署操作。
4. 部署完成蓝鲸后，记得恢复配置项为默认的 `"false"`。

此问题已经反馈到了 bk-apigateway 开发，请先参考临时方案处理。

**问题分析**

根据报错搜索到了官方的 issue： https://github.com/kubernetes/ingress-nginx/issues/7837

检查 ingress-nginx 版本为 0.49.3，符合文中描述。进一步检查文中提到的 `ingress-nginx-controller` configmap，发现存在配置项：
``` yaml
data:
  allow-snippet-annotations: "false"
```

尝试修改为 `"true"`，重试部署发现可以继续进行。

### 重新部署 bk-paas 报错 UPGRADE FAILED bk-paas has no deployed releases
**表现**

在初次部署 bk-paas 时失败，重新部署 bk-paas 会遇到报错：
``` plain
Error:
  UPGRADE FAILED: "bk-paas" has no deployed releases
```

**结论**

先卸载：`helm uninstall -n blueking bk-paas`。

然后重新部署即可恢复。

**问题分析**

当已经存在 release 部署记录时，重新执行 `helmfile sync` 会被解释为 `helm upgrade` 执行升级流程。

Helm 自 2.7.1 版本起，使用最新的成功部署作为升级的基准。如果某个 release 一直未曾成功部署，则重试时会直接报错 “has no deployed releases”。

### 重新部署 bk-paas 报错 UPGRADE FAILED another operation is in progress
**表现**

在初次部署 bk-paas 时失败，重新部署 bk-paas 会遇到报错：
``` plain
Error:
  UPGRADE FAILED: another operation (install/upgrade/rollback) is in progress
```

**结论**

常见于部署过程中操作被意外中断。

先查看异常的 release：
``` bash
helm list -aA
```

然后查看出错历史版本。以 `bk-paas` 为例，命令为 `helm history -n blueking bk-paas`。

根据上一步的结果，有如下选择：
* 如果有已经成功的历史版本，可以回滚：`helm rollback -n blueking bk-paas 成功的revision`。
* 如果没有，可以卸载：`helm uninstall -n blueking bk-paas`。

完成后重新部署即可。

**问题分析**

使用 helm install 或者 helm upgrade 的时候，helm 命令被中断，所以 release 状态未能更新。

这些关键操作有保护避免重复执行，所以不能直接重试。需要先回滚到历史成功版本或者卸载，然后才能继续安装操作。


### Service call failed
**表现**

基础套餐部署到 `bk-paas` 时超时，检查 `bkpaas3-apiserver-migrate-db` pod 的状态为 `CrashLoopBackoff` ，检查发现 `apiserver-bkrepo-init` 容器内出现日志：
``` plain
blue_krill.storages.blobstore.exceptions.RequestError: Service call failed
```
因为日志上方提示请求 bkrepo 创建项目，故先检查 `bkrepo-repository` pod 的日志：
``` plain
时间略 ERROR 9 --- [  XNIO-1 task-1] ExceptionLogger                          [TID: N/A] : User[anonymous] GET [/service/project/info/bkpaas] from [Api] failed[SystemErrorException]: [250115]Service unauthenticated, reason: Expired token
```
而 `bkrepo-auth` pod 中此 url 的最早日志为：
``` plain
时间略 ERROR 9 --- [  XNIO-1 task-2] ExceptionLogger                          [TID: N/A] : User[admin] POST [/api/user/create/project] from [Api] failed[NoFallbackAvailableException]: No fallback available. Cause: [500 Internal Server Error] during [GET] to [http://bk-repo-bkrepo-repository/service/project/info/bkpaas] [ProjectClient#getProjectInfo(String)]: [{
  "code" : 250115,
  "message" : "Service unauthenticated, reason: Expired token",
  "data" : null,
  "traceId" : ""
}]
```
忽略时区干扰，算得时间相差 62s。经开发确认 token 容忍的时间差异为 60s，故判断为时间同步问题所致。

启用 NTP 服务，待各 node 时间一致后，请求恢复正常。


<a id="install-saas" name="install-saas"></a>

## 部署 SaaS 时的报错

### 创建应用时选择安装包后报错 仅支持 .tar 或 tar.gz 格式的文件
**表现**

使用浏览器访问 开发者中心，在 “创建应用” 界面上传 SaaS 安装包文件后，页面顶部出现报错：
>仅支持蓝鲸 S-mart 包，可以从“蓝鲸 S-mart”获取，上传成功后即可进行应用部署 仅支持 .tar 或 tar.gz 格式的文件。

**结论**

已知 Windows 10 和 11 用户使用 Chrome 浏览器可触发此问题。

可按需选择临时解决方案：
* 如果要部署 流程服务（ITSM）及 标准运维（SOPS），可参考 《[基础套餐部署](install-bkce.md#setup_bkce7-i-saas)》 文档在 中控机 使用 “一键脚本” 部署 SaaS。
* 如果是其他 SaaS，或者不便使用一键脚本，可将 `.tar.gz` 安装包解压为 `.tar` 格式进行上传（推荐使用 7-zip 软件操作，**切勿解压为目录后重新打包**为 `.tar` 文件，重新打包过的文件可能无法安装）。

**问题分析**

文件上传界面限制了文件的 MIME 类型为 `application/x-tar,application/x-gzip`。如果不匹配，则会出现上述报错。

已知 Windows 10 系统更新后，`.gz` 文件的 MIME 类型变为了 `application/gzip`。


### 创建应用时选择安装包后报错 应用 ID: 某名称 的应用已存在
**表现**

使用浏览器访问 开发者中心，在 “创建应用” 界面上传 SaaS 安装包文件后，文件名下方出现报错：`应用 ID: 某名称 的应用已存在！`

**结论**

应用已经创建后，如果需要更新软件包，请参考 [《SaaS 部署文档》中的“上传安装包——更新安装包”章节](install-saas-manually.md#upload-bkce-saas) 操作。

**问题分析**

无。


### 部署 SaaS 时报错 配置资源实例异常: unable to provision instance for services mysql
**表现**

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] uploading 工作目录/scripts/../../saas/bk_itsm.tgz
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, 配置资源实例异常: unable to provision instance for services<mysql>❌
```
或者在浏览器里访问开发者中心部署时，在 “准备阶段” —— “配置资源实例” 阶段的日志中出现报错：
> 配置资源实例异常: unable to provision instance for services`<mysql>`

**结论**

kubernetes token 有误。

先刷新 PaaS 中存储的 token：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
rm -f environments/default/paas3_initial_cluster.yaml  # 删除配置文件
./scripts/create_k8s_cluster_admin_for_paas3.sh  # 重新生成
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync  # 重启paas
```
然后重新部署 SaaS。

**问题分析**

用户在卸载后未曾参照文档重命名 bkhelmfile 目录，导致在 k8s 中创建了新的 token ，但是配置文件没有更新。


### 部署 SaaS 时报错 配置资源实例异常: unable to provision instance for services redis
**表现**

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] uploading 工作目录/scripts/../../saas/bk_itsm.tgz
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, 配置资源实例异常: unable to provision instance for services<redis>❌
```
或者在浏览器里访问开发者中心部署时，在 “准备阶段” —— “配置资源实例” 阶段的日志中出现报错：
> 配置资源实例异常: unable to provision instance for services`<redis>`

**结论**

未配置 redis 实例所致。请在中控机工作目录执行 `./scripts/setup_bkce7.sh -u redis`。

**问题分析**

* 一键部署脚本：用户在卸载后未曾参照文档重命名 bkhelmfile 目录，导致自动跳过了此步骤。
* 手动部署：遗漏了 “[在 PaaS 界面配置 Redis 资源池](install-saas-manually.md#paas-svc-redis)” 步骤。


### 部署 SaaS 在构建应用步骤出错
**表现**

在“开发者中心”部署 SaaS 时失败，页面显示在 构建阶段 的 “构建应用” 步骤失败。

**结论**

需要根据右侧日志查阅下面的案例，未记录的问题请提供日志截图联系客服或在社区发帖。

**问题分析**

无


### 部署 SaaS 在构建应用步骤报错 code command not found
**表现**

在“开发者中心”部署 SaaS 时失败，页面显示在 构建阶段 的 “构建应用” 步骤失败。

右侧部署日志显示：
``` plain
/tmp/stdlib.sh: line 2: code: command not found
/tmp/stdlib.sh: line 2: code: command not found
略
    !! command failed (build: file /buildpack/bk-buildpack-python/bin/compile, line 0, code 127: operation failed)
failed with exit code 1
Building failed, please check logs for more details
```

**结论**

未安装 PaaS runtimes 所致，请先完成 《[上传 PaaS runtimes 到 bkrepo](paas-upload-runtimes.md)》 文档。

**问题分析**

部署文档中提示了此步骤可选，并描述了使用场景。用户可能遗漏了文档步骤。

出现这个报错的原因是：PaaS 在部署 `package` 格式的 SaaS 时，会直接 `curl bkrepo-url | bash` 下载构建脚本。

当 runtimes 尚未上传到 bkrepo 时，bkrepo 响应的 json 内容为：
``` json
{
  "code" : 错误码,
...
```
这个 json 被 shell 解释为了 `"code"` 命令和 2 个参数 `:`、 `错误码,`，所以显示出报错 `line 2: code: command not found`。


### 部署 SaaS 在执行部署前置命令步骤出错
**表现**

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, Pre-Release-Hook failed, please check logs for more details❌
command terminated with exit code 1
```
或者在“开发者中心”部署 SaaS 时失败，页面显示在 部署阶段 的 “执行部署前置命令” 步骤失败。

**结论**

目前用户报告的案例中，均为拉取镜像失败所致。又可细分为以下 2 种情况：
1. 遗漏了 “[配置 k8s node 的 DNS](install-bkce.md#hosts-in-k8s-node)” 步骤，导致无法解析 bkrepo docker registry 的域名。
2. 遗漏了 “[调整 node 上的 docker 服务](install-bkce.md#k8s-node-docker-insecure-registries)” 步骤，导致 https 连接失败。

请先检查 **全部 node**，补齐这些操作，然后重试。如未解决，可参考问题分析排查。

**问题分析**

“执行部署前置命令” 对应着 `pre-release-hook` pod。如果报错 `pod not found`，则说明已经被自动清理，可点击 “重新部署” 按钮或者重试“一键脚本”，即出现此 pod。

我们先检查 pod 事件，以 `bk_itsm` 为例：
``` bash
kubectl describe pod -n bkapp-bk0us0itsm-prod pre-release-hook
```
>**提示**
>
>其他 SaaS 需调整 `namespace`。前缀保持不变，app_code 部分需替换 `_` 为 `0us0`，后缀用于区分环境： `prod`（生产环境）或 `stag`（预发布环境）。

该命令输出如下：
``` plain
Events:
  Type     Reason     Age                    From               Message
  ----     ------     ----                   ----               -------
  Normal   Scheduled  3m56s                  default-scheduler  Successfully assigned bkapp-bk0us0itsm-prod/pre-release-hook to node-10-0-1-3
  Normal   Pulling    2m24s (x4 over 3m56s)  kubelet            Pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2"
  Warning  Failed     2m24s (x4 over 3m55s)  kubelet            Failed to pull image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2": rpc error: code = Unknown desc = Error response from daemon: Get https://docker.bkce7.bktencent.com/v2/: dial tcp: lookup docker.bkce7.bktencent.com on 10.0.1.1:53: no such host
  Warning  Failed     2m24s (x4 over 3m55s)  kubelet            Error: ErrImagePull
  Normal   BackOff    2m10s (x6 over 3m55s)  kubelet            Back-off pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2"
  Warning  Failed     119s (x7 over 3m55s)   kubelet            Error: ImagePullBackOff
```
此处的报错是 `node-10-0-1-3` 无法解析 `docker.bkce7.bktencent.com`，请参考 [配置 k8s node 的 DNS](install-bkce.md#hosts-in-k8s-node) 文档操作。

其中 `Error response from daemon:` 为 dockerd 返回的报错，也可能是其他情况。

如：
``` plain
  Warning  Failed     85s (x4 over 2m43s)  kubelet            Failed to pull image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2": rpc error: code = Unknown desc = Error response from daemon: Get https://docker.bkce7.bktencent.com/v2/: x509: certificate is valid for ingress.local, not docker.bkce7.bktencent.com
```
此报错则是 HTTPS 证书问题，请参考 [调整 node 上的 docker 服务](install-bkce.md#k8s-node-docker-insecure-registries) 文档操作。

其他报错可自行处理，或提供上述 kubectl describe pod 命令的完整输出联系蓝鲸助手。


<a id="install-agent" name="install-agent"></a>

## 安装 agent 及插件时的报错

### 执行日志里显示 curl 下载 setup_agent.sh 报错 could not resolv host
**表现**

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://bkrepo.bkce7.bktencent.com/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.bkce7.bktencent.com; Unknown error
```

**结论**

目的主机无法解析 bkrepo 域名。请任选一种方案处理：
* 配置目的主机的 hosts（操作文档见 [配置中控机的 DNS](install-bkce.md#hosts-in-bk-ctrl)），然后**重试出错的任务**。
* 让节点管理今后使用 IP 下载文件（操作文档见 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env) ），然后**创建新任务**。


**问题分析**

此问题无分析过程。

如果你使用了 DNS 提供 bkrepo 域名的解析，可以自行逐级排查 DNS 配置问题。


### 执行日志里显示 curl 下载 setup_agent.sh 报错 Connection timed out
**表现**

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://服务端地址略/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 28, stdout -> , stderr -> curl: (28) Connection timed out after 5000 milliseconds
```

**结论**

从节点管理能 SSH 访问到目的主机，但是目的主机无法访问 bkrepo 下载脚本。

请参考下面的 问题分析 章节排查。

**问题分析**

前往目的主机测试访问服务端地址。

>**提示**
>
>可以参考上述日志中提示的 curl 命令添加 `-v` 参数： `curl -v 其他参数保持不变`。

如果测试结果依旧为连接超时，可参考如下步骤排查：
1. 检查服务端是否正常：
   1. 当服务端地址填写域名时，需要检查 ingress-nginx：
      1. 核对目的主机上解析域名得到的 IP 是否为当前 ingress-nginx pod 所在 node 的 IP。
      2. 如果是云服务，检查安全组是否放行了 `80` 端口，以及是否限制了入站 IP。
      3. 检查 `ingress-nginx` pod 所在 node 的软件防火墙是否有限制 `80` 端口的入站流量。
      4. 在集群内的其他 node 测试访问 `ingress-nginx` service（`80` 端口），如果超时，可能是 k8s 虚拟网络故障。
   2. 当服务端地址填写 IP 时，需要检查 bkrepo-gateway：
      1. 核对该 IP 是否为 k8s 集群中某个 node 的 IP。
      2. 如果是云服务，检查安全组是否放行了 `30025` 端口，以及是否限制了入站 IP。
      3. 检查 服务端 IP 对应主机上的软件防火墙是否有限制 `30025` 端口的入站流量。
      4. 在集群内的其他 node 测试访问 `bk-repo-bkrepo-gateway` service （`30025` 端口），如果超时，可能是 k8s 虚拟网络故障。
2. 检查目的主机的出站限制：
   1. 检查路由表，可能因网段冲突或路由策略导致出口网卡及源 IP 地址不正确。
   2. 如果是云服务，检查安全组是否有出站限制。
   3. 检查软件防火墙是否有出站限制。
3. 当以上检查均未发现问题，需要检查网络：
   1. 网络路由是否互通。
   2. 中途路由器是否存在 访问控制规则。
   3. 硬件防火墙 是否有拦截策略。

### 执行日志里显示 curl 下载 setup_agent.sh 报错 404 not found
**表现**

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://服务端地址略/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 22, stdout -> , stderr -> curl: (22) The requested URL returned error: 404 not found
```

**结论**

用户 bkrepo 曾卸载，因此导致历史文件丢失。因为暂无工具检查数据不一致的情况，故推荐完整卸载蓝鲸重新部署。

**问题分析**

在节点管理报错 404 后，登录制品库管理界面，发现文件存在，点击文件详情，取得 sha256。

然后找到了 `bk-repo-bkrepo-storage` pvc 所对应的 pv，检查发现此 pv 中确实没有 `pv目录前缀/store/sha256的2层前缀目录/文件sha256`这个文件。

询问用户得知有卸载 bkrepo，故断定为卸载导致了历史文件丢失。

经 bkrepo 开发确认暂无此场景的修复工具，且重装 `nodeman` 时因为存在数据库记录无法自动重新上传，推测 PaaS 相关文件上传也会如此，故推荐用户卸载整个蓝鲸。


### 执行日志里显示 agent is not connect to gse server
**表现**

执行日志显示：
``` plain
[时间略 INFO] [script] setup agent. (extract, render config)
[script] request agent config file(s)
[script] gse agent is setup successfully.
[时间略 ERROR] agent(PID: 略) is not connect to gse server
```

**结论**

具体排查过程见问题分析，有如下情况：
1. 用户遗漏了 “节点管理”——“全局配置” 中 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env) 步骤。

**问题分析**

此问题需进一步排查。

请选择其中一台安装失败的机器。登录到此机器，检查 agent 日志文件： `/var/log/gse/agent-err.log`。

发现日志中大量提示：
   ``` plain
   时间略 (略):ZOO_ERROR@getaddrs@599: getaddrinfo: No such file or directory
   ```
   此报错为无法解析 zk 服务器地址所致，需检查配置文件：`/usr/local/gse/agent/etc/agent.conf`。
   * 如果配置文件中 `.zkhost` 的值是 `"bk-zookeeper:2181"`，说明你遗漏了部署步骤，请在 “节点管理”——“全局配置” 中 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env) 。
   * 如果为其他域名，则请自行解决 DNS 解析问题，建议使用 IP。

如有其他情况，请联系助手排查。


### 安装插件时下发安装包失败，执行日志显示作业平台 API 请求异常 HTTP 状态码 401
**表现**

安装插件时在“下发安装包”步骤失败，执行日志显示：
``` plain
时间略 [ERROR] [1306201] [作业平台]API请求异常:(Component request third-party system [JOBV3] interface [fast_transfer_file] error: Status Code: 401, Error Message: third-party system interface response status code is not 200, please try again later or contact component developer to handle this) path => /api/c/compapi/v2/jobv3/fast_transfer_file/
```

**结论**

临时解决办法：重启一次 `bk-job-gateway` pod 即可。在中控机执行如下命令：
``` bash
kubectl rollout restart deployment -n blueking bk-job-gateway
```

**问题分析**

检查发现 `bk-job-gateway-` 开头的 pod 日志中出现异常：
``` plain
时间略 ERROR [,,] 14 --- [           main] c.t.b.j.g.s.impl.EsbJwtServiceImpl       : Build esb jwt public key caught error!
org.springframework.web.client.ResourceAccessException: I/O error on GET request for "http://bkapi.域名略/api/c/compapi/v2/esb/get_api_public_key": Connect to bkapi.域名略:80 [bkapi.域名略/IP略] failed: connect timed out; nested exception is org.apache.http.conn.ConnectTimeoutException: Connect to bkapi.域名略:80 [bkapi.域名略/IP略] failed: connect timed out
```

待开发排查原因。可能是用户虚拟网络不稳定导致 job 误判或缓存了错误结果。


<a id="install-bcs" name="install-bcs"></a>

## 部署容器管理平台时的报错

### PASSWORDS ERROR You must provide your current passwords when upgrading the release
**表现**

执行 `helmfile -f 03-bcs.yaml.gotmpl sync` 命令时出现报错：
``` plain
STDERR:
  Error: UPGRADE FAILED: execution error at (bcs-services-stack/charts/bcs-certs/templates/NOTES.txt:6:4):
  PASSWORDS ERROR: You must provide your current passwords when upgrading the release.
```

**结论**

可参考本文档重新运行一键部署脚本，升级到 7.0.1 ，即可解决此问题。

或在中控机执行如下命令临时打补丁：
>``` bash
>scripts/get_bcs_passwd.sh | tee environments/default/bcs/auto-generated-secrets.yaml
>if grep -nFC 1 /auto-generated-secrets.yaml 03-bcs.yaml.gotmpl ; then echo patched; else sed -i '/resources[.]yaml[.]gotmpl/a\    - environments/default/bcs/auto-generated-secrets.yaml' 03-bcs.yaml.gotmpl && echo patch applied || echo failed to patch ; fi
>```

**问题分析**

7.0.0 版本中默认未在 values 中保存密码，导致 03-bcs.yaml.gotmpl 只能 sync 一次，后续 sync 或 apply 时会报错 MySQL 密码错误。

补充生成 values 文件即可。7.0.1 版本中已经调整为了部署后自动生成文件。

### no matches for kind BkGatewayPluginMetadata in version gateway.bk.tencent.com/v1beta1
**表现**

升级 BCS 时出现如下报错：
``` plain
STDERR:
  Error: UPGRADE FAILED: [unable to recognize "": no matches for kind "BkGatewayPluginMetadata" in version "gateway.bk.tencent.com/v1beta1", error validating "": error validating data: [ValidationError(BkGatewayResource.spec):略]]
```

**结论**

请认真阅读升级文档，需要先升级 `bk-apigateway` 版本 `>=0.4.57`。

**问题分析**

无

<a id="install-co" name="install-co"></a>

## 部署监控日志套餐时的报错
### bk-consul 报错 No private IPv4 address found
**表现**

bk-consul-* 系列 pod 的状态维持在 `CrashLoopBackOff`。检查日志发现：
``` plain
consul 时间略 INFO ==> ** Starting Consul **
==> No private IPv4 address found
```

**结论**

用户分配给 kubelet 的网段不正确，误用了公网网段。私有网段范围如下：
* A 类： `10.0.0.0/8`，地址范围为 10.0.0.0 - 10.255.255.255。
* B 类： `172.16.0.0/12`，地址范围为 172.16.0.0 - 172.31.255.255。
* C 类： `192.168.0.0/16`，地址范围为 192.168.0.0 - 192.168.255.255。

正确配置后重启所有的 kubelet 进程，并重新部署旧的 pod，问题解决。

**问题分析**

检查 Pod IP，确认为公网网段。进一步排查 kubelet 的启动参数，发现分配了公网网段。

### bkmonitor-operator 部署超时，日志显示 dial unix /data/ipc/ipc.state.report: connect: no such file or directory
**表现**

部署 bkmonitor-operator 时超时；或者虽然 `helmfile` 提示部署成功，但是 `bkmonitor-operator-bkmonitorbeat-daemonset` 系列 pod 的状态稳定为 `CrashLoopBackOff`。

检查 pod 日志发现如下报错：
``` plain
failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```

**结论**

在 “节点管理” 中安装 gse agent 成功后，异常 pod 会逐步自动恢复。也可直接删除出错的 pod，会立刻重新创建。

**问题分析**

未安装 agent，导致主机不存在 gse socket 文件，因此容器内报错无此文件。


<a id="install-ci" name="install-ci"></a>

## 部署持续集成套餐时的报错
### 部署 bk-ci 时 timed out waiting for the condition
**表现**

目前因为 `bk-ci-init-turbo` pod 启动失败，可能导致整个 release 超时。

**结论**

`bk-ci` 默认配置项有误，请参考 《[部署持续集成平台-蓝盾](install-ci-suite.md#install-ci)》文档配置 custom values 后重新部署。


<a id="browser" name="browser"></a>

## 浏览器访问时的报错
### 蓝鲸桌面点击图标后提示 应用已经下架，正在为您卸载该应用
**表现**

在蓝鲸桌面点击应用图标，结果提示 ”应用已经下架，正在为您卸载该应用……”。

**结论**

PaaS 初始化异常。

我们正在排查此问题出现的原因，请在 **中控机** 执行如下命令取得数据库转储文件：
``` bash
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysqldump -uroot -pblueking --databases open_paas bkpaas3_apiserver | gzip -c > bk-paas3-dump.sql.gz
```
然后将生成的 `bk-paas3-dump.sql.gz` 文件发送给蓝鲸助手。


**问题分析**

点击桌面的 “添加” 按钮，发现应用商店中只有 “配置平台”、“作业平台” 和 新安装的 SaaS，并没有 “权限中心”、“用户管理” 等应用。

怀疑为 PaaS 初始化数据库异常，用户暂未提供日志，无法找到初始化失败的原因。


### 配置平台循环登录
**表现**

当访问 配置平台（CMDB）时，登录成功后依旧不断提示登录。但是登录成功后访问其他系统均访问，且隐私窗口中只需登录一次即可访问配置平台。

**结论**

用户同时存在多套蓝鲸环境且域名后缀相同，最终清空浏览器 cookie 解决。

使用其他浏览器（或同浏览器登录其他账户）也可临时解决问题。

建议用户尝试使用其他域名。

**问题分析**

蓝鲸 V6 的默认部署域名为 `bktencent.com`，而蓝鲸 V7 的默认域名为 `bkce7.bktencent.com`。当用户已经成功登录 V6 环境后，则会在浏览器存储 `bk_token`，此时访问 V7 环境，因为域名后缀相同，则 `bktencent.com` 域名里的 `bk_token` cookie 也会发给 V7 环境，导致登录校验失败。

此问题涉及同名 cookie 读取逻辑调整，待配置平台评估正式解决方案。


### 登录界面样式丢失
**表现**

当提示登录时，登录界面只能看到文字，且排版错乱。

**结论**

bk-login-pod 启动异常，在中控机执行如下命令重启：
``` bash
kubectl rollout restart deployment -n blueking bk-login-web
```
观察新 pod Ready 后，然后刷新页面即可。

**问题分析**

打开浏览器开发者工具，切换到 network 栏刷新，发现请求静态资源（图片、js 及 css）时响应为 404 Not Found。

首先检查 `ingress-nginx` 的日志，得到请求的上游地址。

检查 endpoint：
``` bash
kubectl get endpoints -A
```

发现确实是 `bk-login-web` pod。

检查 pod 日志：
``` bash
kubectl logs -n blueking deploy/bk-login-web
```

发现对应资源确实是 bk-login-web 响应的 404，且上一行伴有异常：
``` plain
[Errno 2] No such file or directory: '/app/staticfiles//js/login.js'
::ffff:10.244.0.1 - - [时间略] "GET /static/js/login.js HTTP/1.1" 404 13 "http://bkce7.bktencent.com/login/?c_url=/" "UA略" in 0.000382 seconds
```

比对正常环境日志，发现启动时少了一行输出：
``` plain
55 static files copied to '/app/staticfiles'.
```

怀疑是 pod 启动阶段遇到异常，导致 Django collectstatic 因为异常退出，无法复制所需的静态文件。待开发修复。


### 监控平台 观测场景 kubernetes 访问报错 resource is unauthorized
**表现**

访问 “监控平台” —— “观测场景” —— “kubernetes” 界面。页面提示 报错 “resource is unauthorized”。

**结论**

分为 2 种情况：
1. 遗漏步骤 [配置容器监控](install-co-suite.md#bkmonitor-install-operator)。
2. bcs 实际 token 变动，更新 token 配置后重启监控平台解决。

**问题分析**

“部署监控平台”章节末尾有提示配置容器监控，但是用户可能遗漏，需要先询问确认。

如果已经配置过，需要核对 bcs token 是否正确。在工作目录执行 `bash -x scripts/config_monitor_bcs_token.sh`，检查输出的 `GATEWAY_TOKEN` 和 `./environments/default/bkmonitor-custom-values.yaml.gotmpl` 内容是否一致。
   * 如果不一致，请替换文件内容，并部署一次监控平台：`helmfile -f 04-bkmonitor.yaml.gotmpl sync`。
   * 如果一致，也请 **先尝试部署一次监控平台**。如果问题依旧，请联系助手排查。

### 权限中心中申请节点管理及作业平台系统的权限时报错
**表现**

在权限中心申请自定义权限，切换到节点管理系统后，点击选择资源实例时，浏览器顶部会出现报错：
``` plain
接入系统资源接口请求失败: bk_nodeman's API unreachable! call bk_nodeman's API fail! you should check: 1.the network is ok 2.bk_nodeman is available 3.get details from bk_nodeman's log. [POST /api/iam/v1/cloud body.data.method=list_instance](system_id=bk_nodeman, resource_type_id=cloud) request_id=d840e70027cbcd7075bba0f0de3d03cb. Exception HTTPConnectionPool(host='bknodeman.bkce7.bktencent.com', port=80): Max retries exceeded with url: /api/iam/v1/cloud (Caused by NewConnectionError('<urllib3.connection.HTTPConnection object at 0x7f57e8ff8668>: Failed to establish a new connection: [Errno -2] Name or service not known',)) (RESOURCE_PROVIDER_ERROR)
```

申请作业平台权限时也会出现相同的报错。

**结论**

蓝鲸部署 bug，需要补充注册下 coredns，在中控机执行如下脚本：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN $BK_DOMAIN
```

**问题分析**

目前节点管理及作业平台对接权限中心使用了 `$BK_DOMAIN` 后缀的域名，所以需要配置解析。

后续会评估能否切换为 k8s 服务发现域名。请临时配置 coredns 解决此问题。


<a id="use-pipeline" name="use-pipeline"></a>

## 蓝盾使用问题

### 流水线上传构件失败
**表现**

流水线插件 “upload artifact”报错：
``` plain
1 file match:
  /data/devops/workspace/文件名
prepare to upload 大小 B
Error: Process completed with exit code 2189503: com.tencent.devops.common.api.exception.RemoteServiceException: 上传流水线文件失败.
2189503
Please contact platform.
```

**结论**

`bk-ci` 默认配置项有误，请参考 《[部署持续集成平台-蓝盾](install-ci-suite.md#install-ci)》文档重新部署。

**问题分析**

根据文件名确认 `ci-artifactory` Pod 日志，为相同报错，无法直观看到原因。

故启动 `ci-gateway` Pod 的交互 shell：
``` bash
kubectl exec -it -n blueking deploy/bk-ci-bk-ci-gateway -- bash
```

进入 shell 后，检查 nginx 日志目录 `/data/logs/nginx/` 下的 `站点名.access.时间.log` 和 `站点名.error.log`，发现为 `devops.error.log` 中记录了请求 `repo.bk.com` 域名返回了 413，从时间上能和 `ci-artifactory` 日志中的异常对应，因此判断为异常原因。

进一步联系开发确认为 charts 默认值有误所致，需要调整 custom values 文件：`environments/default/bkci/bkci-custom-values.yaml.gotmpl`：
``` yaml
config:
  bkRepoFqdn: bkrepo.{{ .Values.domain.bkDomain }}
```
随后重启 ci 解决：
``` bash
helmfile -f 03-bkci.yaml.gotmpl destroy
helmfile -f 03-bkci.yaml.gotmpl sync
```

### 流水线配置 GitLab 触发后项目设置里没有 webhook 配置项
**表现**

流水线触发器添加了 GitLab，并正确配置了触发事件，但是 git commit 时无法触发。检查 GitLab 项目的配置（settings），也没有设置 webhook url。

**结论**

用户没有仓库的 master 权限，添加权限后重新保存流水线，即可正常触发。

**问题分析**

添加触发器后，流水线保存时会异步触发 webhook 注册逻辑。

检查 ci-process 日志发现报错：`com.tencent.devops.common.api.exception.RemoteServiceException: Webhook添加失败，请确保该代码库的凭据关联的用户对代码库有master权限`。

添加 master 权限后，重新保存流水线，发现 GitLab 项目中已经出现 webhook url，点击 Test 可以成功触发流水线运行。


<a id="use-docker" name="use-docker"></a>

## docker 问题案例
### 配置的 docker registry-mirrors 没有生效
**表现**

部署蓝鲸时，容器镜像拉取失败。报错为 `
Error response from daemon: Get https://registry-1.docker.io/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)`。

使用 `docker pull` 命令测试拉取，报错依旧。

随后配置了 registry-mirrors 为国内源，并 reload dockerd，使用 `docker info` 命令检查配置已经生效，但报错依旧。

**结论**

用户配置的源均已失效，因此回退到了 Docker Hub 拉取。改用 `hub-mirror.c.163.com` 解决。

**问题分析**

使用 `skopeo` 命令检查 registry 情况。发现：
* `skopeo --debug inspect docker://docker.mirrors.ustc.edu.cn/library/busybox` 服务端返回 403。
* `skopeo --debug inspect docker://registry.docker-cn.com/library/busybox` 连接超时。

因此配置的 2 个 mirror 均无效，导致 dockerd 使用了默认的 Docker hub。

测试发现 `hub-mirror.c.163.com` 可用，问题解决。


<a id="use-k8s" name="use-k8s"></a>

## k8s 问题案例

### kubectl logs 报错 dial tcp IP:10250 connect 失败
**表现**

在终端运行 `kubectl logs` 命令时，提示无法连接到服务器。报错如下：
``` plain
Error from server: Get "https://IP:10250/containerLogs/命名空间/POD名/容器名": dial tcp IP:10250: connect: no route to host
```
或者为：
``` plain
Error from server: Get "https://IP:10250/containerLogs/命名空间/POD名/容器名": dial tcp IP:10250: connect: connection refused
```

**结论**

用户对应的节点网络异常（掉线，或者防火墙拦截）导致无法访问。

**问题分析**

在 master 上测试访问该端口确实不通，检查发下目标机器存在防火墙。关闭防火墙后操作恢复正常。


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

一般为 localpv 剩余空间不足所致。例如 mysql 需要 50 GB，bkrepo 需要 90 GB。因此需要某个 node 上的 localpv hostdir 所在的文件系统具备足额的磁盘空间。

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
