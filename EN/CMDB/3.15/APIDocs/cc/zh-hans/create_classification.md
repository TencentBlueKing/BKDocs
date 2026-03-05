### Request method

POST


### request address

/api/c/compapi/v2/cc/create_classification/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Add model classification

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------------|------------|--------|--------------------------------------------|
| bk_classification_id | string | yes | classification ID, English description for internal use of the system |
| bk_classification_name | string | yes | classification name |
| bk_classification_icon | string | no | icon for model classification |



### Request parameter example
```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_classification_id": "cs_test",
    "bk_classification_name": "test_name",
    "bk_classification_icon": "icon-cc-business"
}
```

### return result example

```python

{
    "result": true,
    "code": 0,
    "data": {
        "id": 11,
        "bk_classification_id": "cs_test",
        "bk_classification_name": "test_name",
        "bk_classification_type": "",
        "bk_classification_icon": "icon-cc-business",
        "bk_supplier_account": ""
    },
    "message": "success",
    "permission": null,
    "request_id": "76e9134a953b4055bb55853bb248dcb7"
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

#### data

| Field | Type | Description |
|----------- |-----------|--------------------|
| id | int | ID of new data record |
| bk_classification_id | string | Classification ID, English description for internal use of the system |
| bk_classification_name | string | classification name |
| bk_classification_icon | string | icon for model classification |
| bk_classification_type | string | Used to classify the classification (for example: inner code is built-in classification, empty string is custom classification) |
| bk_supplier_account| string| supplier account|