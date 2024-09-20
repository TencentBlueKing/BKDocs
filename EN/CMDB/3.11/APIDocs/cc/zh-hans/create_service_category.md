### Request method

POST


### request address

/api/c/compapi/v2/cc/create_service_category/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


#### Function Description

Create service taxonomy

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|------------------|
| name | string | yes | service class name |
| parent_id | int | no | parent node ID |
| bk_biz_id | int | yes | business ID |

### Request parameter example

```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "parent_id": 0,
  "bk_biz_id": 1,
  "name": "test101"
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
    "id": 6,
    "name": "test101",
    "root_id": 5,
    "parent_id": 5,
    "bk_supplier_account": "0",
    "is_built_in": false
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
| data | object | new service classification information |

#### data field description

| Field|Type|Description|
|---|---|---|
|id|integer|Service Category ID|
|root_id|integer|Service classification root node ID|
|parent_id|integer|Service classification parent node ID|
|is_built_in|bool|Is it a built-in node (built-in nodes are not allowed to be edited)|
| bk_biz_id | int | business ID |
| name | string | service category name |
| bk_supplier_account| string| supplier account|