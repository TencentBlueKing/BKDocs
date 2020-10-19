# 系统功能

| **进程名称**                                           | **部署服务器**   | **功能**                       |
|--------------------------------------------------------|------------------|--------------------------------|
| **unifyTlogc**                                         | 用户服务器       | 采集日志数据                   |
| **ProcessMonitorBeat**                                 | 用户服务器       | 采集进程端口数据               |
| **basereport**                                         | 用户服务器       | 基础信息                       |
| **gse_ops**                                            | DataServer服务器 | 汇聚Ping告警信息，产生告警事件 |
| **gse_data**                                           | DataServer服务器 | 接收Agent上报数据              |
| JPS: **BkDatabusWorker** Supervisord: **databus_etl**  | 数据模块服务器   | 清洗原始数据到内部格式         |
| JPS: **BkDatabusWorker** Supervisord: **databus_jdbc** | 数据模块服务器   | 分发数据入库MySQL              |
| JPS: **BkDatabusWorker** Supervisord: **databus_es**   | 数据模块服务器   | 分发数据入库ElasticSearch      |
| Supervisord: **dataapi**                               | 数据模块服务器   | 管理API                        |
| **monitor-common:jobserver**                           | 数据模块服务器   | 监控内部流程管理               |
| **monitor-common:logging**                             | 数据模块服务器   | 监控系统日志落地               |
| **monitor-common:polling**                             | 数据模块服务器   | 监控内部调度任务模块           |
| **monitor-common:scheduler**                           | 数据模块服务器   | 监控定时任务                   |
| **monitor-dectector:detect**                           | 数据模块服务器   | 监控检测模块                   |
| **monitor-dectector:detect_cron**                      | 数据模块服务器   | 监控定时运行                   |
| **monitor-kernel:collectX**                            | 数据模块服务器   | 监控汇总模块                   |
| **monitor-kernel:convergeX**                           | 数据模块服务器   | 监控收敛模块                   |
| **monitor-kernel:job**                                 | 数据模块服务器   | 监控告警处理分配节点           |
| **monitor-kernel:poll_gse_base_alarm**                 | 数据模块服务器   | 拉取基础告警                   |
| **monitor-kernel:poll_gse_custom_out_str**             | 数据模块服务器   | 拉取自定义告警                 |
| **monitor-kernel:poll_jungle_alert**                   | 数据模块服务器   | 拉取监控告警                   |
| **monitor-kernel:solutionX**                           | 数据模块服务器   | 监控任务调度                   |
