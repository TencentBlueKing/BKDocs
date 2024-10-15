本文档仅为 helm 部署时的问题。如果其他场景，请查看对应文档：
* [SaaS 部署问题案例](deploy-saas.md)：部署 SaaS (蓝鲸官方或自行开发等）时遇到的问题。
* [产品界面使用问题案例](bk-web.md)：部署过程中，需要进入界面变更时遇到的问题。


## helm 及 helmfile 报错

### 一键脚本 在显示 generate custom.yaml 后报错 timed out waiting for the condition
#### 表现

在运行“一键脚本”安装基础套餐（ `./scripts/setup_bkce7.sh -i base --domain 你配置的域名` ）时，屏幕输出如下：
``` bash
时间略 [INFO] multinode mode deploy
时间略 [INFO] INSTALL:base
时间略 [INFO] generate custom.yaml
时间略 [INFO] create pod to get path of Docker Root Dir
error: timed out waiting for the condition
```

#### 排查处理

这是来自 `kubectl` 命令的报错，意为等待超时。

在报错出现后，之前的错误 Pod 很可能已经被自动清理。请重新运行刚才的脚本，然后新开窗口执行 `kubectl get pod -A | grep -v -e Runn -e Comp` 命令，可以看到有个异常的 Pod。
``` bash
blueking    nsenter-随机字符串   0/1  ErrImagePull   0  6s
```
当 `nsenter` pod 的状态为 `ErrImagePull`，说明无法正常拉取镜像，你需要使用 `kubectl describe pod -n blueking nsenter-补全名字` 查看镜像拉取失败的具体原因。一般为你的网络环境有限制所致，请解决网络问题后重试。

#### 总结
目前常见为网络限制或异常导致镜像拉取失败，解决网络问题即可。

如为其他情况，请联系助手排查。


### 一键脚本报错 helmfile command not found
#### 表现

在运行“一键脚本”安装基础套餐时，出现报错：
``` bash
时间略 [INFO] multinode mode deploy
时间略 [INFO] INSTALL:base
略
时间略 [INFO] installing localpv
scripts/setup_bkce7.sh: line 568: helmfile: command not found
时间略 [ERROR] fail to install local-pv
```

#### 排查处理

检查脚本逻辑发现会把 `helmfile` 安装到 `/usr/local/bin/`。
使用 `file` 命令检查文件 ABI 正常。测试文件执行权限也通过。

发现安装逻辑在显示帮助信息时也能触发，故告知用户执行 `bash -x scripts/setup_bkce7.sh -h`，发现 `command -v helmfile` 不通过，然后成功触发了文件复制。

故检查 `PATH` 变量，发现存在 `/usr/local/sbin/`，但是没有 `/usr/local/bin/`，判定为用户修改错误所致，补回后问题解决。

#### 总结

部署不当。


### 一键脚本 或 helmfile 输出大段报错 failed to download at version
#### 表现

在使用 “一键脚本” 安装任意套餐，或者直接执行 `helmfile` 命令时，出现大段报错，内容如下：
``` bash
STDERR:
  Error: failed to download "名称" at version "版本号"
```

#### 排查处理

检查 `hub.bktencent.com` 解析到的 IP 是否正确。

可以临时修改中控机的 hosts 文件解决：
``` plain
49.234.165.79 hub.bktencent.com
```

如果后续拉取镜像失败，同理修改 node 的 hosts 文件。

#### 总结

海外用户会解析到我们的新加坡节点。请临时配置 hosts 使用上海节点。

可联系助手反馈镜像同步问题，请提供镜像路径。


### 一键脚本 或 helmfile 输出大段报错 timed out waiting for the condition
#### 表现

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


#### 排查处理

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
  * 解决办法：请先找到 pod 的报错，并在本文搜索报错的核心关键词。如果本文没有处理案例，可咨询客服，或参考 《[卸载](../uninstall.md)》 文档卸载后重新部署。
* 镜像拉取超时。
  * 表现：在早期 kubectl describe pod 时可以看到 Events 显示 `Pulling image XXX`。如果发现较晚，则镜像可能拉取完毕，此时 kubectl get pod 无任何异常，且 pod 未曾重启过。
  * 解决办法：目前镜像策略都是复用现存镜像，可改用其他网络下载所需的镜像，然后导出为 tar 包，在上述 pod 所在的 node 导入。
* 镜像不存在。
  * 表现：kubectl get pod 显示 `ImagePullBackOff` 状态。kubectl describe pod 时可以看到 Events 显示 `Failed to pull image "镜像路径": rpc error: code = Unknown desc = Error response from daemon: manifest for 镜像路径 not found: manifest unknown: manifest unknown`。
  * 解决办法：请联系蓝鲸助手处理。


#### 总结

这是一个笼统的报错，请先参考 “排查处理” 章节做初筛，然后根据报错中选择一个关键词搜索 《[pod 异常状态问题案例](deploy-pod-unready.md)》文档里的已知案例。

如果没有找到案例，请提交如下信息给助手：
1. 全部 Pod 的概况： `kubectl get pod -A`。
2. 全部 Pod 的详情： `kubectl describe pod -A`。
3. 提交异常 Pod 的日志： `kubectl logs -n 命名空间 POD名`。
4. 如果 Pod 概况中 `RESTART` 列的值大于 3，需要额外提交上次日志： `kubectl logs -p -n 命名空间 POD名`。


### helmfile 部署 03-bcs.yaml.gotmpl 时报错 error calling index: index of nil pointer
#### 表现

执行 `helmfile -f 03-bcs.yaml.gotmpl sync`，直接出现报错：
``` plain
ERROR:
  exit status 1

EXIT STATUS
  1

STDERR:
Error: template: bcs-services-stack/charts/bcs-project-manager/templates/variable-migration-job.yaml:51:20: executing "bcs-services-stack/charts/bcs-project-manager/templates/variable-migration-job.yaml" at <include "bcs-common.mongodb.host" (dict "externalMongo" .Values.svcConf.mongo.address "globalStorage" .Values.global.storage "namespace" .Release.Namespace)>: error calling include: template: bcs-services-stack/charts/bcs-common/templates/_storage.tpl:41:37: executing "bcs-common.mongodb.host" at <index . "localStorage" "mongodb">: error calling index: index of nil pointer
```

#### 排查处理

无

#### 总结

helm 版本低于 3.12，参考部署文档升级后即可。


## docker 问题案例
### 配置的 docker registry-mirrors 没有生效
#### 表现

部署蓝鲸时，容器镜像拉取失败。报错为 `
Error response from daemon: Get https://registry-1.docker.io/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)`。

使用 `docker pull` 命令测试拉取，报错依旧。

随后配置了 registry-mirrors 为国内源，并 reload dockerd，使用 `docker info` 命令检查配置已经生效，但报错依旧。

#### 排查处理

使用 `skopeo` 命令检查 registry 情况。发现：
* `skopeo --debug inspect docker://docker.mirrors.ustc.edu.cn/library/busybox` 服务端返回 403。
* `skopeo --debug inspect docker://registry.docker-cn.com/library/busybox` 连接超时。

因此配置的 2 个 mirror 均无效，导致 dockerd 使用了默认的 Docker hub。

测试发现 `hub-mirror.c.163.com` 可用，问题解决。

#### 总结

用户配置的源均已失效，因此回退到了 Docker Hub 拉取。改用 `hub-mirror.c.163.com` 解决。


<a id="use-k8s" name="use-k8s"></a>

## k8s 问题案例

### kubectl logs 报错 dial tcp IP:10250 connect 失败
#### 表现

在终端运行 `kubectl logs` 命令时，提示无法连接到服务器。报错如下：
``` plain
Error from server: Get "https://IP:10250/containerLogs/命名空间/POD名/容器名": dial tcp IP:10250: connect: no route to host
```
或者为：
``` plain
Error from server: Get "https://IP:10250/containerLogs/命名空间/POD名/容器名": dial tcp IP:10250: connect: connection refused
```

#### 排查处理

在 master 上测试访问该端口确实不通，检查发下目标机器存在防火墙。关闭防火墙后操作恢复正常。

#### 总结

用户对应的节点网络异常（掉线，或者防火墙拦截）导致无法访问。

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
