# 分流计算
支持一个数据源根据业务维度切分成若干数据结构相同的结果数据表。

图例，分流计算

![](../../../../assets/dataflow/components/processing/dataflow-split.png)

#### 节点配置
分流计算通常由一个实时结果数据（实时数据源或实时计算），通过配置不同切分逻辑输出到具有相同表名的不同业务结果表中，配置例子如下：

![](../../../../assets/dataflow/components/processing/dataflow-split-example.png)

#### 可以连接的下游节点类型
暂不支持连接下游节点

