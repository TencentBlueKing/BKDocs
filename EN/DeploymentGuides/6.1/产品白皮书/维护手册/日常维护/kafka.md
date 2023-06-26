# Kafka

Kafka 在蓝鲸架构中，用于数据上报通道的队列缓存。在数据链路中，生产者是 GSE 组件的 `gse_data` 进程，将 agent 上报的监控时序数据或者日志采集数据
写入到 kafka 集群。消费者是监控后台的 `transfer` 进程，将队列中的数据消费，清洗，并入库到相应存储中。

## Kafka 搭建

1. 搭建 kafka 使用的 Zookeeper 集群。（详见：[Zookeeper](./zookeeper.md)）
2. 安装 JDK

   ```bash
   /data/install/bin/install_java.sh -p /data/bkce -f /data/src/java8.tgz
   ```

3. 安装 kafka

   ```bash
   /data/install/bin/install_kafka.sh -j kafka_ip1,kafka_ip2,kafka_ip3 -z zk1_ip1,zk_ip2,zk_ip3/common_kafka -b <kafka本机监听的网卡地址> -d /data/bkce/public/kafka -p 9092
   ```

4. 根据需要注册 consul 的服务名

   ```bash
   /data/install/bin/reg_consul_svc -n kafka -p 9092 -a <kafka本机监听的网卡地址> -D > /etc/consul.d/service/kafka.json
   consul reload
   ```

## Kafka 常用操作

- 查看 topics：`/opt/kafka/bin/kafka-topics.sh --describe --zookeeper zk.service.consul:2181/common_kafka`
- 查看 topic 配置：`/opt/kafka/bin/kafka-configs.sh --zookeeper zk.service.consul:2181/common_kafka --entity-type topics --entity-name snapshot2 --describe`
- 修改 per-topic 配置：[官方文档](http://kafka.apache.org/documentation.html#topicconfigs) `/opt/kafka/bin/kafka-configs.sh --zookeeper zk.service.consul:2181/common_kafka --entity-type topics --entity-name snapshot2 --alter --add-config retention.bytes=1073741824`

## Kafka 扩容

当接入的数据越来越多，原有的 broker，cpu 和磁盘均告急时，需要扩容 broker 来缓解 kafka 压力。

Kafka 官方文档关于扩容集群的说明见：https://kafka.apache.org/0100/documentation.html#basic_ops_cluster_expansion

在蓝鲸下可以使用以下步骤来完成扩容：

1. 如果是新机器，请先按照通用的扩容步骤，做好初始化。（详见：[组件扩容](./scale_node.md)）
2. 通过 yum 安装 kafka：`yum -y install kafka` 应该会从 bk-custom 这个仓库中安装 kafka 0.10.2.0 版本
3. 将原 kafka 机器的 /etc/kafka/server.properties 文件拷贝到新节点，并修改内网 ip 地址和 `broker.id` 的配置，id 在 kafka 集群中必须保持唯一。
4. 创建必要数据目录：`install -d -o kafka -g kafka /data/bkce/public/kafka`
5. 启动 kafka：`systemctl enable --now kafka`
6. 可以在 zk 的节点上(/brokers/ids)确认新扩容的 kafka 的 broker id 出现。

扩容完成后，新的 broker，如果没有新的 Topic 创建，它不会承载任何数据，除非手动迁移老的数据到新的 broker。

现在假设按整个 topic 迁移到新的 broker 上。待迁移的 topic 名字为 "0bkmonitor_5243810" 和 "0bkmonitor_5243810"，目标 broker 为 "4,5"

1. 编辑 ~/topic.json 

    ```json
    {"topics": [{"topic": "0bkmonitor_5243810"},
            {"topic": "0bkmonitor_5244020"}],
    "version":1
    }
    ```

2. 运行命令生成 json 描述

    ```bash
    $ cd /opt/kafka 
    $ bin/kafka-reassign-partitions.sh --zookeeper zk.service.consul/common_kafka --topics-to-move-json-file ~/topic.json --broker-list "4,5" --generate
    Current partition replica assignment
    {"version":1,"partitions":[{"topic":"0bkmonitor_5243810","partition":0,"replicas":[1,2]},{"topic":"0bkmonitor_5244020","partition":0,"replicas":[2,1]}]}

    Proposed partition reassignment configuration
    {"version":1,"partitions":[{"topic":"0bkmonitor_5243810","partition":0,"replicas":[5,4]},{"topic":"0bkmonitor_5244020","partition":0,"replicas":[5,4]}]}
    ```

3. 拷贝上一步输出中 "Proposed partition reassignment configuration" 行下方的 json 到文件 ~/reasign_topic.json 
4. 运行命令发起重分配

    ```bash
    $ cd /opt/kafka
    $ ./bin/kafka-reassign-partitions.sh --zookeeper zk.service.consul/common_kafka --reassignment-json-file ~/reasign_topic.json  --execute
    Current partition replica assignment

    {"version":1,"partitions":[{"topic":"0bkmonitor_5243810","partition":0,"replicas":[1,2]},{"topic":"0bkmonitor_5244020","partition":0,"replicas":[2,1]}]}

    Save this to use as the --reassignment-json-file option during rollback
    Successfully started reassignment of partitions.
    ```

5. 可以使用 `--verify` 参数确认重分配的进度

    ```bash
    $ ./bin/kafka-reassign-partitions.sh --zookeeper zk.service.consul/common_kafka --reassignment-json-file ~/reasign_topic.json  --verify
    Status of partition reassignment: 
    Reassignment of partition [0bkmonitor_5243810,0] is still in progress
    Reassignment of partition [0bkmonitor_5244020,0] is still in progress
    ```
