
### Request Method

POST


### Request address

/api/c/compapi/v2/cc/add_host_to_resource_pool/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Add the host with the specified id to the resource pool according to the host list information.

### Request Parameters



#### Interface Parameters

| Field Type Required Description
|--------------------|--------------|--------|---------------------|
| host_info | object array | yes | host info | directory | int |
| directory | int | no | resource pool directory ID |

#### host_info
| Field | Type | Required | Description |
|-----------------|--------|-----|-------------------------|
| bk_host_innerip | string | yes | host internal ip |
| bk_cloud_id | int | yes | cloud zone id |
bk_host_name | string | no | host name, it can be other attributes | operator | string | yes
| operator | string | No | The main maintainer, it can be other attributes too | bk_comment
| bk_comment | string | No | Comment, it can also be other attributes |

### Example for request parameters

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "host_info": [
         {
             "bk_host_innerip": "127.0.0.1",
             "bk_host_name": "host1",
             "bk_cloud_id": 0,
             "operator": "admin",
             "bk_comment": "comment"
         },
         {
             "bk_host_innerip": "127.0.0.2",
             "bk_host_name": "host2",
             "bk_cloud_id": 0,
             "operator": "admin",
             "bk_comment": "comment"
         }
     ],
     "directory": 1
}
```

### Return Result Example

```json
{
   "result": true,
   "code": 0,
   "message": "success",
   "data": {
       "success": [
           {
               "index": 0,
               "bk_host_id": 6
           },
           {
               "index": 1,
               "bk_host_id": 7
           }
       ]
   },
   "permission": null,
   "request_id": "e43da4ef221746868dc4c837d36f3807"
}

```

### Return Result Parameter Description

#### Response

| name | type | description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | data | object |
| data | object | the data returned by the request | permission | object | permission
| permission | object | permission information |
| request_id | string | request chain id |

#### Data field description

| field | type | description |
| ------- | ----- | ------------------ |
| success | array | Array of successfully added host information |
| error | array | array of host information that failed to be added |

#### Success field description

| field | type | description |
| ---------- | ---- | --------------- |
| index | int | index of successfully added host |
| bk_host_id | int | added host ID |

#### Error field description

| field | type | description |
| ------------- | ------ | --------------- |
| index | int | Add failed host index |
| error_message | string | failure reason |