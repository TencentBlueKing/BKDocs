>本文简单介绍了容器化版相关说明，同时详细介绍了容器化版蓝鲸各产品、组件和 release、charts 包的说明，以及各个服务对应 pod 的主要功能，建议在部署容器化版前，阅读此篇文章，对容器化版蓝鲸有大致的了解，以便理解容器化整体的形态及部署过程遇到某个流程异常的排查。


# 部署前须知

## 容器化蓝鲸基本认识
1. 容器化蓝鲸对应的版本号是 7.x，相较于 6.X 最大的区别主要是部署方式的改变，6.X 是二进制部署。
2. 容器化版蓝鲸不是简单的拉起一个镜像 Docker run，平台涉及多个自研模块及诸多开源组件，是基于 K8S 改造的全平台容器化形态
3. 容器化版蓝鲸的搭建部署、运行维护需要一定的容器知识基础，包括不限于 Docker、K8S、helm 等；


## 一些有用的相关文档分享
- [K8S 官方文档](https://kubernetes.io/zh/docs/home/)
- [helm 官方文档](https://helm.sh/zh/docs/)
- [了解 helmfile](https://cloud.tencent.com/developer/article/1766822)
- [kubectl 命令](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [Docker 官方文档](https://docs.docker.com/get-started/)
- [chart 仓库介绍](http://www.coderdocument.com/docs/helm/v2/charts/intro_to_charts.html)
- K8S 基本概念快速预览
	- **Master**: k8s 的主控组件，对应的对象是 node。
	- **Node**: 是 k8s 集群的机器节点，相当于 master-node。一个 node 就对应一个具体的物理机或者虚拟机。
	- **Container**: 是一个镜像容器，一个 container 是一个镜像实例
	- **Pod**: 是 k8s 集群的最小单元，一个 pod 可以包含一个或者多个 container
	- **Service**: 多个相同的 pod 组成一个服务，统一对外提供服务。
	- **Volume**: 存储卷，pod 对外暴露的共享目录，它可以挂载在宿主机上，这样就能让同 node 上多个 pod 共享一个目录。
	- **Replication Controller**: 用于控制 pod 集群的控制器，可以制定各种规则来让它控制一个 service 中的多个 pod 的创建和消亡, 很多地方简称为 rc。
	- **Namespace**: 命名空间，用于将一个 k8s 集群隔离成不同的空间，pod, service, rc, volume 都可以在创建的时候指定其 namespace。
	- **StatefulSet**: 有状态集群，比如一个主从的 mysql 集群就是有状态集群，需要先启动主再启动从，这就是一种有状态的集群。
	- **Persistent Volume**: 持久存储卷。之前说的 volume 是挂载在一个 pod 上的，多个 pod(非同 node)要共享一个网络存储，就需要使用持久存储卷，简称为 pv。
	- **Persistent Volume Claim**: 持久存储卷声明。他是为了声明 pv 而存在的，一个持久存储，先申请空间，再申明，才能给 pod 挂载 volume，简称为 pvc。
	- **Label**: 标签。我们可以给大部分对象概念打上标签，然后可以通过 selector 进行集群内标签选择对象概念，并进行后续操作。
	- **Secret**: 私密凭证。密码保存在 pod 中其实是不利于分发的。k8s 支持我们创建 secret 对象，并将这个对象打到 pod 的 volume 中，pod 中的服务就以文件访问的形式获取密钥。
	- **EndPoint**: 用于记录 service 和 pod 访问地址的对应关系。只有 service 配置了 selector, endpoint controller 才会自动创建 endpoint 对象

# 下一步
前往《[准备资源及环境](prepare.md)》文档。
