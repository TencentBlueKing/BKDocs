
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/import_uptime_check_task/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Import dial test tasks

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ---- | ---- | ---------------- |
| bk_biz_id | int | yes | business ID |
| conf_list | list | Yes | Dial test task configuration list |

#### Dial test task configuration list --conf_list

| Field | Type | Required | Description |
| -------------- | ---- | ---- | ---------------- |
| target_conf | dict | Yes | Dial test task delivery configuration |
| collector_conf | dict | Yes | Basic configuration of test task |
| monitor_conf | list | yes | monitoring policy configuration |

##### Deliver the configuration of the test task--conf_list.target_conf

| Field | Type | Required | Description |
| ------------ | ---- | ---- | ------------------------------------------------ |
| bk_biz_id | int | yes | business ID |
| node_list | list | No | Default [], node configuration needs to be imported |
| node_id_list | list | No | Default [], deliver node ID list, node_list and node_id_list cannot be empty at the same time |

###### Need to import node configuration--conf_list.target_conf.node_list

| Field | Type | Required | Description |
| ----------- | ---- | ---- | ----------- |
| target_conf | dict | Yes | Node delivers configuration |
| node_conf | dict | yes | node basic configuration |

###### Node delivers configuration--conf_list.target_conf.node_list.target_conf

| Field | Type | Required | Description |
| ----------- | ---- | ---- | -------- |
| ip | str | yes | IP |
| bk_cloud_id | int | yes | cloud zone ID |
| bk_biz_id | int | yes | business id |

###### Basic node configuration--conf_list.target_conf.node_list.node_conf

| Field | Type | Required | Description |
| --------------- | ---- | ---- | ----------------------- ------------------ |
| is_common | bool | No | Whether it is a common node, default false |
| name | str | yes | node name |
| location | dict | yes | the region where the node is located |
| carrieroperator | str | Yes | Operator, maximum length 50 (Intranet, China Unicom, China Mobile, others) |

###### Node location--conf_list.target_conf.node_list.node_conf.location

| Field | Type | Required | Description |
| ------- | ---- | ---- | ---- |
| country | str | is | country |
| city | str | is | city |

##### Basic configuration of dial test task--conf_list.collector_conf

| Field | Type | Required | Description |
| -------- | ---- | ---- | ---------------- |
| location | dict | yes | the address of the dial test target |
| groups | str | Yes | The group to which the test task belongs |
| name | str | Yes | Dial test task name |
| protocol | str | Yes | Dial test task protocol type |
| config | dict | Yes | Detailed configuration of dial test task |

###### TCP task config example

```json
"config": {
     "ip_list": ["10.0.0.1"],
     "port": 3306,
     "period": 1,
     "response_format": "in",
     "timeout": 2900,
     "response": null
}
```

###### Detailed configuration of dial test task (TCP, UDP)--conf_list.collector_conf.config

| Field | Type | Required | Description |
| --------------- | ---- | ---- | ------------------------------------------------------ |
| ip_list | list | yes | destination IP address |
| port | int | yes | port address |
| period | int | No | Collection period, unit min, default 1 |
| response_format | str | No | Response information matching method (including: in, excluding: nin, regular: reg), default in |
| timeout | int | No | Expected response time, unit ms, default 3000 |
| response | str | no | expected response content |
| response_code | str | no | expected response code |

###### HTTP task config example

```json
"config": {
     "insecure_skip_verify": true,
     "urls": "http://baidu.com",
     "response_code": "",
     "request": null,
     "period": 1,
     "response_format": "in",
     "method": "GET",
     "headers": [],
     "timeout": 3000,
     "response": null
}
```

###### Detailed configuration of dial test task (HTTP)--conf_list.collector_conf.config

| Field | Type | Description |
| -------------------- | ---- | ---- |
| urls | str | yes |
| method | str | yes |
| headers | list | no |
| insecure_skip_verify | bool | no |
| period | int | no |
| response_format | str | no |
| timeout | int | no |
| response | str | no |
| response_code | str | no |
| request | str | no |

