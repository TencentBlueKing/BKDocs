# 集群管理

## 1. 启用容器服务
如果当前项目未启用过容器服务，会看到如下的启用页面。如果是管理员，这里会直接出现有权限的业务列表(业务列表来源于配置平台)；非管理员需要单独申请。
![-w2020](../assets/bcs_start.png)

可以点击【查看帮助】，了解如何申请业务权限。
![-w2020](../assets/bcs_auth.png)

通过绑定有权限的业务，正式【启用容器服务】
![-w2020](../assets/bcs_start1.png)


## 2. 创建集群
集群作为容器调度的基础，启用完容器服务后，首先需要创建集群。平台提供了两种创建集群的方式，一种是新建集群，另一种是导入已有集群。
![-w2020](../assets/cluster_create.png)

###  新建集群
####  创建集群 Master 节点

![-w2020](../assets/create_cluster_chioce.png)

点击展开更多设置，附加参数设置，此步骤为非必选，有特殊场景时才会使用到该参数

| 变量名         | 描述            | 默认值                |
| -------------- | --------------- | --------------------- |
| DOCKER_LIB     | Docker数据目录  | /data/bcs/lib/docker  |
| DOCKER_VERSION | Docker版本      | 19.03.9               |
| KUBELET_LIB    | kubelet数据目录 | /data/bcs/lib/kubelet |
| K8S_VER        | 集群版本        | 1.20.11               |
| K8S_SVC_CIDR   | 集群Service网段 | 10.96.0.0/12          |
| K8S_POD_CIDR   | 集群Pod网段     | 10.244.0.0/16         |

选择【新建集群】，通过【选择服务器】，完成 Master 节点的选择。
![-w2020](../assets/cluster_create_new.png)

点击【确定】后，开始创建集群。可以通过【查看日志】观察集群的创建过程。
![-w2020](../assets/cluster_create_process.png)

集群 Master 创建完成后，可以点击【总览】查看集群状态。
![-w2020](../assets/cluster_overview.png)

可以看到成功添加了一个 Master 节点。但其实当前集群并非可用，因为通常 Master 节点并不会设置成调度节点，而是需要添加 Node 节点(业务容器实际运行所在的主机)。
![-w2020](../assets/cluster_overview1.png)

#### 安装bcs-kube-agent组件

集群创建后还不能马上使用BCS SaaS管理集群，要做到管理集群的能力，必须安装好bcs-kube-agent，用于上报集群信息到bcs后台，具体操作如下：

- 注意：目前bcs-kube-agent只支持在BCS平台上创建的集群上安装，导入的集群无需安装，否则导入集群会出现异常

- 选择其中一台master角色服务器，如果master服务器上没有安装helm，可以执行下面命令安装，也可以自己去网上下载

  `wget https://bkopen-1252002024.file.myqcloud.com/ce7/tools/helm && chmod +x helm && mv helm /usr/bin/`

- 添加chart包镜像仓库

  ```shell
  helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
  helm repo add blueking-dev https://hub.bktencent.com/chartrepo/dev
  ```

- 如果命名空间bcs-system不存在，则需要创建命名空间

  `kubectl create ns bcs-system`

- bcs-gateway绑定hosts，解决bcs网关访问问题，可以把域名bcs-api-gateway绑定到集群“蓝鲸社区版7.0”任意一台node上，这个node最好是master角色

  `kubectl edit cm coredns -n kube-system`

  添加以下内容：

  ```
          hosts {
            1.1.1.1 bcs-api-gateway
            fallthrough
          }
          # 1.1.1.1 是集群“蓝鲸社区版7.0”任意一台node，最好是master
  ```

  ![](D:\社区版7.0文档\BKDocs\ZH\7.0\BCS\产品白皮书\assets\coredns_hosts.png)

