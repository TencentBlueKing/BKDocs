### Request method

POST


### request address

/api/c/compapi/v2/itsm/operate_node/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Document node operation interface

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| sn | string | yes | odd number
| operator | string | yes | document node processor, document node owner, must be within the range of processors |
| state_id | int | yes | node ID, must be the currently processable node |
| action_type | string | yes | operation type: TRANSITION (approval)/CLAIM (claim)/DISTRIBUTE (dispatch)/DELIVER (transfer order) )/TERMINATE (terminate node and document) |
| fields | array | No | Approval form field list (required for approval operations, not for other operation types)|
| processors_type | string | No| Specified processor type (required for order dispatch and order transfer operations, not for other operation types): GENERAL (general role table), organizational structure (ORGANIZATION), PERSON (individual), STARTER ( Bill of Lading)|
| processors | string | No| Designated processors (required for order dispatching and order transfer operations, and not for other operation types): processors_type is the unique identifier of the system when it is GENERAL, the role ID when it is ORGANIZATION, and blueking when it is PERSON The username of the user, it is empty when STARTER|
| action_message | string | No | Operation remarks (mandatory for order transfer and termination operations, optional for other operation types)|

### fields

| Field | Type | Required | Description |
| ---------------------- | ------ | -------- |------|
| key | string | is | the unique identifier of the field |
| value | string | is | field value |

### Request parameter example 1: Approval

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019110816441094",
     "operator": "zhangsan",
     "action_type": "TRANSITION",
     "action_message": "test",
     "state_id": 4,
     "fields": [
       {
         "key": "SHENPIJIEGUO",
         "value": "TONGYI"
       },
       {
         "key": "SHENPIBEIZHU",
         "value": "hello"
       }
     ]
}
```

### Request parameter example 2: transfer order

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019110710341888",
     "operator": "zhangsan",
     "action_type": "DELIVER",
     "action_message": "test",
     "processors": "zhangsan",
     "processors_type": "PERSON",
     "state_id": 4
}
```


### Request parameter example three: claim

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019110816441094",
     "operator": "zhangsan",
     "action_type": "CLAIM",
     "action_message": "test",
     "state_id": 4
}
```


### Request parameter example 4: terminate

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019110816441094",
     "operator": "zhangsan",
     "action_type": "TERMINATE",
     "action_message": "test",
     "state_id": 4
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