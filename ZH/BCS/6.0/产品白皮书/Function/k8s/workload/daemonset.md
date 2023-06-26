# Kubernetes DaemonSet 说明

DaemonSet 能够让所有（或者一些特定）的 Node 节点运行同一个 Pod。当有节点加入集群时，也会为他们新增一个 Pod。

当有节点从集群移除时，这些 Pod 也会被回收。

删除 DaemonSet 将会删除它创建的所有 Pod。

使用 DaemonSet 的一些典型用法：
- 运行集群存储 daemon，例如在每个节点上运行 glusterd、ceph
- 在每个节点上运行日志收集 daemon，例如 fluentd、logstash
- 在每个节点上运行监控 daemon，例如 Prometheus Node Exporter、collectd 等

## 1. 模板示例

```yml
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
  labels:
    name: node-exporter
spec:
  template:
    metadata:
      labels:
        name: node-exporter
      annotations:
         prometheus.io/scrape: "true"
         prometheus.io/port: "9100"
    spec:
      hostPID: true
      hostIPC: true
      hostNetwork: true
      containers:
        - ports:
            - containerPort: 9100
              protocol: TCP
          resources:
            requests:
              cpu: 0.15
          securityContext:
            privileged: true
          image: prom/node-exporter:v0.15.2
          args:
            - --path.procfs
            - /host/proc
            - --path.sysfs
            - /host/sys
            - --collector.filesystem.ignored-mount-points
            - '"^/(sys|proc|dev|host|etc)($|/)"'
          name: node-exporter
          volumeMounts:
            - name: dev
              mountPath: /host/dev
            - name: proc
              mountPath: /host/proc
            - name: sys
              mountPath: /host/sys
            - name: rootfs
              mountPath: /rootfs
      volumes:
        - name: proc
          hostPath:
            path: /proc
        - name: dev
          hostPath:
            path: /dev
        - name: sys
          hostPath:
            path: /sys
        - name: rootfs
          hostPath:
            path: /
```

## 2. 配置项介绍

DaemonSet 和 Deployment 的大部分配置相同，这里就不在介绍相同点(具体参考 Deployment 说明中的配置项介绍)。

由于 DaemonSet 本身的调度机制和 Deployment 有所不同，配置上会带来一些差异，例如 DaemonSet 并没有`.spec.replicas`字段，每个节点最多只运行一个 Pod，Pod 的总数取决于调度约束条件(节点个数、nodeSelector、taint 和 toleration 等)。
