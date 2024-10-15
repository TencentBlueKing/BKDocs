### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/search_notice_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query alarm group

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---------- | ---- | ---- | -------- |
| bk_biz_ids | list | no | business ID |
| ids | list | no | notification group ID |

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_ids": [2],
     "ids": [1]
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
| --------------- | ------ | ------------------ |
| bk_biz_id | int | Business ID |
| name | string | name |
| message | string | description |
| notice_way | dict | Notification methods at various levels |
| id | int | Alarm ID |
| notice_receiver | list | Notifier list |
| webhook_url | string | callback address |
| update_time | string | update time |
| update_user | string | update user |
| create_time | string | Creator |

#### notice_receiver - Notifier list

There are two types of notification objects: `user` or `group`.

1. The notification object corresponding to user is the user name
2. group corresponds to the notification group
     1. operator - main person in charge
     2. bk_bak_operator - backup manager
     3. bk_biz_tester - test
     4. bk_biz_productor - product
     5. bk_biz_maintainer - Operation and maintenance
     6. bk_biz_developer - development

#### Sample data

```json
{
   "message": "OK",
   "code": 200,
   "data": [
     {
       "bk_biz_id": 2,
       "update_time": "2019-11-18 17:51:54+0800",
       "notice_receiver": [
         {
           "type": "user",
           "id": "admin"
         }
       ],
       "update_user": "admin",
       "name": "layman",
       "notice_way": {
         "1": ["weixin"],
         "2": ["weixin"],
         "3": ["weixin"]
       },
       "create_time": "2019-11-18 17:51:54+0800",
       "message": "",
       "webhook_url": "",
       "id": 5
     }
   ],
   "result": true
}
```