### Request method

POST


### request address

/api/c/compapi/v2/itsm/token/verify/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

token verification interface

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| token | string | yes | itsm generates encrypted token |


### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "token": "PF14MnqZcrqqN7tc4mKDt4YVgzf3sagw3vdyvxSgcohF/qZDan0AC3TzKnlcMx53EFWIku2AY5WOIlU4P97bDw=="
}
```

### return result example

```json
{
"message": "success",
"code": 0,
"data": {
"is_passed": true
},
     "result": true
}

```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ----------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | object | return data |

### data

| Field | Type | Description |
| -------------| ------ | -------- |
| is_passed | bool | whether passed |