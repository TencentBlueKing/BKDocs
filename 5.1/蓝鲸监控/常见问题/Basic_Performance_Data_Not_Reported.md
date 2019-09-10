## 基础性能数据未上报
### 1. 检测CMDB是否有快照数据显示
若没有数据，则进入下列步骤检测
若有数据，先检查bkdata所在机器crontab里是否有update_cc_cache.sh的项目。若无则先运行`bkeec install cron`。若有联系蓝鲸技术支持同学。

-----
### 2. 检查进程
agent机器：有进程则ok

#### 2.1 Linux
>ps -ef | grep basereport

#### 2.2 Windows
>tasklist | findstr basereport

-----
### 3. 若进程检测失败
查看进程启动失败原因

#### 3.1 Linux
> ./basereport -c ../etc/basereport.conf

#### 3.2 Windows
> basereport.exe -c ../etc/basereport.conf

-----
### 4. 检查连接
agent机器：有正常连接ESTABLISHED则ok

#### 4.1 Linux
>netstat -tnp | grep 58625

#### 4.2 Windows
>netstat -ano | grep 58625

若存在proxy，proxy机器：检测58625端口同上。并检查gse_transit进程是否正常（成对出现）

GSE_IP和GSE_IP1机器：检测9092端口

#### 4.3 Linux
>netstat -tnp | grep 9092

#### 4.4 Windows
>netstat -ano | grep 9092

-----
### 5. 检查配置
ZK_IP机器：查看ZK节点
		>/data/bkee/service/zk/bin/zkCli.sh -server ip:2181 (ip通常为zk本机内网IP)
	get /gse/config/etc/dataserver/data/1001

	正常会出现类似下面的数据结构
```
	{"server_id": -1, "data_set": "snapshot", "partition": 1, "cluster_ind	ex": 0, "biz_id": 2, "msg_system": 1}
```

topic为data_set和biz_id组成，则
topic=snapshot2
能获取到topic则OK

-----
### 6. 检查数据
KAFKA_IP机器上：查看KAFKA最新数据，等待1分钟查看是否有数据，有数据则OK

```json
cd /data/bkee/service/kafka/
zkaddr=`cat config/server.properties | grep common_kafka | cut -d '=' -f 2`
sh bin/kafka-topics.sh --list --zookeeper $zkaddr
sh bin/kafka-console-consumer.sh --bootstrap-server $LAN_IP:9092--topic $topic（第5步查询到的）
```

-----
### 7. 检查日志
GSE_IP和GSE_IP1机器：
> ps -ef | grep gse_data
cd /data/bkee/public/gse/data
ls -l

看有没有gse_datapid开头命名的日志
若有，tail查看日志内容


