### Request method

GET


### Request address

/api/c/compapi/v2/usermanage/retrieve_user/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> Click on the application ID -> Basic information acquisition|
| bk_token | string | No | Current user login status, one of bk_token and bk_username must be valid, and bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user. This field is used to specify the current user when the application is in the whitelist for login-free authentication |


### Function description

Query user specific details

### Request parameters




#### API parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| id | String | No | Lookup the content of the target user, which can be 'username', 'id', etc., used with lookup_field, see the example below for details |
| lookup_field | String | No | Lookup field, default is 'username', optional unique fields: 'username', 'id' |
| fields | String | No | Return fields, such as "username,id" |


### Request parameter example

Select the user whose username is admin, and only return the username and id fields (default search username, no need to specify lookup_field)
``` json
{
   "bk_app_code": "xxx",
   "bk_app_secret": "xxx",
   "bk_token": "xxx",
   "bk_username": "xxx",
   "id": "admin",
   "lookup_field": "username",
   "fields": "username,id"
}
```

### Return result example

It is only for indication, please refer to the actual request result
```json
{
     "message": "Success",
     "code": 0,
     "data": {
       "id":1,
       "username":"admin",
       "departments":[],
       "extras":{},
       "leader":[]
     },
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
|-----------|-----------|-----------|
|result| bool | Return result, true means success, false means failure |
|code|int|Return code, 0 means success, other values mean failure|
|message|string|Error message|
|data| array| The result is dynamically returned according to the request parameters, you can refer to the above returned result example |

**data** Field analysis (the specific field depends on the parameter `fields`)

| Field | Type | Description |
|-----------|-----------|-----------|
|id| int | user ID |
|username|string| username |
|departments|array| A list of departments associated with the user |
|extras| dict | user extension fields |
|leader| array| user association superior |