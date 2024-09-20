### Request method

POST


### request address

/api/c/compapi/v2/cc/search_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the model instance according to the relationship instance

- This interface is only applicable to custom hierarchical models and general model instances, not to model instances such as business, cluster, module, and host

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|--------------------------|
| bk_obj_id | string | yes | model ID |
| page | object | yes | pagination parameters |
| condition | object | No | query condition of model instance with association |
| time_condition | object | No | Query condition for querying model instances by time |
| fields | object | No | Specify the fields returned by the query model instance, the key is the model ID, and the value is the model attribute field to be returned by the query model|

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|-----------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | no | sort field |

#### condition
The user in the example is the model

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| field |string |yes | the value is the field name of the model |
| operator |string |yes | value: $regex $eq $ne |
| value |string |is | the value corresponding to the model field name configured by field |

#### time_condition

| Field | Type | Required | Description |
|--------|--------|-----|--------------------|
| oper | string | is the | operator, currently only supports and |
| rules | array | yes | time query conditions |

#### rules

| Field | Type | Required | Description |
|--------|--------|-----|--------------------------------|
| field | string | yes | the value is the field name of the model |
| start | string | yes | start time in the format of yyyy-MM-dd hh:mm:ss |
| end | string | yes | end time in format yyyy-MM-dd hh:mm:ss |


### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id": "bk_switch",
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_inst_id"
    },
    "fields": {
        "bk_switch": [
            "bk_asset_id",
            "bk_inst_id",
            "bk_inst_name",
            "bk_obj_id"
        ]
    },
    "condition": {
        "user": [
            {
                "field": "operator",
                "operator": "$regex",
                "value": "admin"
            }
        ]
    },
    "time_condition": {
        "oper": "and",
        "rules": [
            {
                "field": "create_time",
                "start": "2021-05-13 01:00:00",
                "end": "2021-05-14 01:00:00"
            }
        ]
    }
}
```

### Return result example

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 2,
        "info": [
            {
                "bk_asset_id": "sw00001",
                "bk_inst_id": 1,
                "bk_inst_name": "sw1",
                "bk_obj_id": "bk_switch"
            },
            {
                "bk_asset_id": "sw00002",
                "bk_inst_id": 2,
                "bk_inst_name": "sw2",
                "bk_obj_id": "bk_switch"
            }
        ]
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ----------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|-----------|-----------|-------------|
| count | int | number of records |
| info | array | model instance actual data |