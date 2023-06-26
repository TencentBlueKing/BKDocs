# 采集器概述

不同的采集器有不同的使用场景.

| 采集器 | 采集范围 | 应用场景 |
| ----- | -------- | -------------- |
| Basereport(基础性能采集器) | 主机硬件配置信息、CPU、内存、磁盘、网络等实时状态 | 实时检测主机整体状态，应用于 CMDB -主机快照数据展示，监控平台-主机监控 |
| Bkmetricbeat(插件采集器) | 为插件提供数据清洗和转换等能力，将不同的数据格式转为标准监控平台的数据格式. | 所有的插件需求如 Exporter，DataDog，Script，JMX 等 |
| Exporter(插件) | 托管于 Bkmetricbeat ，内置 Exporter 集成了 Prometheus 成熟的采集器生态，无需像自定义 Exporter 那样需要进行复杂的配置，且可扩展性和可维护性比默认组件强，使用户能够快速用上 Prometheus Exporter 强大的采集能力。| 内置 Exporter 采集器支持：Haproxy 、 Memcache 、 SQL Server 、 Oracle 、 Weglogic 、 RabbitMQ  、 ZooKeeper 等，应用于监控平台-组件监控 |
| DataDog(插件) | 托管于 Bkmetricbeat ，为进一步增强监控平台的采集能力，基于现有的组件监控的采集架构拓展了 DataDog 的采集方式。通过在 DataDog Agent Integrations 的基础上封装一层 DataDog Http Server ，从而达到与 Prometheus Exporter 相似的被动采集方式。 | 内置 DataDog 采集器支持：Kafka 、 Microsoft AD 、 Ceph 、 Consul 、 Elasticsearch 、 Exchange_Server_2010 、 Microsoft IIS 、 MongoDB 等，应用于监控平台-组件监控 |
| BK-Pull(远程拉取采集器) | 如 tomcat | 需要远程拉取的应用场景 |
| Processbeat(进程性能采集 | 主机内进程的监听端口状态、性能 | 及时发现进程异常，避免进程异常导致的连锁反应，应用于监控平台-主机监控-进程监控汇  |
| BKLogBeat(高性能日志采集器) | 主机内用户所选日志文件  | 对用户特定日志文件实现过滤、采集上报，从日志中发现问题，应用于监控平台-自定义监控/仪表盘视图 |
| Gsecmdline(自定义上报命令行工具) | 根据用户下发的脚本采集指定数据 | 对于其他采集器无法覆盖的数据或者用户自开发的服务，用户可自行编写脚本采集数据通过 Gsecmdline 上报，应用监控平台-自定义监控/仪表盘视图 |
| Uptimecheckbeat(拨测监控采集器) | 定期主动对用户选定的服务进行探测 | 用户可通过 HTTP 、 TCP 、 UDP 三种协议对指定服务进行定期请求，监控检测返回内容和响应时间是否符合用户设定，主动发现消除隐患，应用于监控平台-拨测监控 |
