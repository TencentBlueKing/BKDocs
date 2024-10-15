### Request method

POST


### request address

/api/c/compapi/v2/cc/search_business/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query business

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| fields | array | No | Specifies the field to query. The parameter is any attribute of the business. If you do not fill in the field information, the system will return all the fields of the business |
| condition | dict | No | Query condition, the parameter is any attribute of the business, if not written, it means to search all data, (historical legacy field, please do not continue to use, please use biz_property_filter) |
| biz_property_filter| object| No| Business attribute combination query conditions |
| page | dict | no | pagination criteria |

Note: There are two types of transactions, unfiled transactions and archived transactions.
- To query archived business, please add condition `bk_data_status:disabled` in condition.
- If you want to query unarchived business, please do not include the field "bk_data_status", or add the condition `bk_data_status: {"$ne":disabled"}` in condition.
- Only one of the two parameters `biz_property_filter` and `condition` can take effect, and the parameter `condition` is not recommended to continue to use.
- The number of array elements involved in the parameter `biz_property_filter` does not exceed 500. The number of `rules` involved in the parameter `biz_property_filter` does not exceed 20. Parameter `biz_property_filter`
The nesting level cannot exceed 3 levels.

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | No | Sorting field, by adding - in front of the field, such as sort:&#34;-field&#34; can indicate descending order according to field |

### Request parameter example
```python
{
    "bk_app_code":"esb_test",
    "bk_app_secret":"xxx",
    "bk_username": "xxx",
    "bk_token":"xxx",
    "bk_supplier_account":"123456789",
    "fields":[
        "bk_biz_id",
        "bk_biz_name"
    ],
    "biz_property_filter":{
        "condition":"AND",
        "rules":[
            {
                "field":"bk_biz_maintainer",
                "operator":"equal",
                "value":"admin"
            },
            {
                "condition":"OR",
                "rules":[
                    {
                        "field":"bk_biz_name",
                        "operator":"in",
                        "value":[
                            "test"
                        ]
                    },
                    {
                        "field":"bk_biz_id",
                        "operator":"equal",
                        "value":1
                    }
                ]
            }
        ]
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":""
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
                "bk_biz_id": 1,
                "bk_biz_name": "esb-test",
                "default": 0
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
| count | int | number of records |
| info | array | business actual data |

#### info
| Field | Type | Description |
|-----------|-----------|-----------|
| bk_biz_id | int | business id |
| bk_biz_name | string | business name |
|default | int | indicates business type |