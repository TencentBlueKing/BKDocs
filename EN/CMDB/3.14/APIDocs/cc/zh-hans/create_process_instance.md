
### Request method

POST


### request address

/api/c/compapi/v2/cc/create_process_instance/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create a process instance based on the service instance ID and process instance property values

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|---- -------------------|
| service_instance_id | int | yes | service instance ID |
| processes | array | yes | attribute values in the process instance different from the template |

#### process_info field description
| Field|Type|Required|Description|
|---|---|---|---|
|auto_start|bool|No|Whether to start automatically|
|auto_time_gap|int|no|pull gap|
|bk_biz_id|int|no|business id|
|bk_func_id|string|No|Function ID|
|bk_func_name|string|no|process name|
|bk_process_id|int|no|process id|
|bk_process_name|string|no|process alias|__
|bk_supplier_account|string|No|Supplier account|
|face_stop_cmd|string|No|Force stop command|
|pid_file|string|No|PID file path|
|priority|int|no|startup priority|
|proc_num|int|No|Number of starts|
|reload_cmd|string|No|Process reload command|
|restart_cmd|string|No|Restart command|
|start_cmd|string|no|start command|
|stop_cmd|string|no|stop command|
|timeout|int|No|Operation timeout|
|user|string|no|start user|
|work_path|string|no|work path|
|bind_info|object|No|Bind info|

#### bind_info field description
| Field|Type|Required|Description|
|---|---|---|---|
|enable|bool|no|whether the port is enabled|
|ip|string|no|bind ip|
|port|string|No|The port to bind|
|protocol|string|no|protocol to use|
|row_id|int|No|The template row index used for instantiation, unique within the process|

### Request parameter example

```json
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "service_instance_id": 48,
  "processes": [
    {
      "process_info": {
        "bk_supplier_account": "0",
        "description": "",
        "start_cmd": "",
        "restart_cmd": "",
        "pid_file": "",
        "auto_start": false,
        "timeout": 30,
        "reload_cmd": "",
        "bk_func_name": "java",
        "work_path": "/data/bkee",
        "stop_cmd": "",
        "face_stop_cmd": "",
        "bk_process_name": "job_java",
        "user": "",
        "proc_num": 1,
        "priority": 1,
        "bk_biz_id": 2,
        "bk_start_param_regex": "",
        "bk_process_id": 1,
        "bind_info": [
          {
              "enable": false,
              "ip": "127.0.0.1",
              "port": "80",
              "protocol": "1",
              "template_row_id": 1234
          }
        ]
      }
    }
  ]
}
```

### return result example

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "request_id": "e43da4ef221746868dc4c837d36f3807",
  "data": [64]
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
| data | object | list of newly created process instance IDs |