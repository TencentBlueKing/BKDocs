### Request method

POST


### request address

/api/c/compapi/v2/cc/list_service_instance_detail/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the list of service instances (with process information) according to the business id, and you can add query conditions such as module id

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-------------------|
| bk_biz_id | int | yes | business ID |
| bk_module_id | int | no | module ID |
| bk_host_id | int | No | Host ID, note: this field is no longer maintained, please use the bk_host_list field |
| bk_host_list | array| no | list of host IDs |
| service_instance_ids | int | no | list of service instance ids |
| selectors | int | No | label filter function, operator optional values: `=`,`!=`,`exists`,`!`,`in`,`notin`|
| page | object | yes | pagination parameters |

Note: Only one of the parameters `bk_host_list` and `bk_host_id` can take effect, and `bk_host_id` is not recommended.

#### selectors
| Field | Type | Required | Description |
| -------- | ------ | ---- | ------ |
| key | string | no | field name | |
| operator | string | no | operator optional values: `=`,`!=`,`exists`,`!`,`in`,`notin` |
| values | - | No | Different operators correspond to different value formats |

#### page field description

| Field | Type | Required | Description |
| ----- | ------ | ---- | --------------------- |
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 1000 |

### Request parameter example

```python

{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "page": {
    "start": 0,
    "limit": 10,
  },
  "bk_module_id": 8,
  "bk_host_list": [11,12],
  "service_instance_ids": [49],
  "selectors": [{
    "key": "key1",
    "operator": "notin",
    "values": ["value1"]
  }]
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
        "bk_biz_id": 1,
        "id": 49,
        "name": "p1_81",
        "service_template_id": 50,
        "bk_host_id": 11,
        "bk_module_id": 56,
        "creator": "admin",
        "modifier": "admin",
        "create_time": "2019-07-22T09:54:50.906+08:00",
        "last_time": "2019-07-22T09:54:50.906+08:00",
        "bk_supplier_account": "0",
        "service_category_id": 22,
        "process_instances": [
          {
            "process": {
              "proc_num": 0,
              "stop_cmd": "",
              "restart_cmd": "",
              "face_stop_cmd": "",
              "bk_process_id": 43,
              "bk_func_name": "p1",
              "work_path": "",
              "priority": 0,
              "reload_cmd": "",
              "bk_process_name": "p1",
              "pid_file": "",
              "auto_start": false,
              "last_time": "2019-07-22T09:54:50.927+08:00",
              "create_time": "2019-07-22T09:54:50.927+08:00",
              "bk_biz_id": 3,
              "start_cmd": "",
              "user": "",
              "timeout": 0,
              "description": "",
              "bk_supplier_account": "0",
              "bk_start_param_regex": "",
              "bind_info": [
                {
                    "enable": true,
                    "ip": "127.0.0.1",
                    "port": "80",
                    "protocol": "1",
                    "template_row_id": 1234
                }
              ]
            },
            "relation": {
              "bk_biz_id": 1,
              "bk_process_id": 43,
              "service_instance_id": 49,
              "process_template_id": 48,
              "bk_host_id": 11,
              "bk_supplier_account": "0"
            }
          }
        ]
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

#### data.info field description

| Field|Type|Description|Description|
|---|---|---|---|
|id|integer|Service Instance ID||
|name|array|service instance name||
|service_template_id|int|service template ID||
|bk_host_id|int|host ID||
|bk_host_innerip|string|Host IP||
|bk_module_id|integer|module ID||
|creator|string|creator||
|modifier|string|Modifier||
|create_time|string|creation time||
|last_time|string|repair time||
|bk_supplier_account|string|Supplier ID||
|service_category_id|integer|service category ID||
|process_instances|array|process instance info|include||
|bk_biz_id|int|Business ID|Business ID||
|process_instances.process|object|Process instance details|Process attribute fields||
|process_instances.relation|object|Relationship information of process instance|such as host ID, process template ID||

#### data.info.process_instances[x].process field description
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

#### data.info.process_instances[x].process.bind_info[n] field description
| Field|Type|Description|
|---|---|---|
|enable|bool|Whether the port is enabled|
|ip|string|bind ip|
|port|string|The port to bind|
|protocol|string|The protocol used|
|template_row_id|int|The template row index used for instantiation, unique within the process|

#### data.info.process_instances[x].relation field description
| Field|Type|Description|
|---|---|---|
|bk_biz_id|int|business id|
|bk_process_id|int|process id|
|service_instance_id|int|service instance id|
|process_template_id|int|process template id|
|bk_host_id|int|host id|
|bk_supplier_account|string|Supplier Account|