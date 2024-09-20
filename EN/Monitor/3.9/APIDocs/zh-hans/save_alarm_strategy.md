
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/save_alarm_strategy/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Save alert policy

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| :---------- | ------ | ---- | ---------------- |
| action_list | list | Yes | Action list (Action) |
| bk_biz_id | int | yes | business ID |
| item_list | list | Yes | Monitoring items (Item) |
| name | string | yes | policy name |
| scenario | string | yes | monitoring object |
| is_enabled | string | No | Whether to enable, default enabled |

#### action_list

Action currently only has notification type. When creating a policy, if the ID of the notification group is passed in, the notification group will be used.

| Field | Type | Required | Description |
| ---------------------------------- | ------ | ---- | --------------------- |
| action_type | string | yes | action type (notice) |
| config | dict | yes | action configuration |
| config.alarm_end_time | string | yes | notification time period |
| config.alarm_start_time | string | yes | notification time period |
| config.send_recovery_alarm | bool | yes | whether to send recovery |
| config.alarm_interval | int | yes | notification interval |
| notice_template | dict | no | notification configuration |
| notice_template.anomaly_template | string | no | exception notification template |
| notice_template.recovery_template | string | no | recovery notification template |
| notice_group_list | list | yes | notification group list (NoticeGroup) |

#### action_list.notice_group_list

Can use existing notification group

1. If the id exists, use the notification group corresponding to the id, and the incoming notification group configuration will update the notification group.
2. If there is no id, create a new notification group based on the incoming fields.

| Field | Type | Required | Description |
| --------------- | ------ | ---- | ---------------------------------------------------- |
| notice_receiver | list | no | recipient |
| name | string | no | notification group name |
| notice_way | dict | No | Notification method, alarm level is key, value is a list composed of notification methods |
| message | string | no | remarks |
| id | int | no | notification group ID |

#### item_list

| Field | Type | Required | Description |
| ----------------------- | ------ | ---- | ---------------------------- |
| rt_query_config | dict | Yes | Indicator query configuration (RtQueryConfig) |
| metric_id | string | yes | metric |
| name | string | yes | monitoring item name |
| data_source_label | string | yes | data source |
| algorithm_list | list | Yes | Algorithm configuration list (Algorithm) |
| no_data_config | dict | yes | no data configuration |
| no_data_config.is_enabled | bool | Yes | Whether to enable no data alarm |
| no_data_config.continous | int | no | No data alarm detection cycle number |
| data_type_label | string | yes | data type |
| target | list | yes | monitoring target |

#### item_list.rt_query_config

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric name |
| unit_conversion | int | yes | unit conversion |
| unit | string | yes | unit |
| extend_fields | string | no | other fields |
| agg_condition | list | yes | query conditions |
| agg_interval | int | yes | aggregation period |
| agg_dimension | list | yes | query dimension |
| agg_method | string | yes | aggregation method |
| result_table_id | string | yes | result table ID |

#### item_list.algorithm_list

| Field | Type | Required | Description |
| ---------------------------- | ------ | ---- | -------------- |
| algorithm_config | list | Yes | Algorithm configuration list |
| level | int | yes | alarm level |
| trigger_config | dict | yes | trigger condition |
| trigger_config.count | int | yes | trigger threshold |
| trigger_config.check_window | int | yes | Number of trigger detection windows |
| algorithm_type | string | yes | algorithm type |
| recovery_config | dict | yes | recovery configuration |
| recovery_config.check_window | int | yes | number of recovery cycles |
| message_template | string | no | |

#### item_list.target Field description

| Field | Type | Required | Description |
| ------ | ------ | ---- | --------------- |
| field | string | yes | monitoring target type |
| value | dict | yes | monitoring target data item |
| method | string | yes | monitoring target method |

field - combined based on target node type and target object type
host_target_ip
host_ip
host_topo
service_topo
service_service_template
service_set_template
host_service_template
host_set_template

#### item_list.target.value field description

| Field | Type | Required | Description |
| ----------- | ------ | ---- | -------- |
| ip | string | yes | target ip |
| bk_cloud_id | string | yes | cloud region id |

#### Algorithm configuration

##### Static threshold

Static thresholds can be configured multiple times at a time, so it is a list structure.

```json
[
   {
     "method": "gt", // gt,gte,lt,lte,eq,neq
     "threshold": 1
   }
]
```

##### Simple chain comparison

```json
{
   "floor": 1,
   "ceil": 1
}
```

##### Simple year-on-year comparison

```json
{
   "floor": 1,
   "ceil": 1
}
```

##### Advanced Ring Comparison

```json
{
   "floor": 1,
   "ceil": 1,
   "floor_interval": 1,
   "ceil_interval": 1
}
```

##### Advanced year-on-year

```json
{
   "floor": 1,
   "ceil": 1,
   "floor_interval": 1,
   "ceil_interval": 1
}
```

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_id":2,
     "item_list":[
         {
             "rt_query_config":{
                 "metric_field":"idle",
                 "agg_dimension":["ip", "bk_cloud_id"],
                 "unit_conversion":1.0,
                 "extend_fields":"",
                 "agg_method":"AVG",
                 "agg_condition":[],
                 "agg_interval":60,
                 "result_table_id":"system.cpu_detail",
                 "unit":"%"
             },
             "metric_id":"bk_monitor.system.cpu_detail.idle",
             "name":"\u7a7a\u95f2\u7387",
             "data_source_label":"bk_monitor",
             "algorithm_list":[
                 {
                     "algorithm_config":[[
                         {
                             "threshold":0.1,
                             "method":"gte"
                         }
                     ]],
                     "level":1,
                     "trigger_config":{
                         "count":1,
                         "check_window":5
                     },
                     "algorithm_type":"Threshold",
                     "recovery_config":{
                         "check_window":5
                     },
                     "message_template":""
                 }
             ],
             "no_data_config":{
                 "is_enabled":false,
                 "continuous":5
             },
             "data_type_label":"time_series",
             "name":"\u7a7a\u95f2\u7387",
             "target":[
                 [
                     {
                         "field":"bk_target_ip",
                         "method":"eq",
                         "value":[
                             {
                                 "ip":"10.0.0.1",
                                 "bk_cloud_id":0
                             }
                         ]
                     }
                 ]
             ]
         }
     ],
     "scenario":"os",
     "action_list":[
         {
             "notice_template":{
                 "anomaly_template":"aa",
                 "recovery_template":""
             },
             "notice_group_list":[
                 {
                     "notice_receiver":[
                         "user#test"
                     ],
                     "name":"test",
                     "notice_way":{
                         "1":["weixin"],
                         "3":["weixin"],
                         "2":["weixin"]
                     },
                     "message":"",
                     "notice_group_name":"test",
                     "id":1
                 }
             ],
             "action_type":"notice",
             "config":{
                 "alarm_end_time":"23:59:59",
                 "send_recovery_alarm":false,
                 "alarm_start_time":"00:00:00",
                 "alarm_interval":120
             }
         }
     ],
     "name":"test"
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |

#### data field description

| Field | Type | Required | Description |
| ----------- | ---- | ---- | ------ |
| strategy_id | int | yes | strategy ID |

#### Sample data

```json
{
     "result": true,
     "code": 200,
     "data": {
         "strategy_id": 1
     },
     "message": ""
}
```