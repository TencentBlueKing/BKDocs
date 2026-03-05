### Request method

POST


### request address

/api/c/compapi/v2/cc/count_instance_associations/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Model instance relationship quantity query (v3.10.1+)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|------------|---------|------|---------------|
| bk_biz_id | int | No | Business ID, which needs to be provided when querying the mainline model |
| bk_obj_id | string | yes | model ID |
| conditions | object | No| Combination of query conditions, the combination supports AND and OR, can be nested, up to 3 layers, and each layer supports a maximum of 20 OR conditions, not specifying this parameter means matching all (conditions is null) |

#### conditions

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | is | rule operator|
| rules | array | yes | scope condition rules for the selected business |

#### conditions.rules

| Field | Type | Required | Description |
|----------|--------|------|----------|
| field | string | yes | condition field, optional value id, bk_inst_id, bk_obj_id, bk_asst_inst_id, bk_asst_obj_id, bk_obj_asst_id, bk_asst_id |
| operator | string | yes | operator, optional value equal, not_equal, in, not_in, less, less_or_equal, greater, greater_or_equal, between, not_between, etc. |
| value | - | No | The expected value of the condition field, different operators correspond to different value formats, and the array type supports a maximum of 500 elements |

For detailed assembly rules, please refer to: https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md

### Request parameter example

```json
{
     "bk_app_code": "code",
     "bk_app_secret": "secret",
     "bk_username": "xxx",
     "bk_token": "xxxx",
     "bk_obj_id": "bk_switch",
     "conditions": {
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
     }
}
```

### return result example

```json
{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": {
         "count": 1
     }
}
```

### return result parameters

#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|-------|---------|----------------------------|
| count | int | return the number of instance data that meets the condition |