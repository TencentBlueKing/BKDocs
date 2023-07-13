# Druid

通过为数据处理配置 Druid 下游节点，可将计算结果数据导入 Druid 系统中，从而支持海量数据聚合分析。

图例，Druid 节点
![](../../../../assets/dataflow/components/storage/dataflow-druid.png)

#### 节点配置
- 节点名称： 自动生成，由上游结果表和当前节点类型组成
- 结果数据表：从上游节点继承过来
- 存储集群：通常可选有默认集群组集群，其它可选集群与任务所属项目相关
- 过期时间：数据入库后保存的过期时间

配置例子如下：

![](../../../../assets/dataflow/components/storage/dataflow-druid-example.png)

对于运行中的任务，双击节点后，在数据查询标签页可对 Druid 中的数据进行查询：
![](../../../../assets/dataflow/components/storage/dataflow-druid-query.png)
