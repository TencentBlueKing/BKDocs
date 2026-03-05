### Request method

POST


### request address

/api/c/compapi/v2/cc/create_service_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create a service template with the specified name and service category based on the service template name and service category ID passed in

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-------------------|
| name | string | yes | service template name |
| service_category_id | int | yes | service category ID |
| bk_biz_id | int | yes | business ID|

### Request parameter example

```python
{
   "bk_app_code": "esb_test",
   "bk_app_secret": "xxx",
   "bk_username": "xxx",
   "bk_token": "xxx",
   "bk_biz_id": 1,
   "name": "test4",
   "service_category_id": 1
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
     "bk_biz_id": 1,
     "id": 52,
     "name": "test4",
     "service_category_id": 1,
     "creator": "admin",
     "modifier": "admin",
     "create_time": "2019-09-18T23:09:44.251970453+08:00",
     "last_time": "2019-09-18T23:09:44.251970568+08:00",
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
| data | object | the data returned by the request |

#### data field description

| Field|Type|Description|
|---|---|---|
|id|int|Service Template ID|
|bk_biz_id|int|business id|
|name|string|service template name|
|service_category_id|int|service template ID|
| creator | string | The creator of this data |
| modifier | string | The person who modified this data last |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |