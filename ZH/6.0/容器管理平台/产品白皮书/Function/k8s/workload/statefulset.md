# Kubernetes StatefulSet 说明

StatefulSet 是为了解决有状态服务的问题而设计的，它是一个给 Pod 提供唯一标志的控制器，可以保证部署和扩展的顺序。StatefulSet 适用于有以下某个或多个需求的应用：
- 稳定的、唯一的网络标识
- 稳定的、持久化的存储
- 有序的、优雅的部署和扩展
- 有序的、优雅的删除和停止

## 1. 模板示例

```yml
apiVersion: apps/v1beta2
kind: StatefulSet
metadata:
  name: relay
spec:
  selector:
    matchLabels:
      app: relay
  podManagementPolicy: "Parallel"
  serviceName: "relay"
  replicas: 50
  updateStrategy:
    type: OnDelete
  template:
    metadata:
      labels:
        app: "relay"
    spec:
      schedulerName: tgw-domain-scheduler
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      terminationGracePeriodSeconds: 660
      containers:
      - name: relay-runner
        image: relay:2.0.0
        command: [ "/bin/bash", "-c", "source /tgwenv/tgwenv.sh && /opt/relay-runner/bin/run_server -c /opt/relay-runner/conf/application.conf" ]
        volumeMounts:
        - name: config
          mountPath: /opt/relay-runner/conf
        - name: tgwenv
          mountPath: /tgwenv
      initContainers:
      - name: tgw-init
        image: tgw-init:0.0.3
        command:
        - tgw-init
        args: ["--kubeconf="]
        env:
        - name: ENV_PATH
          value: /tgwenv
        volumeMounts:
        - name: tgwenv
          mountPath: /tgwenv
      volumes:
      - name: config
        configMap:
          name: apps-relay-config
      - name: tgwenv
        emptyDir: {}
```
## 2. 配置项介绍

StatefulSet 和 Deployment 的大部分配置相同，这里就不在介绍相同点(具体参考 Deployment 说明中的配置项介绍)，重点说明 StatefulSet 常用的配置。

### 2.1 Pod 管理策略

`.spec.podManagementPolicy`有两种："OrderedReady"和"Parallel"，其中"Parallel"策略告诉 StatefulSet 控制器并行的终止所有 Pod，在启动或终止另一个 Pod 前，不必等待这些 Pod 变成 Running 和 Ready 或者完全终止状态。

### 2.2 initContainers

`initContainers`并非 StatefulSet 特有的，它同样可以被 Deployment，Daemonset 所使用。这里单独介绍是因为`initContainers`在 StatefulSet 中较常用，它可以根据每个 Pod 的“状态”，完成复杂的初始化工作，为后续容器的启动运行提供环境基础。

## 3. StatefulSet 之“吃豆小游戏”实践

小游戏的后台房间服务用到了 StatefulSet，因为每个房间需要自己的网络标识，所以 Pod 是“有状态”的。
```yml
apiVersion: apps/v1beta2
kind: StatefulSet
metadata:
  name: rumpetrollv2
  namespace: rumpetroll-v2
spec:
  selector:
    matchLabels:
      app: web
  serviceName: "rumpetroll2"
  replicas: 5
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: pyrumpetroll:0.3
        ports:
        - containerPort: 20000
          name: web
        env:
        - name: DOMAIN
          value: game2-got.o.qcloud.com
        - name: MAX_CLIENT
          value: "2"
        - name: MAX_ROOM
          value: "100"
        - name: REDIS_HOST
          value: redis
        - name: REDIS_PORT
          value: "6379"
        - name: REDIS_DB
          value: "0"
        - name: REDIS_PASSWORD
          value:
        - name: NUMPROCS
          value: "1"
        - name: HOST
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
```

## 4. BCS 模板集操作

关于 StatefulSet 在 BCS 界面的用法，请参照 [在 K8S 中部署 WordPress](../../../Scenes/Deploy_wordpress.md)。

Helm 实例化 WordPress 资源描述文件如下：

![-w1997](../../../assets/15684300467698.jpg)

部署成功后的实例如下：

![-w1677](../../../assets/15684299788323.jpg)
