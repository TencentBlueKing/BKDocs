## 采集器概述

蓝鲸除了自研的采集器外，还有有基于 Beats 的基础性能采集器、组件监控采集器，此外组件采集器支持 Prometheus Exporter 及自助导入、 DataDog 开源的 100+ 款组件。采集器详细内容参考下表：


| 采集器 | 采集范围 | 应用场景 |
| ------| -------- | ------- |
| * Basereport(基础性能采集器)| 主机硬件配置信息、CPU、内存、磁盘、网络等实时状态 | 实时检测主机整体状态，应用于 CMDB -主机快照数据展示，监控平台-主机监控 |
| * Bkmetricbeat(组件性能采集器)| 开源组件、中间件层服务(提供接入支持，没有覆盖到的组件需用户自行开发 Prometheus 采集器)的状态、性能等实时状态 | 采集组件的 Metrics 信息，支持 Redis，Apache，Nginx 等开源组件，也负责托管 DataDog 采集器及 Prometheus 的 Exporter ，应用于监控平台-组件监控 |
| Exporter(组件性能采集器)| 托管于 Bkmetricbeat ，内置 Exporter 集成了 Prometheus 成熟的采集器生态，无需像自定义 Exporter 那样需要进行复杂的配置，且可扩展性和可维护性比默认组件强，使用户能够快速用上 Prometheus Exporter 强大的采集能力。  | 内置 Exporter 采集器支持：Haproxy 、 Memcache 、 SQL Server 、 Oracle 、 Weglogic 、 RabbitMQ  、 ZooKeeper 等，应用于监控平台-组件监控 |
| DataDog(组件性能采集器)| 托管于 Bkmetricbeat ，为进一步增强监控平台的采集能力，基于现有的组件监控的采集架构拓展了 DataDog 的采集方式。通过在 DataDog Agent Integrations 的基础上封装一层 DataDog Http Server ，从而达到与 Prometheus Exporter 相似的被动采集方式。| 内置 DataDog 采集器支持：Kafka 、 Microsoft AD 、 Ceph 、 Consul 、 Elasticsearch 、 Exchange_Server_2010 、 Microsoft IIS 、 MongoDB 等，应用于监控平台-组件监控 |
| * Processbeat(进程性能采集)| 主机内进程的监听端口状态、性能 | 及时发现进程异常，避免进程异常导致的连锁反应，应用于监控平台-主机监控-进程监控汇 |
| * Unifytlogc(高性能日志采集器)| 主机内用户所选日志文件 | 对用户特定日志文件实现过滤、采集上报，从日志中发现问题，应用于监控平台-自定义监控/仪表盘视图 |
| * Gsecmdline(自定义上报命令行工具)| 根据用户下发的脚本采集指定数据 | 对于其他采集器无法覆盖的数据或者用户自开发的服务，用户可自行编写脚本采集数据通过 Gsecmdline 上报，应用监控平台-自定义监控/仪表盘视图 |
| * Uptimecheckbeat(拨测监控采集器)| 定期主动对用户选定的服务进行探测 | 用户可通过 HTTP 、 TCP 、 UDP 三种协议对指定服务进行定期请求，监控检测返回内容和响应时间是否符合用户设定，主动发现消除隐患，应用于监控平台-拨测监控 |
