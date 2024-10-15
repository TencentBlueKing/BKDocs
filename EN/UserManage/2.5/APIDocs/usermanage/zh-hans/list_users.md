### Request method

GET


### Request address

/api/c/compapi/v2/usermanage/list_users/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> Click on the application ID -> Basic information acquisition|
| bk_token | string | No | Current user login status, one of bk_token and bk_username must be valid, and bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user. This field is used to specify the current user when the application is in the whitelist for login-free authentication |


### Function description

Get user list

### Request parameters




#### API parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| lookup_field | String | No | Lookup field, default value is 'username' |
|page | integer | No | page number |
| page_size | integer | No | Number of results per page |
| fields | string | No | Return value fields, eg "username,id" |
| exact_lookups | string | No | List of exact lookups, eg "jack,pony" |
| fuzzy_lookups | string | No | List of fuzzy lookups, eg "jack,pony" |


### Request parameter example

``` json
{
   "bk_app_code": "xxx",
   "bk_app_secret": "xxx",
   "bk_token": "xxx",
   "bk_username": "xxx",
   "lookup_field": "username",
   "page": 1,
   "page_size": 0,
   "fields": "username,id,departments,leader,extras",
   "exact_lookups": "jack,pony",
   "fuzzy_lookups": "jack,pony"
}
```

### Return result example

It is only for indication, please refer to the actual request result
```json
{
     "message": "Success",
     "code": 0,
     "data": [{
       "id":1,
       "username":"admin",
       "departments":[],
       "extras":{},
       "leader":[],
     }],
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

**data** field analysis (the specific field depends on the parameter `fields`)

| Field | Type | Description |
|-----------|-----------|-----------|
|id| int | user ID |
|username|string| username |
|departments|array| A list of departments associated with the user |
|extras| dict | user extension fields |
|leader| array| user association superior |