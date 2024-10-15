
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/search_alarm_strategy_v2/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query the alarm policy list

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | ---- | ---------- |
| page | int | yes | page number |
| page_size | int | Yes | Number of items per page |
| conditions| list | yes | query conditions |
| bk_biz_id | int | yes | business ID |
| scenario | string | no | monitoring scenario |
| with_notice_group | bool | yes | whether to supplement notification group information |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "page": 1,
     "page_size": 10,
     "conditions": [
         {
             "key": "strategy_id",
             "value": [
                 "36"
             ]
         }
     ],
     "bk_biz_id": 7,
     "with_notice_group": false
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

| Field | Type | Description |
| :---------- | ------ | ---------------- |
| data_source_list | list | Data source list (DataSource) |
| notice_group_list | list | Notice group list (NoticeGroup) |
| scenario_list | list | Monitoring object list (Scenario) |
| strategy_config_list | list | Strategy configuration list (StrategyConfig)|
| strategy_label_list | list | Strategy label list (StrategyLabel) |

#### data.data_source_list

| Field | Type | Description |
| ---------------------------------- | ------ | ----------------------- |
| type | string | data type |
| name | string | data name |
| data_type_label | string | data type label |
| data_source_label| string | data source label |
| count | int | Count the number of strategies by data source |

#### data.notice_group_list

| Field | Type | Description |
| --------------- | ------ | ------------- |
| notice_group_id | int | notification group ID |
| notice_group_name| string | Notification group name |
| count | int | Number of policies by notification group |

#### data.scenario_list

| Field | Type | Description |
| -------------------------- | ------ | -------------------------- |
| id | int | Monitoring object ID |
| display_name | string | Monitoring object name |
| count | int | Number of strategies by monitoring object |

#### data.strategy_config_list

| Field | Type | Required | Description |
| :---------------------- | ------ | ---- | ---------- |
| actions | list | yes | action list |
| source | string | yes | policy source |
| detects | list | yes | detection configuration list |
| id | int | yes | policy ID |
| items | list | yes | monitoring item list |
| labels | list | yes | policy label list |
| name | string | yes | policy name |
| scenario | string | yes | monitoring object |
| is_enabled | bool | no | whether to enable |
| update_time | string | no | policy creation time |
| create_time | string | No | Create policy time |
| update_user | string | no | Create strategist |
| create_user | string | no | Create strategist |
| alert_count | int | no | number of alerts |
| type | string | no | policy type |
| target_object_type | string | no | target object type |
| shield_info | dict | no | shield configuration information |
| shield_info.is_shielded | bool | no | whether to shield |
| add_allowed | bool | no | allowed to add |
| data_source_type | string | no | data source type |
| bk_biz_id | int | yes | business ID |

#### data.strategy_config_list.actions

| Field | Type | Description |
| ---------------------------------- | ------ | ----------------------- |
| action_type | string | action type (notice) |
| config | dict | action configuration |
| config.alarm_end_time | string | notification time period |
| config.alarm_start_time | string | notification time period |
| config.send_recovery_alarm | bool | Whether to send recovery |
| config.alarm_interval | int | notification interval |
| notice_template | dict | notification configuration |
| notice_template.anomaly_template | string | exception notification template |
| notice_template.recovery_template | string | Recovery notification template |
| notice_group_list | list | Notice group list (NoticeGroup) |

#### data.strategy_config_list.actions.notice_group_list
| Field | Type | Description |
| --------------- | ------ | ------------------------------------------------------ |
| notice_receiver | list | recipients |
| name | string | notification group name |
| notice_way | dict | Notification method, alarm level is key, value is a list composed of notification methods |
| message | string | remarks |
| id | int | notification group ID |

#### data.strategy_config_list.detects

| Field | Type | Description |
| ---------------------------- | ------ | ---------------- |
| id | int | detection id |
| level | int | Alarm level |
| expression | string | calculation formula |
| trigger_config | dict | trigger condition configuration |
| trigger_config.count | int | Number of triggers |
| trigger_config.check_window | int | trigger period |
| recovery_config | dict | recovery condition configuration |
| recovery_config.check_window | int | recovery cycle |
| connector | string | Same level algorithm connector |

#### data.strategy_config_list.items

