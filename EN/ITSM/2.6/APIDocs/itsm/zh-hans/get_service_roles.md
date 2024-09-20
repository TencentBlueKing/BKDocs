### Request method

GET


### request address

/api/c/compapi/v2/itsm/get_service_roles/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

get service role

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| service_id | string | yes | service id, obtained from `data["id"]` field in `service list query` |
| ticket_creator | string | No | Biller, used when instantiating the leader and the biller itself |


### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "service_id": 1,
     "ticket_creator": "admin"
}
```

### return result example

```json
{
"message": "success",
"code": 0,
"data": [{
"id": 92580,
"name": "Node 1",
"processors_type": "GENERAL",
"processors": "xx",
"sign_type": "or"
},
{
"id": 92581,
"name": "Node 2",
"processors_type": "IAM",
"processors": "Rating Managers",
"sign_type": "or"
},
{
"id": 92582,
"name": "Node 3",
"processors_type": "PERSON",
"processors": "xxx",
"sign_type": "and"
}
],
"result": true
}

```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ----------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | list | return data |

### data

| Field | Type | Description |
| ------- | --------- | ----------------------- |
| id | int | node id |
| name | string | node id |
| processors_type | string | processor type |
| processors | string | Processors, use "," to separate multiple |
| sign_type | string |Countersignature type, "or" is an or sign, and any one person passes it, it is passed, "and" is multi-signed, and all approvers pass it to be considered |