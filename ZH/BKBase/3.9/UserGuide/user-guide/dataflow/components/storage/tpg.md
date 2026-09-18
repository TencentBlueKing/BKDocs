# TPG

通过为数据处理配置 TPG 下游节点，可将计算结果数据导入 TPG 系统中，从而支持关系型数据库的各种分析操作。
仅支持对 TDW 离线计算的下游配置 TPG 存储

图例，TPG 节点
![](../../../../assets/dataflow/components/storage/dataflow-tpg.png)

#### 节点配置
- 节点名称： 自动生成，由上游结果表和当前节点类型组成
- 结果数据表：从上游节点继承过来
- 存储集群：通常可选有默认集群组集群，其它可选集群与任务所属项目相关
- 过期时间：数据入库后保存的过期时间

配置例子如下：

![](../../../../assets/dataflow/components/storage/dataflow-tpg-example.png)

