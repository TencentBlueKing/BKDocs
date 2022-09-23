# 套餐内置变量

## 变量列表

* CMDB变量： 触发该套餐的告警目标主机或服务实例的CMDB信息
* 告警变量： 触发该套餐的告警信息
* 策略变量： 触发该套餐的告警策略信息
* 套餐变量：与本次动作执行相关的信息
* 内容变量： 仅通知套餐可用，变量会根据不同的通知方式会呈现不同的样式。

## 变量格式说明

Jinja2 是一个现代的，设计者友好的，仿照 Django 模板的 Python 模板语言。

`{{target.host.bk_host_innerip}}`

## CMDB 变量


变量名|含义|示例
 --- | --- | ---- 
target.business.bk_biz_id | 业务ID | 2
target.business.bk_biz_name | 业务名称 | 蓝鲸
target.business.bk_biz_developer_string | 开发人员字符串 | admin,user1,user2
target.business.bk_biz_maintainer_string | 运维人员字符串 | admin,user1
target.business.bk_biz_tester_string | 测试人员字符串 | admin,user1
target.business.bk_biz_productor_string | 产品人员字符串 | admin,user1
target.business.operator_string | 操作人员字符串 | admin,user1
target.host.module_string | 模块名 | module1,module2
target.host.set_string | 集群名 | set1,set2
target.host.bk_host_id | 主机ID | 1
target.host.bk_cloud_id | 云区域ID | 0
target.host.bk_cloud_name | 云区域名称 | 默认区域
target.host.bk_host_innerip | 内网IP | 127.0.0.1
target.host.bk_host_outerip | 外网IP | 127.0.1.11
target.host.bk_host_name | 主机名 |
target.host.bk_os_name | 操作系统名称 | linux
target.host.bk_os_type | 操作系统类型(枚举数值) | 1
target.host.operator_string | 负责人 | admin,user1
target.host.bk_bak_operator_string | 备份负责人 | admin,user1
target.host.bk_comment | 备注信息 | comment
target.hosts.bk_host_name | 主机名 | VM_1,VM_2
target.hosts.bk_host_innerip | 内网IP | 127.0.0.1,127.0.0.2
target.service_instance.service_instance_id | 服务实例ID | 1
target.service_instance.name | 服务实例名 | xxx_127.0.1.11
target.service_instances.service_instance_id | 服务实例ID | 1,2
target.service_instances.name | 服务实例名 | xxx_127.0.1.11,xxx_127.0.1.12
target.processes[0].port | 第i个进程的端口 | 80
target.process["process_name"].bk_process_id | 进程ID | 1
target.process["process_name"].bk_process_name | 进程名称 | 进程1
target.process["process_name"].bk_func_name | 进程功能名称 | java
target.process["process_name"].bind_ip | 绑定IP | 127.0.1.10
target.process["process_name"].port | 绑定端口 | 1,2,3-5,7-10


## 告警变量

触发该套餐的告警信息


变量名|含义|示例
 --- | --- | ---- 
alarm.name | 告警名称 | CPU总使用率告警
alarm.dimensions["dimension_name"].display_name | 维度名 | 目标IP
alarm.dimensions["dimension_name"].display_value | 维度值 | 127.0.0.1
alarm.level | 告警级别 | 1
alarm.level_name | 告警级别名称 | 致命
alarm.duration | 告警持续时间（秒） | 130
alarm.duration_string | 告警持续时间字符串 | 2m 10s
alarm.target_string | 告警目标 | 127.0.1.10,127.0.1.11
alarm.dimension_string | 告警维度(除目标) | 磁盘=C,主机名=xxx
alarm.collect_count | 汇总事件数量 | 10
alarm.notice_from | 消息来源 | 蓝鲸监控
alarm.company | 企业标识 | 蓝鲸
alarm.data_source_name | 数据来源名称 | 数据平台
alarm.data_source | 数据来源 | BKMONITOR
alarm.detail_url | 详情链接 | http://paas.blueking.com/o/bk_monitorv3/?bizId=1&actionId=2#event-center
alarm.current_value | 当前值 | 1.1
alarm.target_type | 目标类型 | host, service, topo
alarm.target_type_name | 目标类型名称 | 主机, 服务实例, 节点
alarm.callback_message | 回调数据 | 见下示例

