### Request method

POST


### request address

/api/c/compapi/v2/cc/search_inst_association_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query instance association topology

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ------------------- | ------ | ---- | ---- |
| bk_obj_id | string | yes | model id |
| bk_inst_id | int | yes | instance id |


### Request parameter example

``` python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id":"test",
    "bk_inst_id":1
}
```


### Return result example

```python
{
    "result": true,
    "code": 0,
    "data": [
        {
            "id": "",
            "bk_obj_id": "biz",
            "bk_obj_icon": "icon-cc-business",
            "bk_inst_id": 0,
            "bk_obj_name": "business",
            "bk_inst_name": "",
            "asso_id": 0,
            "count": 1,
            "children": [
                {
                    "id": "6",
                    "bk_obj_id": "biz",
                    "bk_obj_icon": "icon-cc-business",
                    "bk_inst_id": 6,
                    "bk_obj_name": "business",
                    "bk_inst_name": "",
                    "asso_id": 558
                }
            ]
        }
    ],
    "message": "success",
    "permission": null,
    "request_id": "94c85fdf6a9341e18750a44d6e18c127"
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

#### data

| Field | Type | Description |
| ------------ | ------------ | --------------------------- |
| bk_inst_id | int | instance ID |
| bk_inst_name | string | The name of the instance for display |
| bk_obj_icon | string | the name of the model icon |
| bk_obj_id | string | model ID |
| bk_obj_name | string | The name of the model for display |
| children | object array | collection of all associated instances under this model |
| count | int | children contains the number of nodes |

#### children

| Field | Type | Description |
|--------------|--------|--------------------|
|bk_inst_id | int | instance ID |
|bk_inst_name | string | The name of the instance for display |
|bk_obj_icon | string | the name of the model icon |
|bk_obj_id | string | model ID |
|bk_obj_name | string | The name of the model for display |
|asso_id | string | association id |