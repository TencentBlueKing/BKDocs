# 设置流水线并发

功能介绍详见：[控制流水线并发](../../../Pipeline/pipeline-edit-guide/concurrency-control/pipeline-concurrency.md)

## 分组，组内同一时间只能运行一个构建，且总是运行最新到达的构建

当前流水线，相同分支触发时，分为一组，当新任务到达时，取消正在运行的构建，启动最新到达的任务：

```yaml
concurrency:
group: "${{ci.pipeline_id}}-${{ci.branch}}"
```

## 分组，组内同一时间只能运行一个构建，多个任务到达时排队

```yaml
concurrency:
group: "${{ci.pipeline_id}}-${{ci.branch}}"
cancel-in-progress: false
queue-length: 3
queue-timeout-minutes: 10
```

## 不分组，并发执行

不配置 `concurrency`，默认并发执行，具体并发的任务数和当前环境下的资源有关
