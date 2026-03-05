
### Request method

POST


### request address

/api/c/compapi/v2/cc/search_objects/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query models based on optional criteria

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|----------------------------------------------------------|
| creator | string | No | The creator of this data |
| modifier | string | No | The person who modified this data last |
| bk_classification_id | string | No | The classification ID of the object model, which can only be named with English letter sequences |
| bk_obj_id | string | No | The ID of the object model, which can only be named with a sequence of English letters |
| bk_obj_name | string | No | The name of the object model, used for presentation, can use any language that humans can read | |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "creator": "user",
    "modifier": "user",
    "bk_classification_id": "test",
    "bk_obj_id": "biz"
    "bk_obj_name": "aaa"
}
```

### Return result example

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
        {
            "bk_classification_id": "bk_organization",
            "create_time": "2018-03-08T11:30:28.005+08:00",
            "creator": "cc_system",
            "description": "",
            "id": 4,
            "bk_ispaused": false,
            "ispre": true,
            "last_time": null,
            "modifier": "",
            "bk_obj_icon": "icon-XXX",
            "bk_obj_id": "XX",
            "bk_obj_name": "XXX",
            "position": "{\"test_obj\":{\"x\":-253,\"y\":137}}",
            "bk_supplier_account": "0"
        }
    ]
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------------ |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|--------------------|--------------------|---------------------------------------------------------------------------------------------------|
| id | int | ID of the data record |
| creator | string | The creator of this data |
| modifier | string | The person who modified this data last |
| bk_classification_id | string | The classification ID of the object model, which can only be named with English alphabet sequences |
| bk_obj_id | string | The ID of the object model, which can only be named with English alphabet sequences |
| bk_obj_name | string | The name of the object model, used for display |
| bk_supplier_account | string | Supplier account |
| bk_ispaused | bool | Whether to disable, true or false |
| ispre | bool | whether it is pre-defined, true or false |
| bk_obj_icon | string | ICON information of the object model, used for front-end display, the value can refer to [(modleIcon.json)](/static/esb/api_docs/res/cc/modleIcon.json)|
| position | json object string | coordinates for front-end display |
| description | string | Description of the data                  |