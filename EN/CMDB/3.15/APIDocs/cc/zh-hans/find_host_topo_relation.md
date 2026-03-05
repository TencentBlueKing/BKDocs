### Request method

POST


### request address

/api/c/compapi/v2/cc/find_host_topo_relation/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Get the relationship between the host and the topology

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
  bk_biz_id| int| is |business ID|
| bk_set_ids|array | No| A list of cluster IDs, up to 200|
| bk_module_ids|array | No| A list of module IDs, up to 500|
| bk_host_ids|array | No | Host ID list, up to 500 |
| page| object| is |page information|

#### page field description

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
|start|int|No|Get data offset position|
|limit|int| is the limit on the number of data in the past, it is recommended to be 200|

### Request parameter example

```python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "page": {
         "start": 0,
         "limit": 10
     },
     "bk_biz_id": 2,
     "bk_set_ids": [1, 2],
     "bk_module_ids": [23, 24],
     "bk_host_ids": [25, 26]
}
```

### return result example

```python

{
     "result": true,
     "code": 0,
     "data": {
         "count": 2,
         "data": [
             {
                 "bk_biz_id": 2,
                 "bk_host_id": 2,
                 "bk_module_id": 2,
                 "bk_set_id": 2,
                 "bk_supplier_account": "0"
             },
             {
                 "bk_biz_id": 1,
                 "bk_host_id": 1,
                 "bk_module_id": 1,
                 "bk_set_id": 1,
                 "bk_supplier_account": "0"
             }
         ],
         "page": {
             "limit": 10,
             "start": 0
         }
     },
     "message": "success",
     "permission": null,
     "request_id": "f5a6331d4bc2433587a63390c76ba7bf"
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

#### data field description

| Name | Type | Description |
|---|---|---|
| count| int| number of records |
| data| object array | Detailed data list of hosts and clusters, modules, and clusters under business |
| page | object | page |

#### data.data field description
| Name | Type | Description |
|---|---|---|
| bk_biz_id | int | business ID |
| bk_set_id | int | cluster ID |
| bk_module_id | int | module ID |
| bk_host_id | int | host ID |
| bk_supplier_account | string | Supplier account |

#### data.page field description
| Name | Type | Description |
|---|---|---|
|start|int|data offset position|
|limit|int|Limit on the number of past data|