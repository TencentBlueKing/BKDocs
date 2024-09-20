# 容器监控组件

## 相关组件列表

目前蓝鲸容器监控部署的组件有

* bkm-operator：任务调度器，负责监听各类资源并对采集任务进行计算调度。
* bkm-event-worker：采集 kubernetes 事件。
* bkm-daemonset-worker：采集集群内 endpoints 指标数据，为了避免跨主机流量传输，同一个节点的 endpoints 会被分配到该节点的 daemonset 上。
* bkm-statefulset-worker：采集集群外 endpoints 指标数据，用户如果 endpoints 数量过多，会自动扩容 worker 副本数来均衡采集任务。
* bkm-prometheus-node-exporter: 社区官方组件，用于采集 node 指标数据，具体请参考 https://github.com/prometheus/node_exporter。
* bkm-kube-state-metrics: 社区官方组件，用于采集 k8s 集群自身指标信息，具体请参考 https://github.com/kubernetes/kube-state-metrics。
其中 bkm-daemonset-worker 和 bkm-prometheus-node-exporter 都是 Daemonset 类型，每个集群节点都会部署。



## 资源占用

假设现在集群有 10 个节点，则所需的最小资源如下：

CPU（共 3.1Core）:

* bkm-operator: 1 * 0.2Core = 0.2Core
* bkm-daemonset-worker: 10 * 0.15Core = 1.5Core
* bkm-event-worker: 1 * 0.25Core = 0.25Core
* bkm-statefulset-worker: 1 * 0.15Core = 0.15Core
* bkm-prometheus-node-exporter: 10 * 0.1Core = 1Core

Mem（共 3632M）:

* bkm-operator: 1 * 256M = 256M
* bkm-daemonset-worker: 10 * 192M = 1920M
* bkm-event-worker: 1 * 264M = 264M
* bkm-statefulset-worker: 1 * 192M = 192M
* bkm-prometheus-node-exporter: 10 * 100M = 1000M

## bkm-operator

bkmonitor-operator 是蓝鲸容器监控 kubernetes 管理器，与蓝鲸监控生态深度融合，复用了底层传输链路以及存储。operator 通过监听 dataid/podMonitor/serviceMonitor/probe 等 CRD 资源，生成采集任务并调度分发到所有的节点上，并利用 gse 管道上报数据。

bkmonitor-operator 是参考 prometheus-operator 改造而来，同时也提供了更多的新特性。整个架构对比 prometheus-operator 来讲，我们少了 prometheus 组件，多了三种类型的 worker，分别为 bkm-event-worker/bkm-daemonset-worker/bkm-statefulset-worker，三种不同类型的 worker 承担着不同功能的任务采集。

三种 operator worker 可以替代 prometheus 的采集能力，而通过 gse 管道能力我们可以使用蓝鲸监控的存储和查询能力。**得益于蓝鲸监控中心化存储，bkmonitor-operator 较 prometheus-operator 方案，对集群内资源消耗更低。因为 prometheus 并不需要部署在业务集群，由管控集群纳管。**

### Architecture

bkmonitor-operator 整体架构如下：
![](media/16921744056585.jpg)


### Operator Workers

在介绍 operator worker 之前，先讲讲 operator 组件的采集任务划分。在蓝鲸监控，我们是以 dataid 为标识对数据来源进行管理，这是管理端特性，用户实际上不感知此标识，在容器环境中，dataid 也是一种 CRD。在用户集群接入蓝鲸监控之后，首先监控管理后端会对集群注入 3 个 dataid。分别是：

* custommetricdataid：自定义指标 dataid。
* k8seventdataid：内置事件 dataid。
* k8smetricdataid：内置指标 dataid。

为了管理区分，operator 注入的 serviceMonitor 采集会使用内置 dataid，这个是通过在 `metadata.annotations` 声明 `isSystem: "true"` 指定的。而用户的数据上报会用自定义 dataid。当然，我们也对 dataid 进行了扩展，用户可以在监控这边申请新的 dataid，用于匹配特性维度的 serviceMonitor，以便对数据进行隔离，如果量太大的话，我们会对 dataid 进行存储集群的划分。

在集群接入后，dataid 资源就绪后，operator 就会开始工作了。operator 涉及到多个组件，这里一一做介绍：

