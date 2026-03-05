
### request method

POST


### request address

/api/c/compapi/v2/cc/update_set_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

According to the business id and cluster template id, edit the cluster template under the specified business

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------------- | ------ | ----- | -------------- |
| bk_biz_id | int | yes | business ID |
| set_template_id | int | yes | cluster template ID |
| name | string | and service_template_ids are optional, and both are optional | cluster template name |
| service_template_ids | array | and name are optional, both are optional | service template ID list |


### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "name": "test",
    "bk_biz_id": 20,
    "set_template_id": 6,
    "service_template_ids": [59]
}
```

### Return result example

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
        "version": 0,
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
| ------- | ------ | ------------------------------------- |
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
| name | string | cluster template name |
| bk_biz_id | int | business ID |
| version | int | cluster template version |
| creator | string | creator |
| modifier | string | Last Modifier |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |