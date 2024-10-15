
### Request method

POST


### request address

/api/c/compapi/v2/cc/create_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

create instance

- This interface is only applicable to custom hierarchical models and general model instances, not to model instances such as business, cluster, module, and host

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------------|------------|--------|--------------------------------------------|
| bk_obj_id | string | yes | model ID |
| bk_inst_name | string | yes | instance name |
| bk_biz_id | int | No | Business ID, must be passed when creating a custom mainline hierarchical model instance |
| bk_parent_id | int | No | It must be passed when creating a custom mainline hierarchical model instance, representing the parent hierarchical instance ID|

  Note: When operating a custom mainline hierarchical model instance and using the authority center, for cmdb versions less than 3.9, it is also necessary to pass the metadata parameter containing the business id of the instance, otherwise the authority center authentication will fail. format is
"metadata": {
     "label": {
         "bk_biz_id": "64"
     }
}

Other fields belonging to instance attributes can also be used as input parameters.


### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id":"test3",
    "bk_inst_name":"example18",
    "bk_biz_id":0
}
```

### return result example

```json

{
    "result": true,
    "code": 0,
    "data": {
        "bk_biz_id": 0,
        "bk_inst_id": 1177099,
        "bk_inst_name": "example18",
        "bk_obj_id": "test3",
        "bk_supplier_account": "0",
        "create_time": "2022-01-05T17:28:27.069+08:00",
        "last_time": "2022-01-05T17:28:27.069+08:00",
        "test4": ""
    },
    "message": "success",
    "permission": null,
    "request_id": "87de106ab55549bfbcc46e47ecf5bcc7"
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
|----------- |-----------|----------|
| bk_inst_id | int | instance id |
| bk_biz_id | int | business id |
| bk_inst_name | string | instance name |
| bk_obj_id | string | model id |
| bk_supplier_account| string | Supplier account |
| create_time | string | creation time |
| last_time | string | update time |