# BlueKing Monitoring VS Prometheus

In the field of container monitoring, Prometheus is standard and has become the most popular monitoring tool. However, in complex enterprise environments, Prometheus always has many limitations, so the community has also introduced many solutions. Currently, BlueKing Monitoring provides a complete set of Kubernetes solutions, covering indicators, events, logs, Trace, etc.

## Limitations of Prometheus

### Function limitations

* Prometheus is metric-based monitoring and is not suitable for logs, events, and tracing.
* Prometheus defaults to the Pull model, and there is no solution across cloud regions.
* When the amount of data is too large, it is very easy to OOM and cannot be clustered and horizontally expanded. Neither the official nor the community has a silver bullet. It is necessary to choose a reasonable combination of Federate, Cortex, Thanos and other solutions. Although there are these high-availability solutions, the efficiency is still very slow when the amount of data is large. There are many situations where large clusters cannot handle it, such as Lgame Metal Slug. The essential reason is that Prometheus’s local storage does not have data synchronization capabilities. It is difficult to maintain data consistency while ensuring availability.
* Prometheus, Alertmanager Grafana and other systems are relatively fragmented, lack a unified view, and cannot be used out of the box.
* The production environment runs multiple prometheus clusters, and the management and usage costs are very high.
* Yaml is very flexible, the cost is relatively high, and the UI is too weak


### Prometheus large memory problem

As the scale increases, the CPU and memory required by Prometheus will increase. Memory generally reaches the bottleneck first. At this time, either more memory is added, or the cluster is sharded to reduce single-machine indicators. Here we first discuss the memory problem of the stand-alone version of Prometheus.

reason:

* The memory consumption of Prometheus is mainly due to the fact that a Block data is written to the disk every 2 hours. All data is in the memory before being written to the disk, so it is related to the collection volume.
* When loading historical data, it is from disk to memory. The larger the query range, the larger the memory. There is some room for optimization here.
* Some unreasonable query conditions will also increase memory, such as Group or large-range Rate.

### Prometheus slow restart and hot loading

When Prometheus restarts, it needs to load the contents of Wal into memory. The longer the retention time and the larger the Wal file, the longer the actual restart. This is the mechanism of Prometheus and there is no other way. Therefore, if you can Reload, do not restart. Restart must be done. It will lead to short-term unavailability, and at this time, Prometheus high availability is very important.


## Why OpenTelemetry mainly recommends Push

Prometheus mainly promotes the Pull method, and OpenTelemetry mainly promotes the Push method. Which method is better?

### How Pull VS Push works

|Principle comparison |Pull|Push|
|---|---|---|
|Configuration management |Centralized configuration |1. On-end static configuration <br> 2. Obtain configuration through the configuration center |
|Monitoring object discovery |1. Static <br> 2. Relying on service discovery mechanisms such as k8s, CMDB, etc. |Reported by the application independently, no service discovery module required |
|Deployment method |1. The application directly exposes the port and accesses service discovery <br> 2. The service does not directly expose the port, such as MYSQL relying on the adapter (Exporter) |The application is actively pushed to the monitoring system |
|Scalability |1. Relies on Pull-side expansion; <br> 2. Requires Pull Agent and storage decoupling (native Prometheus does not support) |Simple, only requires horizontal expansion of the central receiving end |

To make the right choice, you need to first understand the working principles of Pull and Push. The key difference here is how the monitoring objects are discovered. Pull needs to obtain the target address list in advance, in order to be able to automatically expand and shrink based on the business. For collection, the ability of service discovery is indispensable. For example, K8s naturally has the advantage of service discovery. Push does not need to know the target address list in advance, and it is relatively simple.

![](media/16921759032406.jpg)
Pull method

![](media/16921759163876.jpg)

Push mode

### Pull VS Push capability comparison

|Comparison of capabilities |PULL |PUSH |
|---|---|---|
|Monitor object liveness |Simple |Indistinguishable |
|Data completeness calculation |Feasible |Difficult |
|Short life cycle (Job, Serverles), high real-time performance |Difficult to apply |Applicable |
|Flexibility of indicator acquisition |Fixed, easy to share, available on demand |Flexible, passively accepting learning from links |

