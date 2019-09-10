# 配置平台FAQ

## CMDB无快照数据

> 此文档描述4.0及以上的社区版的问题排查
>
> Windows主机暂不支持快照数据

**表象**：配置管理系统的实时状态显示`当前主机没有安装Agent或者Agent已经离线`

**原因**

1. gse及gse_agent状态不正常
2. bkdata的快照数据任务不存在
3. kafka内节点或topic数据异常

**思路方法**

- **检查模块状态**
  - 确定cmdb，gse，gse_agent，zk，kafka模块的状态是否正常，可以使用`./bkcec status XXX模块`来确认
- **检查cmdb日志**

```
检查/data/bkce/log/cmdb/cmdb_datacollection.INFO文件
出现ccapi.go93] fail to get configure, will get again，表示不正常
返回hostsnap.go:xxx] master check : iam still master，表示正常
检查cmdb_datacollection.ERROR文件，确认是否出现err:fail to connect zookeeper. err：lookup zk.service.consul等
如果日志出现“subcribing channel 2_snapshot”后没有subChan Close，那么表明收数据协程正常工作
如果上述条都正常，但没有”handle xx num mesg, routines xx“，说明通道里没数据，请到redis里 subscribe ${biz}_snapshot 确认通道是否没数据，参考如下检查redis数据方法
```

- **gse agent采集端排查**

```bash
# 检查进程是否存在，basereport进程存在且唯一
Linux： ps -ef | grep basereport
Windows: tasklist | findstr basereport

# 若进程不存在，手动启动，检查启动失败的原因
Linux: cd /usr/local/gse/plugins/bin && ./basereport -c ../etc/basereport.conf
Windows(cygwin): cd /cygdrive/c/gse/plugins/bin/ && ./basereport -c ../etc/basereport.conf
Windows(无cygwin) : cd C:/gse/plugins/bin/ && start.bat basereport

# 检查数据上报连接，有正常ESTABLISHED的链接则ok
# 若存在proxy，登陆proxy机器：检测58625端口同上
Linux netstat -antp | grep 58625 | grep ESTABLISHED
Windows netstat -ano | grep 58625
```

- **gse服务端排查**

```bash
# 登陆 GSE后台服务器，检测 gse_data 是否连上9092端口:
Linux: lsof -nP -c dataWorker | grep :9092
Windows: netstat -ano | grep 9092

# 看有没有 gse_data 的pid 开头命名的日志。 若有，tail查看日志内容
datapid=$(pgrep -x dataWorker)
ls -l /data/bkce/public/gse/data/${datapid}*
```

- **检查kafka**
	- 登陆任意 KAFKA 机器：查看KAFKA最新数据，等待1分钟查看是否有数据。 如果有数据，在最后一行命令后加上`| grep $ip` $ip用无快照数据的ip替换， 再次查看是否有数据

```bash
# 登录到kafka所在的机器上
$ source /data/install/utils.fc
/data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 get /gse/config/etc/dataserver/data/1001
# 确认存在topic
zkaddr=`cat /data/bkce/service/kafka/config/server.properties | grep common_kafka | cut -d '=' -f 2`
topic=`bash /data/bkce/service/kafka/bin/kafka-topics.sh --list --zookeeper $zkaddr|grep ^snap`

# 查看topic中的最新数据
bash /data/bkce/service/kafka/bin/kafka-console-consumer.sh --zookeeper $zkaddr --topic $topic
# 每隔一分钟会上报数据，有数据上报侧表示正常
```

- **检查bkdata**

```bash
# 快照数据对应bkdata，databus的redis任务，需确认databus状态下的redis任务是否存在
$ bash /data/bkce/bkdata/dataapi/bin/check_databus_status.sh
# 检查是否存在如下redis任务
===========REDIS===============
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    25  100    25    0     0    142      0 --:--:-- --:--:-- --:--:--   142
redis_1001_2_snapshot
{"name":"redis_1001_2_snapshot","connector":{"state":"RUNNING","worker_id":"x.x.x.x:10053"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"x.x.x.x:10053"}]}
==========================

# 若上述任务不存在，可能在初始化bkdata数据时异常，可以采用如下方法重新创建，先确认init_bkdata_snapshot是否存在
$ ll /data/bkce/.init_bkdata_snapshot
$ rm -f /data/bkce/.init_bkdata_snapshot
$ deactivate
$ source /data/install/utils.fc
$ init_bkdata_snapshot
# 再根据上面的重新确认是否有redis任务
```

- **检查redis通道**

```bash
# 此步主要检查redis内是否有快照数据，在redis服务器上
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
```

## CMDB无主机信息

**表象**：CMDB内主机信息为空

**原因**

1. gse安装异常或gse数据初始化不对
2. gse_agent安装异常

**思路办法**

原因1：参考GSE数据初始化失败解决方法，需要更新GSE版本中的初始化程序文件on_migrate和parse_bizid，路径`/data/bkce/gse/server/bin`

原因2：重装gse_agent