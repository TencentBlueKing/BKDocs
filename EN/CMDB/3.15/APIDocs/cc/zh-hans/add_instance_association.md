### Request Method

POST


### Request address

/api/c/compapi/v2/cc/add_instance_association/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Adds a relationship between model instances.

### Request Parameters



#### Interface Parameters

| Field Type Required Description
|----------------------|------------|--------|------------------------------|
| bk_obj_asst_id | string | Yes | The unique id of the association between models| | bk_inst_id | Field | Type | Required | Description
| bk_inst_id | int64 | Yes | Source model instance id|
| bk_asst_inst_id | int64 | Yes | target model instance id|
| metadata | object | Yes | metadata |


metadata params

| Field | Type | Required | Description |
|---------------------|------------|--------|-----------------------------|
| label | string map | Yes | label information |


Label Parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|-----------------------------|
| bk_biz_id | string | Yes | Business ID |

### Request parameter example

```json
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_obj_asst_id": "bk_switch_belong_bk_host",
     "bk_inst_id": 11,
     "bk_asst_inst_id": 21,
     "metadata": {
         "label": {
             "bk_biz_id": "1"
         }
     }
}
```

### Return Result Example

```json
{
     "result": true,
     "code": 0,
     "message": "",
     "data": {
         "id": 1038
     },
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
}

```

### Return Result Parameter Description

#### Response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | data | object |
| data | object | the data returned by the request | permission | object | permission
| permission | object | permission information |
| request_id | string | request chain id |

#### Data

| field | type | description |
|------------|----------|--------------|
|id|int64|Newly added instance relationship identity id|