### Request method

POST


### request address

/api/c/compapi/v2/cc/search_inst_by_object/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query instance information for a given model

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_obj_id | string | yes | custom model ID |
| fields | array | no | specify the fields of the query |
| condition | dict | no | query condition |
| page | dict | no | pagination criteria |

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | no | sort field |

#### fields parameter description

The parameters are all fields defined by the model corresponding to the target instance of the query


#### condition parameter description

The condition parameter is all fields defined by the model corresponding to the target instance of the query

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_obj_id": "xxx",
    "fields": [
    ],
    "condition": {
    },
    "page": {
        "start": 0,
        "limit": 10,
        "sort": ""
    }
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
        "count": 4,
        "info": [
            {
                "bk_inst_id": 0,
                "bk_inst_name": "default area",
                "bk_supplier_account": "123456789"
            }
        ]
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| data | object | the data returned by the request |
| permission | object | permission information |
| request_id | string | request chain id |

#### data

| Field | Type | Description |
|-----------|-----------|-----------|
| count | int | the number of elements in the info collection |
| info | array | instance collection of the queried model |

####info

| Field | Type | Description |
|-----------|-----------|-----------|
| bk_inst_id | int | instance ID |
| bk_inst_name | string | instance name |
| bk_supplier_account | string | Supplier account |