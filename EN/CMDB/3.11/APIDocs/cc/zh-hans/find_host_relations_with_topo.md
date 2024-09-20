### Request method

POST


### request address

/api/c/compapi/v2/cc/find_host_relations_with_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

According to the business topology instance node, query the host relationship information under the instance node

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|-----------------------------|
| page | dict | is | query condition |
| fields | array | yes | host attribute list, control which fields are in the host that returns the result, please fill in as required, can be bk_biz_id, bk_host_id, bk_module_id, bk_set_id, bk_supplier_account|
| bk_obj_id | string | yes | the model ID of the topology node, which can be a custom hierarchical model ID, set, module, etc., but not a business |
| bk_inst_ids | array | yes | the instance ID of the topology node, up to 50 instance nodes are supported |
| bk_biz_id | int | yes | business id |

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |
| sort | string | no | sort field |

### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_biz_id": 1,
     "page": {
         "start": 0,
         "limit": 10
     },
     "fields": [
         "bk_module_id",
         "bk_host_id"
     ],
     "bk_obj_id": "province",
     "bk_inst_ids": [10,11]
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
       "count": 1,
       "info": [
           {
               "bk_host_id": 2,
               "bk_module_id": 51
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
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|-----------|-----------|-----------|
| count | int | number of records |
| info | array | host relationship information |

####info
| Field | Type | Description |
|-----------|-----------|-----------|
| bk_host_id | int | host id |
| bk_module_id | int | module id |