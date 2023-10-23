# 快速构建 Nginx 集群
## 情景

传统的 Nginx 集群要先部署多个 Nginx 节点，然后通过 `upstream` 统一一个入口提供给用户访问。

该过程操作繁琐，接下来看 BCS（容器管理平台） 如何通过 **容器调度** 快速构建 Nginx 集群。

## 前提条件

- [K8S 基本概念](https://kubernetes.io/zh/docs/concepts/)，包含  [Deployment](https://kubernetes.io/zh/docs/concepts/workloads/controllers/deployment/)、[Services](https://kubernetes.io/docs/concepts/services-networking/service/)。

- [完成 BCS 部署](../../../../DeploymentGuides/6.0/产品白皮书/增强包安装/机器评估/bcs_evaluate.md)
- 准备 2 台云主机：4 核 8 G，不低于 CentOS 7，K8s Master 和 Node 各 1 台
- 完成上述 2 台云主机的 [Agent 安装](../../../../NodeMan/2.0/产品白皮书/Feature/Agent.md) ，并分配至 [CMDB 业务下](../../../../CMDB/3.9/UserGuide/产品功能/ResourcePool.md)

## 操作步骤

1. 新建集群

2. BCS 快速构建 Nginx 集群

## 新建集群
### 启用容器服务

在 BCS 首页，点击`新建项目`，如`欢乐游戏(demo)`。

![-w1378](../assets/15648362836651.jpg)

然后选择容器编排类型为 `Kubernetes` ，关联 *前提条件* 中提到的 CMDB 业务，点击`启用容器服务`。

![-w1304](../assets/15648364147641.jpg)

### 新建集群

`启用容器服务`后，进入容器服务欢迎页，点击`创建容器集群`。

![-w1361](../assets/15648365448905.jpg)

按提示填写集群的基本信息。

![-w1368](../assets/15648366557109.jpg)

> 容器服务的集群划分和 [传统单体应用在 CMDB 中的集群划分](../../../../CMDB/3.9/UserGuide/场景案例/CMDB_management_hosts.md) 很类似，可以按照`地域（如华北区）`或者`完全独立的应用集合（微信区）`来划分。

选择 1 台云主机作为 Master。

![-w1368](../assets/15648366389029.jpg)

点击`确定`后，集群开始初始化。

![-w1368](../assets/15648367382011.jpg)

点击`节点管理`

![-w1363](../assets/15648839802641.jpg)

点击`添加节点`，按提示节点添加。

![-w1368](../assets/15648840282881.jpg)

至此，新建集群完毕。可以看到集群的基础信息。

![-w1487](../assets/15648861584543.jpg)

另外，在集群的设置(**⋮**)下拉菜单中，可以看到集群主要性能指标。

![-w1488](../assets/15648861821783.jpg)

## BCS 快速构建 Nginx 集群

### 新建命名空间

新建命名空间`dev`。

![-w1462](../assets/15652519427953.jpg)

### 新建模板集

模板集，可以类比为 K8S 中 **[Helm](https://helm.sh/)** 的`Charts`，在 K8S 编排中，是 K8S 对象的集合：`Deployment（无状态）`、`StatefulSet（有状态）`、`DaemonSet（守护进程集）`、`Job（定时任务）`、`Configmap（配置项）`、`Secret（保密字典）`，具体参见 [模板集使用介绍](../Function/TemplateIntroduce.md) 。

打开菜单`[模板集]`，新建模板集`web-nginx`。

![-w1466](../assets/15652520004880.jpg)

按提示，填写`Deployment`

![-w1465](../assets/15652532175601.jpg)

![-w1462](../assets/15652535815272.jpg)

填写`Service`

![-w1458](../assets/15652542476126.jpg)

### 实例化

![-w1470](../assets/15652543011285.jpg)

![-w1466](../assets/15652545088426.jpg)

### 检查部署效果

在菜单`网络` -> `Services`中，找到刚实例化的 Service `web-nginx`。

![-w1465](../assets/15652551496895.jpg)

在菜单`[应用]` -> `[Deployment]`中可以找到 `web-nginx`。

![-w1464](../assets/15652552229901.jpg)

以及其运行指标：

![-w1463](../assets/15652552369974.jpg)

通过访问 `Node+NodePort`，可以查看刚刚部署 Nginx 集群的版本号。

```bash
[root@ip-10-0-5-94-n-bcs-k8s-40015 ~]# curl 10.0.5.94:30008 -I
HTTP/1.1 200 OK
Server: nginx/1.12.2
Date: Thu, 08 Aug 2019 09:11:42 GMT
```

通过访问`Service IP + Port`，也可以查看刚部署 Nginx 的版本号。

```bash
[root@ip-10-0-5-94-n-bcs-k8s-40015 ~]# curl 10.254.11.4:8088 -I
HTTP/1.1 200 OK
Server: nginx/1.12.2
Date: Thu, 08 Aug 2019 09:12:33 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 11 Jul 2017 13:29:18 GMT
Connection: keep-alive
ETag: "5964d2ae-264"
Accept-Ranges: bytes
```
