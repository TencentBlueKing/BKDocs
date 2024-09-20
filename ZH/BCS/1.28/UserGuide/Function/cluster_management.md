# 集群管理

## 一. 启用容器服务
如果当前项目未启用过容器服务，会看到如下的启用页面。如果是管理员，这里会直接出现有权限的业务列表(业务列表来源于配置平台)；非管理员需要单独申请。
![-w2020](../assets/bcs_start.png)

可以点击【查看帮助】，了解如何申请业务权限。
![-w2020](../assets/bcs_auth.png)

通过绑定有权限的业务，正式【启用容器服务】
![-w2020](../assets/bcs_start1.png)

## 二. 前置条件

### 网络连通性保证

因为业务集群与蓝鲸容器服务后台模块部署的集群相互有服务请求，使用前要保证网络连通性

- 容器平台管理业务集群需要访问业务集群的 ApiServer 服务
- 业务集群内会部署 bcs-k8s-watch（上报集群元数据与事件）、cluster-autoscaler（节点自动扩缩容）会调用容器管理平台后台服务

推荐节点出口使用 NAT 网关（出口 IP 白名单问题，因为业务会创建多个集群，每个集群添加多个节点，这样出口 IP 会经常变更、删除与新增，不利于白名单管理），业务服务接入层对外使用负载均衡产品来实现

### 蓝鲸容器服务出口暴露

目前业务集群内需要调用两个容器管理平台后台服务

- bcs-k8s-watch

  调用 bcs-stroage 接口，以域名的方式调用，例如：https://bcs-api.{蓝鲸平台域名}:31024

- bcs-kube-agent（自建集群需要，导入集群无需）

  调用 bcs-api-gateway 接口，以域名方式调用，例如：https://bcs-api.{蓝鲸平台域名}:31443

- cluster-autoscaler（节点自动扩缩容)

  调用 bcs-api-gateway 接口，以域名方式调用，例如：https://bcs-api.{蓝鲸平台域名}:31443

如何获取 bcs-api 域名？

```bash
# 在蓝鲸集群（蓝鲸社区版7.0(BCS-K8S-00000）中执行命令获取ingress域名
kubectl get ingress stack-bcs-api-gateway-http -n bcs-system
stack-bcs-api-gateway-http   nginx   bcs-api.xxx.xxx.com   172.17.247.1   80      24d
```

先检查域名是否已经解析，如果没有解析可以参考以下域名解析方法

- 个人或企业的域名解析系统（推荐）
- 在 coredns 中指定 hosts 解析，配置 hosts 详情可参考https://coredns.io/plugins/hosts/（不推荐）
- 节点主机的 hosts 中配置 hosts 解析，需要重启 coredns pod 所在节点的 docker 服务与重建 coredns（不推荐）

域名解析的目的地址是什么？

- 如果业务集群与蓝鲸部署集群（蓝鲸社区版 7.0 BCS-K8S-00000）能直通，可以使用 NodePort，域名解析到蓝鲸集群的任一节点即可，缺点是只能解析到单个节点，没有高可用，为临时使用方案，不推荐
  ```bash
  # 在蓝鲸集群（蓝鲸社区版7.0(BCS-K8S-00000）中执行命令获取bcs-api-gateway、bcs-storage NodePort信息
  kubectl get svc -n bcs-system|grep -E 'bcs-storage|bcs-api-gateway'
  bcs-api-gateway  NodePort  172.18.254.206  8081:31595/TCP,80:31000/TCP,443:31443/TCP,9091:30868/TCP
  bcs-storage  NodePort  172.18.252.140  50024:31024/TCP,50025:31025/TCP
  ```