##### Monitoring strategy configuration--conf_list.monitor_conf

| Field | Type | Required | Description |
| ------------------ | ------ | ---- | --------------------------------------------------- |
| alarm_level_config | dict | Yes | Monitoring trigger condition configuration |
| alarm_strategy_id | int | yes | Monitoring strategy ID, 0 |
| bk_biz_id | int | yes | business ID |
| condition | list | yes | monitoring range |
| display_name | string | yes | monitoring name |
| is_classify_notice | bool | yes | whether to classify alarms |
| is_enabled | bool | Yes | Whether to enable |
| is_recovery | bool | yes | recovery alarm switch |
| monitor_target | str | Yes | Monitor target field |
| nodata_alarm | int | Yes | Number of no data alarms |
| node_count | int | yes | node average / partial number of nodes |
| rules | dict | yes | convergence rules |
| scenario | str | yes | monitoring scenario |
| unit | str | yes | monitoring field unit |
| where_sql | str | Yes | Can be used for precondition filtering. Partial monitoring support using the database directly as the source |

###### Convergence rules--conf_list.monitor_conf.rules

| Field | Type | Required | Description |
| ------------ | ---- | ---- | -------- |
| alarm_window | int | yes | alarm window |
| check_window | int | yes | check window |
| count | int | yes | quantity |

###### Monitoring trigger condition configuration --conf_list.monitor_conf.alarm_level_config

| Field | Type | Required | Description |
| ---- | ---- | ---- | ------------------------------------------ |
| 1 | dict | No | Alarm triggering configuration corresponding to the alarm level, manifested as fatal alarm |
| 2 | dict | No | Alarm triggering configuration corresponding to the alarm level, expressed as early warning alarm |
| 3 | dict | No | Alarm triggering configuration corresponding to the alarm level, which appears as a reminder alarm |

###### Alarm triggering configuration corresponding to the alarm level--conf_list.monitor_conf.alarm_level_config.1

| Field | Type | Required | Description |
| ---------------- | ---- | ---- | ----------------------------------------------- |
| alarm_start_time | str | yes | start alarm time of the day |
| alarm_end_time | str | yes | end alarm time of the day |
| detect_algorithm | list | yes | detection algorithm configuration |
| is_recovery | str | is | city |
| monitor_level | int | Yes | Alarm level, 1 fatal, 2 warning, 3 reminder |
| notify_way | list | yes | notification method, mail, wechat, sms, phone |
| phone_receiver | list | Yes | Phone notification object, account name |
| responsible | list | yes | list of other notifiers |
| role_list | list | Yes | Notifier group, configured in business management |

###### Detection algorithm configuration --conf_list.monitor_conf.alarm_level_config.1.detect_algorithm

| Field | Type | Required | Description |
| ------------ | ---- | ---- | --------------------------------------------------------- |
| config | dict | yes | detection algorithm detailed configuration |
| algorithm_id | int | Yes | Detection algorithm ID, static threshold 1000, year-on-year strategy (simple) 1001, month-on-month strategy (simple) 1002 |

###### Detailed configuration of detection algorithm (static threshold)--conf_list.monitor_conf.alarm_level_config.1.detect_algorithm.config

| Field | Type | Required | Description |
| --------- | ---- | ---- | -------- |
| threshold | int | yes | comparison value |
| method | str | yes | comparison method |
| message | str | no | description |

###### Detailed configuration of detection algorithm (year-on-year, month-on-month)--conf_list.monitor_conf.alarm_level_config.1.detect_algorithm.config

| Field | Type | Required | Description |
| ------- | ---- | ---- | --------------- |
| ceil | int | yes | alarm greater than the set value |
| floor | str | Yes | Alarm below set value |
| message | str | no | description |

#### Request parameter example

