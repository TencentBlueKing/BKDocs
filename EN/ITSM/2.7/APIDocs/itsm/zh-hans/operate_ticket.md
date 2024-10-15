### Request method

POST


### request address

/api/c/compapi/v2/itsm/operate_ticket/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Document Operation Interface

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| sn | string | yes | odd number
| operator | string | yes | document processor, must be within the scope of the processor |
| action_type | string | yes | action type: SUSPEND/UNSUSPEND/WITHDRAW/TERMINATE|
| action_message | string | No | Operation remarks (required for pending and terminated operations, optional for other types of operations)|


### Request parameter example 1: pending

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019100818365320",
     "operator": "zhangsan",
     "action_type": "SUSPEND",
     "action_message": "test"
}
```

### Request parameter example 2: recovery

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019100818365320",
     "operator": "zhangsan",
     "action_type": "UNSUSPEND",
     "action_message": "test"
}
```

### Request parameter example 3: cancel order

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019100818365320",
     "operator": "zhangsan",
     "action_type": "WITHDRAW",
     "action_message": "test"
}
```
### Request parameter example 4: terminate

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019100818365320",
     "operator": "zhangsan",
     "action_type": "TERMINATE",
     "action_message": "test"
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": [],
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ----------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | object | return data, empty |