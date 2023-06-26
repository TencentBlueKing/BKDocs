# 容器服务
## 集群管理功能

> 集群管理主要是通过 OPS 及标准运维，管理集群的 master 及 node 的生命周期。

![-w2020](../media/be5b35287524b4a809e64220a6684e0e.jpg)
<center>集群管理功能架构图</center>

## WebConsole

![-w2020](../media/b628b49d7f03c7a23145f595acd571bc.png)
<center>WebConsole架构图</center>

WebConsole 是容器服务提供快捷查看集群状态的命令行服务，通过 Session 管理，POD 生命周期管理，操作审计等子模块完成一个易用，安全性高的 WebConsole 服务。

**Pod 生命周期管理：** 对集群的 WebConsole，每个用户会新建一个容器，如果用户 10 分钟不操作，平台会自动断开连接，如果超过 1 个小时未执行命令，平台主动回收 WebConsole 容器，减少资源占用。

**操作审计：** 用户任何操作以及命令行的返回，都有详细的操作记录。
