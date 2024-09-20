### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/update_partial_strategy_v2/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Batch update policy local configuration

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------- | ---- | ---- | --------------- |
| edit_data | dict | Yes | Data to be modified |
| ids | list | Yes | List of policy IDs to be modified |
| bk_biz_id | int | yes | business ID |

#### edit_data

| Field | Type | Required | Description |
| ------------------ | ------- | ---------- | ---------- |
| is_enabled | bool | no | enabled status |
| notice_group_list | list | No | Alarm group configuration |
| labels | list | no | policy labels |
| trigger_config | dict | no | trigger condition |
| recovery_config | dict | no | recovery conditions |
| alarm_interval | int | no | notification interval |
| send_recovery_alarm | bool | no | recovery notification |
| message_template | string | no | notification template |
| no_data_config | dict | no | no data configuration |
| target | list | no | monitoring target |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "ids": [
         23121
     ],
     "edit_data": {
         "notice_group_list": [
             4644
         ]
     },
     "bk_biz_id": 883
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ------------------ |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | list | Successfully updated policy id table |

#### Sample data

```json
{
   "result": true,
   "code": 200,
   "message": "OK",
   "data": [
     23121
   ]
}
```