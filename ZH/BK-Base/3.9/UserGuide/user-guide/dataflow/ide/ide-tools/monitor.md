# 数据流监控

## 整体监控

通过点击操作栏监控按钮，可查看各个运行中节点的输入输出信息。

![](../../../../assets/dataflow/ide/ide-tools/monitor/dataflow-flow-monitor.png)

- 说明

> 各节点的输入输出一般代表当前最近 10 分钟内运行任务最近一次上报的输入输出情况。而对于离线计算相关节点及其下游存储节点，该信息代表的是最近一个调度周期内执行的监控情况。

## 节点监控

将鼠标移至某一个节点，可查看该节点过去 24 小时的数据量趋势和计算延迟。

- 数据量趋势
  ![](../../../../assets/dataflow/ide/ide-tools/monitor/dataflow-node-monitor-trend.png)

- 计算延迟
  ![](../../../../assets/dataflow/ide/ide-tools/monitor/dataflow-node-monitor-delay.png)

- 离线调度信息（只展示于离线相关节点）
  ![](../../../../assets/dataflow/ide/ide-tools/monitor/dataflow-node-monitor-schedule.png)

