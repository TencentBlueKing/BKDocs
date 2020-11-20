# 基础性能数据未上报
## 检测 CMDB 是否有快照数据显示
若没有数据，则进入下列步骤检测
若有数据，先检查 bkdata 所在机器 crontab 里是否有 update_cc_cache.sh 的项目。若无则先运行`./bkcec install cron`。若有联系[蓝鲸技术支持同学](https://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDgwMjAwMV80NDMwOTZfODAwODAyMDAxXzJf)。

## 检查进程
agent 机器：有进程则 ok

### Linux
>ps -ef | grep basereport

### Windows
>tasklist | findstr basereport


## 若进程检测失败
查看进程启动失败原因

切换到 cd /usr/local/gse/plugins/bin/目录下
### Linux
> ./basereport -c ../etc/basereport.conf

### Windows
> basereport.exe -c ../etc/basereport.conf

## 检查连接
agent 机器：有正常连接 ESTABLISHED 则 ok

### Linux
>netstat -tnp | grep 58625

### Windows
>netstat -ano | grep 58625

若存在 proxy，proxy 机器：检测 58625 端口同上。并检查 gse_transit 进程是否正常（成对出现）

GSE_IP 和 GSE_IP1 机器：检测 9092 端口

### Linux
>netstat -tnp | grep 9092

### Windows
>netstat -ano | grep 9092

## 检查配置
ZK_IP 机器：查看 ZK 节点
		>/data/bkce/service/zk/bin/zkCli.sh -server ip:2181 (ip通常为zk本机内网IP)plainplainplainplainplainplainplainplain
	get /gse/config/etc/dataserver/data/1001

	正常会出现类似下面的数据结构
	
```bash
	{"server_id": -1, "data_set": "snapshot", "partition": 1, "cluster_ind	ex": 0, "biz_id": 2, "msg_system": 1}
```

topic 为 data_set 和 biz_id 组成，则
topic=snapshot2
能获取到 topic 则 OK

## 检查数据
KAFKA_IP 机器上：查看 KAFKA 最新数据，等待 1 分钟查看是否有数据，有数据则 OK

```json
cd /data/bkce/service/kafka/
zkaddr=`cat config/server.properties | grep common_kafka | cut -d '=' -f 2`
sh bin/kafka-topics.sh --list --zookeeper $zkaddr
sh bin/kafka-console-consumer.sh --bootstrap-server $LAN_IP:9092--topic $topic（第5步查询到的）
```

## 检查日志
GSE_IP 和 GSE_IP1 机器：
> ps -ef | grep gse_data
cd /data/bkce/public/gse/data
ls -l

看有没有 gse_datapid 开头命名的日志
若有，tail 查看日志内容
