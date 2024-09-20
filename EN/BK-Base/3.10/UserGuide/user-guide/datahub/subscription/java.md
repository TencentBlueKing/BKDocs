# Usage example

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
         //SASL authentication and authorization configuration

         // Authentication protocol
         properties.put(BkConsumerConfig.SECURITY_PROTOCOL_CONFIG, "SASL_PLAINTEXT");
         // Authentication mechanism
         properties.put(BkConsumerConfig.SASL_MECHANISM_CONFIG, "SCRAM-SHA-512");
         // jaas token
         properties.put(BkConsumerConfig.SASL_JAAS_TOKEN_CONFIG, "xxx");
         //Queue service management end address
         properties.put(BkConsumerConfig.BKQUEUE_SERVICE_URL_CONFIG, "xx.xx.xx.xx");

         //Whether to automatically submit offset to kafka in the background
         properties.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, true);

         //How often consumer offsets are automatically committed to Kafka (in milliseconds enable.auto.commit) set to true
         properties.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");

         //Fault detection, heartbeat detection mechanism interval time, within this value range, if no heartbeat is received, the consumer will be deleted
         //And start rebalancing (rebanlance), the value must be between group.min.session.timeout and group.max.session.timeout.ms
         properties.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, "30000");

         //Serialization class of key - value
         properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
         properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
         BkKafkaConsumer consumer = new BkKafkaConsumer(properties);

         //Subscribe to topic
         consumer.subscribe(Arrays.asList("topic1", "topic2"));

         while (true) {
             //Pull data
             ConsumerRecords<String, String> consumerRecords = consumer.poll(1000);
             if (consumerRecords == null || consumerRecords.isEmpty()) {
                 Thread.sleep(2000);
             }
             for (ConsumerRecord record : consumerRecords) {
                 //Print results
                 logger.info("Got record: topic:{} key:{} value:{} offset:{} partition:{} \n",
                         new Object[]{record.topic(), record.key(), record.value(), record.offset(), record.partition()});
             }
         }

     }
}

```
# Main parameter description

| Parameters | Description |
| :--- | :--- |
| BKQUEUE\_SERVICE\_URL\_CONFIG | Platform queue service address: Find the corresponding variable in the `/data/install/local_spec.env` file of the central control computer: \<BKDATA_KAFKA_QUEUE_HOST>:\<BKDATA_KAFKA_QUEUE_PORT> |
| SASL\_JAAS\_TOKEN\_CONFIG | Authorization code, applied for by the platform |

# Consumer API directory

| Serial number | Interface name | Introduction to the interface | Differences from native |
| :--- | :--- |:--- |:--- |
| 1 | BkKafkaConsumer(Map<String, Object> configs) | Constructor | The following configuration items must be configured correctly to use the consumer API of the queue service to consume data # Authentication protocol<br/>security.protocol=SASL_PLAINTEXT<br/># Authentication mechanism<br/>sasl.mechanism=SCRAM-SHA-512<br/># jaas username<br/>sasl.jaas.user=xxx<br/># jaas password<br/>sasl.jaas.password =xxx<br/># BlueKing Queue Service Management End Address<br/>bkqueue.service.url=xx.xx.xx.xx |
| 2 | BkKafkaConsumer(Properties properties) | Constructor | The following configuration items must be configured correctly to use the consumer API of the queue service to consume data # Authentication protocol<br/>security.protocol=SASL_PLAINTEXT<br/># Authentication mechanism<br/ >sasl.mechanism=SCRAM-SHA-512<br/># jaas username<br/>sasl.jaas.user=xxx<br/> jaas password<br/>sasl.jaas.password=xxx<br/> # BlueKing Queue Service Management End Address<br/>bkqueue.service.url=xx.xx.xx.xx |
| 3 | subscribe(Collection<String> topics) | Subscribe to topics | Support multi-cluster and multi-topic subscriptions, topic automatic discovery |
| 4 | subscribe(Collection<String> topics, ConsumerRebalanceListener listener) | Subscribe to a topic, specify the callback function | Support multi-cluster and multi-topic subscription, topic automatic discovery |
| 5 | subscribe(Pattern pattern, ConsumerRebalanceListener listener) | Subscribe to topics, support regular expressions | Support multi-cluster and multi-topic subscriptions, topic automatic discovery |
| 6 | unsubscribe() | Unsubscribe | No difference |
| 7 | poll(long timeout) | Batch pull messages | Support multi-cluster and multi-topic consumption, and support automatic cluster discovery and switching |
| 8 | commitSync() | Synchronous commit offset | No difference |
| 9 | commitSync(Map<TopicPartition, OffsetAndMetadata> offsets) | Specify partition and offset commit | No difference |
| 10 | commitAsync() | Asynchronous commit offset | No difference |
| 11 | commitAsync(OffsetCommitCallback callback) | Asynchronously commit offset, specify callback function | No difference |
| 12 | commitAsync(Map<TopicPartition, OffsetAndMetadata> offsets, OffsetCommitCallback callback) | Submit offset asynchronously, and specify the partition, offset and callback function | No difference |
| 13 | position(TopicPartition partition) | Get the offset of the next record | No difference |
| 14 | committed(TopicPartition partition) | Get the last committed offset of the specified partition | No difference |
| 15 | metrics() | Get the Metrics of consumers corresponding to all subscription topics | No difference |
| 16 | partitionsFor(String topic) | Get all partition information of all subscribed topics | No difference |
| 17 | listTopics() | Get all subscribed topics and corresponding partition list mapping | No difference |
| 18 | beginningOffsets(Collection<TopicPartition> partitions) | Get the last committed offset of the specified partition | No difference |
| 19 | endOffsets(Collection<TopicPartition> partitions) | Get the latest offset of the specified partition | No difference |
| 20 | close() | Close the consumer instance | No difference |
| 21 | close(long timeout, TimeUnit unit) | Close the consumer instance | No difference |

# Reference documentation

The java client is a kafka client encapsulated based on kafka-clients-0.10.2.0 (scala-2.11). Compared with the native client,
Support automatic cluster discovery and automatic switching