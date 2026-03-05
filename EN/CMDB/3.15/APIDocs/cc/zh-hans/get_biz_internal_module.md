
### Request method

GET


### request address

/api/c/compapi/v2/cc/get_biz_internal_module/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Obtain business idle machines, faulty machines and modules to be recycled according to the business ID

### Request parameters




#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_id | int | yes | business ID |

### Request parameter example

```python

{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id":0
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
  "data": {
    "bk_set_id": 2,
    "bk_set_name": "空闲机池",
    "module": [
      {
        "bk_module_id": 3,
        "bk_module_name": "空闲机",
        "default": 1,
        "host_apply_enabled": false
      },
      {
        "bk_module_id": 4,
        "bk_module_name": "故障机",
        "default": 2,
        "host_apply_enabled": false
      },
      {
        "bk_module_id": 5,
        "bk_module_name": "待回收",
        "default": 3,
        "host_apply_enabled": false
      }
    ]
  }
}
```

### Return result parameter description
#### response
| Name | Type | Description |
| ------- | ------ | -------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |


#### data description
| Field | Type | Description |
|-----------|------------|------------|
|bk_set_id | int64 | The instance ID of the set to which the idle machine, the faulty machine and the module to be recycled belong |
|bk_set_name | string |The instance name of the set to which the idle machine, the faulty machine and the module to be recycled belong|

#### module description
| Field | Type | Description |
|-----------|------------|------------|
|bk_module_id | int | Instance ID of idle machine, faulty machine or module to be recycled |
|bk_module_name | string |Instance name of idle machine, faulty machine or module to be recycled|
|default | int | indicates the module type |
| host_apply_enabled|bool|Whether to enable automatic application of host attributes|