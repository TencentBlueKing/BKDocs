
### request method

POST


### request address

/api/c/compapi/v2/cc/update_proc_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Update process template information

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
| process_template_id | int | no | process template ID |
| process_property | object | yes | process template field information to be updated |

#### process_property can appear fields

annotation:

as_default_value: Whether the value of the process is subject to the template
value: the value of the process, different field types are different

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
|proc_num| object| No| {"value": null, "as_default_value": false}, value type is number|
|stop_cmd|object| No| {"value": "","as_default_value": false}, value type is string|
|restart_cmd|object|No|{"value": "","as_default_value": false}, value type is string|
|face_stop_cmd|object|No|{"value": "","as_default_value": false}, value type is string|
|bk_func_name|object|No|{"value": "a7","as_default_value": true}}, value type is string|
|work_path|object|No|{"value": "","as_default_value": false}, value type is string|
|priority|object|No|{"value": null,"as_default_value": false}, value type is number|
|reload_cmd|object|No|{"value": "","as_default_value": false}, value type is string|
|bk_process_name|object|No|{"value": "a7","as_default_value": true}}, value type is string|
|pid_file|object|No|{"value": "","as_default_value": false}, value type is string|
|auto_start|object|No|{"value": null,"as_default_value": null}}, value type is boolean|
|auto_time_gap|object|No|{"value": null,"as_default_value": false}, value type is number|
|start_cmd|object|No|{"value": "","as_default_value": false}, value type is string|
|bk_func_id|object|No|{"value": "","as_default_value": false} value type is string|
|user|object|No|{"value": "","as_default_value": false}, value type is string|
|timeout|object|No|{"value": null,"as_default_value": false}, value type is number|
|description|object|No|{"value": "1","as_default_value": true}}, value type is string|
|bk_start_param_regex|object|No|{"value": "","as_default_value": false}, value type is string||
|bind_info|object|No| {"value":[],,"as_default_value": true }, see process_property.bind_info.value[n]|


#### process_property.bind_info.value[n] Fields that can appear

Notice:

When modifying bind_info, you must first obtain the contents of the bind_info of the original process, then modify the existing bind_info of the process, and pass the modified content to the modification structure.

annotation:

as_default_value: Whether the value of the process is subject to the template
value: the value of the process, different field types are different

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
|enable|object|No| {"value": false,"as_default_value": true}, value type is boolean|
|ip|object|No| {"value": "1","as_default_value": true}, value type is string||
|port|object|No| {"value": "100","as_default_value": true}, value type is string||
|protocol|object|No| {"value": "1","as_default_value": true},, value type is string||
|row_id|int|No| uniquely represents the id, the newly added row can be set to empty, and the update must keep the original value|







### Request parameter example
```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "process_template_id": 50,
  "process_property": {
    "proc_num": {
        "value": 300,
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
        "value": "root100",
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
    "id": 50,
    "bk_process_name": "p1",
    "bk_biz_id": 1,
    "service_template_id": 51,
    "property": {
      "proc_num": {
        "value": 300,
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
        "value": "root100",
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
    "last_time": "2019-06-21T16:25:03.962512+08:00",
    "bk_supplier_account": "0"
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
| data | object | updated process template information |

#### data field description

| Name | Type | Description |
|---|---|---|
| id | int | data id |
| bk_process_name | string | process alias |
| bk_biz_id | int| business id |
| service_template_id | int | service template id |
| property |object | property|
| creator | string | The creator of this data |
| modifier | string | The person who modified this data last |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |