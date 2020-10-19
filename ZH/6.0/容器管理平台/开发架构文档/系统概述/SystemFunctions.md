# 系统功能

| **进程名称**                          | **部署服务器**    | **功能**                      |
|--------------------------------------|------------------|--------------------------------|
| **bk_monitor:run_data_access**       | 监控中心后台服务器 | 基础性能拉取模块                |
| **bk_monitor:run_data_access_cmd**   | 监控中心后台服务器 | 基础性能执行调度模块            |
| **bk_monitor:run_detect_new**        | 监控中心后台服务器 | 基础性能检测模块                |
| **cron**                             | 监控中心后台服务器 | 周期任务模块                   |
| **bk_monitor:poll_alarm_bk_monitor** | 监控中心后台服务器 | 基础性能告警拉取模块(检测后数据) |
| **event:run_poll_alarm**             | 监控中心后台服务器 | 事件拉取模块                   |
| **flows:collect**                    | 监控中心后台服务器 | 告警汇总，通知模块              |
| **flows:converge**                   | 监控中心后台服务器 | 告警收敛模块                   |
| **flows:match_alarm**                | 监控中心后台服务器 | 告警匹配模块                   |
| **scheduler-celery**                 | 监控中心后台服务器 | 后端异步任务模块               |
| **WebConsole**                       | 容器服务后台服务器 | WebConsole 模块               |
| **bcs_cc**                           | 配置中心服务器     | 配置中心                      |
