### Request method

GET


### Request address

/api/c/compapi/v2/itsm/get_service_catalogs/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Service Directory Inquiry

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| has_service | string | No | By default, all service directories are returned. When has_service="true", only the directories bound to service items are returned |
| service_key | string | No | Service item key values: change (change), event (event), request (request), question (question), support filtering the service directory bound to the service through the service item key value |


### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "has_service": "true",
     "service_key": "change"
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": [
         {
             "name": "Root Directory",
             "level": 0,
             "id": 1,
             "key": "root",
             "desc": "",
             "children": [
                 {
                     "name": "Basic configuration",
                     "level": 1,
                     "id": 10,
                     "key": "JICHUPEIZHI",
                     "children": [
                         {
                             "name": "Business Management",
                             "level": 2,
                             "id": 12,
                             "key": "YEWUGUANLI",
                             "children": [],
                             "desc": ""
                         }
                     ],
                     "desc": ""
                 }
             ]
         }
     ],
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
| ------- | ------ | --------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | array | return data |

### data
| Field | Type | Description |
| ------- | ------ | --------------------- |
| id | int | service directory id |
| key | string | unique identifier of the service directory |
| name | string | service directory name |
| level | int | service catalog level |
| desc | string | service catalog description |
| children | array | service directory subdirectories |

### Children
| Field | Type | Description |
| ------- | ------ | --------------------- |
| id | int | service directory id |
| key | string | unique identifier of the service directory |
| name | string | service directory name |
| level | int | service catalog level |
| desc | string | service catalog description |
| children | array | service directory subdirectories |