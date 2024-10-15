### Request Method

POST


### Request address

/api/c/compapi/v2/cc/batch_create_instance_association/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

  Create generic model instance associations in batches (v3.10.2+)

### Request Parameters



#### Interface Parameters

| parameter | type | required | description |
| -------------- | ------ | ---- | ------------------- -- |
| bk_obj_id | string | yes | source model id |
| bk_asst_obj_id | string | yes | target model id |
| bk_obj_asst_id | string | yes | the unique id of the relationship between models |
| details | array | yes | batch create the content of association relationships, no more than 200 relationships |

#### details

| parameter | type | required | description |
| --------------- | ------ |- | ---- | -------------- |
| bk_inst_id | int | yes | source model instance id |
| bk_asst_inst_id | int | yes | target model instance id |

#### Request Parameter Example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_obj_id": "bk_switch",
     "bk_asst_obj_id": "host",
     "bk_obj_asst_id": "bk_switch_belong_host",
     "details":[
         {
             "bk_inst_id": 11,
             "bk_asst_inst_id": 21
         },
         {
             "bk_inst_id": 12,
             "bk_asst_inst_id": 22
         }
     ]
}
```

### Return Result Example

```json
{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": {
         "success_created": {
             "0":73
         },
         "error_msg": {
             "1":"Association instance does not exist"
         }
     }
}
```

### Return Result Parameter Description

#### Response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | permission | object |
| permission | object | permission information |
| request_id | string | Request chain id |
| data | object | The data returned by the request.

#### data

| field | type | description |
| -------------- | ---- | ----------------------------------------------------------- |
| success_created | map | The key is the instance relationship index in the parameter details array, and the value is the id of the successfully created instance relationship |
| error_msg | map | The key is the instance relationship index in the parameter details array, and the value is the error message |