* bkm-operator：任务调度器，负责监听各类资源并对采集任务进行计算调度。
* bkm-event-worker：采集 kubernetes 事件。
* bkm-daemonset-worker：采集集群内 endpoints 指标数据，为了避免跨主机流量传输，同一个节点的 endpoints 会被分配到该节点的 daemonset 上。
* bkm-statefulset-worker：采集集群外 endpoints 指标数据，用户如果 endpoints 数量过多，会自动扩容 worker 副本数来均衡采集任务。
* bkm-prometheus-node-exporter: 社区官方组件，用于采集 node 指标数据，具体请参考 [prometheus/node_exporter](https://github.com/prometheus/node_exporter)。
* bkm-kube-state-metrics: 社区官方组件，用于采集 k8s 集群自身指标信息，具体请参考 [kubernetes/kube-state-metrics](https://github.com/kubernetes/kube-state-metrics)。

### Monitor Resources

bkmonitor-operator 沿用了 prometheus-operator 的 monitor CRD，包括 podMonitor/serviceMonitor/probe。同时对此概念进行了扩展补充。

通常情况下，用户接入蓝鲸容器监控后，所有的采集资源和配置会跟之前使用 prometheus-operator-stack 一样，**但 prometheus 的采集存在一些局限性：**

**1）单点问题**

如果用户集群的采集 endpoints 太多的话，集群内的 prometheus 资源使用率会非常高，部分用户的 prometheus 使用 128G 内存独占的机器都扛不住，因为 prometheus 承担了数据采集，指标存储和指标查询的功能。诚然，官方也说可以通过 thanos 等方案来减少 prometheus 的存储和查询压力，通过多部署 prometheus 节点来减低采集任务的开销，**但这同时也大大的提高了运维成本和经济成本。**

但这个问题在 bkmonitor-operator 有着自己的解决手段，首先，我们将采集任务调度到了每个 worker 身上，**将中心化压力打散到分布式的 worker 身上，所以不会有单机瓶颈。同时正如上述提到的，这种方式也可以减低跨主机间的网络传输。** statefulset worker 数量可以根据用户的采集 endpoints 数量进行扩容或者缩容，**任务调度会自动感知。**

**2）本地采集**

并不是所有的服务均能以集群节点能访问的形式暴露，比如 kubernetes 的控制面板组件，kube-proxy，kube-controller 以及 kube-scheduler 等，它们的服务是以 localhost 形式暴露，集群 pod 网络策略并不通。所以这种场景下，prometheus 是无法进行采集的。

得益于 daemonset 机制，每个集群节点都会部署一个 bkm-daemonset-worker 实例，该实例可以使用 `hostNetwork` 的形式共享主机网络栈，所以 worker 就可以轻松采集主机上的以 localhost 暴露的 endpoints。用户只需要在部署 serviceMonitor 的时候在 metadata.annotations 里声明 `forwardLocalhost: "true"` 即可，operator 检查到有此标识的话，就将 endpoint host 转化为 localhost 下发到 worker。

**3）资源开销**

bkmonitor-operator 对 prometheus discovery 机制做了链接共享优化，在 prometheus 的设计里，每个 discovery 有着自己独立的 apiserver 长链接，消费来自 k8s 的事件。但实际上，这些链接是可以共享的，对相同 namespace 资源监听可以缓存，并在内存中使用一套订阅分发机制。

如果集群中有 500 个 serviceMonitor 分布在 30 个 namespace 下，那 prometheus-operator 需要 500 个 tcp 长链，而 bkmonitor-operator 只需要 30 个。bkmonitor-operator 在保证数据准确性的前提下大大优化了监听性能。

### Monitor Secrets

bkmonitor-operator 的采集任务通过 secrets 资源进行分发，每个 secrets 会包含多个采集任务，写入时使用 gzip 压缩，减少数据量。三种不同的 worker 分别对应着不同的 secrets 前缀：

* event-worker-*
* daemonset-worker-*
* statefulset-worker-*

operator 会支持监视集群监控资源的变化，如果资源发生了变化，则生成采集任务并调度到响应的 worker。这个过程 operator-worker 是通过 secrets 进行交互，operator 更新 secrets，`reloader-sidecar` 感知 secrets 变化后，将数据与本地数据进行对比，如若采集任务有变更，则通知 worker 进行 reload，反之不做任何处理。

### Performance

bkmonitorbeat 采集发送压测性能如下：

| 指标数量/发送间隔/(CPU/MEM)| 5s | 15s | 60s |
| --- | --- | --- | --- |
| 1k | 2.1% / 20-25M | 1.5% / 23-26M | 0.7% / 19-23M |
| 5k | 3.0% / 20-25M | 1.6% / 21-32M | 1.0% / 17-20M |
| 10k | 1.4% / 30-45M | 1.4% / 33-43M | 1.1% / 33-46M |
| 100k | 100% / 20-190M | 20% / 140-190M | 5.4% / 100-180M |
| 300k | 100% / 150-190M | 100% / 150-200M | 8% / 60-120M |




