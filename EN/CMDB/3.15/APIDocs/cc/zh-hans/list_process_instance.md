### Request method

POST


### request address

/api/c/compapi/v2/cc/list_process_instance/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the process instance list according to the service instance ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|--------------------|
|bk_biz_id|int|Yes| Business ID|
| service_instance_id | int | yes | service instance ID |


### Request parameter example

```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "service_instance_id": 54
}
```

### Return result example

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "request_id": "e43da4ef221746868dc4c837d36f3807",
  "data": [
    {
      "property": {
        "auto_start": false,
        "auto_time_gap": 60,
        "bk_biz_id": 2,
        "bk_func_id": "",
        "bk_func_name": "java",
        "bk_process_id": 46,
        "bk_process_name": "job_java",
        "bk_start_param_regex": "",
        "bk_supplier_account": "0",
        "create_time": "2019-06-05T14:59:12.065+08:00",
        "description": "",
        "face_stop_cmd": "",
        "last_time": "2019-06-05T14:59:12.065+08:00",
        "pid_file": "",
        "priority": 1,
        "proc_num": 1,
        "reload_cmd": "",
        "restart_cmd": "",
        "start_cmd": "",
        "stop_cmd": "",
        "timeout": 30,
        "user": "",
        "work_path": "/data/bkee",
        "bind_info": [
            {
                "enable": false,  
                "ip": "127.0.0.1",  
                "port": "100",  
                "protocol": "1", 
                "template_row_id": 1  
            }
        ]
      },
      "relation": {
        "bk_biz_id": 1,
        "bk_process_id": 46,
        "service_instance_id": 54,
        "process_template_id": 1,
        "bk_host_id": 1,
        "bk_supplier_account": ""
      }
    }
  ]
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
| data | array | the data returned by the request |

#### data field description

| Field|Type|Description|
|---|---|---|
|property|object|Process property information|
|relation|object|Relationship information between process and service instance|

#### data[x].property field description
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

#### data[x].property.bind_info[n] field description
| Field|Type|Description|
|---|---|---|
|enable|bool|Whether the port is enabled|
|ip|string|bind ip|
|port|string|The port to bind|
|protocol|string|The protocol used|
|template_row_id|int|The template row index used for instantiation, unique within the process|

#### data[x].relation field description
| Field|Type|Description|
|---|---|---|
|bk_biz_id|int|business id|
|bk_process_id|int|process id|
|service_instance_id|int|service instance id|
|process_template_id|int|process template id|
|bk_host_id|int|host id|
|bk_supplier_account|string|Supplier Account|