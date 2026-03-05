
### request method

POST


### request address

/api/c/compapi/v2/cc/update_event_subscribe/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

modify subscription

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------------------|----------|--------|--------------------------------------------------|
| bk_supplier_account | string | yes | supplier account |
| subscription_id | int | yes | subscription id |
| subscription_name | string | yes | the name of the subscription |
| system_name | string | yes | the name of the system subscribed to the event |
| callback_url | string | yes | callback function |
| confirm_mode | string | Yes | Event sending success verification mode, optional 1-httpstatus, 2-regular |
| confirm_pattern | string | is the httpstatus or regular pattern of | callback |
| subscription_form | string | yes | events to subscribe to, separated by commas |
| timeout | int | yes | timeout for sending events |


### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "0",
    "subscription_name":"mysubscribe",
    "subscription_id": 2,
    "system_name":"SystemName",
    "callback_url":"http://127.0.0.1:8080/callback",
    "confirm_mode":"httpstatus",
    "confirm_pattern":"200",
    "subscription_form":"hostcreate",
    "timeout":10
}
```

### Return result example

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": "success"
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| data | object | the data returned by the request |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |