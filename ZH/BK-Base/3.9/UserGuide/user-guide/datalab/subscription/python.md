# 使用示例

```py
# -*- coding: utf-8 -*-
import time
from bkdata.queue.kafka.consumer import BKKafkaConsumer
import logging

manager_server = '<BKQUEUE_SERVICE_HOST>'  # 计算平台队列服务地址


def main():
    topics = ['queue_topic1']  # 填写订阅的topic, queue_table_name
    configs = {
        'data_token': 'xxx'  # 在计算平台申请到的token
    }
    # logging.basicConfig(level=logging.DEBUG)
    c = BKKafkaConsumer(manager_server, **configs)
    print 'start', topics
    c.subscribe(topics)
    while True:
        msgs = c.consume(num_messages=5000, timeout=0)
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

# 主要参数说明

| 参数 | 说明 |
| :--- | :--- |
| manager\_server | 计算平台队列服务地址：在中控机的 `/data/install/local_spec.env` 文件中找到对应的变量： \<BKDATA_KAFKA_QUEUE_HOST>:\<BKDATA_KAFKA_QUEUE_PORT> |
| topics | 订阅的 topic 列表, topic 为&lt;queue\_表名&gt; |
| configs | 客户端配置 |
| configs.data\_token | 授权码, 计算平台申请到的 |

# 函数说明

# subscribe\(self, topics\)

订阅 topic

* topics: 订阅的 topic 列表

## consume\(num\_messages=1, timeout=-1\)

批量拉取数据

* num\_messages: 拉取最大记录数

* timeout: 拉取最大超时时间

返回格式:

消息列表 list\(Message\)

Message 包含数据的 value,key,partition 等等.

* 获取 topic: msg.topic\(\)

* 获取 key: msg.key\(\)

* 获取 partition: msg.partition\(\)

...

更详细可参见:

[https://docs.confluent.io/current/clients/confluent-kafka-python/index.html\#message](https://docs.confluent.io/current/clients/confluent-kafka-python/index.html#message)

## close\(\)

关闭客户端

## subscription\(\)

返回已订阅的 topic 列表

## unsubscribe\(\)

取消订阅, 暂停客户端

# 参考文档

python 客户端封装 confluent-kafka-python 库

文档所以可以参考:

[https://docs.confluent.io/current/clients/confluent-kafka-python/index.html](https://docs.confluent.io/current/clients/confluent-kafka-python/index.html)

