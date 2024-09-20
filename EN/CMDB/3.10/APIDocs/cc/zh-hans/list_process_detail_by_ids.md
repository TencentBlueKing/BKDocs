### Request method

POST


### request address

/api/c/compapi/v2/cc/list_process_detail_by_ids/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the process details corresponding to the process ID under a business (v3.9.8)

### Request parameters



#### Interface parameters

|Field|Type|Required|Description|
|---|---|---|---|
|bk_biz_id|int|Yes| The business ID of the process |
|bk_process_ids|array|Yes|Process ID list, up to 500 |
|fields|array|No|Process attribute list, control which fields are in the process instance information of the returned result, which can speed up interface requests and reduce network traffic transmission<br>If it is empty, return all fields of the process, bk_process_id is a required field|


### Request parameter example

``` json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id":1,
    "bk_process_ids": [
        43,
        44
    ],
    "fields": [
        "bk_process_id",
        "bk_process_name",
        "bk_func_id",
        "bk_func_name"
    ]
}
```

### Return result example
``` json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
        {
            "bk_func_id": "",
            "bk_func_name": "pr1",
            "bk_process_id": 43,
            "bk_process_name": "pr1"
        },
        {
            "bk_func_id": "",
            "bk_func_name": "pr2",
            "bk_process_id": 44,
            "bk_process_name": "pr2"
        }
    ]
}
```

### Return result parameter description

| Name | Type | Description |
|---|---|--- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | array | the data returned by the request |

#### data
| Name | Type | Description |
|---|---|--- |
|bk_func_id|string|function ID|
|bk_func_name|string|process name|
|bk_process_id|int|process id|
|bk_process_name|string|Process alias|