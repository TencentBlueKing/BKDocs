# Stage

为了更清晰的描述 CI 流程，我们引入 Stage（阶段）的概念。

- 由多个 Jobs（作业）组成；
- 同一个 Stage 下的 Job 执行方式为并行，由于 Job 之间是相互独立的，某个 Job 失败后，其它的 Job 会被运行到完成；
- 一个 Job 失败，则该 Stage 失败。

![Stage](../../assets/stage.png)

## Stage准入

如果您的流水线需要中断流程，引入审核机制，那么Stage准入可以满足你的需求，它支持在你的流程中加入审批流。

### 如何使用

- 点击Stage左侧的闪电ICON

![](../../assets/stage-checkin-1.png)

- 在弹出框里将准入规则改为“人工审核”（默认是自动，即不审核）

![](../../assets/stage-checkin-2.png)

- 设置对应的审批流（每个审批流可包含多个审批环节，如果一个审批环节中涉及多人时，任意一人审批即可进入下一审批环节）

![](../../assets/stage-checkin-3.png)

### 高级玩法

- 可通过设置“审批时间限制”来保护流水线任务，若超出时间仍未进行审批，视为审批不通过，流水线进入 STAGE_SUCCESS状态，流程终止。
- 可通过设置“自定义参数”在审核时修改，用来改变流水线变量，再配合Job/Task的条件执行来影响后续流程。



## Stage 的通用选项

### Fastkill

开启 Fastkill 之后，当 Job 失败时立即结束当前 Stage。

### 流程控制选项

通过高级流程控制，可以定义 Job 的运行逻辑。

![Stage Detail](../../assets/stage_detail.png)

## 接下来你可能需要

- [Task](Task.md)
- [Job](Job.md)
