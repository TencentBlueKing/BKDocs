# 蓝鲸应用自动扩缩容

> 开发者中心为应用提供了自动扩缩容的功能，帮助 SaaS 开发者更有效地管理应用资源及服务副本数量。

## 功能介绍

开发者中心基于 BCS 的 GPA 组件，提供了蓝鲸应用自动扩缩容能力，目前主要支持基于资源指标进行扩缩容。

启用开发者中心的自动扩缩容能力后，你所管理的蓝鲸应用将会拥有如下能力：

- 在负载高峰期，自动增加副本数量以降低各副本负载及响应时间
- 在负载低谷期，自动缩减副本数量以节约资源与成本

在后续的功能规划中，我们还会支持诸如根据访问量扩缩容，应用休眠，定时扩缩容等场景。

## 扩缩容策略

### 基于资源的扩缩容

#### 单指标情况

基于资源的扩缩容主要依靠资源的 `平均使用率` 来计算目标副本数量，简化计算公式如下：`desiredReplicas = Ceil((currentUtilization / targetUtilization) * currentReplicas)`

举个例子：假设目前 web 进程有两个副本：Pod1 & Pod2，设置的资源指标为 `CPU 使用率 = 85%`，最大副本数是 5，最小副本数是 2。

当 Pod1，Pod2 CPU 使用率分别为 100%，80% 时，web 进程平均 CPU 使用率为 90%，经计算可得预期副本数为 `Ceil(90 / 85 * 2) = 3`；由于当前副本数和预期副本数都没有超过最大副本数，因此会扩容到 3 个副本。

当 Pod1，Pod2 CPU 使用率分别为 30%，50% 时，web 进程平均 CPU 使用率为 40%，经计算可得预期副本数为 `Ceil(40 / 85 * 2) = 1`；但由于预期副本数低于最小副本数，因此仅能缩容到 2 个副本，同时还因为当前副本数和最小副本数相同，所以不会触发缩容动作。

| CPU 使用率 | 平均 CPU 使用率 | 预期副本数 | 未超过最大/小副本数 | 动作 |
| ---------- | --------------- | ---------- | ------------------- | ---- |
| 100% / 80% | 90%             | 3          | ✓                   | 扩容 |
| 30% / 50%  | 40%             | 1          | ✗                   | 无   |

根据公式亦可得：当设置资源指标为 `CPU 使用率 = 85%` 时，若平均 CPU 使用率超过 85% 且未达到最大副本数，即会触发扩容；若平均 CPU 使用率低于 `(currentReplicas - 1)/currentReplicas * 85` 且未达到最小副本数，则会触发缩容；该值在当前有两个副本时为 42.5%，三个副本时为 56.7%，其他情况以此类推。

当然了，如果某个副本未处于就绪状态，计算资源平均使用率时将不会包含在内。

#### 多指标情况

如果我们使用多个资源指标，比如 `CPU 使用率 = 85 % && 内存使用率 = 80%`，则扩缩容判定规则如下：

扩容条件：

- CPU 使用率超过扩容阈值 **或** 内存使用率超过扩容阈值
- 当前副本数量未达到或超过最大副本数

缩容条件：

- CPU 使用率低于缩容阈值 **且** 内存使用率低于缩容阈值
- 当前副本数量未达到或低于最小副本数

更多指标的情况以此类推。

### 扩缩容生效时间

自动扩缩容能力遵循 `快扩慢缩` 的策略；即满足扩容条件时，能够快速完成副本数量变更；满足缩容条件时，则会持续监测，直到整个稳定窗口期内均满足缩容条件后，才会进行缩容。

## 使用指南

应用可以在产品页面上配置自动扩缩：

- 云原生应用：『部署管理』 -> 『展开实例详情』 -> 『扩缩容』 -> 『自动调节』
- 普通应用：『应用引擎』 -> 『进程管理』 -> 『扩缩容』 -> 『自动调节』

基于源码部署的应用，也可以在[应用描述文件](./app_desc.md)中定义自动扩缩容。

注意：目前开发者中心限制资源扩缩容指标固定为 `CPU 使用率 = 85%`，后续将会开放自定义指标供用户选择。
