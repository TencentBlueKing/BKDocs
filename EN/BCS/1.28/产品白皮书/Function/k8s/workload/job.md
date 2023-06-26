# Kubernetes Job 说明

Job 负责批量处理短暂的一次性任务，即仅执行一次的任务，它保证批处理任务的一个或多个 Pod 成功结束。kubernetes(简称 k8s)支持以下几种 Job：
- 非并行 Job：通常创建一个 Pod 直至其成功结束
- 固定结束次数的 Job：设置`.spec.completions`，创建多个 Pod，直到`.spec.completions`个 Pod 成功结束
- 带有工作队列的并行 Job：设置`.spec.Parallelism`但不设置`.spec.completions`，当所有 Pod 结束并且至少一个成功时，Job 就认为是成功

## 1. 模板示例

```yml
apiVersion: batch/v1
kind: Job
metadata:
  name: ah-buyer-init-auctionhouse
spec:
  template:
    metadata:
      name: ah-buyer-init-auctionhouse
    spec:
      nodeSelector:
        network: private
      containers:
      - name: ah-buyer-init-auctionhouse
        image: solr:5.5.5
        command:
        - sh
        - /opt/ahs/jobs/init-auctionhouse.sh
        volumeMounts:
        - name: initjobconfig
          mountPath: /opt/ahs/jobs
      restartPolicy: OnFailure
      volumes:
      - name: initjobconfig
        configMap:
          name: ah-buyer-init-jobs-config
  backoffLimit: 4
```
## 2.  配置项介绍

- `.spec.template`: 这里不再介绍(具体参考 Deployment 说明中的配置项介绍)
- `.spec.completions`:  标志 Job 结束需要成功运行的 Pod 个数，默认为 1
- `.spec.parallelism`:  标志并行运行的 Pod 的个数，默认为 1
- `.spec.template.spec.containers.restartPolicy`: 只能是"Never"或者"OnFailure"
- `.spec.backoffLimit`: 确定为失败前的重试次数
- `.spec.activeDeadlineSeconds`: 失败 Pod 的重试最大时间，超过这个时间不会继续重试 (No more pods will be created, and existing pods will be deleted)
