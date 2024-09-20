# Usage example

```py
# -*- coding: utf-8 -*-
import time
from bkdata.queue.kafka.consumer import BKKafkaConsumer
import logging
manager_server = '<BKQUEUE_SERVICE_HOST>' # Platform queue service address


def main():
     topics = ['queue_topic1'] # Fill in the subscribed topic, queue_table_name
     configs = {
         'data_token': 'xxx' #Token applied for on the platform
     }
     # logging.basicConfig(level=logging.DEBUG)
     c = BKKafkaConsumer(manager_server, **configs)
     print 'start', topics
     c.subscribe(topics)
     while True:
         msgs = c.consume(num_messages=5000, timeout=5)
         if len(msgs) == 0:
             print 'waiting'
             time.sleep(1)
             continue

         print 'get:', len(msgs)
         print msgs

         # msg detail
         for msg in msgs:
             print msg.topic(), msg.value(), msg.partition(), msg.offset(), msg.key()


if __name__ == '__main__':
     main()
```

# Main parameter description

| Parameters | Description |
| :--- | :--- |
| manager\_server | Platform queue service address: Find the corresponding variable in the `/data/install/local_spec.env` file of the central control computer: \<BKDATA_KAFKA_QUEUE_HOST>:\<BKDATA_KAFKA_QUEUE_PORT> |
| topics | Subscribed topic list, topic is &lt;queue\_table name&gt; |
| configs | client configuration |
| configs.data\_token | Authorization code, applied for by the platform |

# Function description

# subscribe\(self, topics\)

Subscribe to topic

* topics: subscribed topic list

## consume\(num\_messages=1, timeout=-1\)

Pull data in batches

* num\_messages: Pull the maximum number of records

* timeout: maximum timeout for pulling

Return format:

Message list list\(Message\)

Message contains the value, key, partition, etc. of the data.

* Get topic: msg.topic\(\)

* Get key: msg.key\(\)

* Get partition: msg.partition\(\)

...For more details see:

[https://docs.confluent.io/current/clients/confluent-kafka-python/index.html\#message](https://docs.confluent.io/current/clients/confluent-kafka-python/index .html#message)

## close\(\)

Close client

## subscription\(\)

Returns the subscribed topic list

## unsubscribe\(\)

Unsubscribe, suspend client

# Reference documentation

python client package confluent-kafka-python library

Documentation so you can refer to:

[https://docs.confluent.io/current/clients/confluent-kafka-python/index.html](https://docs.confluent.io/current/clients/confluent-kafka-python/index.html)

