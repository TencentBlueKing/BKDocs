本文按 release 名字组织，会收录关键报错的有效内容。请搜索逐个单词搜索全文，以免不匹配。

## 第三方组件
非蓝鲸产品。

### elasticsearch 及 redis-cluster 部署超时
#### 表现

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

#### 排查处理

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

#### 总结

网络限制导致虚拟网络不通，解除限制后 bk-elastic 自动恢复正常。

bk-redis-cluster 在删除 pvc 后重新部署，恢复正常：
``` bash
kubectl delete pvc -n blueking -l app.kubernetes.io/instance=bk-redis-cluster  # 删除磁盘数据
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis-cluster sync  # 重新部署
```

### bk-repo 部署超时，bk-repo-gateway 日志显示 Address family not supported by protocol
#### 表现

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

#### 排查处理

检查 nginx 报错，为系统不支持 IPv6 所致。

检查配置文件发现硬编码了 IPv6 地址监听，故只能推动用户启用系统 IPv6 功能，同时提单给开发避免此类硬编码。

#### 总结

1. 用户内核未启用 IPv6，启用后恢复。
2. bk-repo 不应该强制监听 IPv6 地址，已经向开发提单： https://github.com/TencentBlueKing/bk-repo/issues/119


### bk-apigateway 部署报错 Snippet directives are disabled by the Ingress administrator
#### 表现

使用一键脚本部署时，部署到 bk-apigateway 时报错：
``` plain
ERROR:
  exit status 1
略

COMBINED OUTPUT:
  Release "bk-apigateway" does not exist. Installing it now.
  Error: admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: nginx.ingress.kubernetes.io/configuration-snippet annotation cannot be used. Snippet directives are disabled by the Ingress administrator
```

#### 排查处理

根据报错搜索到了官方的 issue： https://github.com/kubernetes/ingress-nginx/issues/7837

检查 ingress-nginx 版本为 0.49.3，符合文中描述。进一步检查文中提到的 `ingress-nginx-controller` configmap，发现存在配置项：
``` yaml
data:
  allow-snippet-annotations: "false"
```

尝试修改为 `"true"`，重试部署发现可以继续进行。

#### 总结

ingress-nginx 在 0.49.1 启用的安全策略。此问题已经反馈到了 bk-apigateway 开发。

临时解决方案：
1. 编辑 configmap： `kubectl edit configmap -n ingress-nginx ingress-nginx-controller`。
2. 在编辑界面中修改 `allow-snippet-annotations` 为 `"true"`。
3. 重新开始部署操作。
4. 部署完成蓝鲸后，记得恢复配置项为默认的 `"false"`。


### 重新部署 bk-paas 报错 UPGRADE FAILED bk-paas has no deployed releases
#### 表现

在初次部署 bk-paas 时失败，重新部署 bk-paas 会遇到报错：
``` plain
Error:
  UPGRADE FAILED: "bk-paas" has no deployed releases
```

#### 排查处理

当已经存在 release 部署记录时，重新执行 `helmfile sync` 会被解释为 `helm upgrade` 执行升级流程。

Helm 自 2.7.1 版本起，使用最新的成功部署作为升级的基准。如果某个 release 一直未曾成功部署，则重试时会直接报错 “has no deployed releases”。

先卸载：`helm uninstall -n blueking bk-paas`。

然后重新部署即可恢复。

#### 总结

无。


### 重新部署 bk-paas 报错 UPGRADE FAILED another operation is in progress
#### 表现

在初次部署 bk-paas 时失败，重新部署 bk-paas 会遇到报错：
``` plain
Error:
  UPGRADE FAILED: another operation (install/upgrade/rollback) is in progress
```

#### 排查处理

使用 helm install 或者 helm upgrade 的时候，helm 命令被中断，所以 release 状态未能更新。

先查看异常的 release：
``` bash
helm list -aA
```

然后查看出错历史版本。以 `bk-paas` 为例，命令为 `helm history -n blueking bk-paas`。

根据上一步的结果，有如下选择：
* 如果有已经成功的历史版本，可以回滚：`helm rollback -n blueking bk-paas 成功的revision`。
* 如果没有，可以卸载：`helm uninstall -n blueking bk-paas`。

完成后重新部署即可。

#### 总结

操作不当。

这些关键操作有保护避免重复执行，所以不能直接重试。需要先回滚到历史成功版本或者卸载，然后才能继续安装操作。


### Service call failed
#### 表现

基础套餐部署到 `bk-paas` 时超时，检查 `bkpaas3-apiserver-migrate-db` pod 的状态为 `CrashLoopBackoff` ，检查发现 `apiserver-bkrepo-init` 容器内出现日志：
``` plain
blue_krill.storages.blobstore.exceptions.RequestError: Service call failed
```

#### 排查处理
 
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

#### 总结

环境问题。


## 部署容器管理平台时的报错

### no matches for kind BkGatewayPluginMetadata in version gateway.bk.tencent.com/v1beta1
#### 表现

升级 BCS 时出现如下报错：
``` plain
STDERR:
  Error: UPGRADE FAILED: [unable to recognize "": no matches for kind "BkGatewayPluginMetadata" in version "gateway.bk.tencent.com/v1beta1", error validating "": error validating data: [ValidationError(BkGatewayResource.spec):略]]
```
#### 排查处理

无

#### 总结

操作不当。

请认真阅读升级文档，需要先升级 `bk-apigateway` 版本 `>=0.4.57`。


## 部署监控日志套餐时的报错
### bk-consul 报错 No private IPv4 address found
#### 表现

bk-consul-* 系列 pod 的状态维持在 `CrashLoopBackOff`。检查日志发现：
``` plain
consul 时间略 INFO ==> ** Starting Consul **
==> No private IPv4 address found
```

#### 排查处理

检查 Pod IP，确认为公网网段。进一步排查 kubelet 的启动参数，发现分配了公网网段。

用户分配给 kubelet 的网段不正确，误用了公网网段。私有网段范围如下：
* A 类： `10.0.0.0/8`，地址范围为 10.0.0.0 - 10.255.255.255。
* B 类： `172.16.0.0/12`，地址范围为 172.16.0.0 - 172.31.255.255。
* C 类： `192.168.0.0/16`，地址范围为 192.168.0.0 - 192.168.255.255。

正确配置后重启所有的 kubelet 进程，并重新部署旧的 pod，问题解决。

#### 总结

配置不当。


### bkmonitor-operator 部署超时，日志显示 dial unix /data/ipc/ipc.state.report: connect: no such file or directory
#### 表现

部署 bkmonitor-operator 时超时；或者虽然 `helmfile` 提示部署成功，但是 `bkmonitor-operator-bkmonitorbeat-daemonset` 系列 pod 的状态稳定为 `CrashLoopBackOff`。

检查 pod 日志发现如下报错：
``` plain
failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```

#### 排查处理

未安装 agent，导致主机不存在 gse socket 文件，因此容器内报错无此文件。

在 “节点管理” 中安装 gse agent 成功后，异常 pod 会逐步自动恢复。也可直接删除出错的 pod，会立刻重新创建。

#### 总结

操作不当。
