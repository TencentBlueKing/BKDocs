### Request method

POST


### request address

/api/c/compapi/v2/cc/batch_create_proc_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Batch create process templates

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
| bk_biz_id | int | yes | business ID |
| service_template_id | int | No | service template ID |
| processes | array | yes | process template information |


#### processes
as_default_value: Whether the value of the process is subject to the template

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
  "service_template_id": 1,
  "processes": [
    {
      "spec": {
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
  "data": [[52]]
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
| data | array | successfully created process template ID |