- 如果业务集群与蓝鲸部署集群（蓝鲸社区版 7.0(BCS-K8S-00000）不能直通，则需要在 NodePort 前加一层负载均衡（如 CLB）做高可用，需要配置两条规则
  | 服务名称        | 协议 | VIP        | VPORT | RSIP             | RSPORT |
  | --------------- | ---- | ---------- | ----- | ---------------- | ------ |
  | bcs-api-gateway | TCP  | 负载均衡 IP | 443   | 蓝鲸集群所有节点 | 31443  |
  | bcs-storage     | TCP  | 负载均衡 IP | 31024 | 蓝鲸集群所有节点 | 31024  |

​       域名解析到负载均衡 VIP 即可，注意，如果负载均衡实例有安全组，需要创建放通业务集群出口 IP 的安全组规则

### 安装 gse_agent

蓝鲸容器平台安装 gse_agent 是为了保证以下功能的正常运行

- 蓝鲸容器监控，它使用 gse_agent 作为数据管道上报数据
- 蓝鲸日志平台，它使用 gse_agent 作为数据管道上报数据
- 节点模版自定义流程功能，它使用 gse_agent 执行 job 平台与标准运维任务
- 节点自动扩缩容自定义流程功能，它使用 gse_agent 执行 job 平台与标准运维任务
- 自建集群使用标准运维安装 kubernetes 组件，它使用 gse_agent 执行标准运维任务

gse_agent 安装详情请参考：[安装蓝鲸 Agent（直连区域）](../../../../NodeMan/2.2/UserGuide/QuickStart/DefaultAreaInstallAgent.md)

非直连网络环境安装 gse_agent 请参考：[安装蓝鲸 Agent（自定义云区域）](../../../../NodeMan/2.2/UserGuide/QuickStart/CustomCloudAreaInstallAgent.md)
## 三. 创建集群

集群作为容器调度的基础，启用完容器服务后，首先需要创建集群。平台提供了两种创建集群的方式，一种是新建集群，另一种是导入已有集群。
![-w2020](../assets/cluster_create.png)

####  创建集群 Master 节点

![-w2020](../assets/create_cluster_chioce.png)

点击展开更多设置，附加参数设置，此步骤为非必选，有特殊场景时才会使用到该参数

| 变量名         | 描述                                                    | 默认值                |
| -------------- | ------------------------------------------------------- | --------------------- |
| DOCKER_LIB     | Docker 数据目录                                          | /data/bcs/lib/docker  |
| DOCKER_VERSION | Docker 版本                                              | 19.03.9               |
| KUBELET_LIB    | kubelet 数据目录                                         | /data/bcs/lib/kubelet |
| K8S_VER        | 集群版本                                                | 1.20.11               |
| K8S_SVC_CIDR   | 集群 Service 网段                                         | 10.96.0.0/12          |
| K8S_POD_CIDR   | 集群 Pod 网段                                             | 10.244.0.0/16         |
| bcs_ws_used    | 使用 websocket 模式，适用于集群与蓝鲸服务集群不在同一内网 | false                 |

如果需创建集群节点的网络与蓝鲸服务集群（蓝鲸项目下的集群蓝鲸社区版 7.0 BCS-K8S-00000）不在同一内网的情况下，需要开启 websocket 模式，在附加参数中填入“bcs_ws_used = true”

![-w2020](../assets/bcs_ws_used.png)

选择【新建集群】，通过【选择服务器】，完成 Master 节点的选择。
![-w2020](../assets/cluster_create_new.png)

点击【确定】后，开始创建集群。可以通过【查看日志】观察集群的创建过程。
![-w2020](../assets/cluster_create_process.png)

集群 Master 创建完成后，可以点击【总览】查看集群状态。
![-w2020](../assets/cluster_overview.png)

可以看到成功添加了一个 Master 节点。但其实当前集群并非可用，因为通常 Master 节点并不会设置成调度节点，而是需要添加 Node 节点(业务容器实际运行所在的主机)。
![-w2020](../assets/cluster_overview1.png)

#### 安装 bcs-kube-agent

创建完集群后会自动部署 bcs-kube-agent、bcs-k8s-watch 组件，以下是具体查看方式

```bash
# 保证bcs-kube-agent是Ready与Running状态
kubectl get pod -n bcs-system
NAME                              READY   STATUS    RESTARTS   AGE
bcs-kube-agent-685b985f94-rg5sg   1/1     Running   0          82m

# 日志查看没有明显错误
kubectl logs bcs-kube-agent-685b985f94-rg5sg --tail=10 -n bcs-system
```



集群创建后还不能马上使用蓝鲸容器管理平台管理集群，要做到管理集群的能力，必须安装好 bcs-kube-agent，用于上报集群信息到容器平台后台，具体操作如下：

- 注意：目前 bcs-kube-agent 只支持在蓝鲸容器管理平台上创建的集群上安装，导入的集群无需安装，否则导入集群会出现异常

- 选择其中一台 master 角色服务器，如果 master 服务器上没有安装 helm，可以执行下面命令安装，也可以自己去网上下载

  `wget https://bkopen-1252002024.file.myqcloud.com/ce7/tools/helm && chmod +x helm && mv helm /usr/bin/`

- 添加 chart 包镜像仓库

  ```shell
  helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
  ```
- 如果命名空间 bcs-system 不存在，则需要创建命名空间

  `kubectl create ns bcs-system`

- bcs-kube-agent 需要访问容器平台服务 bcs-api-gateway，具体配置方法请参考 “前置条件中的蓝鲸容器服务出口暴露章节”

- 如果 bcs-api-gateway 没有创建 ingress，也没有提前解析好 ingress 里的域名就需要给 bcs-gateway 绑定 hosts，解决 bcs 网关访问问题，否则这一步可以忽略
  把域名 bcs-api-gateway 绑定到集群“蓝鲸蓝鲸 7.0”任意一台 node 上，这个 node 最好是 master 角色

  `kubectl edit cm coredns -n kube-system`

  添加以下内容：

  ```plain
          hosts {
            1.1.1.1 bcs-api-gateway
            fallthrough
          }
          # 1.1.1.1 是集群“蓝鲸蓝鲸7.0”任意一台node，最好是master
  ```

  ![](../assets/coredns_hosts.png)

- 创建 bcs-kube-agent 所需证书

  把以下内容保存到上一步集群 master 服务器上，文件名为：bcs-client-bcs-kube-agent.yaml

  ```plain
  apiVersion: v1
  data:
    ca.crt: 
    tls.crt: 
    tls.key: 
  kind: Secret
  metadata:
    name: bcs-client-bcs-kube-agent
    namespace: bcs-system
  type: kubernetes.io/tls
  ```

  通过 webconsole 或 ssh 到集群“蓝鲸蓝鲸 7.0”

  ![-w2020](../assets/webconsole_login.png)

  ```shell
  # 在集群中执行如下命令
  kubectl get secret bcs-gateway-bcs-services-stack -n bcs-system -o yaml
  ```

  把里面的 ca.crt、tls.crt、tls.key 里面的内容填充到 bcs-client-bcs-kube-agent.yaml 里

  执行 `kubectl apply -f bcs-client-bcs-kube-agent.yaml`创建好证书

- 通过 helm chart 安装 bcs-kube-agent

  把以下内容保存文件为 bcs-kube-agent-values.yaml

  ```plain
  global:
    serviceMonitor:
      enabled: false
    env:
      BK_BCS_clusterId: {集群ID}
  args:
    BK_BCS_API: {BK_BCS_API_GATEWAY}
    BK_BCS_APIToken: {BK_BCS_APIToken}
    BK_BCS_reportPath: /bcsapi/v4/clustermanager/v1/clustercredential/%s
  image:
    registry: hub.bktencent.com/dev
    repository: blueking/bcs-kube-agent
    tag: v1.25.0-alpha.6
  ```

  把 {集群ID} 替换为目前你操作的集群 ID，例如：BCS-K8S-40000

  {BK_BCS_APIToken}替换为以下命名获取的字符串，获取方法如下
  ```bash
  # 在 “蓝鲸” 项目下的 “蓝鲸社区版7.0”集群下使用web-console，执行以下命名获取
  kubectl get secret bcs-password -n bcs-system -o yaml
  # 找到字段：gateway_token
  # base64解密：
  echo "gateway_token值"|base64 -d
  ```

  把{BK_BCS_API_GATEWAY}替换为 bcs-api-gateway 的访问域名，域名如何获取已在 “蓝鲸容器服务出口暴露” 一节中说明，这里不再重复说明，例如：https://bcs-api.xxxx.com

  执行以下命令安装 bcs-kube-agent

  ```plain
  helm repo update
  helm upgrade --install bcs-kube-agent blueking-dev/bcs-kube-agent -f ./bcs-kube-agent-values.yaml -n bcs-system --devel
  
  Release "bcs-kube-agent" does not exist. Installing it now.
  NAME: bcs-kube-agent
  LAST DEPLOYED: Wed Apr 13 20:14:42 2022
  NAMESPACE: bcs-system
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  
  kubectl get pod -n bcs-system
  NAME                             READY   STATUS    RESTARTS   AGE
  bcs-kube-agent-749d58b65-x7qkk   1/1     Running   0          9s
  
  # pod日志没有错误就代表bcs-kube-agent安装成功
  kubectl logs bcs-kube-agent-749d58b65-x7qkk -n bcs-system
  W0413 12:15:23.805420       1 client_config.go:552] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.
  I0413 12:15:23.841994       1 report.go:74] apiserver addresses: https://1.1.1.1:6443,https://1.1.1.2:6443,https://1.1.1.3:6443
  I0413 12:15:23.842031       1 report.go:77] bke-server url：https://bcs-api-gateway:31443/bcsapi/v4/clustermanager/v1/clustercredential/BCS-K8S-40000
  ```

  

####  添加集群 Node 节点

选中【节点管理】标签，点击【添加节点】。选择主机的方式和创建 Master 类似。【确定】后，节点的添加会进入初始化阶段，直到最终完成添加。
![-w2020](../assets/cluster_add_node.png)
![-w2020](../assets/cluster_add_node1.png)

【节点管理】标签除了可以查看集群的所有节点外，还提供了一些集群日常管理的操作，如【停止调度】等，具体可以参考[K8S 官方介绍](https://kubernetes.io/zh/docs/concepts/architecture/nodes/)。



## 四. 导入已有集群

除了可以新建集群，容器服务也支持用户导入已有的集群。导入集群有两种方式：

- 通过集群的 kubeconfig 来达到 BCS 纳管的目的，这种导入方式优点是兼容各种各样的 K8S 集群，缺点是 BCS 只能控制 K8S 集群里的资源，而不能对云上其它资源进行管控，例如集群管理，节点添加，负载均衡等控制
- 通过各个云服务商的 API Key 方式导入集群，这种导入方式不同的云服务商有不同的 API Key，目前只支持腾讯云公有云的 TKE，后续会陆续支持 Amazon EKS，Azure AKS，Google GKE 等云服务商，这种放入方式优点是可以扩展对云资源的管控，例如集群管理，节点添加，负载均衡等控制

#### 1. kubeconfig 导入方式

![-w2020](../assets/create_container_cluster.png)

![-w2020](../assets/import_cluster.png)
![-w2020](../assets/import_cluster_by_kubeconfig.png)

填写集群导入所需参数，导入方式选择“kubeconfig”，参数“集群 kubeconfig”的获取方式一般有两种：

- 如果是云服务商提供的集群，一般在集群的基本信息可以找到，例如腾讯云公有云 TKE 的获取方式如下：

  ![-w2020](../assets/kubeconfig_content.png)

- 如果是自建原生 K8S 集群，可以在 Master 节点上的/root/.kube/config 文件中获取

kubeconfig 需同时满足以下两个条件，否则可能导致导入集群失败：

- 集群“蓝鲸社区版 7.0（BCS-K8S-00000）“所有节点服务器到被导入集群 APIServer 网络端口连通正常，如果 APIServer 有防火墙的，请开通网络策略

  - 腾讯云公网 TKE 要打开外网访问，**托管集群** 需要添加“蓝鲸社区版 7.0（BCS-K8S-00000）”集群所有 Node 节点的出口 IP 为 APIServer 的访问白名单

    ![-w2020](../assets/open_clb.png)

    ![-w2020](../assets/bcs_k8s_00000.png)


  - **独立集群** 需要在云产品“负载均衡”里，找到绑定 TKE 集群的 CLB 实例，实例名的命名规则一般是：${TKE 集群 ID}_default_kubelb-internet，给 CLB 实例绑定允许访问 TKE 集群 APIServer 的 IP 地址或 IP 段安全组来保证集群 APIServer 的网络安全

    ![-w2020](../assets/cloud_product_clb.png)

    ![-w2020](../assets/clb_ins_by_cls.png)

    ![-w2020](../assets/clb_sec_group.png)

    **注意：**如果“蓝鲸社区版 7.0（BCS-K8S-00000）”集群的节点是云上服务器，请先确认好节点服务器是走服务器外网还是走 nat 出口后再配置 APIServer 白名单或安全组

- 提供的 kubeconfig 用户是 cluster-admin 角色，否则会因为权限不足导致管控失败

  ![-w2020](../assets/get_admin_role.png)



获取到 kubeconfig 后，可以在导入集群页面进行有效性测试，如果测试通过，“导入”按钮会置为可用状态，否则请根据测试失败的错误提示处理错误，一般错误都是 kubeconfig 不同时满足上面讲的两个条件导致的

![-w2020](../assets/kubeconfig_test.png)

![-w2020](../assets/kubeconfig_test_success.png)

![-w2020](../assets/import_success.png)

导入集群成功后，等待 1 分钟左右，使用 webconsole 验证是否导入成功

![-w2020](../assets/web_console_test_index.png)

可以正常进入 webconsole 代表导入集群成功

![-w2020](../assets/webconsole_success.png)



#### 2. 云服务商 API 密钥导入方式
通过云服务商 API 密钥导入集群与 kubeconfig 导入方式一样，需同时满足以下两个条件，否则可能导致导入集群失败：

- 集群“蓝鲸社区版 7.0（BCS-K8S-00000）“所有节点服务器到被导入集群 APIServer 网络端口连通正常，如果 APIServer 有防火墙的，请开通网络策略

  - 腾讯云公网 TKE 要打开外网访问，**托管集群** 需要添加“蓝鲸社区版 7.0（BCS-K8S-00000）”集群所有 Node 节点的出口 IP 为 APIServer 的访问白名单

    ![-w2020](../assets/open_clb.png)

    ![-w2020](../assets/bcs_k8s_00000.png)


  - **独立集群** 需要在云产品“负载均衡”里，找到绑定 TKE 集群的 CLB 实例，实例名的命名规则一般是：${TKE 集群 ID}_default_kubelb-internet，给 CLB 实例绑定允许访问 TKE 集群 APIServer 的 IP 地址或 IP 段安全组来保证集群 APIServer 的网络安全

    ![-w2020](../assets/cloud_product_clb.png)

    ![-w2020](../assets/clb_ins_by_cls.png)

    ![-w2020](../assets/clb_sec_group.png)

    **注意：**如果“蓝鲸社区版 7.0（BCS-K8S-00000）”集群的节点是云上服务器，请先确认好节点服务器是走服务器外网还是走 nat 出口后再配置 APIServer 白名单或安全组

- 提供的 kubeconfig 用户是 cluster-admin 角色，否则会因为权限不足导致管控失败

  ![-w2020](../assets/get_admin_role.png)



满足以上两个先决条件后就可以开始通过云服务商 API 密钥导入集群了

![-w2020](../assets/cloud_import_no_key.png)

- 导入方式选择“云服务商”

- 云服务目前只支持 TKE，后续会支持到 Amazon EKS，Azure AKS，Google GKE 等云服务商

- 如果没有云凭证需要先创建一个，云凭证创建流程如下：

  - 首先在腾讯云公有云上使用主账户创建一个子账户（至少具备 TKE 集群管理、CVM 管理、负载均衡网络管理权限），用于做集群管理，强烈不建议使用主账户

  - 在子账户下创建 API 密钥，如果已经存在 API 密钥可以忽略此步骤

    ![-w2020](../assets/access_manager.png)

    ![-w2020](../assets/create_api_key.png)

  - 把创建的密钥录入到 BCS 中

    ![-w2020](../assets/bcs_create_api_key.png)

    ![-w2020](../assets/bcs_create_api_key_import.png)

    ![-w2020](../assets/bcs_create_api_key_result.png)

创建完云凭证后继续完成导入操作

![-w2020](../assets/cloud_import.png)

- 所属区域：通过云凭证拉取凭证有权限的区域列表，选择要导入集群的所属区域
- TKE 集群 ID：通过云凭证拉取所属区域下存在的 TKE 集群列表

点击“导入”按钮，完成集群导入

![-w2020](../assets/bcs_create_api_key_list.png)

导入集群成功后，等待 1 分钟左右，使用 webconsole 验证是否导入成功

![-w2020](../assets/web_console_test_index_cloud.png)

可以正常进入 webconsole 代表导入集群成功

![-w2020](../assets/webconsole_success_cloud.png)



#### 3. bcs-k8s-watch 组件手工部署方式

bcs-k8s-watch 组件用于集群内资源事件，导入已有集群时会自动部署 bcs-k8s-watch 组件，无需用户关注。有些环境下也有可能部署失败，需要手工再次部署，如果部署成功可以忽略本章内容

判断 bcs-k8s-watch 组件是否部署成功，有以下两种方式：

- 通过“事件查询”功能判断是否存在事件信息，如果列表为空代表 bcs-k8s-watch 组件部署不成功

  ![-w2020](../assets/watch_event_query.png)

- 通过资源视图查看 bcs-k8s-watch Pod 是否存在，不存在代表 bcs-k8s-watch 组件部署不成功

  ![-w2020](../assets/bcs_k8s_watch_pod.png)

重新部署 bcs-k8s-watch 组件方式如下：

- 在组件库启用 bcs-k8s-watch 组件

  ![-w2020](../assets/enable_bcs_k8s_watch.png)

  ![-w2020](../assets/enable_bcs_k8s_watch_info.png)

- 获取 bcs-k8s-watch 启用所需信息

  BK_BCS_clusterId：集群ID，例如：BCS-K8S-40000，可以在集群列表里获取

  ![-w2020](../assets/cluster_list.png)

  

  BK_BCS_customStorage：蓝鲸容器管理平台后台模块 bcs-storage 的地址，逻辑架构如下：

  ![-w2020](../assets/event_data_process.png)

  bcs-storage 的地址需要去“蓝鲸”项目下的集群“蓝鲸 7.0（BCS-K8S-00000）”中获取，具体有两种使用方法，选其一即可

  - 使用 Loadbalancer 方案（有高可用）

    如果集群“蓝鲸 7.0（BCS-K8S-00000）”配置了 ingress，可以使用 ingress 地址，具体查询命令

    `kubectl get ingress stack-bcs-api-gateway-http -n bcs-system`

    查看 HOSTS 字段是否有配置，如果有配置，ingress 域名解析的目的地址一定是一个 Loadbalancer 的 VIP，需要在这个 Loadbalancer 上配置 bcs-storage 模块的端口转发规则，如下图

    ![-w2020](../assets/ingress_trans.png)

    bcs-storage 的 NodePort 获取命令如下，服务端口 50024 冒号后面的就是 bcs-storage 的 NodePort 端口，这里的 NodePort 端口是 31024，创建 Loadbalancer 规则时，VPORT 与 NodePort 最好保持一致，这里的 VPORT 也设置为 31024 即可

    `kubectl get svc bcs-storage -n bcs-system`

    ![-w2020](../assets/get_bcs_storage_port.png)

    要保证业务集群的出口 IP 可以连接这个 Loadbalance 的 VIP 与 VPORT，可以通过设置防火墙安全组等操作完成

    最后参数 BK_BCS_customStorage 的参考值如下：

    BK_BCS_customStorage：https://{ingress 的 HOSTS 字段值}:31024

    - 首先要使用 https 协议

    - 域名是 ingress 的 HOSTS 字段值，域名需要解析到 Loadbalancer 的 VIP

    - 端口为 Loadbalancer 的 VPORT

      

  - 使用 NodePort（无高可用）

    如果在部署蓝鲸的时候没有使用 ingress，我们也可以用 NodePort 解决这个问题，首先需要获取 bcs-storage 模块的 NodePort，方法和上面 ingress 里获取 NodePort 的方法一样

    bcs-storage 的 NodePort 获取命令如下，服务端口 50024 冒号后面的就是 bcs-storage 的 NodePort 端口，这里的 NodePort 端口是 31024

    `kubectl get svc bcs-storage -n bcs-system`

    ![-w2020](../assets/get_bcs_storage_port.png)

    要保证业务集群的出口 IP 可以连接蓝鲸 7.0 集群（BCS-K8S-00000）的任一节点 IP，可以通过设置防火墙安全组等操作完成

    

    因为使用了https协议，证书里绑定了域名，我们不能直接通过蓝鲸7.0集群（BCS-K8S-00000）的任一节点IP连接bcs-storage，需要先在业务集群的coredns里提前配置好hosts，使用证书里默认绑定的域名“bcs-api-gateway”来访问bcs-storage，操作方法如下：plainplainplain

    `kubectl edit cm coredns -n kube-system`

    添加以下内容：

    ```
            hosts {
              1.1.1.1 bcs-api-gateway
              fallthrough
            }
            # 1.1.1.1 是集群“蓝鲸蓝鲸7.0”任意一台node ip，最好是master
    ```

      ![](../assets/coredns_hosts.png)

    操作完毕后需要保证业务集群内可以正常解析bcs-api-gateway到蓝鲸7.0集群（BCS-K8S-00000）的任一节点IP

    最后参数BK_BCS_customStorage的参考值如下：

    BK_BCS_customStorage：https://bcs-api-gateway:31024

    - 首先要使用https协议
    - 域名为bcs-api-gateway
    - 端口为bcs-storage的NodePort端口

    注意：NodePort方案的缺点是没有高可用，如果在部署bcs-k8s-watch组件时填写的蓝鲸7.0集群（BCS-K8S-00000）的任一节点IP服务器下线后，bcs-k8s-watch组件将无法正常连接到bcs-storage，需要手动在coredns里修改hosts配置，把bcs-api-gateway解析替换成另一个蓝鲸7.0集群（BCS-K8S-00000）的节点IP

    

    连接bcs-storage所需证书内容获取，证书内容包括 ca_crt，tls_crt，tls_key，具体获取方法如下：

    通过webconsole或ssh到集群“蓝鲸蓝鲸7.0”

    ![-w2020](../assets/webconsole_login.png)

      ```shell
      # 在集群中执行如下命令
      kubectl get secret bcs-gateway-bcs-services-stack -n bcs-system -o yaml
      
      # 把ca.crt、tls.crt、tls.key内容逐个做base64解密
      echo -n LS0tLS1CRUdJTiBSU0...|base64 -d
      
      ```

    把ca.crt、tls.crt、tls.key解密的内容填充到启用bcs-k8s-watch组件时所需参数的ca_crt，tls_crt，tls_key里即可，以下是bcs-k8s-watch组件部署参数示例，部署组件时替换里面的参数内容即可

    ```yaml
    env:
      BK_BCS_clusterId: BCS-K8S-40000
      BK_BCS_customStorage: https://bcs-api-gateway:31024
    secret:
      bcsCertsOverride: true
      ca_crt: |
        -----BEGIN CERTIFICATE-----
        MIIBiTCCAS6gAwIBAgIQFa9cbqrXTOjmR/bacdg7kTAKBggqhkjOPQQDAjAkMSIw
        IAYDVQQDExliY3MtY2EtYmNzLXNlcnZpY2VzLXN0YWNrMB4XDTIyMTAxNzA3Mjgw
        ...
        MKwY5LDu7uB1mWUjQg==
        -----END CERTIFICATE-----
      tls_crt: |
        -----BEGIN CERTIFICATE-----
        MIIDZjCCAw2gAwIBAgIQSje2zlODYH2m7eiqiwN59zAKBggqhkjOPQQDAjAkMSIw
        IAYDVQQDExliY3MtY2EtYmNzLXNlcnZpY2VzLXN0YWNrMB4XDTIzMDQxODA5NDk1
        ...
        p6GLxggykVlbzg==
        -----END CERTIFICATE-----
      tls_key: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEowIBAAKCAQEAr9L7A1CtvfjEQ36S1vBBGbFi2Lb1kXiyed4FWZia5+8pptKB
        1+O7iEUrP6GzFyeFfJ+7A2Cmnz7cLb7Yr0eGWvUc++2rH9vWCfLrzyzDem9jxIWn
        ...
        3BBU3cK4g1UwNLslfh0RSI3/AIS9/iVC6tVRDXuchfU8hVsZAWR3
        -----END RSA PRIVATE KEY-----
    ```

    ![-w2020](../assets/bcs_k8s_watch_deployment.png)

    部署完后查看组件状态与事件查询是否有内容

    ![-w2020](../assets/bcs_k8s_watch_deployment_status.png)

    ![-w2020](../assets/event_query_content.png)
