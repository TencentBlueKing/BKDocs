# Redis 常见问题

## Redis 密码修改

> 如下指引，若无特殊说明，全部在中控机`/data/install`目录进行

### 停止 Redis

```bash
./bkcec stop redis
```

### 修改 Redis 密码

修改 globals.env 里的 REDIS_PASS 值，密码不要包含 [ ] / : @ ? 等特殊字符

### 同步 install 目录

```bash
./bkcec sync common
```

### 重新生成配置

```bash
echo bkdata fta gse job cmdb paas redis | xargs -n 1 ./bkcec render
```

### 关闭相关服务

```bash
echo bkdata fta gse job cmdb paas | xargs -n 1 ./bkcec stop
```

### 更新 ZooKeeper 内 Redis 密码

此步有 2 种方式，推荐方式 1

方式 1：通过命令修改 zk 内 redis 密码

```bash
# 修改方法，注意把引号内新密码调整为redis的新密码，密码不要包含 [ ] / : @ ? 等特殊字符
$ /data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181
Connecting to zk.service.consul:2181
Welcome to ZooKeeper!
JLine support is enabled
[zk: zk.service.consul:2181(CONNECTED) 0]
WATCHER::

WatchedEvent state:SyncConnected type:None path:null

# 此处获取到老密码
[zk: zk.service.consul:2181(CONNECTED) 0] get /gse/config/etc/dataserver/storage/all/0_1
([{"host":"redis.service.consul","port":6379,"type":4,"passwd":"老密码位置"}])
cZxid = 0x100000096
ctime = Mon Aug 20 11:32:05 CST 2018
mZxid = 0x200015eec
mtime = Thu Aug 23 19:38:04 CST 2018
pZxid = 0x100000096
cversion = 0
dataVersion = 5
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 79
numChildren = 0

# 此处使用set命令，设置新密码，严格按照上面获取的串，仅修改密码位置
[zk: zk.service.consul:2181(CONNECTED) 1] set /gse/config/etc/dataserver/storage/all/0_1 [{"host":"redis.service.consul","port":6379,"type":4,"passwd":"新密码"}]

# 可以再查询是否为新的密码，为新的密码表示OK
[zk: zk.service.consul:2181(CONNECTED) 1] get /gse/config/etc/dataserver/storage/all/0_1
```

方式 2：可以通过重新安装 gse 来实现

```bash
./bkcec stop gse
./bkcec install gse 1
./bkcec start gse
```

### 修改 bkdata databus 的配置

在 bkdata 服务器上修改`/data/bkce/bkdata/databus/conf/redis.cluster.properties`配置，新增`connector.redis.auth=新密码`配置

注意新密码不要用任何符号引起来，类似单引号，双引号

```bash
connector.redis.auth=新密码
```

### 启动服务验证

```bash
echo redis paas cmdb gse job bkdata fta | xargs -n 1 ./bkcec start
```

确保 JOB，CMDB，蓝鲸监控等模块功能全部 OK
