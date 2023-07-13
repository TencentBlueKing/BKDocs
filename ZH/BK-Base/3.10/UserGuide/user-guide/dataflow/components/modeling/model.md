# 算法模型

将 ModelFlow 上已发布的模型版本在数据开发中应用。

![](../../../../assets/dataflow/components/modeling/dataflow-model.png)

<center>图1：算法模型</center>

<br/>

#### 节点配置
若上游配置了 Tspider 节点、实时数据节点、离线数据节点或其它算法模型节点，可为其下游配置算法模型节点，通常需要指定数据输入、数据输出等配置，相关例子如下：

![](../../../../assets/dataflow/components/modeling/dataflow-model-example.png)

<center>图2：节点配置</center>

<br/>

#### 可以连接的下游节点类型举例
- Tspider
- Queue
- 算法模型
