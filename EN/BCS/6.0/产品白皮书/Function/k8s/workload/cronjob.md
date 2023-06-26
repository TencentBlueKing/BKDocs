# Kubernetes CronJob 说明

K8S 集群使用 Cron Job 管理基于时间的作业，可以在指定的时间点执行一次或在指定时间点执行多次任务。 一个 Cron Job 就好像 Linux crontab 中的一行，可以按照 Cron 定时运行任务。

## 1. 模板示例

```yml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: recordpopulation
spec:
  concurrencyPolicy: Allow
  failedJobsHistoryLimit: 1
  jobTemplate:
      spec:
      template:
        spec:
          containers:
          - args:
            - /app/cronrunner
            - -host
            - psynet:8080
            - -job
            - /ServiceTask/Population/RecordPopulation
            env:
            - name: TZ
              value: Asia/Shanghai
            image: cronrunner:tc1
            imagePullPolicy: IfNotPresent
            name: cronrunner
            resources: {}
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirstWithHostNet
          hostNetwork: true
          restartPolicy: Never
          schedulerName: default-scheduler
          securityContext: {}
          terminationGracePeriodSeconds: 30
  schedule: '*/1 * * * *'
  successfulJobsHistoryLimit: 3
  suspend: false
```

## 2. 配置项介绍

### 2.1 调度

`.spec.schedule`是`.spec` 中必需的字段，它的值是 Cron 格式字的符串，例如：`*/1 * * * *` ，根据指定的调度时间 Job 会被创建和执行

### 2.2 并发策略

`.spec.concurrencyPolicy`字段也是可选的。它指定了如何处理被 Cron Job 创建的 Job 的并发执行。只允许指定下面策略中的一种：
- Allow（默认）：允许并发运行 Job
- Forbid：禁止并发运行，如果前一个还没有完成，则直接跳过下一个
- Replace：取消当前正在运行的 Job，用一个新的来替换
注意，当前策略只能应用于同一个 Cron Job 创建的 Job。如果存在多个 Cron Job，它们创建的 Job 之间总是允许并发运行。

### 2.3 挂起

`.spec.suspend` 字段是可选的。如果设置为 true，后续所有执行都将被挂起。它对已经开始执行的 Job 不起作用。默认值为 false
