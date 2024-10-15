### Request Method

POST


### Request address

/api/c/compapi/v2/cc/batch_update_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Batch Update Object Instances

### Request Parameters



#### Interface Parameters

| Field | Type | Required | Description |
|---------------------|-------------|--------|------------------------------------|
| bk_obj_id | string | yes | model ID |
| update | array| is | the field and value of the instance to update |

#### update
| field | type | required | description |
|--------------|--------|-------|--------------------------------|
| datas | object | yes | the value of the field being updated in the instance | 
| inst_id | int | yes | specify the specific instance of datas to update |

#### datas
| Field | Type | Required | Description |
|--------------|--------|-------|--------------------------------|
| bk_inst_name | string | No | instance name, can be other custom fields |

**datas is an object of type map, key is the field defined by the model corresponding to the instance, and value is the value of the field**.


### Request parameter example

```Python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "xxx",
     "bk_token": "xxx",
     "bk_obj_id": "test",
     "update":[
         {
           "datas": {
             "bk_inst_name": "batch_update"
           },
           "inst_id": 46
          }
         ]
}
```


### return result example

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

#### Response

| name | type | description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | permission | object |
| permission | object | permission information |
| request_id | string | Request chain id |
| data | object | the data returned by the request | | permission | object | permission information