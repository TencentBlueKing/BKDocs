# 安装 GSE 详解

GSE 分后台和 agent/proxy 的安装，GSE 后台由部署脚本安装，agent/proxy 由节点管理 SaaS 负责安装和日常管理。

GSE 后台的部署依赖主要有：redis、zookeeper、mongodb

## 配置 GSE

GSE 的环境变量配置文件（./bin/04-final/gse.env）需要注意的配置项：

1. MongoDB 相关配置

```bash
BK_GSE_MONGODB_HOST=mongodb.service.consul
BK_GSE_MONGODB_PORT=27017
BK_GSE_MONGODB_USERNAME=gse
BK_GSE_MONGODB_PASSWORD=
```

2. Redis 相关配置。 GSE 使用的 Redis，必须和 GSE 同机部署（更准确点说，要和 gse_dba 进程同机部署），所以配置项里没有 HOST 的选项，只提供端口和密码

```bash
BK_GSE_REDIS_PASSWORD=
BK_GSE_REDIS_PORT=6379
```

3. Zookeeper 相关配置。 需要注意 BK_GSE_ZK_AUTH 值，第一次配置后，不可修改，因为 zk 节点已经被加密。


## 安装 GSE

```bash
./bkcli install gse
./bkcli initdata gse
./bkcli start gse
```

说明：

1. 初始化 zookeeper 上的基础节点，使用脚本: `./bin/create_gse_zk_base_node.sh` 和 `./bin/create_gse_zk_dataid_1001_node.sh`
2. 安装 GSE： `./bin/install_gse.sh -e ./bin/04-final/gse.env -s /data/src -p /data/bkce -b $LAN_IP`
3. 启动 GSE 后台进程 `systemctl start bk-gse.target`
