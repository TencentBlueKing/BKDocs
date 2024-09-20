### Request Method

POST


### Request address

/api/c/compapi/v2/cc/add_host_to_resource/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Add a host to the resource pool

### Request parameters



#### Interface Parameters

| Field Type Required Description
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | supplier account |
| host_info | dict | yes | host info |
| bk_biz_id | int | No | Business ID |

#### host_info

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_host_innerip | string | yes | host internal ip |
| import_from | string | yes | host import source, imported in api mode is 3 |
| bk_cloud_id | int | yes | cloud zone ID |

### Example for request parameters
```python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_supplier_account": "123456789",
     "bk_biz_id": 3
     "host_info": {
         "0": {
             "bk_host_innerip": "10.0.0.1",
             "bk_cloud_id": 0,
             "import_from": "3"
         }
     }
}
```
The "0" of host_info in the example indicates the number of lines that can be incremented sequentially.
### return result example

```Python

{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": {}
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