# 安装环境

- 操作系统

Linux CentOS 6.5+

- 网络要求

1000Mb

- 网络策略

保证 CMDB 与 MongoDB，Redis，Zookeeper 联通，以保证 CMDB 正常运行

保证 CMDB 与 PAAS 连通，以保证 CMDB 登录模块正常运行

保证 CMDB 与数据平台的 Redis 联通，以保证 CMDB 的 datacollection 模块正常运行

> **注意：**保质个服务之间的防火墙策略
