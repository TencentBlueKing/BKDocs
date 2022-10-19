# 维护说明

## 数据模块服务日志目录

主要文件说明如下：

```bash
logs/bkmonitor/
|--transfer.log                 Transfer 日志
|--kernel.log                   监控日志（及以下）
|--kernel_api.log               监控后台 API 日志
|--influxdb-proxy.log           influxdb-proxy 日志
|-- monitor-supervisor.sock
|-- monitor-supervisord.log
|-- monitor-supervisord.pid
```

## 监控产生的告警事件存储在 MySQL 中

- 数据库名：`bkdata_monitor_alert`
- 表名：alarm_anomaly_record、alarm_event、alarm_alert
  - alarm_anomaly_record：异常记录表
  - alarm_event：事件表
  - alarm_alert：通知记录表
- 清理建议：根据实际需求，也可以手动清理。

例：清理半年前的告警事件数据：
`delete from bkdata_monitor_alert.ja_alarm_alarminstance where source_time < date_sub(now(),interval 6 month)`;

## 监控数据存储在 influxdb

按数据用途拆分库表，如 rt 为`system.cpu_detail`的表，存储在数据库 system 中的`cpu_detail`表中，保留策略为`shard group`持续 1 天，保留 90 天，需要在每个节点上修改：

根据不同的性能数据存储的库名前缀不同，具体规则如下：

在仪表盘中选中指标：`system.cpu_detail.usage`，按.分割指标，system 表示库名前缀，`cpu_detail`表示表名，usage 表示字段名。库名实际为 system。

保存周期，目前原始性能数据保存周期默认为 30 天。如需修改，针对对应的数据库执行： `alter RETENTION POLICY rp_system on system DURATION 2160h SHARD DURATION 24h DEFAULT`
该操作设置业务 id 为 2 的主机性能数据保存周期为 90 天

## 自有数据链路排障指引

当发现监控平台数据丢失或无数据时，可以考虑排查自有链路是否有问题，引发数据的丢失。可以从以下的步骤确认链路环节是否有问题：

### Zookeeper 数据是否正确写入

首先，我们需要检查 zookeeper 写入的数据是否正常。因为如果监控与 GSE data server 之间的信息同步有问题，会导致 data server 无法将数据写入 kafka，从而导致后续链路异常，引起无数据。检查 zookeeper，主要关注两个路径：
a.`/gse/config/etc/dataserver/data/${data_id}`

该路径下的信息，告知了 GSE data server 对于这个 data id 上报的信息，该交付到哪个消息队列中。信息格式正常情况下，应该有如下所示内容：

```json
[{
    "server_id": -1,                # 不必关心，写死
    "data_set": "0bkmonitor_1001",  # 数据源名称
    "partition": 1,
    "cluster_index": 500,     # GSE data server集群ID
    "biz_id": 0,              # 业务ID，写死
    "msg_system": 1,          # 消息队列类型，写死，1表示kafka
    "bkmonitor_config": True  # 表明是监控配置
}]
```

GSE data server 获取到该配置后，内部会有进一步的信息拼接，具体如下：

- 通过 cluster_index，从/gse/config/etc/dataserver/storage/all/0_500 获取 kafka 写入集群信息。
- 拼接 data_set 和 biz_id 信息，获取 topic 名称，具体关系为：${data_set}${biz_id}。以上面信息为例，topic 名称为 0bkmonitor_10010。

b.`/gse/config/etc/dataserver/storage/all/0_500`

该路径下的信息，告知了 GSE data server 集群 ID 为 500 的消息队列。正常情况下，应该有如下所示内容：
[{"host":"kafka.service.consul","port":9092}]

如果上述 zookeeper 中的信息异常或丢失，建议：

- 检查数据库 mysql 中的 metadata_datasource 表中配置是否有问题，导致数据写入异常
- 检查监控的 metadata_config_cron 服务是否正常运行

### Kafka 数据是否正常

在上述步骤确认写入 zookeeper 的数据正常后，我们可以尝试从 kafka 读取该 data_id 对应的 topic，查看是否有数据。如果发现无数据，建议检查：

- Agent 与 DataServer 之间网络，链接是否存在。`netstat -npt| grep 58625`
- DataServer 与 kafka 之间的链接是否存在。`netstat -npt | grep 9092`
- DataServer 与其他存储之间的长连接判断，类似 `netstat -npt| grep ${port}`

### Transfer 工作是否正常

Transfer 在读取 kafka 数据后，会将数据解析成结构化数据，通过 influxdb-proxy 写入到 influxDB 中。判断 Transfer 是否正常，可以有以下步骤处理：

指标说明

