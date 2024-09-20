### Request Method

POST


### Request address

/api/c/compapi/v2/cc/batch_delete_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Delete object instances in batches

### Request Parameters



#### Interface Parameters

| Field Type Required Description
|---------------------|-------------|--------|-------------------------------------|
| bk_obj_id | string | yes | Model ID |
| delete | object | yes | delete |

#### delete
| Field | Type | Required | Description |
|---------------------|-------------|--------|-------------------------------------|
| inst_ids | array | yes | collection of instance IDs |

### Request parameter example

```python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_obj_id": "test",
     "delete":{
     "inst_ids": [123]
     }
}
```

### return result example

```python

{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": "success"
}
```

#### Response

| name | type | description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | permission | object |
| permission | object | permission information |
| request_id | string | Request chain id |
| data | object | the data returned by the request | | permission | object | permission information