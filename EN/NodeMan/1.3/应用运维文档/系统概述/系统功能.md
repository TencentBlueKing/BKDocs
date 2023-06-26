# 系统功能

## 节点管理后台进程

| **进程名称**                                              | **部署服务器** | **功能**               |
| -------------------------------------------------------- | -------------| ----------------------|
| nodeman_api                                              | 节点管理服务器 | 节点管理后台 API 服务      |
| nodeman_celery:nodeman_celery                            | 节点管理服务器 | 后台 celery 任务            |
| nodeman_celery_beat:nodeman_celery_beat                  | 节点管理服务器 | 定时任务生成模块            |
| nodeman_celery_default:nodeman_celery_default            | 节点管理服务器 | 其他相关任务执行模块 |
| nodeman_pipeline_additional:nodeman_pipeline_additional  | 节点管理服务器 | pipeline 其他任务执行模块            |
| nodeman_pipeline_schedule:nodeman_pipeline_schedule      | 节点管理服务器 | pipeline schedule 任务执行模块         |
| nodeman_pipeline_worker:nodeman_pipeline_worker          | 节点管理服务器 | pipeline 任务执行模块         |

