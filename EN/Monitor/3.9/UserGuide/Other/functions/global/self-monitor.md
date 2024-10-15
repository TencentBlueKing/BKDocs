# self-monitoring

Self-monitoring is to monitor the monitoring platform itself to ensure that there is no problem with the monitoring platform itself. Self-monitoring is divided into two parts:

The first part: Monitoring link display, simply showing the running and survival status of the monitored module.

Part 2: Monitor module performance indicators. Problems can be better located through the display of performance indicators.

## Monitoring link display

simply put:

* red abnormal
* yellow warning
* Green normal

> **Note**: When the red color is abnormal, you can see more specific information by hovering the mouse on it. It is an effective way to quickly locate problems.

![-w2021](media/15754477874581.jpg)

## Module performance indicators

A Prometheus+Grafana self-monitoring system has been deployed, through which the behavior of influxdb_proxy and transfer can be monitored.

### Basic instructions for use

Entrance: https://bkmonitor.grafana.{$PaaS_URL}.com/?orgId=1

Default username and password: admin

> Note: The domain name is determined during deployment.

### Indicator description

* influxdb_proxy_go_info and transfer_go_info

|name|function|
|---|---|
|go_threads|Number of threads|
|go_gc_duration_seconds|gc time spent|
|go_goroutines|number of gouroutines|

* influxdb_proxy_alert

|name|function|
|---|---|
|influxdb_proxy_state_change|Monitor the proxy's restart operation. When a restart occurs, this indicator will be &gt;0|
|influxdb_proxy_backend_offline|The offline situation of backend (influxdb instance)|
|influxdb_proxy_backend_offline|kafka offline situation|
|influxdb_proxy_consul_offline|consul offline situation|
|influxdb_proxy_http_success_with_wrong_code|Monitor the error code transparently transmitted from the influxdb instance to the client through the proxy|
|influxdb_proxy_http_request_failed|Monitor the number of failed http requests|
|influxdb_proxy_http_blocked_request|Blocked (not returned) http request|
|influxdb_proxy_http_to_cluster_blocked_request|Number of blocked requests from http to cluster|
|influxdb_proxy_cluster_request_failed|Number of failed cluster requests|
|influxdb_proxy_cluster_blocked_request|Number of blocked cluster requests|
|influxdb_proxy_cluster_to_backend_blocked_request|The number of blocked requests from cluster to backend|
|influxdb_proxy_backend_request_failed|Number of failed backend requests|
|influxdb_proxy_backend_blocked_request|Number of blocked backend requests|
|influxdb_proxy_backend_backup_failed|backend backup failed number|
|influxdb_proxy_backend_recover_failed|number of backend recovery failures|
|influxdb_proxy_backend_blocked_backup|Number of blocked backups|
|influxdb_proxy_backend_not_recovered_too_large_backup|The number of unrestored backups with too large data volume|


* influxdb_proxy_request_speed

|name|function|
|---|---|
|influxdb_proxy_http_increase_speed|http request number growth rate|
|influxdb_proxy_cluster_increase_speed|cluster request number increase speed|
|influxdb_proxy_backend_increase_speed|backend request number growth rate|
|influxdb_proxy_backup_increase_speed|Backup number increase speed|
|influxdb_proxy_recover_increase_speed|Recovery number growth rate|
|influxdb_proxy_cluster_to_backend_send_speed|cluster request growth rate transmitted to backend|


* transfer_basic

|name|function|
|---|---|
|transfer_bulk_backend_buffer_usage|buffer utilization|
|transfer_esb_request_status|status count of esb request|
|transfer_scheduler_panic_pipeline|Number of crashed pipelines|
|transfer_pipeline_frontend_status|Front-end pipeline status|
|transfer_pipeline_processor_status|Processor pipeline status|
|transfer_pipeline_backend_status|Backend pipeline status|
|transfer_scheduler_pipeline_status|Pipeline scheduling status|
|transfer_consul_write_status|transfer write consul count|
|transfer_kafka_frontend_rebalanced|kafka rebalance times|
|transfer_esb_request_handle_seconds|Time consumed in processing esb request|