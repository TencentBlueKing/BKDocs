# 告警事件/性能数据的维护

## 告警事件维护

监控产生的告警事件存储在 MySQL 中。

- 数据库名：bkdata_monitor_alert；

- 表名：alarm_anomaly_record、alarm_event、alarm_alert

  * alarm_anomaly_record：异常记录表

  * alarm_event：事件表

  * alarm_alert：通知记录表

例：清理半年前的告警事件数据：

`delete from bkdata_monitor_alert.alarm_event where source_time < date_sub(now(),interval 6 month);`

## 性能数据维护

- 监控采集的性能数据全部存储在时序数据库 influxdb 中。

- 根据不同的性能数据存储的库名前缀不同，具体规则如下：

    在仪表盘中选中指标：system.cpu_summary.usage，按.分割指标，system 表示库名前缀，cpu_summary 表示表名，usage 表示字段名。库名实际为 system_{biz_id}，其中 biz_id 为业务 id。
    因此业务 2 的主机性能数据存储的数据库名为：system_2。

- 保存周期，目前原始性能数据保存周期默认为 30 天。

    如需修改，针对对应的数据库执行：alter RETENTION POLICY rp_system_2 on system_2 DURATION 2160h SHARD DURATION 24h DEFAULT
    
    该操作设置业务 id 为 2 的主机性能数据保存周期为 90 天。
