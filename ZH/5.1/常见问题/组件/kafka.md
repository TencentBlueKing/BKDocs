# Kafka 常见问题

## Kafka 常用操作

Kakfa 查询 topic

```bash
$ /data/bkce/service/kafka/bin/kafka-topics.sh --zookeeper zk.service.consul:2181/common_kafka --describe | grep Topic
```

查看 topic 状态

```bash
$ /data/bkce/service/kafka/bin/kafka-topics.sh --zookeeper zk.service.consul:2181/common_kafka --describe --topic connect-configs.tsdb
```

查看 topic 能否读

```bash
$ /data/bkce/service/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka.service.consul:9092 --topic connect-configs.tsdb --from-beginning | head
```

确认实时的 topic 能否读

```bash
$ /data/bkce/service/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka.service.consul:9092 --topic connect-configs.etl --from-beginning | head
```

## Kafka broker 节点缺失

若社区版为 3 台部署的，必须返回[1, 2, 3]才正常，示例如下
若brokers ids不为[1, 2, 3]，可能存在`/data/bkce/public/kafka/.lock`文件，有的话，删除此文件，再重新使用`./bkcec stop kafka`和`./bkcec start kafka`重启kafka，重启完再次确认状态

```bash
[root@rbtnode1 /data/install]# /data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 ls /common_kafka/brokers/ids
Connecting to zk.service.consul:2181
log4j:WARN No appenders could be found for logger (org.apache.zookeeper.ZooKeeper).
log4j:WARN Please initialize the log4j system properly.
log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
WATCHER::

WatchedEvent state:SyncConnected type:None path:null
[1, 2, 3]
```

## kafka 数据或日志清理

> Kafka 将数据持久化到了硬盘上，允许配置一定的策略对数据清理，清理的策略有两个，删除和压缩
>
> 严格注意：下面清理策略，请根据实际业务，服务器状况，及需求来定制

有如下 2 种方式进行设置

方式一：通过调整配置文件

```bash
# 配置文件位置
/data/bkce/service/kafka/config/server.properties

# 可以增加log.cleanup.policy这个数据清理方式设置，此行为为删除动作
log.cleanup.policy=delete

# 下面有2种方式，保留时间或大小，请自行根据实际情况调整此处设置，1G为1073741824。具体保留大小根据实际情况设置
# 注意：下面为直接删除，删除后的消息不可恢复
log.retention.hours=168（超过指定时间168小时后，删除旧的消息）
log.retention.bytes=10737418240（超过指定大小10G后，删除旧的消息）
```

设置完毕，重启服务来生效

方式二：Kakfa 设置 Topic 过期时间

```bash
# 设置过期时间，只能用毫秒（retention.ms），或者bytes（retention.bytes）
$ /data/bkce/service/kafka/bin/kafka-topics.sh --zookeeper zk.service.consul:2181/common_kafka --topic snapshot2 --alter --config retention.ms=17280000
$ WARNING: Altering topic configuration from this script has been deprecated and may be removed in future releases.
		  Going forward, please use kafka-configs.sh for this functionality
$ updated config for topic "snapshot2"
```

## Kafka gse_data 报错

在 gse 的模块 gse_data 的日志中，会出现有如下报错，这种是 Kafka 消息机制的正常行为，只要确定快照数据 OK，就可确认`gse_data->kafka->bkdata_>cmdb`的链路正常

```bash
     52 [2018-08-23 16:47:05.109] <11297--805308672>[ERROR][kafka_producer:18]KAFKA-3-ERROR: rdkafka#producer-15 10.X.X.X:9092/1: Receive failed: Disconnected
     53 [2018-08-23 16:47:05.614] <11297--318793984>[ERROR][kafka_producer:18]KAFKA-3-ERROR: rdkafka#producer-4 kafka.service.consul:9092/bootstrap: Receive failed: Disconnected
     54 [2018-08-23 16:52:05.198] <11297--176183552>[ERROR][kafka_producer:18]KAFKA-3-ERROR: rdkafka#producer-12 10.X.X.X:9092/1: Receive failed: Disconnected
     55 [2018-08-23 16:52:05.936] <11297--998275328>[ERROR][kafka_producer:18]KAFKA-3-ERROR: rdkafka#producer-14 10.178.181.35:9092/3: Receive failed: Disconnected
     56 [2018-08-23 16:57:05.115] <11297--956311808>[ERROR][kafka_producer:18]KAFKA-3-ERROR: rdkafka#producer-16 10.178.181.35:9092/3: Receive failed: Disconnected
     57 [2018-08-23 16:57:05.115] <11297--1166031104>[ERROR][kafka_producer:18]KAFKA-3-FAIL: rdkafka#producer-12 kafka.service.consul:9092/bootstrap: Receive failed: Disconnected
```
