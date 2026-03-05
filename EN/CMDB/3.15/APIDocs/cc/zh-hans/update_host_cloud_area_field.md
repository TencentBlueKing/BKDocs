
### request method

POST


### request address

/api/c/compapi/v2/cc/update_host_cloud_area_field/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Based on the host id list and cloud zone id, update the host's cloud zone field

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
| bk_biz_id | int | No | Business ID |
| bk_cloud_id | int | yes | cloud zone ID |
| bk_host_ids | array | yes | host IDs, up to 2000 |


### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_host_ids": [43, 44], 
    "bk_cloud_id": 27,
    "bk_biz_id": 1
}
```

### Return result example

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "data": ""
}
```

### Example of returned results - cloud region + intranet IP duplicate

```python
{
  "result": false,
  "code": 1199014,
  "message": "Data uniqueness check failed, bk_host_innerip repeated",
   "permission": null,
   "request_id": "e43da4ef221746868dc4c837d36f3807",
   "data": null
}
```

### Return the result instance - too many hosts for one operation
```python
{
   "result": false,
   "code": 1199077,
   "message": "The number of records in one operation exceeds the maximum limit: 2000",
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
| data | object | the data returned by the request |