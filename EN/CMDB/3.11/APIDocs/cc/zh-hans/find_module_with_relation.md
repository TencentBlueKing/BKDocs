
### Request method

POST


### request address

/api/c/compapi/v2/cc/find_module_with_relation/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query modules under business according to conditions (v3.9.7)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_id | int | yes | business ID |
| bk_set_ids | array | No | Cluster ID list, up to 200 |
| bk_service_template_ids | array | no | list of service template IDs |
| fields | array | yes | module attribute list, control which fields are included in the module information of the returned result |
| page | object | yes | page information |

#### page field description

| Field | Type | Required | Description |
| ----- | ------ | ---- | --------------------- |
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 2,
    "bk_set_ids":[1,2],
    "bk_service_template_ids": [3,4],
    "fields":["bk_module_id", "bk_module_name"],
    "page": {
        "start": 0,
        "limit": 10
    }
}
```

### return result example

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
                "bk_module_id": 8,
                "bk_module_name": "license"
            },
            {
                "bk_module_id": 12,
                "bk_module_name": "gse_proc"
            }
        ]
    }
}
```
### Return result parameter description
#### response
| Name | Type | Description |
| ------- | ------ | ------------------------------------ |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

Data field description:

| Name | Type | Description |
| -------- | ------------ | ------------------ |
| count | int | number of records |
| info | object array | module actual data |