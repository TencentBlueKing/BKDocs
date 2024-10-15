
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/search_alarm_strategy/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query alarm policy

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | ---- | ---------- |
| page | int | no | page number |
| page_size | int | No | Number of items per page |
| ids | list | no | policy ID list |
| metric_id | string | no | metric ID |
| bk_biz_id | int | yes | business ID |
| fields | list | no | required fields |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_id": 2,
     "ids": [1, 2]
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
| action_list | list | Action list (Action) |
| source_type | string | data source |
| target | list | monitoring target |
| bk_biz_id | int | Business ID |
| item_list | list | Monitoring items (Item) |
| name | string | policy name |
| scenario | string | monitoring object |
| id | int | policy ID |

#### data.action_list

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

#### data.action_list.notice_group_list

| Field | Type | Description |
| --------------- | ------ | ------------------------------------------------------ |
| notice_receiver | list | recipients |
| name | string | notification group name |
| notice_way | dict | Notification method, alarm level is key, value is a list composed of notification methods |
| message | string | remarks |
| id | int | notification group ID |

#### item_list

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

#### item_list.rt_query_config

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

#### item_list.algorithm_list

| Field | Type | Description |
| ---------------------------- | ------ | --------------- |
| algorithm_config | list | algorithm configuration list |
| level | int | Alarm level |
| trigger_config | dict | trigger condition |
| trigger_config.count | int | trigger threshold |
| trigger_config.check_window | int | Number of trigger detection windows |
| algorithm_type | string | algorithm type |
| recovery_config | dict | recovery configuration |
| recovery_config.check_window | int | Number of recovery cycles |
| message_template | string | |

#### Sample data
```json
{
    "message": "OK",
    "code": 200,
    "data": [
        {
            "bk_biz_id": 2,
            "item_list": [
                {
                    "update_time": "2019-11-22 14:50:23+0800",
                    "data_type_label": "time_series",
                    "metric_id": "bk_monitor.system.cpu_detail.idle",
                    "item_name": "空闲率",
                    "strategy_id": 1,
                    "data_source_label": "bk_monitor",
                    "algorithm_list": [
                        {
                            "algorithm_config": [[
                                {
                                    "threshold": 0.1,
                                    "method": "gte"
                                }
                            ]],
                            "update_time": "2019-11-22 14:50:23+0800",
                            "trigger_config": {
                                "count": 1,
                                "check_window": 5
                            },
                            "strategy_id": 1,
                            "level": 1,
                            "algorithm_type": "Threshold",
                            "recovery_config": {
                                "check_window": 5
                            },
                            "create_time": "2019-11-22 14:50:23+0800",
                            "algorithm_id": 19,
                            "message_template": "",
                            "item_id": 2,
                            "id": 19
                        }
                    ],
                    "no_data_config": {
                        "is_enabled": false,
                        "continuous": 5
                    },
                    "create_time": "2019-10-26 15:54:18+0800",
                    "rt_query_config_id": 2,
                    "item_id": 2,
                    "rt_query_config": {
                        "update_time": "2019-11-22 14:50:23+0800",
                        "metric_field": "idle",
                        "agg_dimension": [
                            "ip",
                            "bk_cloud_id"
                        ],
                        "unit_conversion": 1,
                        "result_table_id": "system.cpu_detail",
                        "extend_fields": "",
                        "create_time": "2019-10-26 15:54:18+0800",
                        "rt_query_config_id": 2,
                        "agg_method": "AVG",
                        "agg_condition": [],
                        "agg_interval": 60,
                        "id": 2,
                        "unit": "%"
                    },
                    "id": 2,
                    "name": "空闲率"
                }
            ],
            "update_time": "2019-11-22 14:50:23+0800",
            "target": [
                [
                    {
                        "field": "bk_target_ip",
                        "method": "eq",
                        "value": [
                            {
                                "bk_target_ip": "10.0.0.1",
                                "bk_target_cloud_id": 0
                            }
                        ]
                    }
                ]
            ],
            "scenario": "os",
            "strategy_id": 1,
            "action_list": [
                {
                    "update_time": "2019-11-22 14:50:24+0800",
                    "notice_template": {
                        "recovery_template": "",
                        "update_time": "2019-11-22 14:50:24+0800",
                        "create_time": "2019-10-26 15:54:19+0800",
                        "anomaly_template": "aa",
                        "action_id": 2
                    },
                    "id": 2,
                    "notice_group_list": [
                        {
                            "update_time": "2019-11-18 17:51:54+0800",
                            "notice_receiver": [
                                {
                                    "type": "user",
                                    "id": "admin"
                                }
                            ],
                            "name": "user group",
                            "notice_way": {
                                "1": [
                                    "weixin"
                                ],
                                "2": [
                                    "weixin"
                                ],
                                "3": [
                                    "weixin"
                                ]
                            },
                            "create_time": "2019-11-18 17:51:54+0800",
                            "notice_group_id": 5,
                            "message": "asdf",
                            "notice_group_name": "user group",
                            "id": 5
                        }
                    ],
                    "create_time": "2019-10-26 15:54:18+0800",
                    "action_type": "notice",
                    "config": {
                        "alarm_end_time": "23:59:59",
                        "send_recovery_alarm": false,
                        "alarm_start_time": "00:00:00",
                        "alarm_interval": 120
                    },
                    "strategy_id": 1,
                    "action_id": 2
                }
            ],
            "source_type": "BKMONITOR",
            "strategy_name": "test",
            "create_time": "2019-10-23 21:34:12+0800",
            "id": 1,
            "name": "test"
        }
    ],
    "result": true
}
```