```
{
  "bk_biz_id": 2, // 业务ID
  "bk_biz_name": "蓝鲸", // 业务名称
  "latest_anomaly_record":{ // 最新异常点信息
    "origin_alarm":{
      "anomaly":{ // 异常信息
        "1":{ // 告警级别
          "anomaly_message":"avg(使用率) >= 0.0, 当前值46.17", // 异常消息
          "anomaly_time":"2020-03-03 04:10:02", // 异常产生事件
          "anomaly_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540.999.999.1" // 异常数据ID
        }
      },
      "data":{ // 数据信息
        "record_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540", // 数据ID
        "values":{    // 数据值
          "usage":46.17,
          "time":1583208540
        },
        "dimensions":{ // 数据维度
          "bk_topo_node":[
            "module|6"
          ],
          "bk_target_ip":"10.0.1.10",
          "bk_target_cloud_id":"0"
        },
        "value":46.17,    // 指标值
        "time":1583208540 // 时间
      }
    },
    "create_time":"2020-03-03 04:10:02", // 产生事件
    "source_time":"2020-03-03 04:09:00", // 数据事件
    "anomaly_id":6211913 // 异常ID
  },
  "type":"ANOMALY_NOTICE", // 通知类型 ANOMALY_NOTICE异常通知，RECOVERY_NOTICE恢复通知
  "event":{ // 事件信息
    "create_time":"2020-03-03 03:09:54", // 产生时间
    "end_time":"2020-03-03 04:19:00", // 结束时间
    "begin_time":"2020-03-03 03:08:00", // 开始时间
    "event_id":"48af047a4251b9f49b7cdbc66579c23a.1583204880.999.999.1",
    "level":1, // 告警级别
    "level_name": "致命", // 级别名称
    "id":8817 // 事件ID
  },
  "strategy":{
        "item_list":[
            {
                "metric_field_name":"使用率", // 指标名称
                "metric_field":"usage" // 指标
            }
        ],
        "id":144, // 策略ID
        "name":"测试策略" // 策略名称
    }
}
```

## 策略变量


触发该套餐的告警策略信息

变量名|含义|示例
 --- | --- | ---- 
strategy.strategy_id | 策略ID | 1
strategy.name | 策略名称 | CPU总使用率
strategy.scenario | 场景 | os
strategy.source_type | 数据来源 | BKMONITOR
strategy.bk_biz_id | 业务ID | 2
strategy.item.result_table_id | 结果表名称 | system.cpu_detail
strategy.item.name | 指标名称 | 空闲率
strategy.item.metric_field | 指标字段 | idle
strategy.item.unit | 单位 | %
strategy.item.agg_interval | 周期 | 60
strategy.item.agg_method | 聚合方法 | AVG


## 套餐变量

与本次动作执行相关的信息

变量名|含义|示例
 --- | --- | ---- 
action_instance.name | 套餐名称 | 机器重启
action_instance.plugin_type_name | 套餐类型 | 作业平台
action_instance.assignees | 负责人 | admin,tony
action_instance.operate_target_string | 执行对象 | 127.0.0.1
action_instance.bk_biz_id | 业务ID | 2
action_instance.start_time | 开始时间 | 1970-08-01 10:00:00+08:00
action_instance.duration | 执行耗时(秒) | 130
action_instance.duration_string | 执行耗时字符串 | 2m 10s
action_instance.status_display | 执行状态 | 执行中
action_instance.opt_content | 具体内容 | 已经创建作业平台任务，点击查看详情http://www.job.com/


## 内容变量

仅通知套餐可用。变量会根据不同的通知方式会呈现不同的样式。具体呈现效果可通过 套餐配置 - 模板预览 功能查看

变量名|含义|示例
 --- | --- | ---- 
content.level | 告警级别 |
content.time | 最近异常时间 |
content.duration | 告警持续时间 |
content.target_type | 告警目标类型 |
content.data_source | 告警数据来源 |
content.content | 告警内容 |
content.biz | 告警业务 |
content.target | 告警目标 |
content.dimension | 告警维度 |
content.detail | 告警详情 |
content.related_info | 关联信息 |
content.begin_time | 首次异常时间 |

