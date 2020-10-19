# 安装环境

-   **操作系统**

    Linux CentOS 6.5+

-   **网络要求**

    其他节点1000Mb，NodeManager节点和DataNode节点要求万兆网卡。

-   **YUM源**

    默认

-   **网络策略**

    保证与Kafka、Zookeeper、Mysql、ESB、Redis间端口联通，**注意所有端口必须绑定在内网IP，禁止使用0.0.0.0**

    **保证NameNode 主备节点可以SSH互通。**
