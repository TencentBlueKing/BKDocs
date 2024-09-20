
### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/export_uptime_check_task/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Export test task configuration

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ------ | ------ | ---- | ----------------------------------------------------------- |
| bk_biz_id | int | yes | business id |
| protocol | str | no | protocol type (TCP, UDP, HTTP)|
| task_ids | str | No | Task ID, multiple tasks separated by commas |
| node_conf_needed | int | No | Whether to export task-related node configuration information, 0 or 1, default is 1 |

#### Request parameter example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_id": 2,
     "task_ids": "60",
     "protocol": "TCP"
}
```

### Return parameters

| Field | Type | Description |
| ------- | ------ | --------------------------------- |
| result | bool | Return the result, true means success, false means failure |
| code | int | Return code, 200 indicates success, other values indicate failure |
| message | string | error message |
| data | list | results |

## data

There are multiple configuration lists (conf_list) inside

### Configuration list --conf_list

| Field | Type | Description |
| -------------- | ---- | -------------- |
| collector_conf | dict | Basic configuration of dial test task |
| target_conf | dict | Test task delivery configuration |
| monitor_conf | list | Monitoring strategy corresponding to the dial test task |

#### Basic configuration of dial test task--data.conf_list.collector_conf

| Field | Type | Description |
| ----------- | ------ | ----------- |
| location | dict | Dial test target address |
| groups | str | The group to which the test task belongs |
| name | str | Dial test task name |
| protocol | str | Dial test task protocol type |
| config | dict | Detailed configuration of dial test task |

##### Detailed configuration of basic configuration of dial test task (TCP)--data.conf_list.collector_conf.config (TCP, UDP)

| Field | Type | Description |
| ----------- | ------ | ----------- |
| ip_list | list | destination IP address |
| port | int | port address |
| period | int | Collection period, unit min |
| response_format | str | Response information matching method (including: in, excluding: nin, regular: reg) | timeout | int | expected response time |
| response | str | expected response content |
| response_code | str | expected response code |

###### Example of config returned by http task

```json
{
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
}
```
##### Detailed configuration of basic configuration of dial test task (HTTP)--data.conf_list.collector_conf.config(HTTP)

| Field | Type | Description |
| ----------- | ------ | ----------- |
| urls | str | url |
| method | str | request method |
| headers | list | request headers |
| insecure_skip_verify | bool | whether to enable ssh verification |
| period | int | Collection period, unit min |
| response_format | str | Response information matching method (including: in, excluding: nin, regular: reg) | timeout | int | expected response time |
| response | str | expected response content |
| response_code | str | expected response code |

##### Dial the address of the test target--data.conf_list.collector_conf.location

| Field | Type | Description |
| ----------- | ------ | ----------- |
| bk_state_name | str | country |
| bk_province_name | str | province |

#### Deliver the configuration of the test task--data.conf_list.target_conf

| Field | Type | Description |
| ----------- | ------ | ----------- |
| bk_biz_id | int | Business ID |
| node_list | list | node information associated with the task |

##### Node information associated with the task--data.conf_list.target_conf.node_list

| Field | Type | Description |
| ----------- | ------ | ----------- |
| node_conf | dict | node configuration information |
| target_conf | dict | Node sends information |

###### Node sends information--data.conf_list.target_conf.node_list.target_conf

| Field | Type | Description |
| ----------- | ------ | ----------- |
| bk_biz_id | int | The business to which the node belongs |
| ip | str | node IP |
| bk_cloud_id | int | Node cloud area ID |

###### Node configuration information--data.conf_list.target_conf.node_list.node_conf

| Field | Type | Description |
| ----------- | ------ | ----------- |
| carrieroperator | str | operator information |
| name | str | node name |
| is_common | bool | Whether it is a common node |
| location | dict | The area where the node is located |

###### The area where the node is located--data.conf_list.target_conf.node_list.node_conf.location

| Field | Type | Description |
| ----------- | ------ | ----------- |
| country | str | country |
| city | str | province |

#### The area where the node is located--data.conf_list.monitor_conf
| Field | Type | Description |
| ----------- | ------ | ----------- |
| alarm_level_config | dict | Monitoring trigger condition configuration |
| monitor_target | str | Monitor target field |
| unit | str | unit |
| display_name | str | monitoring name |
| node_count | int | number of nodes |
| is_enabled | bool | Whether to enable |
| nodata_alarm | int | No data alarm |
| rules | dict | Alarm convergence configuration |
| is_classify_notice | bool | Whether to classify the alarm |
| where_sql | str | Monitoring source query conditions |
| condition | list | monitoring range |
| bk_biz_id | int | Business ID |
| scenario | str | monitoring scenario |
| monitor_id | int | Monitoring source ID |
| alarm_strategy_id | int | Monitoring strategy ID |
| is_recovery | bool | automatic recovery |

##### Alarm convergence configuration--data.conf_list.monitor_conf.rules

| Field | Type | Description |
| ------|-------|-------|
| alarm_window | int | alarm window |
| check_window | int | Check window |
| count | int | quantity |

##### Monitoring trigger condition configuration--data.conf_list.monitor_conf.alarm_level_config

Field | Type | Description |
------|-------|-------|
1 | dict | Alarm triggering configuration corresponding to the alarm level, expressed as fatal alarm |
2 | dict | Alarm triggering configuration corresponding to the alarm level, expressed as early warning alarm |
3 | dict | Alarm triggering configuration corresponding to the alarm level, which appears as a reminder alarm |

###### Alarm triggering configuration corresponding to the alarm level--data.conf_list.monitor_conf.alarm_level_config.1

Field | Type | Description |
------|-------|-------|
alarm_start_time | str | start alarm time of the day |
alarm_end_time | str | end alarm time of the day |
detect_algorithm | list | detection algorithm configuration |
is_recovery | str | automatic recovery |
monitor_level | int | Alarm level, 1 fatal, 2 warning, 3 reminder |
notify_way | list |Notification method, mail, wechat, sms, phone |
phone_receiver | list | phone notification object, account name |
responsible | list | list of other notifiers |
role_list | list | Notifier grouping, configured in business management |

###### Detection algorithm configuration--data.conf_list.monitor_conf.alarm_level_config.1.detect_algorithm

|Field |Type |Description |
|------|-------|-------|
| config | dict |Detection algorithm detailed configuration |
| algorithm_id | int | Detection algorithm ID, static threshold 1000, year-on-year strategy (simple) 1001, month-on-month strategy (simple) 1002 |

###### Detailed configuration of detection algorithm (static threshold)--data.conf_list.monitor_conf.alarm_level_config.1.detect_algorithm.config

|Field | Type | Description |
|------|-------|-------|
threshold | int | comparison value |
method | str | comparison method |
message | str | description |

###### Detailed configuration of detection algorithm (year-on-year, month-on-month)--data.conf_list.monitor_conf.alarm_level_config.1.detect_algorithm.config

|Field | Type | Description |
|------|-------|-------|
ceil | int | Alarm greater than the set value |
floor | str | Alarm below set value |
message | str | description |

#### Return parameter example

```json
{
    "message": "OK",
    "code": 200,
    "data": [
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
    ],
    "result": true
}
```