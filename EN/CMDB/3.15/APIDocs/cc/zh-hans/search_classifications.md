### Request method

POST


### request address

/api/c/compapi/v2/cc/search_classifications/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query Model Classification

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|------------------|

### Request parameter example
``` python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
}
```

### Return result example

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": [
         {
            "bk_classification_icon": "icon-cc-business",
            "bk_classification_id": "bk_host_manage",
            "bk_classification_name": "主机管理",
            "bk_classification_type": "inner",
            "bk_supplier_account": "0",
            "id": 1
         }
     ]
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|----------------------|----------|-----------------------------------------------|
| bk_classification_id | string | Classification ID, English description for internal use of the system |
| bk_classification_name | string | classification name |
| bk_classification_type | string | Used to classify the classification (for example: inner code is built-in classification, empty string is custom classification) |
| bk_classification_icon | string | The icon of the model classification, the value can be referred to, the value can be referred to [(classIcon.json)](resource_define/classIcon.json) |
| id | int | data record ID |
| bk_supplier_account| string| supplier account |