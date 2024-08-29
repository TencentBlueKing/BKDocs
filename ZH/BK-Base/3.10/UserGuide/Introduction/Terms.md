## 术语解释

![](media/15843596426259.jpg)

- 数据集成
    - **[数据源](../user-guide/datahub/data-access/concepts.md)**：业务的原始数据，可通过 日志、数据库、消息队列等多种方式上报至平台
    - **[清洗](../user-guide/datahub/data-clean/detail.md)**：将原始数据源根据字段进行格式化提取、转化等结构化操作
- 数据开发
    - **[实时计算](../user-guide/dataflow/stream-processing/concepts.md)**：秒级的计算处理延时，实时挖掘数据背后的价值
    - **[离线计算](../user-guide/dataflow/batch-processing/concepts.md)**：按小时、天来周期性统计数据，一般用于报表统计类数据
- 数据探索
    - 数据查询：以标准 SQL 统一查询不同种类存储的数据 
    - **[交互式 Notebook](../user-guide/datalab/datalab.md)**：通过 SQL 或 Python、Java 等语言对数据交互式分析，支持在网页文档中编写代码和运行代码。
- **结果数据表** ：也称结果表，在平台中可以用于查询、计算、可视化的数据表，一般由原始数据清洗、实时/离线计算产生
- **可视化**：将结果表通过图表的方式呈现，具体详见蓝鲸图表平台。