- 创建bcs-kube-agent所需证书

  把以下内容保存到上一步集群master服务器上，文件名为：bcs-client-bcs-kube-agent.yaml

  ```
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

  通过webconsole或ssh到集群“蓝鲸社区版7.0”

  ![-w2020](../assets/webconsole_login.png)

  ```shell
  # 在集群中执行如下命令
  kubectl get secret bcs-gateway-bcs-services-stack -n bcs-system -o yaml
  ```

  把里面的ca.crt、tls.crt、tls.key里面的内容填充到bcs-client-bcs-kube-agent.yaml里

  执行 `kubectl apply -f bcs-client-bcs-kube-agent.yaml `创建好证书

- 通过helm chart安装bcs-kube-agent

  把以下内容保存文件为bcs-kube-agent-values.yaml

  ```
  global:
    serviceMonitor:
      enabled: false
    env:
      BK_BCS_clusterId: {集群ID}
  args:
    BK_BCS_API: https://bcs-api-gateway:31443
    BK_BCS_APIToken: {BK_BCS_APIToken}
    BK_BCS_reportPath: /bcsapi/v4/clustermanager/v1/clustercredential/%s
  image:
    registry: hub.bktencent.com/dev
    repository: blueking/bcs-kube-agent
    tag: v1.25.0-alpha.6
  ```

  把 {集群ID} 替换为目前你操作的集群ID，例如：BCS-K8S-40000

  {BK_BCS_APIToken}替换为以下命名获取的字符串，获取方法如下

  ```
  # 在集群 蓝鲸社区版7.0 上执行以下命令
  kubectl get secret bcs-password -n bcs-system -o yaml
  # 找到字段：gateway_token
  # base64解密：
  echo "gateway_token值"|base64 -d
  ```

  执行以下命令安装bcs-kube-agent

  ```
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


### 导入已有集群
除了可以新建集群，容器服务也支持用户导入已有的集群。
![-w2020](../assets/cluster_imported.png)

导入集群通过录入集群的kubeconfig来实现BCS对K8S的集群管控，可实现绝大多数K8S集群管控，但请注意以下两个先决条件：

- 集群“蓝鲸社区版7.0“所有节点服务器到被导入集群APIServer网络连通正常，如果APIServer有防火墙的，请开通网络策略
- 提供的kubeconfig用户是cluster-admin角色，否则会因为权限不足导致管控失败

支持集群范围：

- 用户自建集群
- 各种云厂商集群，如腾讯云TKE，Amazon EKS，Azure AKS，Google GKE等

目前导入集群功能还不支持使用证书的kubeconfig（正式发布后会支持证书kubeconfig），支持serviceaccount token，需在集群上执行以下命令获取token：

```
# 创建serviceaccount，并绑定cluster-admin权限
kubectl create --namespace default serviceaccount bcs
kubectl create clusterrolebinding bcs --clusterrole=cluster-admin --serviceaccount=default:bcs

# 获取token
kubectl get secret $(kubectl get sa bcs -n default -o jsonpath={.secrets[0].name}) -n default -o go-template='{{.data.token | base64decode}}'
```

如何获取kubeconfig，一般K8S集群的kubeconfig都保存在/root/.kube/config，例如：

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: xxxxxxxxxxxxxxxxxxxx
    server: https://apiserver.k8s.com
  name: cluserxxx
contexts:
- context:
    cluster: cluserxxx
    user: "11111111"
  name: cluserxxx-11111111-context-default
current-context: cls-n203bmqk-2990581962-context-default
kind: Config
preferences: {}
users:
- name: "11111111"
  user:
    client-certificate-data: xxxx=
    client-key-data: xxx==
```

去掉client-certificate-data，client-key-data字段，增加token字段，修改kubeconfig后，格式如下：

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: xxxxxxxxxxxxxxxxxxxx
    server: https://apiserver.k8s.com
  name: cluserxxx
contexts:
- context:
    cluster: cluserxxx
    user: "11111111"
  name: cluserxxx-11111111-context-default
current-context: cls-n203bmqk-2990581962-context-default
kind: Config
preferences: {}
users:
- name: "11111111"
  user:
    token: {获取的token值}
```

把修改完后的kubeconfig保存为文件config_type_token，然后执行：

```
kubectl get node --kubeconfig=./config_type_token
```

如果可以执行成功，代表这是个有效的token，下一步就可以开始导入集群了

![](../assets/import_kubeconfig.png)

导入集群成功后，等待1分钟左右，使用webconsole验证是否导入成功

![](../assets/import_success_test.png)

可以正常进入webconsole代表导入集群成功

![](../assets/import_success.png)