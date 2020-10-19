# DataBus

![](../media/dd20e57169cc15784fbbab136fd53091.png)

数据总线模块实现了数据清洗和分发入库环节。

清洗：从 Kakfa 对原始数据进行字段提取，转换成 Avro 格式（带压缩）写回 Kafka 待内部系统使用；

分发：从 Kafka 消费内部数据，按需入库到 MySQL 或 ElasticSearch 中。