```json
{   
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_biz_id": 2,
    "conf_list": [
        {
            "target_conf": {
                "bk_biz_id": 0,
                "node_id_list": [],
                "node_list": [
                    {
                        "node_conf": {
                            "carrieroperator": "内网",
                            "location": {
                                "country": "中国",
                                "city": "广东"
                            },
                            "name": "中国广东内网",
                            "is_common": false
                        },
                        "target_conf": {
                            "bk_biz_id": 0,
                            "ip": "",
                            "bk_cloud_id": 0
                        }
                    },
                    {
                        "node_conf": {
                            "carrieroperator": "内网",
                            "location": {
                                "country": "中国",
                                "city": "广东"
                            },
                            "name": "中国广东内网",
                            "is_common": false
                        },
                        "target_conf": {
                            "bk_biz_id": 0,
                            "ip": "",
                            "bk_cloud_id": 0
                        }
                    }
                ]
            },
            "collector_conf": {
                "config": {
                    "ip_list": [
                        "10.0.0.1"
                    ],
                    "period": 1,
                    "response_format": "in",
                    "port": 3306,
                    "timeout": 2900,
                    "response": null
                },
                "protocol": "TCP",
                "name": "test_tcp1",
                "groups": "未分类",
                "location": {
                    "bk_state_name": "中国",
                    "bk_province_name": "北京"
                }
            },
            "monitor_conf": [
                {
                    "alarm_level_config": {
                        "2": {
                            "notify_way": [
                                "mail"
                            ],
                            "role_list": [
                                "Tester"
                            ],
                            "monitor_level": 2,
                            "alarm_end_time": "23:59",
                            "responsible": [],
                            "detect_algorithm": [
                                {
                                    "config": {
                                        "threshold": 10,
                                        "message": "",
                                        "method": "gte"
                                    },
                                    "algorithm_id": 1000
                                },
                                {
                                    "config": {
                                        "message": "",
                                        "ceil": 10,
                                        "floor": 10
                                    },
                                    "algorithm_id": 1001
                                }
                            ],
                            "phone_receiver": [],
                            "alarm_start_time": "00:00",
                            "is_recovery": false
                        }
                    },
                    "monitor_target": "available",
                    "unit": "%",
                    "display_name": "\"test_tcp1\"节点平均值可用率",
                    "node_count": 0,
                    "is_enabled": true,
                    "nodata_alarm": 0,
                    "rules": {
                        "count": 1,
                        "alarm_window": 1440,
                        "check_window": 5
                    },
                    "is_classify_notice": false,
                    "where_sql": "",
                    "condition": [
                        []
                    ],
                    "bk_biz_id": 2,
                    "scenario": "uptimecheck",
                    "monitor_id": 0,
                    "alarm_strategy_id": 0,
                    "is_recovery": false
                }
            ]
        }
    ]
}
```

### Return results

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| result | bool | Return the result, true means success, false means failure |
| code | int | Return code, 200 indicates success, other values indicate failure |
| message | string | error message |
| data | list | results |

#### data field description

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
failed | dict | Import failure related information |
success | dict | Import success related information |

##### Import failure related information--data.failed

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
total | int | Number of failed imports |
detail | list | Import failure details |

###### Import failure details--data.failed.detail

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| error_mes | str | Reason for import failure |
| task_name | str | task name |

##### Information related to successful import--data.success

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| total | int | Number of successful imports |
| detail | list | Import success details |

###### Information related to successful import--data.success.datail

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| task_name | str | task name |

#### Return result example
```json
{
    "message": "OK",
    "code": 200,
    "data": {
        "failed": {
            "total": 0,
            "detail": [{
                'task_name': "tcp_test2",
                'error_mes': 'xx'
            }]
        },
        "success": {
            "total": 1,
            "detail": [
                {
                    "task_name": "test_tcp1"
                }
            ]
        }
    },
    "result": true
}
```