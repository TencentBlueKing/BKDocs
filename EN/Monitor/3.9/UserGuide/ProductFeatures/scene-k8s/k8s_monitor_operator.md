# 容Monitoring component

## Related component list

Currently, the components deployed by BlueKing container monitoring are:

* bkm-operator: Task scheduler, responsible for monitoring various resources and calculating and scheduling collection tasks.
* bkm-event-worker: Collect kubernetes events.
* bkm-daemonset-worker: Collect endpoints indicator data in the cluster. In order to avoid cross-host traffic transmission, endpoints of the same node will be assigned to the daemonset of the node.
* bkm-statefulset-worker: Collect endpoints indicator data outside the cluster. If the user has too many endpoints, the number of worker copies will be automatically expanded to balance the collection tasks.
* bkm-prometheus-node-exporter: The official component of the community, used to collect node indicator data. For details, please refer to https://github.com/prometheus/node_exporter.
* bkm-kube-state-metrics: The official component of the community, used to collect the k8s cluster's own indicator information. For details, please refer to https://github.com/kubernetes/kube-state-metrics.
Among them, bkm-daemonset-worker and bkm-prometheus-node-exporter are both Daemonset types and will be deployed on each cluster node.



## Resource usage

Assuming that the cluster now has 10 nodes, the minimum resources required are as follows:

CPU (3.1Core total):

* bkm-operator: 1 * 0.2Core = 0.2Core
* bkm-daemonset-worker: 10 * 0.15Core = 1.5Core
* bkm-event-worker: 1 * 0.25Core = 0.25Core
* bkm-statefulset-worker: 1 * 0.15Core = 0.15Core
* bkm-prometheus-node-exporter: 10 * 0.1Core = 1Core

Mem (3632M in total):

* bkm-operator: 1 * 256M = 256M
* bkm-daemonset-worker: 10 * 192M = 1920M
* bkm-event-worker: 1 * 264M = 264M
* bkm-statefulset-worker: 1 * 192M = 192M
* bkm-prometheus-node-exporter: 10 * 100M = 1000M

## bkm-operator

bkmonitor-operator is the BlueKing container monitoring kubernetes manager. It is deeply integrated with the BlueKing monitoring ecosystem and reuses the underlying transmission links and storage. The operator generates collection tasks by monitoring CRD resources such as dataid/podMonitor/serviceMonitor/probe, schedules and distributes them to all nodes, and uses the gse pipeline to report data.

bkmonitor-operator is modified with reference to prometheus-operator, and also provides more new features. Compared with the entire architecture of prometheus-operator, we have less prometheus components and more three types of workers, namely bkm-event-worker/bkm-daemonset-worker/bkm-statefulset-worker. Three different types of workers are responsible for Collection of tasks with different functions.

Three types of operator workers can replace the collection capabilities of prometheus, and through the gse pipeline capabilities we can use the storage and query capabilities of BlueKing Monitoring. **Thanks to BlueKing monitoring centralized storage, bkmonitor-operator consumes less resources in the cluster than the prometheus-operator solution. Because prometheus does not need to be deployed in the business cluster, it is managed by the management and control cluster.**

### Architecture
The overall structure of bkmonitor-operator is as follows:
![](media/16921744056585.jpg)


### Operator Workers

Before introducing the operator worker, let's first talk about the collection task division of the operator component. In BlueKing Monitoring, we use dataid as an identifier to manage data sources. This is a management-side feature. Users do not actually perceive this identifier. In a container environment, dataid is also a CRD. After the user cluster is connected to BlueKing Monitoring, the monitoring and management backend will first inject 3 dataids into the cluster. They are:

* custommetricdataid: custom metric dataid.
* k8seventdataid: built-in event dataid.
* k8smetricdataid: built-in metric dataid.

To manage differentiation, the serviceMonitor collection injected by the operator will use the built-in dataid, which is specified by declaring `isSystem: "true"` in `metadata.annotations`. The user's data reporting will use a custom dataid. Of course, we have also expanded the dataid. Users can apply for a new dataid on the monitoring side, which is used to match the serviceMonitor of the characteristic dimension to isolate the data. If the amount is too large, we will divide the dataid into storage clusters. .

After the cluster is connected and the dataid resource is ready, the operator will start working. operator involves multiple components, which are introduced one by one here:

