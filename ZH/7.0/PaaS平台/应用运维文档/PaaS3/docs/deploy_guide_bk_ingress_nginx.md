# bk-ingress-nginx 安装指南
bk-ingress-nginx 为蓝鲸 APP 提供负载均衡功能以及其他的可观测性、安全性和可用性功能，本文将会引导 bk-ingress-nginx 的安装流程。

## 准备 values.yaml
### 1.填写镜像
请将可用的镜像地址及其标签填入 `controller.image` 和 `controller.tag`。
如果对应的镜像需要凭证拉取，请将请将对应密钥名称写入配置文件中，详细请查看 `global.imagePullSecrets` 配置项说明。
填写示例：
```yaml
global:
  imagePullSecrets:
    - myImagePullSecrets

controller:
  image: "mirrors.example.com/bkee/bk-ingress-nginx"
  tag: "1.0.0"
```

### 2.使用节点静态端口方式
该方式通过指定特定的静态端口，通过每一个节点暴露服务，但因 Kubernetes 的限制，这个静态的端口有特定的范围限制，默认为：30000-32767。
因此这种方式需要客户端主动指定访问的端口（`nodePorts.http` 端口处理 HTTP 流量，`nodePorts.https` 端口处理 HTTPS 流量）。
优点如下：
- 无需占用节点 80/443 端口，只需保证静态端口可用；
- 无需规划独占节点，任意节点皆可访问服务；
- 容器更新或重启时，服务可保证访问稳定；

但有以下缺点：
- 因为使用 iptables 或 LVS 转发流量，可能会有性能和稳定性问题；
- 也因为流量转发，会导致无法获取客户端 IP；
- 无法使用 80/443 端口，只能通过配置的 `nodePorts` 端口访问；

如果可以在集群外搭建 Nginx 等作为网络边缘设备，解决端口及客户端 IP 的问题，优先推荐使用这种方式。
但为了方便使用，不论是否使用主机网络模式，都提供了节点静态端口访问的方式。
请配置所监听的端口，或者保留默认值，但该值可能会被别的资源占用：
```yaml
nodePorts:
  http: 30180
  https: 30543
```

### 3.确认是否使用主机网络模式（默认开启）
主机网络模式下，bk-ingress-nginx 会直接监听在对应节点的 80 和 443 端口，通过对应节点 IP 直接访问服务。
此外，因为少了额外的转发流程，可直接获取到客户端 IP。

但在该模式下，有如下缺点和限制：
- 如果遇到端口冲突，进程将无法启动；
- 容器更新或重启时，服务不可用；
- 域名只能解析到实际运行服务的节点 IP，有额外维护成本；

因此建议在该模式下，建议：
1. 为 bk-ingress-nginx 规划固定的节点，保证 80/443 端口可用，不能部署如 ingress controller 之类的服务；
2. 为这些节点打上专门的 label，如：`run-bk-ingress-nginx: "true"`；
3. 将对应的 label 配置到 `nodeSelector` 中，且将副本数配置为节点数量；
4. 将域名解析到所有对应的节点 IP；
5. 定期回顾和更新前面配置以确保访问稳定。

如无需开启，请按以下方式配置，并跳过该章节：
```yaml
controller:
  useHostNetwork: false
```

如需开启，请确认已将规划运行 bk-ingress-nginx 的节点打上了对应的 label，请配置：
```yaml
controller:
  useHostNetwork: true
  replicaCount: 2 # 填写成实际规划的节点数
  nodeSelector:
    run-bk-ingress-nginx: "true"  # 可按实际 label 修改
```

## 安装 Chart

准备好 Values.yaml 后，你便可以开始安装蓝鲸 PaaS3.0 开发者中心 bk-ingress-nginx 模块了。执行以下命令，在集群内安装名为 `bk-ingress-nginx 的 Helm release：

```shell
$ helm install bk-ingress-nginx bk-paas3/bk-ingress-nginx --namespace bk-ingress-nginx --values value.yaml
```

上述命令将在 Kubernetes 集群中部署蓝鲸 PaaS3.0 开发者中心 bk-ingress-nginx 服务, 并输出访问指引。

### 卸载Chart

使用以下命令卸载 `bk-ingress-nginx`:

```shell
$ helm uninstall bk-ingress-nginx
```

上述命令将移除所有与 bk-ingress-nginx 相关的 Kubernetes 资源，并删除 release。


## 进行域名解析
bk-ingress-nginx 不能跨集群处理应用流量，因此需要确认当前的应用集群名称及对应的域名，可打开蓝鲸 PaaS3.0 开发者中心 admin 页面，进入 **首页/平台管理/应用集群管理**，找到该集群的接入层配置：
- `sub_path_domain`：为子路径访问模式下的主域名，如果该值不为空，请将该域名解析到节点 IP；

## 验证部署正确性
- 确认命名空间下 pod 皆为 Running 状态，数量符合 `replicaCount` 要求，并且日志中没有持续明显的错误日志。
- 使用域名访问服务 http 端口的 /healthz 地址，返回状态码为200。
- 部署应用后，可正常访问应用页面。