| 名称                                | 描述                       | 模块        | 类型   |
| ----------------------------------- | --------------------------| ------------| ------ |
| consul_write_failed_total           | 写 consul 失败次数         | 动态字段上报 | 计数器 |
| consul_write_success_total          | 写 consul 成功次数         | 动态字段上报 | 计数器 |
| esb_request_fails_total             | 请求 esb 失败次数          | CC 缓存      | 计数器 |
| esb_request_successes_total         | 请求 esb 成功次数          | CC 缓存      | 计数器 |
| esb_request_handle_seconds\*        | 请求 esb 耗时分布          | CC 缓存      | 直方图 |
| go_gc_duration_seconds\*            | gc 暂停耗时统计            | 系统         | 统计   |
| go_goroutines                       | goroutine 数量            | 系统         | 度量   |
| go_threads                          | 系统线程数量               | 系统         | 度量   |
| influx_backend_buffer_remains\*     | influxdb 缓冲区饱和度分布   | influxdb    | 直方图 |
| pipeline_backend_dropped_total      | 流水线后端丢弃消息数        | 流水线       | 计数器 |
| pipeline_backend_handled_total      | 流水线后端处理消息总数      | 流水线       | 计数器 |
| kafka_frontend_rebalanced_total     | kafka 重均衡次数           | kafka       | 计数器 |
| pipeline_frontend_dropped_total     | 流水线前端丢弃消息数        | 流水线       | 计数器 |
| pipeline_frontend_handled_total     | 流水线前端处理消息总数      | 流水线       | 计数器 |
| pipeline_processor_dropped_total    | 流水线处理器丢弃消息数      | 流水线       | 计数器 |
| pipeline_processor_handled_total    | 流水线处理器处理消息总数    | 流水线       | 计数器 |
| pipeline_processor_handle_seconds\* | 流水线处理耗时分布          | 流水线       | 直方图 |
| scheduler_panic_pipeline_total      | 调度器捕获流水线 panic 次数 | 调度器       | 计数器 |
| scheduler_pending_pipelines         | 调度器挂起流水线数量        | 调度器       | 度量   |
| scheduler_running_pipelines         | 调度器运行流水线数量        | 调度器       | 度量   |

a.检查集群状态是否有存活节点：transfer cluster

- 如果没有存活节点，检查 transfer.pid 文件对应的进程是否存在
- 不存在使用 supervisor 拉起
- 存在则检查进程是否僵死

b.检查 dataid 分配情况：transfer shadow

- 如果检查单个 dataid，记下对应的节点
- 如果没有找到对应的 dataid，需要检查元数据是否正确同步配置

c.检查 metrics 是否有问题：http://{{host}}:{{port}}/metrics

- 关注监控指标中加粗的指标状态
- scheduler_running_pipelines 为 0，说明没有流水线被启动
- scheduler_pending_pipelines 不为 0，说明有流水线被挂起
- pipeline_frontend_handled_total 为 0，数据源可能没有数据上报或元数据配置不正确

d.检查日志是否有 CC 缓存或查询主机报错，如有则使用 update-cc-cache 信号更新缓存

e.如果还有查询主机报错，使用命令 transfer signal -s dump-host-info 将缓存打印出来，对比 CC 是否一致

f.使用命令 transfer signal -s set-log-level -v level=debug 将日志级别调整至 debug，跟踪日志流程排错

- 如果日志长时间没有更新，请尝试 strace 排查进程是否假死，假死按后续步骤排查
- 如果提示 kafka 没有 leader 或一直 rebalance error，请检查 kafka 和 Zookeeper 状态
- 日志类似：<db>:<data_id>:<result_table> dropped <n> points 说明对应的存储不可用导致数据丢失，请排查对应的存储状态
- 日志类似：<etl>:<data_id> handle payload <sn>-<raw_data> failed: <message>，说明 data_id 对应的上报数据不符合清洗格式，需要用户修改清洗配置或上报数据，但会导致数据丢失
- 一般来说，错误级别日志说明环境或程序处理错误，需要运维和开发来处理，而警告级别则说明配置或数据问题，需要用户来处理

g.保存当前进程信息：transfer snapshot

h.将日志文件、进程信息和配置文件保存给开发排查

### InfluxDB-Proxy 工作是否正常

为保证 InfluxDB 是高可用的状态，监控平台提供了 influxdb-proxy 实现数据双写。在 Transfer 将数据格式化完成后，将会将数据通过 Proxy 写入到 InfluxDB 中。排查手段可以：

a.通过 supervisorctl 检查 influxdb-proxy 是否正常工作

b.观察 influxdb-proxy 指标是否存在异常，获取方式：

- http:// influxdb_proxy.bkmonitor.service.consul:10201/metrics
- 指标说明

| 名称          | 描述                   | 类型   |
| ------------- | ----------------------| ------ |
| success_total | influxdb 读写成功操作  | 计数器 |
| failed_count  | influxdb 读写失败操作  | 计数器 |
| backup_count  | 备份读写操作           | 计数器 |
| alive_backend | 后端存活 influxdb 数量 | 度量   |

在正常情况下，failed_count 及 backup_count 应该不增长，同时 alive_backend 计数与后端连接的 InfluxDB 实例数量相符。

### InfluxDB 工作是否正常

如果 Proxy 工作正常，可以观察 InfluxDB 状态是否正常。

## Monitor 后台服务排查指引

1\. 检查后台进程是否正常

后台进程是通过 supervisor 托管，可以通过 supervisorctl 查看进程状态。

`supervisorctl -c $BK_HOME/etc/supervisor-bkmonitor-monitor.conf status`

2\. 后台数据流转

![后台数据流转](media/15833893621445.jpg)

可以通过 strategy_id 和事件 ID(event_id)追踪日志流水，从而看出数据在哪一个环节出了问题。

3\. 一致性 hash

后台每一类进程都是可横向扩展，当发现某个进程处理能力不够时，可以通过调整进程数量来提高处理能力。同一类进程之间是通过一致性 hash 计算出当前机器当前进程需要处理哪些业务数据。
查看业务 hash 分配情况。

`workon bkmonitor-monitor ./bin/manage.sh hash_ring`

查看具体某个业务，可以带上参数--biz_id，例如：
`./bin/manage.sh hash_ring --biz_id=2`

4\. healthz 自监控

自监控：后台所有服务的健康度检查，可以通过监控 SaaS 页面查看详情，也可以配置告警接收人，当自监控异常后发送告警通知给相关人。
