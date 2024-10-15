### Request method

GET


### request address

/api/c/compapi/v2/itsm/get_ticket_logs/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Document log query, support querying the transaction log of the document according to the document number

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| sn | string | yes | odd number |

### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": "NO2019090XXXXXXXX"
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": {
         "sn": "NO2019090414050083",
         "title": "xxxxx",
         "create_at": "2019-09-04 14:05:00",
         "creator": "xxx(xxx)",
         "logs": [{
"operator": "xxxx",
"message": "Process started",
"source": "WEB",
"operate_at": "2019-08-09 00:41:02"
}, {
"operator": "xxxx",
"message": "xxxx(xxxx) processing node [bill of lading] (submit)",
"source": "WEB",
"operate_at": "2019-08-09 00:43:43"
}, {
"operator": "xxxx",
"message": "xxxx(xxxx) processing node [approval] (passed)",
"source": "WEB",
"operate_at": "2019-08-10 16:39:14"
}, {
"operator": "xxxx",
"message": "xxxx(xxxx) processing node [Director Approval] (passed)",
"source": "WEB",
"operate_at": "2019-08-10 20:35:45"
}, {
"operator": "xxxx",
"message": "xxxx(xxxx) processing node [account creation] (passed)",
"source": "API",
"operate_at": "2019-08-15 10:20:09"
}, {
"operator": "xxxx",
"message": "Document process ended",
"source": "SYS",
"operate_at": "2019-08-15 10:20:09"
}
         ]
     },
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ----------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | object | return data |

### data

| Field | Type | Description |
| ---------------------- | ------ | -------- |
| sn | string | slip sn |
| title | string | document title |
| create_at | string | creation time |
| creator | string | B/L |
| logs | array | log information list |

### logs

| Field | Type | Description |
| --------------- | ---------- | ---------- |
| operator | string | handler |
| message | string | processing message |
| operate_at | string | processing time |
| source | string | Processing method, including: WEB (page operation)/MOBILE (mobile terminal operation)/API (interface operation)/SYS (system operation) |