### request method

POST


### request address

/api/c/compapi/v2/cc/search_host_lock/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query host locks based on host id list (v3.8.6)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|-------------|--------|--------------------------|
|id_list| array| is |list of host IDs|


### Request parameter example

```python
{
   "bk_app_code": "esb_test",
   "bk_app_secret": "xxx",
   "bk_username": "xxx",
   "bk_token": "xxx",
   "id_list":[1, 2]
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
    "data": {
        1: true,
        2: false
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data
| Field | Type | Description |
|-----------|-----------|-------------|
| data |object| The data returned by the request, the key is the ID, and the value is locked or not |