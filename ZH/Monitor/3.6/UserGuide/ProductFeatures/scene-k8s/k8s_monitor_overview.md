# 开启Kubernetes监控

## 一、相关名词解释

* Kubernetes: 容器管理调度平台，参考什么是kubernetes。
* BCS：蓝鲸容器服务平台（BCS，Blueking Container Service），是高度可扩展、灵活易用的容器管理服务平台。参考BCS使用文档。
* gse_agent: 运行在主机（如CVM、物理机等）上的蓝鲸agent, 是监控数据上报的通道。
* bkmonitorbeat: 指标采集器，用于采集指标数据。bkmonitorbeat 部署会依赖 gse_agent，如主机上未安装 gse agent 会导致 bkmonitorbeat 启动失败（pod 处于 init 状态）。
* bkmonitor-operator：用于监听 serviceMonitor、podMonitor、probeMonitor 等配置，并负责刷新各个 bkmonitorbeat 配置文件。
* dataid: 在监控平台内部用于标识数据的id。

## 二、什么是容器监控

     容器监控，泛指在容器场景下，对容器环境的指标、事件等进行上报。

     目前容器管理平台，基本被kubernetes所统一，此处所指的容器监控，其对象均指运行在kubernetes环境下的容器，对于不通过kubernetes纳管的容器监控场景暂不支持，后文不再单独说明。

容器环境下的监控特点：

* 监控目标是动态的，无法通过传统的方式对指定目标IP，目标端口进行监控。
* 容器会随时销毁，创建，监控目标变化非常快，没有监控无法溯源监测。
* 无需关心容器运行在什么机器上面。
* 容器的数量多，上报的指标量级多。

容器监控的核心诉求,主要分为4类：

1. 集群本身的运行状态监控，监控的目的是随时关注容量、及时发现异常，让集群的运维者能够快速修复集群问题。

   * 对kubernetes集群状态的监控，如master集群的etcd,kube-api, kube-scheduler,kube-proxy,kubelet等核心服务的监控。
   * 对node节点状态的监控，如CPU,内存，网卡等监控。
   * 对资源的统计需求，如cluster，NameSpace, node，pod数量的统计。
   * 对workload、service、pod、container运行指标和状态监控。
2. 容器内的事件、日志的监控。

   容器的日志和事件采集，并能够配置告警。
3. 自定义指标的监控，运行在容器中的服务，自身提供的服务指标是否正常，因为大多数情况下，运行环境的指标正常，并不等于服务本身就是正常的，所以需要上报服务本身的指标。

   服务的指标，如接口的成功，失败，饱和度，错误率等，通常这类指标对应用开发来说，更具有实际参考价值，更能够对业务有帮助。
4. HPA功能，对pod数量动态扩缩容。

   基于关键指标，对容器的pod数量进行增减，达到资源的有效利用。
      
       在云原生社区中，kubernetes各种监控方案尝试中，几乎都是推荐prometheus。原生的prometheus，在数据维度组合较小情况下，能够很好的工作，满足日常的使用需求，但在数据维度较多的情况下，即使用了thanos方案，依然效果不理想。具体表现是，在指标和维度组合数较大的情况下，占用内存比较高，查询速度会变慢，遇到服务重启，恢复时间较长，监控的稳定性受到极大挑战。

## 三、容器监控的方案

        为了让大家统一集中管理监控，将容器监控与主机监控，业务监控等融为一体，监控平台推出了容器场景的监控能力。可以解决以下问题：

* 避免prometheus服务在高负载情况下OOM，查询无响应，可用性不高问题。
* 无需每个kubernetes集群独立部署prometheus。
* 解决容器监控和业务监控割裂使用的问题，集中式查看监控、告警，让监控数据在统一的地方消费使用，无需同时维护多套监控系统。

### 数据采集流程

![](media/16618488813136.jpg)

    整个架构对比 prometheus-operator 来讲，我们少了 prometheus 组件，多了 bkmonitorbeat daemonset，因为我们的 bkmonitorbeat 可以替代 prometheus 的采集能力，而通过 gse 管道能力我们可以使用蓝鲸监控的存储和查询能力，也就是说，用户不需要在集群中部署Prometheus相关组件和prometheus-operator 。

    得益于蓝鲸监控中心化存储，bkmonitor-operator 较 prometheus-operator 方案，对集群内资源消耗更低。

### 数据采集流程说明

1. 用户集群接入到蓝鲸监控后，生成 dataid 资源并应用到用户集群中。
2. operator dataid-wacther 监听到有 dataid 资源创建后，启动 serviceMonitor/podMonitor/Probe 检测器，实时检测集群中的监控对象。
3. operator 根据检测到的资源对象生成采集任务，并为每个节点创建一个 Secrets 资源记录采集任务内容。
4. 节点上的 bkmonitorbeat-reloader 监测到自己节点上的 Secrets 对象有变更，则由 reloader 给 bkmonitorbeat 发送 reload 信号，通知 bkmonitorbeat 重载配置。
5. bkmonitorbeat 感知到有采集任务，进行数据采集上报。

### 采集方式的区别

1. 原Prometheus是由Prometheus-server集中拉取，而蓝鲸监控是通过本机的node去采集，采集压力分摊到每个node, 所以不存在集中式的采集任务压力。
2. 在每个node上部署bkmonitorbeat的daemonset, 该daemonset采集本机的pod中的exporter数据
3. 集群中的数据，由kube-state-metrics， prometheus-node-exporter，kubelet原生提供，由本node的bkmonitorbeat采集
4. 支持多集群的采集，多个集群可以共用一套蓝鲸监控

## 四、如何接入容器监控

接入容器监控的集群，分2种情况

- 在BCS集群中已经接入的k8s集群, 则可以直接在BCS的集群组件中安装bkmonitorbeat operator
- 集群未被BCS纳管，则需要将k8s集群托管，请参考 [集群管理](../../../../..//BCS/1.28/UserGuide/Function/cluster_management.md)，然后再安装bkmonitorbeat operator

接入的过程，请参考[蓝鲸容器监控安装](../../../../../BCS/1.28/UserGuide/Function/container_monitor.md)

## 五、如何查看容器监控数据

观测场景 -> kubernetes
![](media/16618490905946.jpg)

## 六、如何配置容器监控告警

![](media/16618491268965.jpg)

有内置的一些策略，具体查看[容器默认策略说明](./k8s_default_rules.md)

## 七、servicemonitor、podmonitor数据如何接入

容器监控功能，兼容Prometheus的servicemonitor, podmonitor功能，采集目标的定义请参考[文档](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md)

与Prometheus生态的区别是，不需要部署Prometheus-operator和Prometheus，数据上报链路统一走蓝鲸的数据管道。

每个node上面的数据，在本node上面的bkmonitor-operator的daemonset采集，而非集中式采集，因此，采集开销是在daemonset上面。

```
#查看bkmonitor-operator
 kubectl get pods -n bkmonitor-operator -o wide
```

![](media/16618492474662.jpg)

```
#查看daemonset的配置
kubectl get ds -n bkmonitor-operator  bkmonitor-operator-stack-bkmonitorbeat-daemonset -oyaml
```

![](media/16618492531658.jpg)

最高使用CPU1核，内存1G，如果需要采集的数据多，可以调整此配置。

## 八、如何绘制仪表盘-统一监控视角

容器的监控指标，可以在仪表盘中进行展示和分析，可以自定义视图查看

![](media/16618492623861.jpg)
