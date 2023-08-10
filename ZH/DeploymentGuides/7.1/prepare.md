# 资源准备

## 网络要求
因为下载的镜像较大，所以推荐公网带宽至少为 50Mbps。如果带宽过低，则任意导致不能及时拉取镜像，导致部署失败。

1. 中控机（部署前文件下载，以及部署开始时下载 charts）：
   1. 需要能访问蓝鲸静态文件分发站点：`https://bkopen-1252002024.file.myqcloud.com`。
   2. 需要能访问蓝鲸 Helm repo：`https://hub.bktencent.com/`。
2. k8s 集群（部署期间需要联网下载容器镜像）：
   1. 需要能访问 Docker Hub： `https://docker.io` 等。
   2. 需要能访问蓝鲸 Docker registry： `https://hub.bktencent.com/`。

## 中控机硬件
你需要一台机器执行部署操作。我们沿用惯例称其为“中控机”。后续对蓝鲸进行维护操作时，相关命令也是预期在中控机执行。

建议你复用已有的运维机。如果计划设立单独的中控机，配置只需要 2 核 2GB 内存 100GB 磁盘即可。

系统推荐为 CentOS 7。暂未测试部署脚本在其他发行版下的兼容性。

>**提示**
>
>如果你没有单独的中控机，也可复用 k8s 集群的其中一台 `master` 机器。

## k8s 集群硬件数量及软件
### 集群角色
>**注意**
>
>k8s 社区习惯以 `master` 和 `node` 称呼集群角色，本文沿用此习惯。但是 k8s 官网文档中已经将二者统称为 “node”（节点）。
>
>故除非另有说明，部署文档中的 `node` 一词默认不包含 `master`。当指代二者集合时，我们会使用 “全部 node” 来称呼。

如果你选择自建 k8s 集群，则需根据类型准备合乎规格的机器（物理机或虚拟机均可）：
* `master`，也称为 `master-node`。 负责 k8s 集群本身的管理调度，配置至少为 4 核心 8GB 内存 100GB 磁盘。
* `node` 负责承载业务运行。建议每台机器配置至少为 8 核心 32GB 内存 100GB 磁盘。

### 资源评估表
我们整理了各套餐所需的 node 数量。如果你的硬件配置和“集群角色”章节中推荐规格不同，请自行折算。

|蓝鲸套餐 | 描述 | 最低配置 | 推荐配置 | 备注 |
| -- | -- | -- | -- | -- |
|基础套餐 | 后台及 SaaS | 2.5 台 node | 3 台 node | |
|容器管理平台 | 容器管理后台及 SaaS | 0.7 台 node | 1 台 node | |
|监控套餐 | 监控、日志服务及其 SaaS | 1.5 台 node | 2 台 node | 如启用容器监控，k8s 集群存储应大于 500G |
|持续集成套餐 | 目前仅包含流水线 | 2 台 node | 5 台 node | 流水线任务较多时需扩容 node |

### 软件要求
| 需求项 | 具体要求 | 检查命令 |
| -- | -- | -- |
| 操作系统 | CentOS 7.9 64 位 | `cat /etc/centos-release` |
| kernel | 3.10.0 及以上 | `uname -r` |
| Swap | 关闭。防止 io 飙升影响 kubelet 进程。 | `free -m` Swap 这行值为 0 |
| 防火墙 | 关闭 | `iptables -vnL` 无其他规则 |
| SELinux | 关闭。k8s 官方要求。 | `getenforce` 的输出为 Disabled |
| 时区 | 所有服务器时区应该统一，建议使用北京时间 | 使用 `timedatectl set-timezone Asia/Shanghai` 设置为北京时间。 |
| 时间同步 | etcd 选举时要求节点间时间差小于 1s | 配置 `chronyd` 同步时间 |
| docker 版本 | 19.03 及更高 | `docker version` |
| kubenetes 版本 | 限 1.20，其他版本未经测试。用户报告 1.22 以上版本不兼容，1.17 版本部署 bcs 会失败。 | `kubectl version` |


<a id="get-a-k8s-cluster" name="get-a-k8s-cluster"></a>

# 下一步
准备 K8S 集群。

我们适配了如下的场景，请点击前往章节获得对应场景的操作指引：
* [使用蓝鲸提供的 bcs.sh 脚本快速部署 k8s 集群](get-k8s-create-bcssh.md)
* [使用现有的 k8s 集群](get-k8s-import-kubeconfig.md)
* [购买腾讯云 TKE 服务](get-k8s-purchase-tke.md)（其他厂商提供 K8S 集群同理）
