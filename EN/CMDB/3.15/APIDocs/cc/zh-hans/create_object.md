### Request method

POST


### request address

/api/c/compapi/v2/cc/create_object/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

create model

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------------------------------------------------|
| creator |string | No | The creator of this data |
| bk_classification_id | string | yes | the classification ID of the object model, which can only be named with English letter sequences |
| bk_obj_id | string | Yes | The ID of the object model, which can only be named with English alphabet sequences |
| bk_obj_name | string | yes | the name of the object model, used for presentation, can use any language that can be read by humans | |
| bk_obj_icon | string | No | ICON information of the object model, used for front-end display|


### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "creator": "admin",
    "bk_classification_id": "test",
    "bk_obj_name": "test",
    "bk_obj_icon": "icon-cc-business",
    "bk_obj_id": "test"
}
```


### return result example

```python

{
    "code": 0,
    "permission": null,
    "result": true,
    "request_id": "b529879b85c74e3c91b3d8119df8dbc7",
    "message": "success",
    "data": {
        "description": "",
        "bk_ishidden": false,
        "bk_classification_id": "test",
        "creator": "admin",
        "bk_obj_name": "test",
        "bk_ispaused": false,
        "last_time": null,
        "bk_obj_id": "test",
        "create_time": null,
        "bk_supplier_account": "0",
        "position": "",
        "bk_obj_icon": "icon-cc-business",
        "modifier": "",
        "id": 2000002118,
        "ispre": false
    }
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

#### data

| Field | Type | Description |
|-----------|-----------|-------------------|
| id | int | ID of the newly added data record |
| bk_classification_id | int | Classification ID of the object model |
| creator | string | creator |
| modifier | string | Last Modifier |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |
| bk_obj_id | string | model type |
| bk_obj_name | string | model name |
| bk_obj_icon | string | ICON information of the object model, used for front-end display |
| position | json object string | Coordinates for front-end display /
| ispre | bool | whether it is pre-defined, true or false |