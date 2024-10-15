### Request Method

POST


### Request address

/api/c/compapi/v2/cc/batch_update_host/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Bulk update host properties based on host id and properties (cannot be used to update cloud zone fields in host properties)

### Request Parameters



#### Interface Parameters

| Field |Type| Required |Description|
|---------------------|--------------|--------|------------------------------------|
| update | array | yes | host updated attributes and values, up to 500 |

#### update
| field | type | required | description |
|-----------|--------|--------|-------------------------------------------------------|
| properties | object | yes | The properties and values of the host being updated cannot be used to update the Cloud Zone field in the host properties | bk_host_id
| bk_host_id | int | yes | Host ID to update |

#### properties
| Field | Type | Required | Description |
|--------------|--------|-------|--------------------------------------------------------------|
| bk_host_name | string | No | The host name, it can be other attributes, it cannot be used to update the cloud region field in the host attribute |
| operator | string | No | The main maintainer, it can be other attributes as well, it cannot be used to update the cloud region field in the host attribute |
| bk_comment | string | No | Comment, it can also be other attributes, it cannot be used to update the cloud region field in the host attribute |
| bk_isp_name | string | No | The operator to which it belongs can also be other attributes and cannot be used to update the cloud region field in the host attribute |



### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "update":[
       {
         "properties": {
           "bk_host_name": "batch_update",
           "operator": "admin",
           "bk_comment": "test",
           "bk_isp_name": "1"
         },
         "bk_host_id": 46
       }
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
     "data": null
}
```

#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |
