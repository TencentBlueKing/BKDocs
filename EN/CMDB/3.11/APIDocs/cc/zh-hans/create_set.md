### Request method

POST


### request address

/api/c/compapi/v2/cc/create_set/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

create cluster

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_biz_id | int | yes | business ID |
| data | dict | yes | cluster data |

#### data

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_parent_id | int | yes | the ID of the parent node |
| bk_set_name | string | yes | cluster name |
| default | int | No | 0 - common cluster, 1 - built-in module collection, default is 0 |
| set_template_id | int | No | Cluster template ID, which is required when creating a cluster through a cluster template |
|bk_capacity | int | no | design capacity |
| description | string | No | Description of the data |
|bk_set_desc|string|no|cluster description|

**Note: Other required fields are defined by the model**

### Request parameter example

```python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_supplier_account": "123456789",
     "bk_biz_id": 1,
     "data": {
         "bk_parent_id": 1,
         "bk_set_name": "test-set",
         "default": 0,
         "bk_set_desc": "test-set",
         "bk_capacity": 1000,
         "description": "description",
         "set_template_id": 1
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
         "bk_biz_id": 11,
         "bk_capacity": 1000,
         "bk_parent_id": 11,
         "bk_service_status": "1",
         "bk_set_desc": "test-set",
         "bk_set_env": "3",
         "bk_set_id": 4780,
         "bk_set_name": "test-set",
         "bk_supplier_account": "0",
         "create_time": "2022-02-22T20:34:01.386+08:00",
         "default": 0,
         "description": "description",
         "last_time": "2022-02-22T20:34:01.386+08:00",
         "set_template_id": 11,
         "set_template_version": null
      }
}
```
### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------- |
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
| bk_capacity | int | design capacity |
|bk_parent_id|int|ID of the parent node|
| bk_set_id | int | cluster id |
| bk_service_status | string | Service status: 1/2 (1: open, 2: closed) |
|bk_set_desc|string|cluster description|
| bk_set_env | string | Environment type: 1/2/3 (1: test, 2: experience, 3: official) |
|bk_set_name|string|cluster name|
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |
| default | int | 0 - common cluster, 1 - built-in module collection, default is 0 |
| description | string | Data description |
| set_template_version | array | current version of the cluster template |
| set_template_id| int | cluster template ID |