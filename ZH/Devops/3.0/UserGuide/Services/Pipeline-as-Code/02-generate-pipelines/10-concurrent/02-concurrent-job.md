# 设置 Job 并发控制

功能介绍详见：[Job 并发控制](../../../Pipeline/pipeline-edit-guide/concurrency-control/job-concurrency.md)

## 设置单节点并发上限

```yaml
job_private:
name: 使用第三方构建机环境池
runs-on:
pool-name: my-pool
self-hosted: true
concurrency-limit-per-node: 2
queue-timeout-minutes: 3
steps:
- run: echo hi, job_private
```

## 设置环境中所有节点总并发上限

```yaml
job_private:
name: 使用第三方构建机环境池
runs-on:
pool-name: my-pool
self-hosted: true
concurrency-limit-per-node: 2
concurrency-limit-total: 5
queue-timeout-minutes: 3
steps:
- run: echo hi, job_private
```
