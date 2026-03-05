
### Request method

POST


### request address

/api/c/compapi/v2/cc/list_proc_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query process template information based on service template ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|--------------------|
| bk_biz_id | int | yes | business id |
| service_template_id | int | No | Service template ID, at least one of service_template_id and process_template_ids |
| process_template_ids | array | No | Process template ID array, up to 200, at least one of service_template_id and process_template_ids |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "service_template_id": 51,
    "process_template_ids": [
        50
    ]
}
```

### Return result example

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 1,
        "info": [
            {
                "id": 50,
                "bk_process_name": "p1",
                "bk_biz_id": 1,
                "service_template_id": 51,
                "property": {
                    "proc_num": {
                        "value": null,
                        "as_default_value": false
                    },
                    "stop_cmd": {
                        "value": "",
                        "as_default_value": false
                    },
                    "restart_cmd": {
                        "value": "",
                        "as_default_value": false
                    },
                    "face_stop_cmd": {
                        "value": "",
                        "as_default_value": false
                    },
                    "bk_func_name": {
                        "value": "p1",
                        "as_default_value": true
                    },
                    "work_path": {
                        "value": "",
                        "as_default_value": false
                    },
                    "priority": {
                        "value": null,
                        "as_default_value": false
                    },
                    "reload_cmd": {
                        "value": "",
                        "as_default_value": false
                    },
                    "bk_process_name": {
                        "value": "p1",
                        "as_default_value": true
                    },
                    "pid_file": {
                        "value": "",
                        "as_default_value": false
                    },
                    "auto_start": {
                        "value": false,
                        "as_default_value": false
                    },
                    "auto_time_gap": {
                        "value": null,
                        "as_default_value": false
                    },
                    "start_cmd": {
                        "value": "",
                        "as_default_value": false
                    },
                    "bk_func_id": {
                        "value": null,
                        "as_default_value": false
                    },
                    "user": {
                        "value": "",
                        "as_default_value": false
                    },
                    "timeout": {
                        "value": null,
                        "as_default_value": false
                    },
                    "description": {
                        "value": "",
                        "as_default_value": false
                    },
                    "bk_start_param_regex": {
                        "value": "",
                        "as_default_value": false
                    },
                    "bind_info": {
                        "value": [
                            {
                                "enable": {
                                    "value": false,
                                    "as_default_value": true
                                },
                                "ip": {
                                    "value": "1",
                                    "as_default_value": true
                                },
                                "port": {
                                    "value": "100",
                                    "as_default_value": true
                                },
                                "protocol": {
                                    "value": "1",
                                    "as_default_value": true
                                },
                                "row_id": 1
                            }
                        ],
                        "as_default_value": true
                    }
                },
                "creator": "admin",
                "modifier": "admin",
                "create_time": "2019-06-19T15:24:04.763+08:00",
                "last_time": "2019-06-19T15:24:04.763+08:00",
                "bk_supplier_account": "0"
            }
        ]
    }
}
```

### Return result parameter description

#### response

| Name | Type | Description |
|---|---|---|
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data field description

| Field|Type|Description|
|---|---|---|
|count|int|total number|
|info|array|return result|

#### info field description
| Field|Type|Description|
|---|---|---|
|id|int|process template ID|
|bk_process_name|string|process template name|
|property|object|process template properties|
|bk_biz_id|int|Business ID|
|service_template_id|int|service template ID|
| creator | string | The creator of this data |
| modifier | string | The person who modified this data last |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |

#### data.info[x].property

Whether the value of as_default_value process is subject to the template

| Field|Type|Description|
|---|---|---|
|auto_start|bool|Whether to start automatically|
|auto_time_gap|int|pull up interval|
|bk_biz_id|int|business id|
|bk_func_id|string|function ID|
|bk_func_name|string|process name|
|bk_process_id|int|process id|
|bk_process_name|string|Process alias|
|bk_start_param_regex|string|Process start parameter|
|bk_supplier_account|string|Supplier Account|
|create_time|string|create time|
|description|string|description|
|face_stop_cmd|string|force stop command|
|last_time|string|update time|
|pid_file|string|PID file path|
|priority|int|Start priority|
|proc_num|int|Number of starts|
|reload_cmd|string|Process reload command|
|restart_cmd|string|restart command|
|start_cmd|string|start command|
|stop_cmd|string|stop command|
|timeout|int|Operation timeout|
|user|string|starting user|
|work_path|string|work path|
|bind_info|object|bind info|

#### data.info [x].property.bind_info.value[n] field description
| Field|Type|Description|
|---|---|---|
|enable|object|Whether the port is enabled|
|ip|object|bound ip|
|port|object|The port to bind|
|protocol|object|protocol used|
|row_id|int|template row index, unique within the process|