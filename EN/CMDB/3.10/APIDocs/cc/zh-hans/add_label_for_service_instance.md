### Request Method

POST


### Request address

/api/c/compapi/v2/cc/add_label_for_service_instance/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN) that can be obtained from the BlueKing Zhiyun Developer Center -> click on the application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained by cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of application-free login authentication, use this field to specify the current user |


### Function Description

Add a label to the service instance based on the service instance id and the set label.

### Request Parameters



#### Interface Parameters

| Field Type Required Description
|----------------------|------------|--------|-----------------------|
|instance_ids|array| is |service instance ID|
|labels|object|is |Added Label|
| bk_biz_id | int | yes | Business ID |

#### labels field description
- Key validation rule: `^[a-zA-Z]([a-z0-9A-Z\-_.]*[a-z0-9A-Z])?$`.
- value validation rule: `^[a-z0-9A-Z]([a-z0-9A-Z\-_.]*[a-z0-9A-Z])?$`

### Request parameter example

```Python
{
   "bk_app_code": "esb_test",
   "bk_app_secret": "xxx",
   "bk_username": "xxx",
   "bk_token": "xxx",
   "bk_biz_id": 1,
   "instance_ids": [59, 62],
   "labels": {
     "key1": "value1",
     "key2": "value2"
   }
}
```

### return result example

```Python
{
   "result": true,
   "code": 0,
   "message": "success",
   "permission": null,
   "request_id": "e43da4ef221746868dc4c837d36f3807",
   "data": null

}
```

### Return result description

#### Response

| Name | Type | Description |
|---|---|---|
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure | | permission | object |
| permission | object | permission information |
| request_id | string | Request chain id |
| data | object | the data returned by the request | | permission | object | permission information