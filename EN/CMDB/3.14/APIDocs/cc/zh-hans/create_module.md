
### Request method

POST


### request address

/api/c/compapi/v2/cc/create_module/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

create module

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_biz_id | int | yes | business ID |
| bk_set_id | int | yes | cluster id |
| data | dict | is | business data |

#### data

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_parent_id | int | yes | the ID of the parent instance node, the upper instance node of the current instance node, generally refers to the bk_set_id of the set for the module in the topology |
| bk_module_name | string | yes | module name |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "bk_set_id": 10,
    "data": {
        "bk_parent_id": 10,
        "bk_module_name": "test"
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
        "bk_bak_operator": null,
        "bk_biz_id": 1,
        "bk_module_id": 37825,
        "bk_module_name": "test",
        "bk_module_type": "1",
        "bk_parent_id": 10,
        "bk_set_id": 10,
        "bk_supplier_account": "0",
        "create_time": "2022-02-22T20:25:19.049+08:00",
        "default": 0,
        "host_apply_enabled": false,
        "last_time": "2022-02-22T20:25:19.049+08:00",
        "operator": null,
        "service_category_id": 2,
        "service_template_id": 0,
        "set_template_id": 0
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
| bk_bak_operator | string | backup maintainer |
| bk_module_id | int | model id |
|bk_biz_id|int|business id|
| bk_module_id | int | ID of the module to which the host belongs |
| bk_module_name | string | module name |
|bk_module_type|string|module type|
|bk_parent_id|int|ID of the parent node|
| bk_set_id | int | cluster id |
| bk_supplier_account | string | Supplier account |
| create_time | string | creation time |
| last_time | string | update time |
|default | int | indicates the module type |
| host_apply_enabled|bool|Whether to enable automatic application of host attributes|
| operator | string | main maintainer |
|service_category_id|integer|service category ID|
|service_template_id|int|service template ID|
| set_template_id | int | cluster template ID |