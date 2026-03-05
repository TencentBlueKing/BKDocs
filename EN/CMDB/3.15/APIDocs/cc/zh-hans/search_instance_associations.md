### Request method

POST


### request address

/api/c/compapi/v2/cc/search_instance_associations/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Generic Model Instance Relationship Query (v3.10.1+)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|------------|---------|------|----------------|
| bk_biz_id | int | No | Business ID, which needs to be provided when querying the mainline model |
| bk_obj_id | string | yes | model ID |
| conditions | object | No| Combination of query conditions, the combination supports AND and OR, can be nested, up to 3 layers, and each layer supports a maximum of 20 OR conditions, not specifying this parameter means matching all (conditions is null) |
| fields | array | No | Specify the fields that need to be returned, the fields that do not have will be ignored, if not specified, all fields will be returned (returning all fields will affect performance, it is recommended to return on demand) |
| page | object | yes | page setting |

#### conditions

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | is | rule operator|
| rules | array | yes | scope condition rules for the selected business |

#### conditions.rules

| Field | Type | Required | Description |
|----------|--------|------|----------------------------------------------------------------|
| field | string | yes | condition field, optional value id, bk_inst_id, bk_obj_id, bk_asst_inst_id, bk_asst_obj_id, bk_obj_asst_id, bk_asst_id |
| operator | string | yes | operator, optional value equal, not_equal, in, not_in, less, less_or_equal, greater, greater_or_equal, between, not_between, etc. |
| value | - | No | The expected value of the condition field, different operators correspond to different value formats, and the array type supports a maximum of 500 elements |

For detailed assembly rules, please refer to: https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md

####page

| Field | Type | Required | Description |
|-------|--------|------|----------------------------------------------------------------|
| start | int | yes | record start position |
| limit | int | yes | limit number of entries per page, maximum 500 |
| sort | string | No | Retrieval sorting, follow the MongoDB semantic format {KEY}:{ORDER}, sort by creation time by default |

### Request parameter example

```json
{
    "bk_app_code":"code",
    "bk_app_secret":"secret",
    "bk_username": "xxx",
    "bk_token":"xxxx",
    "bk_obj_id":"bk_switch",
    "conditions":{
        "condition": "AND",
        "rules": [
            {
                "field": "bk_obj_asst_id",
                "operator": "equal",
                "value": "bk_switch_connect_host"
            },
            {
                "condition": "OR",
                "rules": [
                    {
                         "field": "bk_inst_id",
                         "operator": "in",
                         "value": [2,4,6]
                    },
                    {
                        "field": "bk_asst_id",
                        "operator": "equal",
                        "value": 3
                    }
                ]
            }
        ]
    },
    "fields":[
        "bk_inst_id",
        "bk_asst_inst_id",
        "bk_asst_obj_id",
        "bk_asst_id",
        "bk_obj_asst_id"
    ],
    "page":{
        "start":0,
        "limit":500
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
        "info": [
            {
                "bk_inst_id": 2,
                "bk_asst_inst_id": 8,
                "bk_asst_obj_id": "host",
                "bk_asst_id": "connect",
                "bk_obj_asst_id": "bk_switch_connect_host"
            }
        ]
    }
}
```

### return result parameter

#### response

| Name | Type | Description |
| ------- | ------ | -------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|------|-------|----------------------------------|
| info | array | map array format, return the instance data that meets the conditions |

####info

| Field | Type | Description |
|------|-------|--------------------------------|
| bk_inst_id | int | source model instance id |
| bk_asst_inst_id| int| target model instance id|
| bk_asst_obj_id| string| the object model id of the association relationship|
| bk_asst_id| string| association type id|
| bk_obj_asst_id| string| automatically generated model association relationship id|