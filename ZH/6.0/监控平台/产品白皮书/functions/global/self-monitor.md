# 自监控

自监控是监控监控平台本身，保证监控平台本身没问题。自监控分为两部分：

第一部分：监控链路展示，简单展示监控的模块运行存活状态。

第二部分：监控模块性能指标，通过性能指标的展示可以更好的定位问题。

## 监控链路展示

简单来说：

* 红色 异常
* 黄色 警告
* 绿色 正常

> **注意**：当红色异常的时候，鼠标停留在上面可以看到更多具体的信息。是问题快速定位有效的一种办法。

![-w2021](media/15754477874581.jpg)

## 模块性能指标

部署了一套 Prometheus+Grafana 自监控系统，可通过该系统监控 influxdb_proxy 与 transfer 的行为。

### 基本使用说明

入口： https://bkmonitor.grafana.{$PaaS_URL}.com/?orgId=1

默认用户名密码： admin

> 注意：域名部署时决定的。

### 指标说明

* influxdb_proxy_go_info 与 transfer_go_info

|名称|功能|
|---|---|
|go_threads|线程数|
|go_gc_duration_seconds|gc 花费时间|
|go_goroutines|gouroutines 数|

* influxdb_proxy_alert

|名称|功能|
|---|---|
|influxdb_proxy_state_change|监控 proxy 的重启操作，重启发生时，该指标会&gt;0|
|influxdb_proxy_backend_offline|backend(influxdb 实例)的离线情况|
|influxdb_proxy_backend_offline|kafka 离线情况|
|influxdb_proxy_consul_offline|consul 离线情况|
|influxdb_proxy_http_success_with_wrong_code|监控由 influxdb 实例通过 proxy 透传到 client 的错误 code|
|influxdb_proxy_http_request_failed|监控失败的 http 请求数|
|influxdb_proxy_http_blocked_request|阻塞(未返回)的 http 请求|
|influxdb_proxy_http_to_cluster_blocked_request|阻塞的从 http 传输到 cluster 的请求数|
|influxdb_proxy_cluster_request_failed|失败的 cluster 请求数|
|influxdb_proxy_cluster_blocked_request|阻塞的 cluster 请求数|
|influxdb_proxy_cluster_to_backend_blocked_request|阻塞的从 cluster 传递到 backend 的请求数|
|influxdb_proxy_backend_request_failed|失败的 backend 请求数|
|influxdb_proxy_backend_blocked_request|阻塞的 backend 请求数|
|influxdb_proxy_backend_backup_failed|backend 备份失败数|
|influxdb_proxy_backend_recover_failed|backend 恢复失败数|
|influxdb_proxy_backend_blocked_backup|阻塞的备份数|
|influxdb_proxy_backend_not_recovered_too_large_backup|数据量过大的未恢复备份数|


* influxdb_proxy_request_speed

|名称|功能|
|---|---|
|influxdb_proxy_http_increase_speed|http 请求数增速|
|influxdb_proxy_cluster_increase_speed|cluster 请求数增速|
|influxdb_proxy_backend_increase_speed|backend 请求数增速|
|influxdb_proxy_backup_increase_speed|备份数增速|
|influxdb_proxy_recover_increase_speed|恢复数增速|
|influxdb_proxy_cluster_to_backend_send_speed|cluster 传输到 backend 的请求增速|


* transfer_basic

|名称|功能|
|---|---|
|transfer_bulk_backend_buffer_usage|缓冲区利用率|
|transfer_esb_request_status|esb 请求的状态计数|
|transfer_scheduler_panic_pipeline|崩溃的流水线数量|
|transfer_pipeline_frontend_status|前端流水线状态|
|transfer_pipeline_processor_status|处理器流水线状态|
|transfer_pipeline_backend_status|后端流水线状态|
|transfer_scheduler_pipeline_status|流水线调度状态|
|transfer_consul_write_status|transfer 写 consul 的计数|
|transfer_kafka_frontend_rebalanced|kafka 再均衡次数|
|transfer_esb_request_handle_seconds|处理 esb 请求消耗的时间|


