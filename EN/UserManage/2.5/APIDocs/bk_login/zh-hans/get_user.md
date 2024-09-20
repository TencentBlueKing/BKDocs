### Request method

GET


### Request address

/api/c/compapi/v2/bk_login/get_user/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> Click on the application ID -> Basic information acquisition|
| bk_token | string | No | Current user login status, one of bk_token and bk_username must be valid, and bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user. This field is used to specify the current user when the application is in the whitelist for login-free authentication |

### Function description

Get user information

### Request parameters



### Request parameter example

```python
{
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_token": "xxx",
}
```
### Return result example

```python
{
     "result": true,
     "code": 0,
     "message": "OK",
     "data": {
         "bk_username": "admin",
         "qq": "12345",
         "bk_role": 1,
         "language": "zh-cn",
         "phone": "12345678911",
         "wx_userid": "",
         "email": "11@qq.com",
         "chname": "admin",
         "time_zone": "Asia/Shanghai"
     }
}
```

### Return result parameter description

| Field | Type | Description |
|-----------|-----------|-----------|
|result| bool | Return result, true means success, false means failure |
|code|int|Return code, 0 means success, other values mean failure|
|message|string|Error message|
|data| array| Result, please refer to the returned result example |

**data**

| Field | Type | Description |
|-----------|-----------|-----------|
| bk_username | string | username |
| qq | string | User QQ |
| language | string | language |
| phone | string | phone number |
| wx_userid | string | Enterprise account user USERID/Pubic account user OPENID |
| email | string | email |
| chname | string | Chinese name |
| time_zone | string | time zone |