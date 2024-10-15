### Request method

POST


### request address

/api/c/compapi/v2/cc/find_instance_association/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the instance relationship of the model.

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|--------------------------|
| condition | object | Yes | query condition |
| bk_obj_id | string | YES | source model id(v3.10+)|


#### condition

| Field | Type | Required | Description |
|---------------------|------------|--------|--------------------------|
| bk_obj_asst_id | string | Yes | the unique id of the model association |
| bk_asst_id | string | NO | unique id of the association type|
| bk_asst_obj_id | string | NO | object model id|


### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "condition": {
         "bk_obj_asst_id": "bk_switch_belong_bk_host",
         "bk_asst_id": "",
         "bk_asst_obj_id": ""
     },
     "bk_obj_id": "xxx"
}
```

### return result example

```json
{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": [{
         "id": 481,
         "bk_obj_asst_id": "bk_switch_belong_bk_host",
         "bk_obj_id": "switch",
         "bk_asst_obj_id": "host",
         "bk_inst_id": 12,
         "bk_asst_inst_id": 13
     }]
}

```


### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ----------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|------------|----------|--------------|
|id|int|the association's unique id|
| bk_obj_asst_id| string| automatically generated model association relationship id.|
| bk_obj_id| string| the source model id of the association relationship |
| bk_asst_obj_id| string| the object model id of the association relationship|
| bk_inst_id| int| source model instance id|
| bk_asst_inst_id| int| target model instance id|