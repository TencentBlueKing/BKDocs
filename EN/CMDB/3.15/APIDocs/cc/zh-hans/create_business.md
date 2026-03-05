### Request method

POST


### request address

/api/c/compapi/v2/cc/create_business/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

new business

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| data | dict | is | business data |

#### data

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_name | string | yes | business name |
| bk_biz_maintainer | string | yes | operation and maintenance personnel |
| bk_biz_productor | string | yes | product person |
| bk_biz_developer | string | yes | developer |
| bk_biz_tester | string | yes | tester |
| time_zone | string | yes | time zone |
| language | string | yes | language, "1" stands for Chinese, "2" stands for English |
**Note: The input parameters here only explain the required and built-in parameters of the system, and the rest of the parameters that need to be filled in depend on the attribute fields defined by the user**

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "data": {
        "bk_biz_name": "cc_app_test",
        "bk_biz_maintainer": "admin",
        "bk_biz_productor": "admin",
        "bk_biz_developer": "admin",
        "bk_biz_tester": "admin",
        "time_zone": "Asia/Shanghai",
        "language": "1"
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
    "data": {
        "bk_biz_developer": "admin",
        "bk_biz_id": 8852,
        "bk_biz_maintainer": "admin",
        "bk_biz_name": "cc_app_test",
        "bk_biz_productor": "admin",
        "bk_biz_tester": "admin",
        "bk_supplier_account": "0",
        "create_time": "2022-02-22T20:10:14.295+08:00",
        "default": 0,
        "language": "1",
        "last_time": "2022-02-22T20:10:14.295+08:00",
        "life_cycle": "2",
        "operator": null,
        "time_zone": "Asia/Shanghai"
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
| data | object | the data returned by the request |
| permission | object | permission information |
| request_id | string | request chain id |

#### data
| Field | Type | Description |
|-----------|-----------|-------------|
| bk_biz_id | int | business id |
| bk_biz_name | string | business name |
| bk_biz_maintainer | string | Operation and maintenance personnel |
| bk_biz_productor | string | product person |
| bk_biz_developer | string | developer |
| bk_biz_tester | string | tester |
| time_zone | string | time zone |
| language | string | language, "1" stands for Chinese, "2" stands for English |
| bk_supplier_account | string | Supplier account |
| create_time | string | creation time |
| last_time | string | update time |
|default | int | indicates business type |
| operator | string | main maintainer |
|life_cycle|string|business lifecycle|