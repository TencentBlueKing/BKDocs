
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/save_alarm_strategy_v2/


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
| :--------- | ------- | ---- | -------------------- |
| actions | list | Yes | Action list (Action) |
| bk_biz_id | int | yes | business ID |
| detects | list | Yes | Detection configuration list (Detect) |
| id | int | no | policy ID |
| items | list | Yes | Monitoring item list (Item) |
| labels | list | yes | policy label list |
| name | string | yes | policy name |
| scenario | string | yes | monitoring object |
| source | string | yes | monitoring source |
| is_enabled | bool | No | Whether to enable, enabled by default |

#### actions

| Field | Type | Required | Description |
| ---------------------------------- | ------ | ---- | ----------------- |
| id | int | yes | action id |
| type | string | yes | action type (notice) |
| config | dict | yes | action configuration |
| config.alarm_end_time | string | yes | notification time period |
| config.alarm_start_time | string | yes | notification time period |
| config.send_recovery_alarm | bool | yes | whether to send recovery |
| config.alarm_interval | int | yes | notification interval |
| notice_template | dict | no | notification configuration |
| notice_template.anomaly_template | string | no | exception notification template |
| notice_template.recovery_template | string | no | recovery notification template |
| notice_group_ids | list | yes | list of notification group IDs |

#### detects

| Field | Type | Required | Description |
| ---------------------------- | ------ | ---- | ----------------- |
| id | int | yes | detect id |
| level | int | yes | alarm level |
| expression | string | yes | calculation formula |
| trigger_config | dict | yes | trigger condition configuration |
| trigger_config.count | int | yes | number of triggers |
| trigger_config.check_window | int | yes | trigger period |
| recovery_config | dict | yes | recovery condition configuration |
| recovery_config.check_window | int | yes | recovery period |
| connector | string | yes | same-level algorithm connector |

#### items

| Field | Type | Required | Description |
| ---------------------------- | ------ | ---- | --------------------------- |
| query_configs | list | Yes | Indicator query configuration (QueryConfig) |
| id | string | Yes | Monitoring item configuration id |
| name | string | yes | monitoring item name |
| expression | string | yes | calculation formula |
| origin_sql | string | yes | origin sql |
| algorithms | list | Yes | Algorithm configuration list (Algorithm) |
| no_data_config | dict | yes | no data configuration |
| no_data_config.is_enabled | bool | Yes | Whether to enable no data alarm |
| no_data_config.continuous | int | No | Number of no-data alarm detection cycles |
| target | list | yes | monitoring target |

####iterms.target

| Field | Type | Required | Description |
| ---------------------------- | ------ | ---- | ------------------------ |
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

#### items.target.value

| Field | Type | Required | Description |
| ----------- | ------ | ---- | -------- |
| ip | string | yes | target ip |
| bk_cloud_id | string | yes | cloud region id |

```json
{
   "target": [
     [
       {
         "field": "host_topo_node",
         "method": "eq",
         "value": [
           {
             "bk_inst_id": 7,
             "bk_obj_id": "biz"
           }
         ]
       }
     ]
   ]
}
```

#### queryconfigs

| Field | Type | Required | Description |
| ------------------ | ------ | ---- | ---------- |
| alias | string | yes | alias |
| data_source_label | string | yes | data source label |
| data_type_label | string | yes | data type label |

##### BkMonitorTimeSeries type

```json
{
   "data_source_label": "bk_monitor",
   "data_type_label": "time_series"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric |
| unit | string | yes | unit |
| agg_condition | list | yes | query conditions |
| agg_dimension | list | yes | aggregation dimension |
| agg_method | string | yes | aggregation method |
| agg_interval | int | yes | aggregation period |
| result_table_id | string | yes | result table ID |

##### BkMonitorLog type

```json
{
   "data_source_label": "bk_monitor",
   "data_type_label": "log"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| agg_method | string | yes | aggregation method |
| agg_condition | list | yes | query conditions |
| result_table_id | string | yes | result table |
| agg_interval | int | yes | aggregation period |

##### BkMonitorEvent type

```json
{
   "data_source_label": "bk_monitor",
   "data_type_label": "event"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric |
| agg_condition | list | yes | query conditions |
| result_table_id | string | yes | result table |

##### BkLogSearchTimeSeries type

```json
{
   "data_source_label": "bk_log_search",
   "data_type_label": "time_series"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric |
| index_set_id | int | yes | index set ID |
| agg_condition | list | yes | query conditions |
| agg_dimension | list | yes | aggregation dimension |
| agg_method | string | yes | aggregation method |
| result_table_id | string | yes | index |
| agg_interval | int | yes | aggregation period |
| time_field | string | yes | time field |
| unit | string | yes | unit |

##### BkLogSearchLog type

```json
{
   "data_source_label": "bk_log_search",
   "data_type_label": "log"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| index_set_id | int | yes | index set ID |
| agg_condition | list | yes | query conditions |
| query_string | int | yes | query statement |
| agg_dimension | list | yes | aggregation dimension |
| result_table_id | string | yes | index |
| agg_interval | int | yes | aggregation period |
| time_field | string | yes | time field |

##### CustomEvent Type

```json
{
   "data_source_label": "custom",
   "data_type_label": "event"
}
```

| Field | Type | Required | Description |
| ------------------ | ------ | ---- | --------------- |
| custom_event_name | string | Yes | Custom event name |
| agg_condition | list | yes | query conditions |
| agg_interval | int | yes | aggregation period |
| agg_dimension | list | yes | query dimension |
| agg_method | string | yes | aggregation method |
| result_table_id | string | yes | result table ID |

##### CustomTimeSeries type

```json
{
   "data_source_label": "custom",
   "data_type_label": "time_series"
}
```
  | Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric |
| unit | string | yes | unit |
| agg_condition | list | yes | query conditions |
| agg_dimension | list | yes | aggregation dimension |
| agg_method | string | yes | aggregation method |
| agg_interval | int | yes | aggregation period |
| result_table_id | string | yes | result table ID |

##### BkDataTimeSeries type

```json
{
   "data_source_label": "bk_data",
   "data_type_label": "time_series"
}
```

| Field | Type | Required | Description |
| --------------- | ------ | ---- | -------- |
| metric_field | string | yes | metric |
| unit | string | yes | unit |
| agg_condition | list | yes | query conditions |
| agg_dimension | list | yes | aggregation dimension |
| agg_method | string | yes | aggregation method |
| agg_interval | int | yes | aggregation period |
| result_table_id | string | yes | result table |
| time_field | string | yes | time field |

#### algorithms

| Field | Type | Required | Description |
| ----------- | ------ | ---- | ------------ |
| config | list | Yes | Algorithm configuration list |
| level | int | yes | alarm level |
| type | string | yes | algorithm type |
| unit_prefix | string | No | Algorithm unit prefix |

#### Algorithm configuration config

##### Static threshold Threshold

```json
[
   {
     "method": "gt", // gt,gte,lt,lte,eq,neq
     "threshold": "1"
   }
]
```

##### Simple ring ratio SimpleRingRatio

```json
{
   "floor": "1",
   "ceil": "1"
}
```

##### Simple year-on-year SimpleYearRound

```json
{
   "floor": "1",
   "ceil": "1"
}
```

##### AdvancedRingRatio

```json
{
   "floor": "1",
   "ceil": "1",
   "floor_interval": 1,
   "ceil_interval": 1
}
```

##### AdvancedYearRound

The configuration format is consistent with the advanced ring detection algorithm configuration format.

##### Intelligent anomaly detection IntelligentDetect

```json
{
   "sensitivity_value": 1 // 0-100
   "anomaly_detect_direct": "ceil" // "ceil", "floor", "all"(default)
}
```

##### Year-on-year amplitude YearRoundAmplitude

```json
{
   "ratio": 1,
   "shock": 1,
   "days": 1,
   "method": "gte" // gt,gte,lt,lte,eq,neq
}
```

##### Year-on-year range YearRoundRange

Consistent with year-on-year amplitude configuration format

##### RingRatioAmplitude
```json
{
  "ratio": 1,
  "shock": 1,
  "days": 1,
  "threshold": 1
}
```

#### Sample data

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_biz_id": 7,
    "scenario": "os",
    "name": "进程端口",
    "labels": [],
    "is_enabled": true,
    "items": [
        {
            "name": "AVG(CPU使用率)",
            "no_data_config": {
                "continuous": 10,
                "is_enabled": false,
                "agg_dimension": [
                    "bk_target_ip",
                    "bk_target_cloud_id"
                ],
                "level": 2
            },
            "target": [],
            "expression": "a",
            "origin_sql": "",
            "query_configs": [
                {
                    "data_source_label": "bk_monitor",
                    "data_type_label": "time_series",
                    "alias": "a",
                    "result_table_id": "system.cpu_summary",
                    "agg_method": "AVG",
                    "agg_interval": 60,
                    "agg_dimension": [
                        "bk_target_ip",
                        "bk_target_cloud_id"
                    ],
                    "agg_condition": [],
                    "metric_field": "usage",
                    "unit": "percent",
                    "metric_id": "bk_monitor.system.cpu_summary.usage",
                    "index_set_id": "",
                    "query_string": "*",
                    "custom_event_name": "usage",
                    "functions": [],
                    "time_field": "time",
                    "bkmonitor_strategy_id": "usage",
                    "alert_name": "usage"
                }
            ],
            "algorithms": [
                {
                    "level": 1,
                    "type": "Threshold",
                    "config": [
                        [
                            {
                                "method": "gte",
                                "threshold": "80"
                            }
                        ]
                    ],
                    "unit_prefix": "%"
                }
            ]
        }
    ],
    "detects": [
        {
            "level": 1,
            "expression": "",
            "trigger_config": {
                "count": 1,
                "check_window": 5
            },
            "recovery_config": {
                "check_window": 5
            },
            "connector": "and"
        }
    ],
    "actions": [
        {
            "type": "notice",
            "config": {
                "alarm_start_time": "00:00:00",
                "alarm_end_time": "23:59:59",
                "alarm_interval": 1440,
                "send_recovery_alarm": false
            },
            "notice_group_ids": [
                11
            ],
            "notice_template": {
                "anomaly_template": "{{content.level}}\n{{content.begin_time}}\n{{content.time}}\n{{content.duration}}\n{{content.target_type}}\n{{content.data_source}}\n{{content.content}}\n{{content.current_value}}\n{{content.biz}}\n{{content.target}}\n{{content.dimension}}\n{{content.detail}}\n{{content.related_info}}",
                "recovery_template": ""
            }
        }
    ]
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |

#### Sample data

```json
{
  "result": true,
  "code": 200,
  "message": "OK",
  "data": {data返回保存的策略结构，与请求参数一致（示例数据中省略）}
}
```