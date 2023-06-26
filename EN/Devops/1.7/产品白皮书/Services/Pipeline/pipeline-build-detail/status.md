# 流水线状态信息汇总

## Pipeline 状态

| KEY | Description | Display Name |
| :--- | :--- | :--- |
| QUEUE | 初始状态：队列中等待调度，在准备执行前会切换为 QUEUE\_CACHE | 队列中 |
| QUEUE\_CACHE | 中间状态：进入执行队列，可以启动 | 待执行 |
| RUNNING | 中间状态：运行中 | 运行中 |
| CANCELED | 最终态：取消 | 取消 |
| STAGE\_SUCCESS | 最终态： 当 Stage 人工审核 取消运行时，是一个成功的状态 | 阶段性完成 （成功） |
| SUCCEED | 最终态：成功 | 成功 |
| FAILED | 最终态：失败 | 失败 |
| TERMINATE | 最终态： 处于 RUNNING 状态的 Pipeline 因环境异常而被强制终止 | 终止 （失败） |
| QUEUE\_TIMEOUT | 最终态：队列中等待调度导致的超时 | 排队超时 |

## Stage 状态

| KEY | Description | Display Name |
| :--- | :--- | :--- |
| QUEUE | 初始状态：队列中等待调度，在准备执行前会切换为 QUEUE\_CACHE | 队列中 |
| QUEUE\_CACHE | 中间状态：进入执行队列，可以启动 | 待执行 |
| RUNNING | 中间状态：运行中 | 运行中 |
| REVIEWING | 中间状态：stage 处于 人工审核中 | 审核中 |
| PAUSE | 中间状态：当 Stage 人工审核 等待审核时 | 暂停执行 |
| CANCELED | 最终态：取消 | 取消 |
| SUCCEED | 最终态：成功 | 成功 |
| FAILED | 最终态：失败 | 失败 |
| TERMINATE | 最终态： 处于 RUNNING 状态的 Stage 因环境异常而被强制终止 | 终止 （失败） |
| SKIP | 最终态：跳过不执行 | 跳过 |
| UNEXEC | 最终态：从未执行，可能构建失败导致的结束，后面未执行 | 从未执行（不参与最终成功/失败状态运算） |
| QUEUE\_TIMEOUT | 最终态：队列中等待调度导致的超时 | 排队超时 |
| STAGE\_SUCCESS | 最终态： 当 Stage 人工审核 取消运行时，是一个成功的状态 | 阶段性完成 （成功） |

## Job 状态

| KEY | Description | Display Name |
| :--- | :--- | :--- |
| QUEUE | 初始状态：队列中等待调度，在准备执行前会切换为 QUEUE\_CACHE | 队列中 |
| QUEUE\_CACHE | 中间状态：进入执行队列，可以启动 | 待执行 |
| LOOP\_WAITING | 中间状态：轮循等待中 互斥组抢锁轮循 | 互斥锁轮循等待中 |
| DEPENDENT\_WAITING | 中间状态：等待依赖的 job 完成才会进入准备环境 | 依赖等待 |
| PREPARE\_ENV | 中间状态：准备环境中，构建机正在启动 | 准备环境中 |
| RUNNING | 中间状态：运行中 | 运行中 |
| PAUSE | 中间状态：插件暂停执行时，会将 Job 的状态也设置为暂停 | 暂停执行 |
| CANCELED | 最终态：取消 | 取消 |
| SUCCEED | 最终态：成功 | 成功 |
| FAILED | 最终态：失败 | 失败 |
| TERMINATE | 最终态： 处于 RUNNING 状态的 JOB 因环境异常而被强制终止 | 终止 （失败） |
| SKIP | 最终态：跳过不执行 | 跳过 |
| UNEXEC | 最终态：从未执行，可能构建失败导致的结束，后面未执行 | 从未执行（不参与最终成功/失败状态运算） |
| QUEUE\_TIMEOUT | 最终态：队列中等待调度导致的超时 | 排队超时 |
| HEARTBEAT\_TIMEOUT | 最终态：构建过程中，Agent 与服务端失联超过 2 分钟 | 心跳超时（失败） |

## Task 状态

| KEY | Description | Display Name |
| :--- | :--- | :--- |
| QUEUE | 初始状态：队列中等待调度，在准备执行前会切换为 QUEUE\_CACHE | 队列中 |
| QUEUE\_CACHE | 中间状态：进入执行队列，可以启动 | 待执行 |
| RETRY | 中间状态：设置了失败重试，进入执行队列 | 待重试 |
| RUNNING | 中间状态：运行中 | 运行中 |
| CALL\_WAITING | 中间状态：用于启动构建环境插件等待构建机回调启动结果 | 等待构建机回调 （运行中） |
| REVIEWING | 中间状态：人工审核插件或质量红线配置了人工审核 并处于待审核 | 待审核（运行中） |
| PAUSE | 中间状态：插件设置了暂停执行 | 暂停执行 |
| REVIEW\_ABORT | 最终态：人工审核插件或质量红线配置了人工审核 并点了驳回/终止 | 人工审核驳回（失败） |
| REVIEW\_PROCESSED | 最终态：人工审核插件或质量红线配置了人工审核 并点了通过 | 人工审核通过（成功） |
| CANCELED | 最终态：取消 | 取消 |
| SUCCEED | 最终态：成功 | 成功 |
| FAILED | 最终态：失败 | 失败 |
| TERMINATE | 最终态： 处于 RUNNING 状态的插件因环境异常而被强制终止 | 终止 （失败） |
| SKIP | 最终态：跳过不执行 | 跳过 |
| EXEC\_TIMEOUT | 最终态：执行时间超过配置的超时时间 | 执行超时（失败） |
| UNEXEC | 最终态：从未执行，可能构建失败导致的结束，后面未执行 | 从未执行（不参与最终成功/失败状态运算） |
| QUEUE\_TIMEOUT | 最终态：队列中等待调度导致的超时 | 排队超时 |
| QUALITY\_CHECK\_FAIL | 最终态：被质量红线拦截后直接失败（未设置人工审核） | 被质量红线拦截（失败） |

