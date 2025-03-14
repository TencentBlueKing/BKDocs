# 新建K8S原生集群

本节介绍如何通过容器管理平台新建一个Kubernetes原生集群。

## 前提条件

- 已登录蓝鲸平台。
- 当前用户在权限中心已被授予容器管理平台（bk_bcs_app）的**项目查看**和**集群创建**权限。
- 用户在容器项目关联的CMDB业务中为**业务运维**角色。

## 新建步骤

### 1. 进入添加集群界面

在顶部导航栏中，选择**集群管理**进入集群管理页面，点击**添加集群**按钮。在新建集群分类中选择**K8S原生集群**。

### 2. 新建K8S原生集群

#### ①填写集群基本信息

- 基本信息
    - **集群名称**：填写1~64字符的集群名称。
    - **集群版本**：选择平台支持的原生Kubernetes版本。
    - **标签** (可选)：为集群设置标签以便管理。
    - **描述** (可选)：填写集群描述信息，将在集群基本信息页面展示。
- 集群环境
    - **所属区域**：选择平台提供支持的地域。
    - **集群环境**：选择集群环境类型（测试或正式）。
- 集群配置
    - **操作系统**：选择平台支持的操作系统类型。
    - **运行时组件**：选择容器运行时（docker或containerd）。
    - **运行时版本**：选择对应的运行时版本。

#### ②填写网络配置

- 基本配置
    - **私有网络**：选择自定义网络。
    - **默认网络插件**：暂仅支持[Flannel](https://github.com/flannel-io/flannel)(Overlay)
    - **集群IP类型**：支持IPv4，Kubernetes 1.23及以上版本支持IPv4/IPv6双栈。
- 容器网络分配
    - **Service IP**：设置Service的CIDR范围。
    - **Pod IP**：设置Pod的CIDR范围。
    - **单节点Pod数量上限**：选择每个节点的Pod数量上限（32、64、128、256）。

#### ③填写控制面配置

- **资源**：从CMDB业务主机拓扑中选择1台、3台或5台服务器。
- **Kube-apiserver高可用方案**：
    - **bcs-apiserver-proxy**：bcs-apiserver-proxy以daemonset形式部署在Kubernetes集群中，利用IPVS通过虚拟IP（VIP）实现集群内组件到APIserver的反向代理，并自动发现控制面节点IP以维护IPVS规则，确保部分控制面节点故障时集群正常运行。

#### ④填写节点配置

> 注：可选择跳过此步骤，后续再添加节点。

- **资源**：从CMDB业务主机拓扑中选择已有服务器。

#### ⑤确认并创建

确认所有配置正确后，点击**创建集群**按钮。系统将启动K8S集群创建流程，用户可通过集群列表中的**查看日志**关注集群创建进度。

## 后续步骤

- **节点管理**：集群创建后，用户可通过**节点列表**管理集群节点，执行操作如停止调度、设置标签、污点或删除节点。
