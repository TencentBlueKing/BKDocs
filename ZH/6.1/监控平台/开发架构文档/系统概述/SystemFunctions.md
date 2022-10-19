# 系统功能
## 采集器

| 进程名称|部署服务器|功能|
|--|--|--|
| unifyTlogc      | 用户服务器 | 采集日志数据 |
| processbeat     | 用户服务器 | 采集进程端口/进程资源数据 |
| basereport      | 用户服务器 | 采集服务器基础信息 |
| bkmetricbeat    | 用户服务器 | 采集组件性能数据 |
| uptimecheckbeat | 用户服务器 | 拨测客户端 |

## 监控后台进程

| **进程名称**                              | **部署服务器** | **功能**               |
| ----------------------------------------- | --------------| ----------------------|
| service:access_xxxN                       | 监控模块服务器 | 数据接入服务            |
| service:detectN                           | 监控模块服务器 | 数据检测服务            |
| service:triggerN                          | 监控模块服务器 | 异常触发服务            |
| service:event_xxxN                        | 监控模块服务器 | 事件触发、事件恢复等服务 |
| service:action_xxxN                       | 监控模块服务器 | 动作执行服务            |
| scheduler:celery_beat                     | 监控模块服务器 | 定时任务生成模块         |
| scheduler:celery_worker_cron              | 监控模块服务器 | 定时任务执行模块         |
| scheduler:celery_worker_api               | 监控模块服务器 | Api 缓存层任务执行模块   |
| scheduler:celery_worker_service           | 监控模块服务器 | 服务相关任务执行模块     |
| scheduler:celery_worker_notice            | 监控模块服务器 | 动作相关任务执行模块     |
| scheduler:celery_image_exporter           | 监控模块服务器 | 图表生成任务执行模块     |
| scheduler:celery_worker_default           | 监控模块服务器 | 其他相关任务执行模块     |
| selfmonitor:healthz                       | 监控模块服务器 | 监控自监控模块           |
| selfmonitor:logging                       | 监控模块服务器 | 监控日志服务             |
| kernel_api:kernel_api                     | 监控模块服务器 | 监控 API 服务           |
| metadata_config_cron:metadata_config_cron | 监控模块服务器 | 元数据信息同步刷新模块   |
| influxdb-proxy                            | 监控模块服务器 | InfluxDB 高可用代理     |
| transfer                                  | 监控模块服务器 | 监控数据清洗入库         |

注：xxx 代表具体的类型，N 代表数字，多个进程会有不同的数字


**注：X 代表同一模块启动的进程个数，各进程会到 consul 中注册节点，根据一致性 hash 算法获取分配到的待处理数据。**

## 监控后台扩展性

监控平台后台采用分布式的部署架构，将任务分布在不同的机器上。

1\. 进程起来后，会先将自己注册到 Consul 集群中，然后再通过一致性 hash，将任务分布到不同的主机上，任务可以是一个业务 ID，也可以是一个单独的监控项。

2\. 在同一主机的不同进程实例中，会继续将任务（不一定是前面的任务，粒度可以更细）分布到不同的进程上，避免进程任务不均匀。
