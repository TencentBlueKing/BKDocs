### request method

POST


### request address

/api/c/compapi/v2/cc/create_service_instance/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create service instances in batches. If the module is bound to a service template, the service instance will also be created according to the template. The process parameter of creating a service instance must also provide the process template ID corresponding to each process

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-------------------|
| bk_module_id | int | yes | module ID |
| instances | array | yes | service instance information to be created |
| bk_biz_id | int | yes | business ID|

#### instances field description

| Field|Type|Required |Description|Description|
|---|---|---|---|---|
|instances.bk_host_id|int|is |host ID|the host ID bound to the service instance|
|instances.processes|array|yes|process information|new process information under the service instance|
|instances.processes.process_template_id|int|yes|process template ID|if the module is not bound to a service template, fill in 0|
|instances.processes.process_info|object|Yes|Process instance information|If the process is bound to a template, only the fields that are not locked in the template are valid|

#### processes field description
| Field|Type|Required |Description|
|---|---|---|---|
|process_template_id|int|yes|process template id|
|auto_start|bool|No|Whether to start automatically|
|auto_time_gap|int|no|pull gap|
|bk_biz_id|int|no|business id|
|bk_func_id|string|No|Function ID|
|bk_func_name|string|no|process name|
|bk_process_id|int|no|process id|
|bk_process_name|string|no|process alias|
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
|process_info|object|is|process information|

#### process_info field description
| Field|Type|Required |Description|
|---|---|---|---|
|bind_info|object|is |bind info|
|bk_supplier_account|string|Yes|Supplier account|

#### bind_info field description
| Field|Type|Required |Description|
|---|---|---|---|
|enable|bool|yes|whether the port is enabled|
|ip|string|is the |bound ip|
|port|string| is the |port to bind to|
|protocol|string| is |the protocol used|
|template_row_id|int|is|the template row index used for instantiation, unique within the process|

### Request parameter example

```json
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "bk_module_id": 60,
  "instances": [
    {
      "bk_host_id": 2,
      "processes": [
        {
          "process_template_id": 1,
          "process_info": {
            "bk_supplier_account": "0",
            "bind_info": [
              {
                  "enable": false,
                  "ip": "127.0.0.1",
                  "port": "80",
                  "protocol": "1",
                  "template_row_id": 1234
              }
            ],
            "description": "",
            "start_cmd": "",
            "restart_cmd": "",
            "pid_file": "",
            "auto_start": false,
            "timeout": 30,
            "auto_time_gap": 60,
            "reload_cmd": "",
            "bk_func_name": "java",
            "work_path": "/data/bkee",
            "stop_cmd": "",
            "face_stop_cmd": "",
            "port": "8008,8443",
            "bk_process_name": "job_java",
            "user": "",
            "proc_num": 1,
            "priority": 1,
            "bk_biz_id": 2,
            "bk_func_id": "",
            "bk_process_id": 1
          }
        }
      ]
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
  "data": [53]
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
| data | object | list of newly created service instance IDs |