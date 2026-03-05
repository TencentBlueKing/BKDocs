
### request method

POST


### request address

/api/c/compapi/v2/cc/update_object/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

update model definition

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|--------------------|--------|-----------------------------------------|
| id | int | no | ID of the object model to use as a condition for update operations |
| modifier | string | No | The person who modified this data last |
| bk_classification_id| string | yes | the classification ID of the object model, which can only be named in English letter sequences|
| bk_obj_name | string | no | the name of the object model |
| bk_obj_icon | string | No | The ICON information of the object model, used for front-end display, the value can refer to [(modleIcon.json)](/static/esb/api_docs/res/cc/modleIcon.json)|
| position | json object string | No | Coordinates for front-end display |



### Request parameter example
```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "id": 1,
    "modifier": "admin",
    "bk_classification_id": "cc_test",
    "bk_obj_name": "cc2_test_inst",
    "bk_obj_icon": "icon-cc-business",
    "position":"{\"ff\":{\"x\":-863,\"y\":1}}"
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
    "data": "success"
}
```

### Return result parameter description

#### response

| Name | Type | Description |
|---|---|---|
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | no data returned |