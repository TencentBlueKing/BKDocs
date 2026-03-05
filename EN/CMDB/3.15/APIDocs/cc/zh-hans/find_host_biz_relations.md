### Request method

POST


### request address

/api/c/compapi/v2/cc/find_host_biz_relations/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query business-related information based on the host ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|----------------------------|
| bk_host_id | array | yes | host ID array, the number of IDs cannot exceed 500 |
| bk_biz_id | int | No | Business ID |

### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_biz_id": 1,
     "bk_host_id": [
         3,
         4
     ]
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
   "data": [
     {
       "bk_biz_id": 3,
       "bk_host_id": 3,
       "bk_module_id": 59,
       "bk_set_id": 11,
       "bk_supplier_account": "0"
     },
     {
       "bk_biz_id": 3,
       "bk_host_id": 3,
       "bk_module_id": 60,
       "bk_set_id": 11,
       "bk_supplier_account": "0"
     },
     {
       "bk_biz_id": 3,
       "bk_host_id": 3,
       "bk_module_id": 61,
       "bk_set_id": 12,
       "bk_supplier_account": "0"
     },
     {
       "bk_biz_id": 3,
       "bk_host_id": 4,
       "bk_module_id": 60,
       "bk_set_id": 11,
       "bk_supplier_account": "0"
     }
   ]
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
|---|---|---|
| bk_biz_id| int| business ID |
| bk_host_id| int | host ID |
| bk_module_id| int| module ID |
| bk_set_id| int | cluster ID |
| bk_supplier_account| string| supplier account |