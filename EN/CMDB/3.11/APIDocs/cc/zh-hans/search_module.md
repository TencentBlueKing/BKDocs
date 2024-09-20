### Request method

POST


### request address

/api/c/compapi/v2/cc/search_module/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

query module

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_biz_id | int | yes | business id |
| bk_set_id | int | no | cluster ID |
| fields | array | yes | query fields, the fields come from the attribute fields defined by the module |
| condition | dict | yes | query condition, the field comes from the attribute field defined by the module |
| page | dict | yes | pagination condition |

####page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit number of entries per page |
| sort | string | no | sort field |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 2,
    "fields": [
        "bk_module_name",
        "bk_set_id"
    ],
    "condition": {
        "bk_module_name": "test"
    },
    "page": {
        "start": 0,
        "limit": 10
    }
}
```

### Return result example

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 2,
        "info": [
            {
                "bk_module_name": "test",
                "bk_set_id": 11,
                "default": 0
            },
            {
                "bk_module_name": "test",
                "bk_set_id": 12,
                "default": 0
            }
        ]
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------- --- |
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
| info | array | result set, where all fields are attribute fields defined by the module |

#### info
| Field | Type | Description |
|-----------|-----------|-----------|
| bk_module_name | string | module name |
| bk_set_id | int | cluster id |
|default | int | indicates the module type |