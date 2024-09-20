### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/edit_shield/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Edit blocking configuration

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ------------- | ------ | ---- | ----------------------- ---------------------------------- |
| bk_biz_id | int | yes | business ID |
| description | string | yes | description |
| begin_time | string | yes | start time |
| end_time | string | yes | end time |
| cycle_config | dict | yes | shielding configuration |
| shield_notice | bool | yes | whether to send shielding notification |
| notice_config | dict | no | notification configuration |
| id | int | yes | shielding configuration ID |
| level | int | No | The level of the blocking policy (if the blocking type is policy blocking, level needs to be passed in) |

#### Shielding configuration (cycle_config)

| Field | Type | Required | Description |
| ---------- | ------ | ---- | -------------------------- -------------------------- |
| begin_time | string | no | start time (every day) |
| end_time | string | No | End time (every day) |
| type | int | Yes | Blocking cycle type (single: 1, daily: 2, weekly: 3, monthly: 4) |
| day_list | list | No | When the cycle is monthly, the days that need to be blocked |
| week_list | list | No | The period is week, and the days need to be blocked |

#### Notification configuration (notice_config)

| Field | Type | Required | Description |
| --------------- | ---- | ---- | ----------------------- ---------------------------------------- |
| notice_time | int | yes | Notification N minutes before blocking starts/ends |
| notice_way | list | yes | notification type, optional values "weixin", "mail", "sms", "voice" |
| notice_receiver | list | Yes | Notifier, including operation and maintenance personnel, product personnel, testers, developers, main and backup personnel, and backup person in charge |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "category":"scope",
     "begin_time":"2019-11-21 00:00:00",
     "end_time":"2019-11-23 23:59:59",
     "cycle_config":{
         "begin_time":"",
         "end_time":"",
         "day_list":[],
         "week_list":[],
         "type":1
     },
     "shield_notice":true,
     "notice_config":{
         "notice_time":5,
         "notice_way":["weixin"],
         "notice_receiver":[
             {
                 "id":"user1",
                 "type":"user"
             }
         ]
     },
     "id": 1,
     "description":"test",
     "bk_biz_id":2
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | Modified blocking policy id |

#### Sample data

```json
{
     "message": "OK",
     "code": 200,
     "data": {
         "id": 1
     },
     "result": true
}
```