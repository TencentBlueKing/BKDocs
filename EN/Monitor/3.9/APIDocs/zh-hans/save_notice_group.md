### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/save_notice_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Save alarm group

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------------- | ------ | ---- | ---------------------------- |
| bk_biz_id | int | yes | business ID |
| name | string | yes | name |
| message | string | yes | description |
| webhook_url | string | no | callback address |
| notice_way | dict | Yes | Notification methods at each level |
| id | int | no | Alarm group ID, create it if it does not exist |
| notice_receiver | list | yes | notification object list |
| wxwork_group | dict | No | Enterprise WeChat robot |

#### notice_receiver - list of notification objects

There are two types of notification objects: `user` or `group`.

1. The notification object corresponding to user is the user name
2. group corresponds to the notification group
    1. operator - main person in charge
    2. bk_bak_operator - backup manager
    3. bk_biz_tester - test
    4. bk_biz_productor - product
    5. bk_biz_maintainer - Operation and maintenance
    6. bk_biz_developer - development

#### notice_way - notification method

Notification methods for each alarm level

Basic notification methods are:

*weixin
*mail
* voice
*sms

#### Sample data

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_biz_id": 2,
     "notice_receiver": [
         {
             "type": "user",
             "id": "admin"
         }
     ],
     "name": "layman",
     "notice_way": {
         "1": ["weixin"],
         "2": ["weixin"],
         "3": ["weixin"]
     },
     "webhook_url": "https://www.qq.com",
     "message": "Test notification",
     "id": 1,
     "wxwork_group": {
         "1": "Group session ID",
         "2": "Group session ID",
         "3": "Group session ID"
     }
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
| id | int | Alarm ID |

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