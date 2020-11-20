## 作业平台 API 简介

**作业平台（Job）是一套基于蓝鲸智云管控平台 Agent 管道之上的基础操作平台，具备大并发处理能力；除了支持脚本执行、文件拉取/分发、定时任务等一系列可实现的基础运维场景以外，还运用流程化的理念很好的将零碎的单个任务组装成一个作业流程；而每个任务都可做为一个原子节点，提供给其它系统和平台调度，实现调度自动化。**


| 资源名称                                                  | 资源描述                       |
| --------------------------------------------------------- | ------------------------------ |
| [execute_job](./execute_job.md)                           | 启动作业                       |
| [fast_execute_script](./fast_execute_script.md)           | 快速执行脚本                   |
| [fast_execute_sql](./fast_execute_sql.md)                 | 快速执行 SQL                    |
| [fast_push_file](./fast_push_file.md)                     | 快速分发文件                   |
| [get_cron_list](./get_cron_list.md)                       | 查询业务下定时作业信息         |
| [get_job_detail](./get_job_detail.md)                     | 查询作业模板详情               |
| [get_job_instance_log](./get_job_instance_log.md)         | 根据作业实例 ID 查询作业执行日志 |
| [get_job_instance_status](./get_job_instance_status.md)   | 查询作业执行状态               |
| [get_job_list](./get_job_list.md)                         | 查询作业模板                   |
| [get_os_account](./get_os_account.md)                     | 查询业务下的执行账号           |
| [get_own_db_account_list](./get_own_db_account_list.md)   | 查询用户有权限的 DB 帐号列表     |
| [get_public_script_list](./get_public_script_list.md)     | 查询公共脚本列表               |
| [get_script_detail](./get_script_detail.md)               | 查询脚本详情                   |
| [get_script_list](./get_script_list.md)                   | 查询脚本列表                   |
| [get_step_instance_status](./get_step_instance_status.md) | 查询作业步骤的执行状态         |
| [operate_job_instance](./operate_job_instance.md)         | 作业实例操作                   |
| [operate_step_instance](./operate_step_instance.md)       | 步骤实例操作                   |
| [push_config_file](./push_config_file.md)                 | 分发配置文件                   |
| [save_cron](./save_cron.md)                               | 新建或保存定时作业             |
| [update_cron_status](./update_cron_status.md)             | 更新定时作业状态               |
