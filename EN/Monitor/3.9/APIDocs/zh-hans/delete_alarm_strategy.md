### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/delete_alarm_strategy/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Delete alert policy

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| :-------- | ---- | ---- | ---------- |
| bk_biz_id | int | yes | business ID |
| id | int | yes | Alarm policy ID |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_id": 2,
     "id": 1
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | null | return data |

##### Sample data

```json
{
     "message": "OK",
     "code": 200,
     "data": null,
     "result": true
}
```