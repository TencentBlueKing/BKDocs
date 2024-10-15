
### request method

POST


### request address

/api/c/compapi/v2/cc/update_service_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Update Service Template Information

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------|
| name | string | and service_category_id are optional, both are optional | service template name |
| service_category_id | int | and name must be filled in, both can be filled in | service category id |
| id | int | yes | service template ID |
| bk_biz_id | int | yes | business ID |

### Request parameter example

```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "name": "test1",
  "id": 50,
  "service_category_id": 3
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
    "bk_biz_id": 1,
    "id": 50,
    "name": "test1",
    "service_category_id": 3,
    "creator": "admin",
    "modifier": "admin",
    "create_time": "2019-06-05T11:22:22.951+08:00",
    "last_time": "2019-06-05T11:22:22.951+08:00",
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
| data | object | updated service template information |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | ------------ |
| id | int | service template ID |
| name | string | service template name |
| bk_biz_id | int | business ID |
| service_category_id | int | service category id |
| creator | string | creator |
| modifier | string | Last Modifier |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |