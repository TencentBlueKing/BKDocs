# 配置平台常见问题

## CMDB 无快照数据

> 此文档描述 4.0 及以上的问题排查
>
> Windows 主机暂不支持快照数据

**表象**：配置管理系统的实时状态显示`当前主机没有安装 Agent 或者 Agent 已经离线`。

**原因**

1. gse 及 gse_agent 状态不正常
2. bkdata 的快照数据任务不存在
3. kafka 内节点或 topic 数据异常

**思路方法**

- 检查模块状态

  - 确定 cmdb，gse，gse_agent，zk，kafka 模块的状态是否正常，可以使用 `./bkeec status XXX模块` 来确认

- **检查 cmdb 日志**

```bash
检查/data/bkee/log/cmdb/cmdb_datacollection.INFO文件
出现ccapi.go93] fail to get configure, will get again，表示不正常
返回hostsnap.go:xxx] master check : iam still master，表示正常
检查cmdb_datacollection.ERROR文件，确认是否出现err:fail to connect zookeeper. err：lookup zk.service.consul等
如果日志出现“subcribing channel 2_snapshot”后没有subChan Close，那么表明收数据协程正常工作
如果上述条都正常，但没有”handle xx num mesg, routines xx“，说明通道里没数据，请到redis里 subscribe ${biz}_snapshot 确认通道是否没数据，参考如下检查redis数据方法
Copy
```

- **gse agent 采集端排查**

```bash
# 检查进程是否存在，basereport 进程存在且唯一
Linux： ps -ef | grep basereport
Windows: tasklist | findstr basereport

# 若进程不存在，手动启动，检查启动失败的原因
Linux: cd /usr/local/gse/plugins/bin && ./basereport -c ../etc/basereport.conf
Windows(cygwin): cd /cygdrive/c/gse/plugins/bin/ && ./basereport -c ../etc/basereport.conf
Windows(无cygwin) : cd C:/gse/plugins/bin/ && start.bat basereport

# 检查数据上报连接，有正常 ESTABLISHED 的链接则 ok
# 若存在 proxy，登录 proxy 机器：检测 58625 端口同上
Linux netstat -antp | grep 58625 | grep ESTABLISHED
Windows netstat -ano | grep 58625
Copy
```

- **GSE 服务端排查**

```bash
# 登录 GSE 后台服务器，检测 gse_data 是否连上 9092 端口:
Linux: lsof -nP -c dataWorker | grep :9092
Windows: netstat -ano | grep 9092

# 看有没有 gse_data 的 pid 开头命名的日志。 若有，tail 查看日志内容
datapid=$(pgrep -x dataWorker)
ls -l /data/bkee/public/gse/data/${datapid}*
Copy
```

- 检查 kafka
  - 登录任意 KAFKA 机器：查看 KAFKA 最新数据，等待 1 分钟查看是否有数据。 如果有数据，在最后一行命令后加上`| grep $ip` $ip 用无快照数据的 ip 替换， 再次查看是否有数据

```bash
# 登录到 kafka 所在的机器上
$ source /data/install/utils.fc
/data/bkee/service/zk/bin/zkCli.sh -server zk.service.consul:2181 get /gse/config/etc/dataserver/data/1001
# 确认存在 topic
zkaddr=`cat /data/bkee/service/kafka/config/server.properties | grep common_kafka | cut -d '=' -f 2`
topic=`bash /data/bkee/service/kafka/bin/kafka-topics.sh --list --zookeeper $zkaddr|grep ^snap`

# 查看 topic 中的最新数据
bash /data/bkee/service/kafka/bin/kafka-console-consumer.sh --zookeeper $zkaddr --topic $topic
# 每隔一分钟会上报数据，有数据上报侧表示正常
Copy
```

- **检查 bkdata**

```bash
# 快照数据对应 bkdata，databus的 redis 任务，需确认 databus 状态下的 redis 任务是否存在
$ bash /data/bkee/bkdata/dataapi/bin/check_databus_status.sh
# 检查是否存在如下 redis 任务
===========REDIS===============
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    25  100    25    0     0    142      0 --:--:-- --:--:-- --:--:--   142
redis_1001_2_snapshot
{"name":"redis_1001_2_snapshot","connector":{"state":"RUNNING","worker_id":"x.x.x.x:10053"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"x.x.x.x:10053"}]}
==========================

# 若上述任务不存在，可能在初始化 bkdata 数据时异常，可以采用如下方法重新创建，先确认 init_bkdata_snapshot 是否存在
$ ll /data/bkee/.init_bkdata_snapshot
$ rm -f /data/bkee/.init_bkdata_snapshot
$ deactivate
$ source /data/install/utils.fc
$ init_bkdata_snapshot
# 再根据上面的重新确认是否有 redis 任务
Copy
```

- **检查 redis 通道**

```bash
# 此步主要检查 redis 内是否有快照数据，在 redis 服务器上
source /data/install/utils.fc
$ redis-cli -h $REDIS_IP -p $REDIS_PORT -a $REDIS_PASS
10.X.X.X:6379> AUTH "REDIS密码"
OK
10.X.X.X:6379> SUBSCRIBE 2_snapshot
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "2_snapshot"
3) (integer) 1
1) "message"
2) "2_snapshot"
3) "{\"localTime\": \"2018-08-15 11:18:00\", \"data\": \"{\\\"beat\\\":{\\\"address\\\":
Copy
```

## CMDB 无主机信息

**表象**：CMDB 内主机信息为空。

**原因**

1. gse 安装异常或 gse 数据初始化不对
2. gse_agent 安装异常

**思路办法**

原因 1：参考 GSE 数据初始化失败解决方法，需要更新 GSE 版本中的初始化程序文件 on_migrate 和 parse_bizid，路径`{BK_PATH}/gse/server/bin`(BK_PATH为蓝鲸的安装路径，二进制版本中一般为`/data/bkce`或`/data/bkee`)

原因 2：重装 gse_agent
