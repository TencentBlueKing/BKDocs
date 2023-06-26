# 安装 CMDB 详解

CMDB 是蓝鲸的配置平台，数据库采用 MongoDB ，服务发现和配置管理使用 ZooKeeper ，缓存队列使用 Redis 存储。

CMDB 的架构可以参考 GitHub 上的 [蓝鲸智云配置平台的架构设计](https://github.com/Tencent/bk-cmdb/blob/master/docs/overview/architecture.md)

CMDB 开源版的部署说明，可以参考 [CMDB 部署文档](https://github.com/Tencent/bk-cmdb/blob/master/docs/overview/installation.md)。

蓝鲸社区版集成 CMDB 时主要在自动化配置和进程托管上进行了规范化改造。

## 配置 CMDB 

CMDB 的主要依赖是 MongoDB 实例，逻辑上，需要 2 个 MongoDB 实例，分别对应主数据库 cmdb，和事件库 cmdb_events。
在环境变量配置中，对应的变量名是：

```bash
BK_CMDB_MONGODB_HOST=mongodb.service.consul
BK_CMDB_MONGODB_PORT=27017
BK_CMDB_MONGODB_USERNAME=cmdb
BK_CMDB_MONGODB_PASSWORD=
BK_CMDB_EVENTS_MONGODB_HOST=mongodb.service.consul
BK_CMDB_EVENTS_MONGODB_PORT=27017
BK_CMDB_EVENTS_MONGODB_USERNAME=cmdb_events
BK_CMDB_EVENTS_MONGODB_PASSWORD=
BK_CMDB_EVENTS_MONGODB_DATABASE=cmdb_events
```

第二个依赖 Redis，它的配置变量，对应单实例的 Redis

```bash
BK_CMDB_REDIS_HOST=redis.service.consul
BK_CMDB_REDIS_PORT=6379
BK_CMDB_REDIS_MASTER_NAME=
BK_CMDB_REDIS_PASSWORD=
```

第三个依赖 zookeeper，它的配置变量比较简单：BK_CMDB_ZK_ADDR=zk.service.consul:2181。

第四个依赖是可选依赖，如果需要开启全文检索功能，需要配置 elasticsearch （7.x.x 版本） 的地址和认证方式。本文不作介绍。

## 安装 CMDB

需要特别注意的是 `CMDB` 先启动，再初始化数据：

```bash
./bkcli sync cmdb
./bkcli install cmdb
./bkcli start cmdb
./bkcli initdata cmdb
```

详解：

1. 安装配置平台: `/data/install/bin/install_cmdb.sh -e  /data/install/bin/04-final/cmdb.env -s /data/src/ -p /data/bkce`
2. 注册配置平台各进程的 consul 服务
3. 启动配置平台: 

    - 先启动 cmdb-admin 服务：`systemctl start bk-cmdb-admin`，然后等待 `cmdb-admin.service.consul` 可以解析后，再进行下一步
    - 调用 cmdb-admin 的接口，初始化数据库
    - 启动 cmdb-auth 服务： `systemctl start bk-cmdb-auth`，等待 `cmdb-auth.service.consul` 可以解析后，再进行下一步
    - 调用 cmdb-auth 的接口，注册权限中心业务模型
    - 启动 cmdb 其他进程 `systemctl start bk-cmdb.target` 
