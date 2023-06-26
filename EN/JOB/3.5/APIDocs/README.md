## 作业平台 V3 API 简介

**作业平台（Job）是一套基于蓝鲸智云管控平台 Agent 管道之上的基础操作平台，具备大并发处理能力；除了支持脚本执行、文件拉取/分发、定时任务等一系列可实现的基础运维场景以外，还运用流程化的理念很好的将零碎的单个任务组装成一个作业流程；而每个任务都可做为一个原子节点，提供给其它系统和平台调度，实现调度自动化。**


| 资源名称                                                                    | 资源描述                                 |
| --------------------------------------------------------------------------- | ---------------------------------------- |
| [batch_get_job_instance_ip_log](./zh-hans/batch_get_job_instance_ip_log.md)         | 根据 ip 列表批量查询作业执行日志         |
| [callback_protocol](./zh-hans/callback_protocol.md)                                 | 回调                                     |
| [execute_job_plan](./zh-hans/execute_job_plan.md)                                   | 启动作业执行方案                         |
| [fast_execute_script](./zh-hans/fast_execute_script.md)                             | 快速执行脚本                             |
| [fast_execute_sql](./zh-hans/fast_execute_sql.md)                                   | 快速执行 SQL                             |
| [fast_transfer_file](./zh-hans/fast_transfer_file.md)                               | 快速分发文件                             |
| [get_account_list](./zh-hans/get_account_list.md)                                   | 查询业务下用户有权限的执行账号列表       |
| [get_cron_list](./zh-hans/get_cron_list.md)                                         | 查询业务下定时作业信息                   |
| [get_cron_detail](./zh-hans/get_cron_detail.md)                                     | 查询定时作业详情                         |
| [get_job_instance_global_var_value](./zh-hans/get_job_instance_global_var_value.md) | 获取作业实例全局变量的值                 |
| [get_job_instance_ip_log](./zh-hans/get_job_instance_ip_log.md)                     | 根据 ip 查询作业执行日志                 |
| [get_job_instance_list](./zh-hans/get_job_instance_list.md)                         | 查询作业实例列表（执行历史)              |
| [get_job_instance_status](./zh-hans/get_job_instance_status.md)                     | 查询作业执行状态                         |
| [get_job_plan_list](./zh-hans/get_job_plan_list.md)                                 | 查询执行方案列表                         |
| [get_job_plan_detail](./zh-hans/get_job_plan_detail.md)                             | 根据作业执行方案 ID 查询作业执行方案详情 |
| [get_job_template_list](./zh-hans/get_job_template_list.md)                         | 查询作业模版列表                         |
| [get_public_script_list](./zh-hans/get_public_script_list.md)                       | 查询公共脚本列表                         |
| [get_public_script_version_list](./zh-hans/get_public_script_version_list.md)       | 查询公共脚本版本列表                     |
| [get_public_script_version_detail](./zh-hans/get_public_script_version_detail.md)   | 查询公共脚本版本详情                     |
| [get_script_list](./zh-hans/get_script_list.md)                                     | 查询脚本列表                             |
| [get_script_version_list](./zh-hans/get_script_version_list.md)                     | 查询业务脚本版本列表                     |
| [get_script_version_detail](./zh-hans/get_script_version_detail.md)                 | 查询业务脚本版本详情                     |
| [operate_job_instance](./zh-hans/operate_job_instance.md)                           | 作业实例操作                             |
| [operate_step_instance](./zh-hans/operate_step_instance.md)                         | 步骤实例操作                             |
| [save_cron](./zh-hans/save_cron.md)                                                 | 新建或保存定时作业                       |
| [update_cron_status](./zh-hans/update_cron_status.md)                               | 更新定时作业状态                         |
