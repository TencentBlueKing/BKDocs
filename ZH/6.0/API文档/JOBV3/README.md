## 作业平台 V3 API 简介

**作业平台（Job）是一套基于蓝鲸智云管控平台 Agent 管道之上的基础操作平台，具备大并发处理能力；除了支持脚本执行、文件拉取/分发、定时任务等一系列可实现的基础运维场景以外，还运用流程化的理念很好的将零碎的单个任务组装成一个作业流程；而每个任务都可做为一个原子节点，提供给其它系统和平台调度，实现调度自动化。**


| 资源名称                                                                    | 资源描述                                 |
| --------------------------------------------------------------------------- | ---------------------------------------- |
| [common](./common.md)                                                       | 通用字段和约定                           |
| [fast_execute_script](./fast_execute_script.md)                             | 快速执行脚本                             |
| [fast_execute_sql](./fast_execute_sql.md)                                   | 快速执行 SQL                             |
| [get_cron_list](./get_cron_list.md)                                         | 查询业务下定时作业信息                   |
| [get_job_instance_status](./get_job_instance_status.md)                     | 查询作业执行状态                         |
| [get_public_script_list](./get_public_script_list.md)                       | 查询公共脚本列表                         |
| [get_script_list](./get_script_list.md)                                     | 查询脚本列表                             |
| [operate_job_instance](./operate_job_instance.md)                           | 作业实例操作                             |
| [operate_step_instance](./operate_step_instance.md)                         | 步骤实例操作                             |
| [push_config_file](./push_config_file.md)                                   | 分发配置文件                             |
| [save_cron](./save_cron.md)                                                 | 新建或保存定时作业                       |
| [update_cron_status](./update_cron_status.md)                               | 更新定时作业状态                         |
| [batch_get_job_instance_ip_log](./batch_get_job_instance_ip_log.md)         | 根据 ip 列表批量查询作业执行日志         |
| [create_credential](./create_credential.md)                                 | 新建凭据                                 |
| [execute_job_plan](./execute_job_plan.md)                                   | 启动作业执行方案                         |
| [fast_transfer_file](./fast_transfer_file.md)                               | 快速分发文件                             |
| [generate_local_file_upload_url](./generate_local_file_upload_url.md)       | 生成本地文件上传 URL                     |
| [get_account_list](./get_account_list.md)                                   | 查询业务下用户有权限的执行账号列表       |
| [get_job_instance_ip_log](./get_job_instance_ip_log.md)                     | 根据 ip 查询作业执行日志                 |
| [get_job_template_list](./get_job_template_list.md)                         | 查询作业模版列表                         |
| [get_job_plan_list](./get_job_plan_list.md)                                 | 查询执行方案列表                         |
| [get_job_plan_detail](./get_job_plan_detail.md)                             | 根据作业执行方案 ID 查询作业执行方案详情 |
| [get_job_instance_list](./get_job_instance_list.md)                         | 查询作业实例列表（执行历史)              |
| [get_job_instance_global_var_value](./get_job_instance_global_var_value.md) | 获取作业实例全局变量的值                 |
| [get_cron_detail](./get_cron_detail.md)                                     | 查询定时作业详情                         |
| [create_file_source](./create_file_source.md)                               | 新建文件源                               |
| [callback_protocol](./callback_protocol.md)                                 | 回调                                     |
| [get_proc_result](./get_proc_result.md)                                     | 操作服务器上的进程结果查询               |
| [get_public_script_version_detail](./get_public_script_version_detail.md)   | 查询公共脚本版本详情                     |
| [get_public_script_version_list](./get_public_script_version_list.md)       | 查询公共脚本版本列表                     |
| [get_script_version_detail](./get_script_version_detail.md)                 | 查询业务脚本版本详情                     |
| [get_script_version_list](./get_script_version_list.md)                     | 查询业务脚本版本列表                     |
| [manage_proc](./manage_proc.md)                                             | 对服务器上的进程进行注册托管/取消托管    |
| [operate_proc](./operate_proc.md)                                           | 操作服务器上的进程                       |
| [operate_process](./operate_process.md)                                     | 操作服务器上的进程-v2 版本               |
| [set_base_report](./set_base_report.md)                                     | 开启/关闭 Agent 基础数据采集上报功能     |
| [update_credential](./update_credential.md)                                 | 更新凭据                                 |
| [update_file_source](./update_file_source.md)                               | 更新文件源                               |