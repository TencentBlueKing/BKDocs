### Request method

GET


### Request address

/api/c/compapi/v2/usermanage/retrieve_department/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | Yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> Click on the application ID -> Basic information acquisition|
| bk_token | string | No | Current user login status, one of bk_token and bk_username must be valid, and bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user. This field is used to specify the current user when the application is in the whitelist for login-free authentication |


### Function description

Query department specific information

### Request parameters




#### API parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| id | string | Yes | Query the id of the target organization, eg 1122 |
| fields | string | No | Return fields, eg "name,id" |


### Request parameter example

Find the organization whose id is 1122, and only return the name and id fields
``` json
{
   "bk_app_code": "xxx",
   "bk_app_secret": "xxx",
   "bk_token": "xxx",
   "bk_username": "xxx",
   "id": 1122,
   "fields": "name,id"
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
       "name":"Head Office",
       "has_children":true,
       "full_name": "headquarters",
       "children": [],
       "parent": null
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
|data| array| Result, please refer to the returned result example |

**data** Field analysis (the specific field depends on the parameter `fields`)

| Field | Type | Description |
|-----------|-----------|-----------|
|id| int | Department ID |
|name|string| Department name |
|has_children|bool| Whether to include sub-departments |
|full_name| string | Full path of department |
|children| array| User-related subdepartments |
|parent| object | The parent department of this department |