* bkm-operator: Task scheduler, responsible for monitoring various resources and calculating and scheduling collection tasks.
* bkm-event-worker: Collect kubernetes events.
* bkm-daemonset-worker: Collect endpoints indicator data in the cluster. In order to avoid cross-host traffic transmission, endpoints of the same node will be assigned to the daemonset of the node.
* bkm-statefulset-worker: Collect endpoints indicator data outside the cluster. If the user has too many endpoints, the number of worker copies will be automatically expanded to balance the collection tasks.
* bkm-prometheus-node-exporter: The official component of the community, used to collect node indicator data. For details, please refer to [prometheus/node_exporter](https://github.com/prometheus/node_exporter).
* bkm-kube-state-metrics: Official component of the community, used to collect k8s cluster's own indicator information. For details, please refer to [kubernetes/kube-state-metrics](https://github.com/kubernetes/kube-state-metrics ).

### Monitor Resources

bkmonitor-operator inherits the monitor CRD of prometheus-operator, including podMonitor/serviceMonitor/probe. At the same time, this concept has been expanded and supplemented.

Normally, after a user accesses BlueKing container monitoring, all collection resources and configurations will be the same as before using prometheus-operator-stack. ** However, there are some limitations in prometheus collection: **

**1) Single point question**

If the user cluster has too many collection endpoints, the prometheus resource usage in the cluster will be very high. Some users' prometheus cannot handle it even if it uses a machine with 128G of dedicated memory, because prometheus is responsible for the functions of data collection, indicator storage and indicator query. . It is true that officials also say that the storage and query pressure of prometheus can be reduced through solutions such as thanos, and the overhead of collection tasks can be reduced by deploying multiple prometheus nodes. ** But this also greatly increases the operation and maintenance costs and economic costs. **

But this problem has its own solution in bkmonitor-operator. First, we schedule the collection task to each worker, and spread the centralized pressure to distributed workers, so there will be no single-machine bottleneck. At the same time, as mentioned above, this method can also reduce network transmission across hosts. ** The number of statefulset workers can be expanded or reduced according to the number of user collection endpoints. ** Task scheduling will automatically sense it. **

**2) Local collection**

Not all services can be exposed in a form that can be accessed by cluster nodes, such as kubernetes control panel components, kube-proxy, kube-controller and kube-scheduler, etc. Their services are exposed in the form of localhost, and the cluster pod network policy does not Doesn’t make sense. Therefore, prometheus cannot collect in this scenario.

Thanks to the daemonset mechanism, each cluster node will deploy a bkm-daemonset-worker instance, which can share the host network stack in the form of `hostNetwork`, so the worker can easily collect endpoints exposed as localhost on the host. Users only need to declare `forwardLocalhost: "true"` in metadata.annotations when deploying serviceMonitor. If the operator detects this identifier, it will convert the endpoint host into localhost and deliver it to the worker.

**3) Resource overhead**

bkmonitor-operator optimizes link sharing for the prometheus discovery mechanism. In the design of prometheus, each discovery has its own independent apiserver long link to consume events from k8s. But in fact, these links can be shared, and listeners to the same namespace resources can be cached and use a subscription distribution mechanism in memory.

If there are 500 serviceMonitors in the cluster distributed under 30 namespaces, then prometheus-operator requires 500 tcp long chains, while bkmonitor-operator only requires 30. bkmonitor-operator greatly optimizes monitoring performance while ensuring data accuracy.

### Monitor Secrets

The collection tasks of bkmonitor-operator are distributed through secrets resources. Each secrets will contain multiple collection tasks. Gzip compression is used when writing to reduce the amount of data. Three different workers correspond to different secrets prefixes:

*event-worker-*
* daemonset-worker-*
*statefulset-worker-*

The operator will support monitoring changes in cluster monitoring resources. If the resources change, a collection task will be generated and dispatched to the corresponding worker. In this process, operator-worker interacts through secrets. The operator updates secrets. After `reloader-sidecar` senses the changes in secrets, it compares the data with local data. If the collection task changes, the worker is notified to reload. Otherwise, no processing is done. .

###Performance

The bkmonitorbeat collection and sending stress test performance is as follows:

| Number of indicators/sending interval/(CPU/MEM)| 5s | 15s | 60s |
| --- | --- | --- | --- |
| 1k | 2.1% / 20-25M | 1.5% / 23-26M | 0.7% / 19-23M |
| 5k | 3.0% / 20-25M | 1.6% / 21-32M | 1.0% / 17-20M |
| 10k | 1.4% / 30-45M | 1.4% / 33-43M | 1.1% / 33-46M |
| 100k | 100% / 20-190M | 20% / 140-190M | 5.4% / 100-180M |
| 300k | 100% / 150-190M | 100% / 150-200M | 8% / 60-120M |