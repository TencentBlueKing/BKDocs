# TDBank

通过为数据处理配置 TDBank 下游节点，可将计算结果数据导入 TDBank 系统中，从而支持海量数据聚合分析。

图例，TDBank 节点
![](../../../../assets/dataflow/components/storage/dataflow-tdbank.png)

#### 节点配置
- 节点名称： 自动生成，由上游结果表和当前节点类型组成
- 结果数据表：从上游节点继承过来
- BID：通常可选有默认集群组集群，其它可选集群与任务所属项目相关
- TdBank 地址：需要输入相应的 TDBank 地址
- KV 分隔符：需要输入 KV 之间的分隔符， 用做分隔 KV
- 记录分隔符：需要输入每条记录之间的分隔符， 用做分隔记录


配置例子如下：

![](../../../../assets/dataflow/components/storage/dataflow-tdbank-example.png)

