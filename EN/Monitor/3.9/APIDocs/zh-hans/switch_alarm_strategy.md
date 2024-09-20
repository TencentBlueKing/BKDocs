### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/switch_alarm_strategy/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Switch alarm strategy

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ---- | ---- | ---------- |
| ids | list | yes | policy ID list |
| is_enabled | bool | yes | whether to enable |

#### Parameter example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "ids": [80],
     "is_enabled": true
}
```

### Response parameters

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |
| request_id | string | request ID |

#### data parameter description

| Field | Type | Description |
| --------- | ------ | ---------- |
| ids | list | List of existing policy IDs |

#### Parameter example

```json
{
  "result": true,
     "code": 200,
     "data": {
     "ids": [
             80
         ]
     },
     "message": "ok",
     "request_id": "eafafwafw1212241212513wafafafw"
}
```