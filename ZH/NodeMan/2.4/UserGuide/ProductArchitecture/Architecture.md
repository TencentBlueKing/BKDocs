# 产品架构

节点管理是基于 SSH 通信链路或者 Windows 的 3389 远程端口，实现批量主机的 Agent 安装。

如果企业需要管理不同管控区域的主机，只需要每个区域提供一台带有外网 IP 的 Linux 主机作为代理(Proxy)主机，同区域内其他云主机只需要和 Proxy 通信就可以实现跨网络管理。

![-w2020](../media/assets/architecture.png)


