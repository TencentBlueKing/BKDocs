# Package built-in variables

## Variable list

* CMDB variable: CMDB information of the target host or service instance that triggers the alarm of this package
*Alarm variable: trigger the alarm information of this package
* Policy variables: Alarm policy information that triggers this package
*Package variables: information related to the execution of this action
* Content variables: Available only in notification packages, variables will present different styles according to different notification methods.

## Variable format description

Jinja2 is a modern, designer-friendly Python templating language modeled after Django templates.

`{{target.host.bk_host_innerip}}`

## CMDB variables


Variable name|meaning|example
  --- | --- | ----
target.business.bk_biz_id | business ID | 2
target.business.bk_biz_name | Business name | BlueKing
target.business.bk_biz_developer_string | developer string | admin,user1,user2
target.business.bk_biz_maintainer_string | Operation and maintenance personnel string | admin,user1
target.business.bk_biz_tester_string | tester string | admin,user1
target.business.bk_biz_productor_string | product personnel string | admin,user1
target.business.operator_string | operator string | admin,user1
target.host.module_string | module name | module1, module2
target.host.set_string | cluster name | set1,set2
target.host.bk_host_id | Host ID | 1
target.host.bk_cloud_id | Cloud region ID | 0
target.host.bk_cloud_name | Cloud zone name | Default zone
target.host.bk_host_innerip | Intranet IP | 10.0.0.1
target.host.bk_host_outerip | External IP | 10.0.0.1
target.host.bk_host_name | host name |
target.host.bk_os_name | operating system name | linux
target.host.bk_os_type | Operating system type (enumeration value) | 1
target.host.operator_string | person in charge | admin,user1
target.host.bk_bak_operator_string | Backup person in charge | admin,user1
target.host.bk_comment | Remarks | comment
target.hosts.bk_host_name | host name | VM_1,VM_2
target.hosts.bk_host_innerip | Intranet IP | 10.0.0.1,10.0.0.1
target.service_instance.service_instance_id | service instance ID | 1
target.service_instance.name | service instance name | xxx_10.0.0.1
target.service_instances.service_instance_id | Service instance ID | 1,2
target.service_instances.name | Service instance name | xxx_10.0.0.1,xxx_127.0.1.12
target.processes[0].port | The port of the i-th process | 80
target.process["process_name"].bk_process_id | process ID | 1
target.process["process_name"].bk_process_name | process name | process 1
target.process["process_name"].bk_func_name | Process function name | java
target.process["process_name"].bind_ip | Bind IP | 10.0.0.1
target.process["process_name"].port | Binding port | 1,2,3-5,7-10

## Alarm variables

Alarm information that triggers this package


Variable name|meaning|example
  --- | --- | ----
alarm.name | Alarm name | Total CPU usage alarm
alarm.dimensions["dimension_name"].display_name | dimension name | target IP
alarm.dimensions["dimension_name"].display_value | dimension value | 10.0.0.1
alarm.level | Alarm level | 1
alarm.level_name | Alarm level name | Fatal
alarm.duration | Alarm duration (seconds) | 130
alarm.duration_string | Alarm duration string | 2m 10s
alarm.target_string | Alarm target | 10.0.0.1,10.0.0.1
alarm.dimension_string | Alarm dimension (except target) | Disk=C, hostname=xxx
alarm.collect_count | Number of aggregated events | 10
alarm.notice_from | Source | BlueKing Monitoring
alarm.company | Corporate Identity | BlueKing
alarm.data_source_name | Data source name | Data platform
alarm.data_source | data source | BKMONITOR
alarm.detail_url | Detail link | http://paas.blueking.com/o/bk_monitorv3/?bizId=1&actionId=2#event-center
alarm.current_value | current value | 1.1
alarm.target_type | target type | host, service, topo
alarm.target_type_name | target type name | host, service instance, node
alarm.callback_message | callback data | see example below

```
{
   "bk_biz_id": 2, // Business ID
   "bk_biz_name": "BlueKing", // Business name
   "latest_anomaly_record":{ // Latest anomaly point information
     "origin_alarm":{
       "anomaly":{ //Exception information
         "1":{ // Alarm level
           "anomaly_message":"avg(usage) >= 0.0, current value 46.17", // exception message
           "anomaly_time":"2020-03-03 04:10:02", // Exception event
           "anomaly_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540.999.999.1" // Abnormal data ID
         }
       },
       "data":{ // data information
         "record_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540", // Data ID
         "values":{ // data values
           "usage":46.17,
           "time":1583208540
         },
         "dimensions":{ // Data dimensions
           "bk_topo_node":[
             "module|6"
           ],
           "bk_target_ip":"10.0.0.1",
           "bk_target_cloud_id":"0"
         },
         "value":46.17, // indicator value
         "time":1583208540 // time
       }
     },
     "create_time":"2020-03-03 04:10:02", // Generate event
     "source_time":"2020-03-03 04:09:00", // data event
     "anomaly_id":6211913 // exception ID
   },
   "type":"ANOMALY_NOTICE", //Notification type ANOMALY_NOTICE exception notification, RECOVERY_NOTICE recovery notification
   "event":{ // event information
     "create_time":"2020-03-03 03:09:54", // Creation time
     "end_time":"2020-03-03 04:19:00", // end time
     "begin_time":"2020-03-03 03:08:00", // start time
     "event_id":"48af047a4251b9f49b7cdbc66579c23a.1583204880.999.999.1",
     "level":1, // Alarm level
     "level_name": "fatal", // level name
     "id":8817 //Event ID
   },
   "strategy":{
         "item_list":[
             {
                 "metric_field_name":"usage rate", // metric name
                 "metric_field":"usage" // metric
             }
         ],
         "id":144, // Strategy ID
         "name":"Test Strategy" // Strategy name
     }
}
```

## Strategy variables


Alarm policy information that triggers this package

Variable name|meaning|example
  --- | --- | ----
strategy.strategy_id | strategy ID | 1
strategy.name | Strategy name | Total CPU usage
strategy.scenario | scenario | os
strategy.source_type | data source | BKMONITOR
strategy.bk_biz_id | Business ID | 2
strategy.item.result_table_id | result table name | system.cpu_detail
strategy.item.name | indicator name | idle rate
strategy.item.metric_field | indicator field | idle
strategy.item.unit | unit | %
strategy.item.agg_interval | period | 60
strategy.item.agg_method | Aggregation method | AVG


## Package variables

Information related to the execution of this action

Variable name|meaning|example
  --- | --- | ----
action_instance.name | Package name | Machine restart
action_instance.plugin_type_name | Package type | Operation platform
action_instance.assignees | person in charge | admin,tony
action_instance.operate_target_string | execution object | 10.0.0.1
action_instance.bk_biz_id | Business ID | 2
action_instance.start_time | start time | 1970-08-01 10:00:00+08:00
action_instance.duration | Execution time (seconds) | 130
action_instance.duration_string | Execution time-consuming string | 2m 10s
action_instance.status_display | execution status | executing
action_instance.opt_content | Specific content | Job platform task has been created, click to view details http://www.job.com/


## Content variables

Only notification plans are available. Variables will appear in different styles according to different notification methods. The specific rendering effect can be viewed through the Package Configuration - Template Preview function.

Variable name|meaning|example
  --- | --- | ----
content.level | Alarm level |
content.time | Recent abnormal time |
content.duration | Alarm duration |
content.target_type | Alarm target type |
content.data_source | Alarm data source |
content.content | Alarm content |
content.biz | Alarm business |
content.target | Alarm target |
content.dimension | Alarm dimension |
content.detail | Alarm details |
content.related_info | Related information |
content.begin_time | First exception time |