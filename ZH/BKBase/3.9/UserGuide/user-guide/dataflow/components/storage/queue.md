# Queue

Queue 节点底层为基于 Kafka 的消息队列服务，支持实时订阅数据。

图例，Queue 节点
![](../../../../assets/dataflow/components/storage/dataflow-queue.png)

#### 节点配置
- 节点名称： 自动生成，由上游结果表和当前节点类型组成
- 结果数据表：从上游节点继承过来
- 存储集群：通常可选有默认集群组集群，其它可选集群与任务所属项目相关
- 过期时间：数据入库后保存的过期时间

配置例子如下：

![](../../../../assets/dataflow/components/storage/dataflow-queue-example.png)
