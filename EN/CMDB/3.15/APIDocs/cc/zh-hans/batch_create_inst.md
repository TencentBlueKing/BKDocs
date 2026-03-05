### Request Method

POST


### Request address

/api/c/compapi/v2/cc/batch_create_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

  Create shared model instances in batches (v3.10.2+)

### Request Parameters



#### Interface Parameters

| parameter | type | required | description |
| -------- | ------ | ---- | ------------------ |
| bk_obj_id | string | yes | the model id used to create, allow creation of instances of common models only |
| details | array | yes | the instance content to create, up to 200, and the content is the attribute information of the model instance |

#### details

| parameter | type | required | description |
| --------------- | ------ |- | ---- | -------------- |
| bk_inst_name | string | yes | instance name |
| bk_asset_id | string | yes | Asset ID |
| bk_sn | string | no | device SN |
| bk_operator | string | no | maintainer |

### Example for request parameters

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_obj_id": "bk_switch",
     "details":[
         {
             "bk_inst_name": "s1",
             "bk_asset_id": "test_001",
             "bk_sn": "00000001",
             "bk_operator": "admin"
         },
         {
             "bk_inst_name": "s2",
             "bk_asset_id": "test_002",
             "bk_sn": "00000002",
             "bk_operator": "admin"
         },
         {
             "bk_inst_name": "s3",
             "bk_asset_id": "test_003",
             "bk_sn": "00000003",
             "bk_operator": "admin"
         }
     ]
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
     "data": {
         "success_created": {
             "1":1001,
             "2":1002
         },
         "error_msg": {
             "0": "Data uniqueness check failed, [bk_asset_id: test_001] duplicated"
         }
     }
}
```
### Return Result Parameter Description

#### Response

| name | type | description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | permission | object |
| permission | object | permission information |
| request_id | string | Request chain id |
| data | object | The data returned by the request.

#### data

| field | type | description |
| -------------- | ---- | ----------------------------------------------------------- |
| success_created | map | The key is the instance index in the parameter details, and the value is the id of the successfully created instance |
| error_msg | map | The key is the index of the instance in the parameter details, and the value is the error message |
