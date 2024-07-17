# 流水线图形化编排

## Stage 操作集合

### 为 Stage 开启准入

在完整的 CI/CD 生命周期中，我们难免会有一些期望人工介入审核的步骤，Stage 准入特性可以允许你在流水线运行到某个 Stage 之前暂停流程，人工介入后可以继续。

#### 开启方法

在编辑流水线时，对已有的某个 Stage 左上角的闪电 ICON 点击进入 Stage 准入属性面板

![](../../../assets/image%20(50).png)

![](../../../assets/image%20(49).png)

#### 开启后的效果

* 如果某个构建任务处于 Stage 准入审核时，那这个构建任务将成为“STAGE\_SUCCESS”状态，可参考[流水线状态信息汇总](../pipeline-build-detail/status.md#pipeline-zhuang-tai)