| Field | Type | Description |
| -------------------------- | ------ | -------------------------- |
| rt_query_config | dict | Indicator query configuration (RtQueryConfig) |
| metric_id | string | metric |
| name | string | Monitoring item name |
| data_source_label | string | data source |
| algorithm_list | list | Algorithm configuration list (Algorithm) |
| no_data_config | dict | No data configuration |
| no_data_config.is_enabled | bool | Whether to enable no data alarm |
| no_data_config.continous | int | No data alarm detection cycle number |
| data_type_label | string | data type |

#### data.strategy_config_list.item_list.rt_query_config

| Field | Type | Description |
| --------------- | ------ | -------- |
| metric_field | string | metric name |
| unit_conversion | int | unit conversion |
| unit | string | unit |
| extend_fields | string | other fields |
| agg_condition | list | query conditions |
| agg_interval | int | aggregation period |
| agg_dimension | list | query dimension |
| agg_method | string | Aggregation method |
| result_table_id | string | result table ID |

#### data.strategy_config_list.items.algorithm_list

| Field | Type | Description |
| ---------------------------- | ------ | -------------- |
| algorithm_config | list | algorithm configuration list |
| level | int | Alarm level |
| trigger_config | dict | trigger condition |
| trigger_config.count | int | trigger threshold |
| trigger_config.check_window | int | Number of trigger detection windows |
| algorithm_type | string | algorithm type |
| recovery_config | dict | recovery configuration |
| recovery_config.check_window | int | Number of recovery cycles |
| message_template | string | |

#### data.strategy_label_list

| Field | Type | Description |
| --------------- | ------ | -------- |
| label_name | string | Policy label name |
| id | int | policy tag ID |
| count | string | Number of strategies counted by strategy label |

#### Sample data
```json
{
    "result": true,
    "code": 200,
    "message": "OK",
    "data": {
        "scenario_list": [
            {
                "id": "application_check",
                "display_name": "业务应用",
                "count": 0
            }
        ],
        "strategy_config_list": [
            {
                "id": 36,
                "version": "v2",
                "bk_biz_id": 7,
                "name": "进程端口",
                "source": "bk_monitorv3",
                "scenario": "host_process",
                "type": "monitor",
                "items": [
                    {
                        "id": 36,
                        "name": "进程端口",
                        "no_data_config": {
                            "level": 2,
                            "continuous": 5,
                            "is_enabled": false,
                            "agg_dimension": []
                        },
                        "target": [
                            [
                                {
                                    "field": "host_topo_node",
                                    "value": [
                                        {
                                            "bk_obj_id": "biz",
                                            "bk_inst_id": 7
                                        }
                                    ],
                                    "method": "eq"
                                }
                            ]
                        ],
                        "expression": "",
                        "origin_sql": "",
                        "query_configs": [
                            {
                                "data_source_label": "bk_monitor",
                                "data_type_label": "event",
                                "alias": "A",
                                "metric_id": "bk_monitor.proc_port",
                                "id": 36,
                                "functions": [],
                                "result_table_id": "system.event",
                                "metric_field": "proc_port",
                                "agg_condition": [],
                                "name": "进程端口"
                            }
                        ],
                        "algorithms": [
                            {
                                "id": 36,
                                "type": "ProcPort",
                                "level": 2,
                                "config": [],
                                "unit_prefix": ""
                            }
                        ]
                    }
                ],
                "detects": [
                    {
                        "id": 36,
                        "level": 2,
                        "expression": "",
                        "trigger_config": {
                            "count": 1,
                            "check_window": 5
                        },
                        "recovery_config": {
                            "check_window": 5,
                            "status_setter": "recovery"
                        },
                        "connector": "and"
                    }
                ],
                "actions": [
                    {
                        "id": 36,
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
                            "anomaly_template": "",
                            "recovery_template": ""
                        }
                    }
                ],
                "is_enabled": true,
                "update_time": "2021-08-11T15:36:58.508375+08:00",
                "update_user": "admin",
                "create_time": "2021-07-21T13:17:31.539288+08:00",
                "create_user": "admin",
                "labels": [],
                "alert_count": 0,
                "shield_info": {
                    "is_shielded": false
                },
                "target_object_type": "HOST",
                "add_allowed": true,
                "data_source_type": "系统事件"
            }
        ],
        "notice_group_list": [
            {
                "notice_group_id": 11,
                "notice_group_name": "主备负责人",
                "count": 1
            }
        ],
        "data_source_list": [
            {
                "type": "bk_monitor_time_series",
                "name": "监控采集指标",
                "data_type_label": "time_series",
                "data_source_label": "bk_monitor",
                "count": 1
            }
        ],
        "strategy_label_list": []
    }
}
```