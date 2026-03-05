### Request method

POST


### request address

/api/c/compapi/v2/cc/find_brief_biz_topo_node_relation/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

This interface is used to query the concise relationship information of the upper and lower layers (models) directly associated with an instance of a certain layer (model) in the business topology. (v3.10.1+)


If the business topology level is from top to bottom, it is business, department (custom business level), cluster, and module. but:


1. In the upward direction, you can query the relationship information of the direct superior **department** to which a certain cluster belongs;


2. Go down to query the module relationship information directly associated with the cluster.


Conversely, you cannot directly query the module relationship contained in the custom level instance **a department** through the department, because the department and the module are not directly related.


### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| src_biz_obj | string | Yes | In the business hierarchy, the model ID of the source hierarchy can be "biz", the custom hierarchy model ID (bk_obj_id), "set" and "module". |
| src_ids | array | is the list of instance IDs represented by | src_biz_obj, and the length range of the list is [1,200]|
| dest_biz_obj | string | yes | The business hierarchy model directly (immediately) associated with src_biz_obj. where business("biz")
As an exception, the dest_biz_obj of any src_biz_obj can be "biz". But the two are not allowed to be the same. |
| page | object | Yes | Paging configuration information returned by the queried data|

#### page field description

| Field | Type | Required | Description |
| ----- | ------ | ---- | --------------------- |
| start | int | yes | record start position, starting from 0 |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |
| sort | string | Unavailable | This field is sorted by the associated (dest_biz_obj) identity ID in the interface by default, please do not set this field |



### Request parameter example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "src_biz_obj": "biz",
     "src_ids": [3,302],
     "dest_biz_obj": "nation",
     "page": {
         "start": 0,
         "limit": 2
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
     "data":
     [
         {
             "bk_biz_id": 3,
             "src_id": 3,
             "dest_id": 3812
         },
         {
             "bk_biz_id": 302,
             "src_id": 302,
             "dest_id": 3813
         }
     ]
}
```

### Return result parameter description

#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data description
| Field | Type | Description |
|-----------|------------|------------|
| bk_biz_id | int | ID of the business to which this instance belongs |
| src_id | int | Consistent with the ID list entered in src_ids in the input parameter. Represents the instance ID of the input parameter query model |
| dest_id | int| Instance ID of the model corresponding to dest_biz_obj in the input parameter and directly associated with the instance corresponding to src_ids |

Note:

1. If it is a downward query (query from the lower level to the lower level), it is judged that the way to pull the data by paging is that the returned data array list is empty.


2. For upward query (query from low level to high level), this interface can return all query results at one time, the condition is that the value of page.limit must be >= the length of src_ids.