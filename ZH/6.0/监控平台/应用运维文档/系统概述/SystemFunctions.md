# 系统功能

| **进程名称**                              | **部署服务器** | **功能**               |
| ----------------------------------------- | --------------| -----------------------|
| service:access_xxxN                       | 监控模块服务器 | 数据接入服务            |
| service:detectN                           | 监控模块服务器 | 数据检测服务            |
| service:triggerN                          | 监控模块服务器 | 异常触发服务            |
| service:event_xxxN                        | 监控模块服务器 | 事件触发、事件恢复等服务 |
| service:action_xxxN                       | 监控模块服务器 | 动作执行服务            |
| scheduler:celery_beat                     | 监控模块服务器 | 定时任务生成模块        |
| scheduler:celery_worker_cron              | 监控模块服务器 | 定时任务执行模块        |
| scheduler:celery_worker_api               | 监控模块服务器 | Api 缓存层任务执行模块  |
| scheduler:celery_worker_service           | 监控模块服务器 | 服务相关任务执行模块     |
| scheduler:celery_worker_notice            | 监控模块服务器 | 动作相关任务执行模块     |
| scheduler:celery_image_exporter           | 监控模块服务器 | 图表生成任务执行模块     |
| scheduler:celery_worker_default           | 监控模块服务器 | 其他相关任务执行模块     |
| selfmonitor:healthz                       | 监控模块服务器 | 监控自监控模块          |
| selfmonitor:logging                       | 监控模块服务器 | 监控日志服务            |
| kernel_api:kernel_api                     | 监控模块服务器 | 监控 API 服务           |
| metadata_config_cron:metadata_config_cron | 监控模块服务器 | 元数据信息同步刷新模块   |
| influxdb-proxy                            | 监控模块服务器 | InfluxDB 高可用代理     |
| transfer                                  | 监控模块服务器 | 监控数据清洗入库        |

> 注：xxx 代表具体的类型，N 代表数字，多个进程会有不同的数字
