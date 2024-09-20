### request method

POST


### request address

/api/c/compapi/v2/cc/create_cloud_area/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create a cloud zone based on the cloud zone name

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-------------|
| bk_cloud_name | string | yes | cloud zone name |

### Request parameter example

``` python
{

    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_cloud_name": "test1"
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
        "created": {
            "origin_index": 0,
            "id": 6
        }
    }
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
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|---------------|----------|----------|
| created | object | Created successfully, return information |


#### data.created

| Name | Type | Description |
|---------|-------|------------|
| origin_index| int | The result order corresponding to the request |
| id| int | cloud zone id, bk_cloud_id |