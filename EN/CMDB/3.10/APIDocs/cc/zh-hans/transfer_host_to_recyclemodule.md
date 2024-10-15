
### request method

POST


### request address

/api/c/compapi/v2/cc/transfer_host_to_recyclemodule/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Submit the module to be recycled from the host to the business

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_id | int | yes | business ID |
Fill in at least one of | bk_set_id | int | and bk_module_id | cluster ID |
| bk_module_id | int | and bk_set_id at least one | module ID |
| bk_host_id | array | yes | host ID |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "bk_set_id": 1,
    "bk_module_id": 1,
    "bk_host_id": [
        9,
        10
    ]
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
    "data": null
}
```
### Return result parameter description

#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request            |