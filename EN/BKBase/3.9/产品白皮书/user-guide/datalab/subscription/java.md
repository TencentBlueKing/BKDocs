# 使用示例

```java
package com.tencent.bkdata.queue.clients.consumer;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.Properties;

public class BkKafkaConsumerDemo {
    private static Logger logger = LoggerFactory.getLogger(BkKafkaConsumerDemo05.class);

    public static void main(String[] args) throws InterruptedException {

        Properties properties = new Properties();
        //SASL 认证授权配置

        // 认证协议
        properties.put(BkConsumerConfig.SECURITY_PROTOCOL_CONFIG, "SASL_PLAINTEXT");
        // 认证机制
        properties.put(BkConsumerConfig.SASL_MECHANISM_CONFIG, "SCRAM-SHA-512");
        // jaas token
        properties.put(BkConsumerConfig.SASL_JAAS_TOKEN_CONFIG, "xxx");
        // 队列服务管理端地址
        properties.put(BkConsumerConfig.BKQUEUE_SERVICE_URL_CONFIG, "xx.xx.xx.xx");

        //是否后台自动提交offset 到kafka
        properties.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, true);

        //消费者偏移自动提交到Kafka的频率（以毫秒为单位enable.auto.commit）设置为true
        properties.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");

        //故障检测，心跳检测机制 的间隔时间，，在该值范围内，没有接收到心跳，则会删除该消费者
        //并启动再平衡（rebanlance）,值必须在group.min.session.timeout 和 group.max.session.timeout.ms之间
        properties.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, "30000");

        //key - value 的序列化类
        properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
        properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
        BkKafkaConsumer consumer = new BkKafkaConsumer(properties);

        //订阅主题
        consumer.subscribe(Arrays.asList("topic1", "topic2"));

        while (true) {
            //拉取数据
            ConsumerRecords<String, String> consumerRecords = consumer.poll(1000);
            if (consumerRecords == null || consumerRecords.isEmpty()) {
                Thread.sleep(2000);
            }
            for (ConsumerRecord record : consumerRecords) {
                //打印结果
                logger.info("Got record: topic:{}  key:{}  value:{}  offset:{}  partition:{} \n",
                        new Object[]{record.topic(), record.key(), record.value(), record.offset(), record.partition()});
            }
        }

    }

}

```

# 主要参数说明

| 参数 | 说明 |
| :--- | :--- |
| BKQUEUE\_SERVICE\_URL\_CONFIG | 计算平台队列服务地址：在中控机的 `/data/install/local_spec.env` 文件中找到对应的变量： \<BKDATA_KAFKA_QUEUE_HOST>:\<BKDATA_KAFKA_QUEUE_PORT> |
| SASL\_JAAS\_TOKEN\_CONFIG | 授权码, 计算平台申请到的 |

# 消费端 Api 目录

| 序号| 接口名                                                       | 接口简介                                       | 和原生差异性                                                 |
| :--- | :--- |:--- |:--- |
| 1    | BkKafkaConsumer(Map<String, Object> configs)                 | 构造函数                                       | 以下配置项必须正确配置才能使用队列服务的消费端 api 消费数据# 认证协议<br/>security.protocol=SASL_PLAINTEXT<br/># 认证机制<br/>sasl.mechanism=SCRAM-SHA-512<br/># jaas 用户名<br/>sasl.jaas.user=xxx<br/># jaas 密码<br/>sasl.jaas.password=xxx<br/># 蓝鲸队列服务管理端地址<br/>bkqueue.service.url=xx.xx.xx.xx |
| 2    | BkKafkaConsumer(Properties properties)                       | 构造函数                                       | 以下配置项必须正确配置才能使用队列服务的消费端 api 消费数据# 认证协议<br/>security.protocol=SASL_PLAINTEXT<br/># 认证机制<br/>sasl.mechanism=SCRAM-SHA-512<br/># jaas 用户名<br/>sasl.jaas.user=xxx<br/> jaas 密码<br/>sasl.jaas.password=xxx<br/># 蓝鲸队列服务管理端地址<br/>bkqueue.service.url=xx.xx.xx.xx |
| 3    | subscribe(Collection<String> topics)                         | 订阅主题 | 支持多集群多 topic 订阅，topic 自动发现                         |
| 4   | subscribe(Collection<String> topics, ConsumerRebalanceListener listener) | 订阅主题，指定回调函数                         | 支持多集群多 topic 订阅，topic 自动发现                         |
| 5    | subscribe(Pattern pattern, ConsumerRebalanceListener listener) | 订阅主题，支持正则表达式                       | 支持多集群多 topic 订阅，topic 自动发现                         |
| 6    | unsubscribe()                                                | 取消订阅                                       | 无差异                                                       |
| 7    | poll(long timeout)                                           | 批量拉取消息                                   | 支持多集群多 topic 消费，并且支持集群自动发现和切换            |
| 8     | commitSync()                                                 | 同步提交 offset                                 | 无差异                                                       |
| 9     | commitSync(Map<TopicPartition, OffsetAndMetadata> offsets)   | 指定分区和 offset 提交                           | 无差异                                                       |
| 10 | commitAsync()                                                | 异步提交 offset                                 | 无差异                                                       |
| 11   | commitAsync(OffsetCommitCallback callback)                   | 异步提交 offset，指定回调函数                   | 无差异                                                       |
| 12   | commitAsync(Map<TopicPartition, OffsetAndMetadata> offsets, OffsetCommitCallback callback) | 异步提交 offset，并指定分区和 offset 以及回调函数 | 无差异                                                       |
| 13   | position(TopicPartition partition)                           | 获取下一条记录的 offset                         | 无差异                                                       |
| 14   | committed(TopicPartition partition)                          | 获取指定分区最后一次提交的 offset               | 无差异                                                       |
| 15   | metrics()                                                    | 获取所有订阅主题对应 consumer 的 Metrics          | 无差异                                                       |
| 16   | partitionsFor(String topic)                                  | 获取所有订阅主题的所有分区信息                 | 无差异                                                       |
| 17   | listTopics()                                                 | 获取所有订阅的主题以及对应的分区列表映射       | 无差异                                                       |
| 18   | beginningOffsets(Collection<TopicPartition> partitions)      | 获取指定分区最后一次提交的 offset               | 无差异                                                       |
| 19   | endOffsets(Collection<TopicPartition> partitions)            | 获取指定分区的最近 offset                       | 无差异                                                       |
| 20   | close()                                                      | 关闭消费者实例                                 | 无差异                                                       |
| 21  | close(long timeout, TimeUnit unit)                           | 关闭消费者实例                                 | 无差异                                                       |

# 参考文档

java 客户端是基于 kafka-clients-0.10.2.0（scala-2.11）封装的 kafka 客户端，相比于原生的客户端，
支持集群自动发现和自动切换
