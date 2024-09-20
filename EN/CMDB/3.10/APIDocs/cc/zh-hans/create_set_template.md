### Request method

POST


### request address

/api/c/compapi/v2/cc/create_set_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create a cluster template with the specified name under the specified business id, and the created cluster template includes the service template through the specified service template id

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------------- | ------ | ---- | -------------- |
| bk_biz_id | int | yes | business ID |
| name | string | yes | cluster template name |
| service_template_ids | array | yes | list of service template ids |


### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_supplier_account": "0",
     "name": "test",
     "bk_biz_id": 20,
     "service_template_ids": [59]
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
         "id": 6,
         "name": "test",
         "bk_biz_id": 20,
         "creator": "admin",
         "modifier": "admin",
         "create_time": "2019-11-27T17:24:10.671658+08:00",
         "last_time": "2019-11-27T17:24:10.671658+08:00",
         "bk_supplier_account": "0"
     }
}
```

### Return result parameter description

#### response

| Name | Type | Description |
| ------- | ------ | ---------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | ------------ |
| id | int | cluster template ID |
| name | array | cluster template name |
| bk_biz_id | int | business ID |
| creator | string | creator |
| modifier | string | Last Modifier |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |