### Request method

POST


### request address

/api/c/compapi/v2/cc/delete_proc_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Delete a process template based on a list of process template IDs

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-------------------|
| process_templates | array | yes | list of process template IDs |
| bk_biz_id | int | yes | business ID|

### Request parameter example

```python
{
   "bk_app_code": "esb_test",
   "bk_app_secret": "xxx",
   "bk_username": "xxx",
   "bk_token": "xxx",
   "bk_biz_id": 1,
   "process_templates": [50]
}
```

### return result example

```python
{
     "result": true,
     "code": 0,
     "data": null,
     "message": "success",
     "permission": null,
     "request_id": "069cbd4eed2846a0b4c995f3d040e2a5"
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