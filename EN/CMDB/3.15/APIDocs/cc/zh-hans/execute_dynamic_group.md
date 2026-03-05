### Request method

POST


### request address

/api/c/compapi/v2/cc/execute_dynamic_group/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query and obtain data according to the specified dynamic grouping rules (V3.9.6)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_id | int | yes | business ID |
| id | string | yes | dynamic grouping primary key ID |
| fields | array | yes | host attribute list, which controls which fields are in the host that returns the result, which can speed up interface requests and reduce network traffic transmission. If the target resource does not have the specified fields, this field will be ignored |
| disable_counter | bool | No | Whether to return the total number of records, the default return |
| page | object | yes | page setting |

####page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | No | Retrieval sort, by default sorted by creation time |

### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_biz_id": 1,
     "disable_counter": true,
     "id": "XXXXXXXX",
     "fields": [
         "bk_host_id",
         "bk_cloud_id",
         "bk_host_innerip",
         "bk_host_name"
     ],
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
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": {
         "count": 1,
         "info": [
             {
                 "bk_obj_id": "host",
                 "bk_host_id": 1,
                 "bk_host_name": "nginx-1",
                 "bk_host_innerip": "10.0.0.1",
                 "bk_cloud_id": 0
             }
         ]
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
|-----------|-----------|-----------|
| count | int | The total number of records that can be matched by the current rule (for the caller to perform pre-pagination, the actual number returned by a single request and whether all the data has been pulled are based on the JSON Array parsing number) |
| info | array | dict array, the actual data of the host, when the dynamic grouping is host query, return the host's own attribute information, and when the dynamic grouping is set query, return the set information |

####data.info
| Name | Type | Description |
| ---------------- | ------ | ---------------|
| bk_obj_id | string | model id |
| bk_host_name | string | hostname | | |
| bk_host_innerip | string | Inner IP |
| bk_host_id | int | host ID |
| bk_cloud_id | int | cloud region |