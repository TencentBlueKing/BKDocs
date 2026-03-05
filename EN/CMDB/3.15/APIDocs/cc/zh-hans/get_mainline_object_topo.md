
### Request method

POST


### request address

/api/c/compapi/v2/cc/get_mainline_object_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Obtain the business topology of the mainline model

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx"
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
      "bk_obj_id": "biz",
      "bk_obj_name": "business",
      "bk_supplier_account": "0",
      "bk_next_obj": "set",
      "bk_next_name": "set",
      "bk_pre_obj_id": "",
      "bk_pre_obj_name": ""
    },
    {
      "bk_obj_id": "set",
      "bk_obj_name": "set",
      "bk_supplier_account": "0",
      "bk_next_obj": "module",
      "bk_next_name": "module",
      "bk_pre_obj_id": "biz",
      "bk_pre_obj_name": "business"
    },
    {
      "bk_obj_id": "module",
      "bk_obj_name": "module",
      "bk_supplier_account": "0",
      "bk_next_obj": "host",
      "bk_next_name": "host",
      "bk_pre_obj_id": "set",
      "bk_pre_obj_name": "set"
    },
    {
      "bk_obj_id": "host",
      "bk_obj_name": "host",
      "bk_supplier_account": "0",
      "bk_next_obj": "",
      "bk_next_name": "",
      "bk_pre_obj_id": "module",
      "bk_pre_obj_name": "module"
    }
  ]
}
```

### Return result parameter description

#### response

| Name | Type | Description |
| ------- | ------ | -------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data
| Field | Type | Description |
|-----------|------------|------------|
|bk_obj_id | string | Unique ID of the model |
|bk_obj_name | string |model name|
|bk_supplier_account | string |Supplier account name|
|bk_next_obj | string |Unique ID of the next model of the current model|
|bk_next_name | string |The next model name of the current model|
|bk_pre_obj_id | string |The unique ID of the previous model of the current model|
|bk_pre_obj_name | string |The name of the previous model of the current model|