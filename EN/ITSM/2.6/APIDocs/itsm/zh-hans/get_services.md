### Request method

GET


### request address

/api/c/compapi/v2/itsm/get_services/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Service list query, support query service list according to the specified directory

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ------------ | ------ | --- | ------ |
| catalog_id | int | No | The id of the service catalog, which can be obtained from the `data["id"]` field in the `Service Catalog Query` interface |
| service_type | string | No | Service type: change (change), event (event), request (request), question (question) |
| display_type | string | No | Visible range type: GENERAL (general role table), organizational structure (ORGANIZATION), third-party system (API) |
| display_role | string | No | Visible range: when display_type is ORGANIZATION, it is the ID of the role; when it is GENERAL/API, it is the unique identifier of the system |

### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "catalog_id": 12,
     "service_type": "request",
     "display_type": "GENERAL",
     "display_role": "GENERAL_8"
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": [
         {
             "id": 3,
             "name": "test1",
             "desc": "1",
             "service_type": "request"
         },
         {
             "id": 4,
             "name": "test2",
             "desc": "2",
             "service_type": "request"
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
| ---------- | ------ | ----- |
| id | int | service id |
| name | string | service name |
| desc | string | service description |
| service_type | string | service type |