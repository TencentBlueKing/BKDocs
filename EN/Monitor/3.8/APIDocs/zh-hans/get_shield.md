
### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/get_shield/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query blocking details

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ---- | ---- | ------ |
| id | int | yes | block ID |
| bk_biz_id | int | yes | business ID |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "id": 1,
     "bk_biz_id": 2
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |

#### data field description

| Field | Type | Description |
|---------------- | ------ | ----------------------------------------------------- |
| bk_biz_id | int | Business ID |
| category | string | Shielding type (scope: "scope", strategy: "strategy", event: "event", alert: "alert") |
| description | string | description |
| begin_time | string | start time |
| end_time | string | end time |
| cycle_config | dict | shielding configuration |
| shield_notice | bool | Whether to send shielding notification |
| notice_config | dict | notification configuration |
| dimension_config | dict | mask dimension |
| id | int | Block ID |
| scope_type | string | scope type |
| status | int | Current status, blocking (1), expired (2), released (3) |

#### Shielding configuration (cycle_config)

| Field | Type | Required | Description |
| ---------- | ------ | ---- | -------------------------------------------- |
| begin_time | string | no | start time (every day) |
| end_time | string | No | End time (every day) |
| type | int | Yes | Blocking cycle type (single: 1, daily: 2, weekly: 3, monthly: 4) |
| day_list | list | No | When the cycle is monthly, the days that need to be blocked |
| week_list | list | No | The period is week, and the days need to be blocked |

#### Notification configuration (notice_config)

| Field | Type | Required | Description |
| --------------- | ---- | ---- | --------------------------------------------------------- |
| notice_time | int | yes | Notification N minutes before blocking starts/ends |
| notice_way | list | yes | notification type, optional values "weixin", "mail", "sms", "voice" |
| notice_receiver | list | Yes | Notifier, including operation and maintenance personnel, product personnel, testers, developers, main and backup personnel, and backup person in charge |

#### Shield dimension (dimension_config)

The shielding dimension is related to the shielding type (category)

##### "scope"

| Field | Type | Required | Description |
| ---------- | ------ | ---- | --------------------------------------- |
| scope_type | string | Yes | Shielding scope, optional values ​​"instance", "ip", "node", "biz" |
| target | list | No | list of instances corresponding to the scope type |
| metric_id | list | no | metric id |

##### "strategy"

| Field | Type | Required | Description |
| ---------- | ------ | ---- | ------------------------ |
| id | list | yes | policy id |
| level | list | no | alarm level |
| scope_type | string | No | Shielding scope, optional values ​​"ip", "node" |
| target | list | No | list of instances corresponding to the scope type |

##### "event"

| Field | Type | Required | Description |
| ---- | ------ | ---- | ------ |
| id | string | yes | event id |

##### "alert"

| Field | Type | Required | Description |
| --------- | ---- | ---- | ------ |
| alert_ids | list | yes | alert id |

> Note: The target in scope and strategy is selected based on scope_type. Instances correspond to instances_id, ip corresponds to {ip, bk_cloud_id}, node corresponds to {bk_obj_id, bk_inst_id}, and biz does not need to pass in anything.

#### Sample data

Range-based blocking
```json
{
    "code": 200,
    "message": "ok",
    "result": true,
    "data": {
        "id": 1,
        "scope_type": "instance",
        "status": 1,
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
        "description":"test",
        "dimension_config":{
            "scope_type":"instance",
            "target":[8]
        },
        "bk_biz_id":2
    }
}

```

Policy-based blocking

```json
{
    "result": true,
    "code": 200,
    "messgae" : "ok",
    "data": {
        "id": 1,
        "scope_type": "instance",
        "status": 1,
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
        "description":"test",
        "dimension_config":{
            "scope_type":"instance",
            "target":[8]
        },
        "bk_biz_id":2
    }
}
```