It is precisely because the working principles of the two are different that they also determine the difference in capabilities between the two. In the field of monitoring, it is very important to monitor the viability of objects. There is a clear goal when pulling, so it can be very simple to judge whether empty data is being pulled or there is a problem with the monitoring object, and the pulling cycle can also be controlled. When pushing, I don’t know what the cycle is, and when I don’t receive data, I don’t know whether it’s because it was offline or because it hung up. So this is why Prom has always preferred the Pull method rather than Push.

However, in some short-life cycle processes or scenarios such as trace, where real-time requirements are very high, or there is no way to define monitoring objects in advance, such as browsers and mobile terminals, reporting can only be done through Push. So this is why the architecture introduced by Opentelemetry is Push.

![](media/16921759336623.jpg)

Pull method

![](media/16921759392417.jpg)
Push mode


### Pull VS Push cost comparison

|Cost comparison |Pull |Push |
|---|---|---|
|Resource consumption |1. Application exposed port method is low <br> 2. Exporter method is high 3. Occupies port resources |1. Application push is low consumption <br> 2. Agent push is low consumption |
|Security Guarantee |Large workload, security of exposed ports |Low workload |
| Core operation and maintenance consumption | 1. The platform maintains many components and the cost is high <br> 2. Simple positioning | 1. The platform maintains few components and the cost is low <br> 2. Positioning is difficult |

The last one is the difference in cost. Now the performance of servers is very high, and the security of enterprises is relatively complete, so resource consumption and security considerations can be relatively ignored. In the actual production process, the uncertainty and wrangling caused by Push are actually more obvious.

### Basic principles of selection

How to choose Pull or Push?

As a platform, having the ability to pull and push at the same time is the optimal solution:

- Monitor hosts, processes, and middleware using Agent Pull collector mode
- Kubernetes and other applications that directly expose the Pull port use the Pull mode
- Select Pull mode for application integration with CMDB (service discovery)
- The application cannot deploy Agent, cannot service discovery, and uses Push if the life cycle is short.

Simple principle:

Use PULL if possible (it can solve service discovery problems), and PUSH for others.



## BlueKing Monitoring Solution

![](media/16921757683635.jpg)

The above is a schematic diagram of the basic working of BlueKing monitoring, which includes two methods: Pull and Push. Three cloud areas are simply drawn to represent the cross-cloud area data transmission capabilities of BlueKing Monitoring.

* Learn from each other
* Compatible with Prom and OTel data protocols
* Compatible with PromQL and function query methods
* You can simply encapsulate the exporter into a BlueKing monitoring plug-in
* Fully compatible with ServiceMonitor and PodMonitor

* Fill in shortcomings (Prom only has Metric, no out-of-box capabilities, etc.)
- Prom dashboard can be imported with one click
-Support simpler UI configuration
- Supports convenient out-of-the-box data display capabilities
- Full functionality reuse, such as fault self-healing and AIOps capabilities

* Fill in the gaps (Prom does not have a cross-cloud regional solution, single point, memory OOM, Otel's metric and log are not yet stable)
  - Supports cross-cloud region and cross-cluster transmission, relying on the BlueKing GSE pipeline, which has carried data transmission of hundreds of thousands of servers, including JOB instructions, log transmission, metric collection, etc.
- Supports local pull, remote pull, and push; local pull effectively disperses the pull pressure of centralized pull and increases the concurrency capability of data transmission. Remote pull optimizes single-point pull and other architectural issues through load balancing.
- Metric supports TraceID output mode, and the ability to output TraceID is implemented in Prom's SDK.

In addition, BlueKing Monitoring also has some unique capabilities.

* The entire BlueKing can be privatized and deployed independently, and all functions will not be affected.
* Relying on BlueKing’s CD management and control capabilities
* BlueKing Monitoring has plug-in collection capabilities, you only need to write plug-ins
* Dynamic collection and plug-in process hosting can be completed by monitoring
* It has the ability to handle faults and even self-heal, and can link with surrounding process services, standard operation and maintenance, and JOB operations
* Relying on computing platform and AIOps platform
* BlueKing Monitoring has big data computing and AI analysis capabilities
* BlueKing Monitoring can also consume data from the computing platform and provide monitoring capabilities for the computing platform.