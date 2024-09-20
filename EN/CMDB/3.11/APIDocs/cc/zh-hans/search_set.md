
### request method

POST


### request address

/api/c/compapi/v2/cc/search_set/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

query cluster

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_biz_id | int | yes | business id |
| fields | array | yes | query fields, all fields are defined by set, these fields include preset fields and user-defined fields |
| condition | dict | yes | query condition, all fields are defined by Set, these fields include preset fields and user-defined fields |
| page | dict | yes | pagination condition |

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | no | sort field |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 2,
    "fields": [
        "bk_set_name"
    ],
    "condition": {
        "bk_set_name": "test"
    },
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_set_name"
    }
}
```

### Return result example

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 1,
        "info": [
            {
                "bk_set_name": "test",
                "default": 0
            }
        ]
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
|-----------|-----------|-----------|
| count | int | number of data |
| info | array | result set, where all fields are attribute fields defined by the cluster |

#### info
| Field | Type | Description |
|-----------|-----------|-----------|
| bk_set_name | string | cluster name |
| default | int | 0 - common cluster, 1 - built-in module collection, default is 0 |