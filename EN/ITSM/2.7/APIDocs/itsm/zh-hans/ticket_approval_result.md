### Request method

POST


### request address

/api/c/compapi/v2/itsm/ticket_approval_result/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Document details query, support to query the details of the document according to the tracking number (carrying basic information and bill of lading information)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| sn | list | yes | odd number |



### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sn": ["NO2019090XXXXXXXX"]
}
```

### return result example

```json
{
     "result": true,
     "code": 0,
     "message": "success",
     "data": [{
         "sn": "REQ20200831000005",
         "title": "Test built-in approval",
         "ticket_url": "https://***",
         "current_status": "FINISHED",
         "updated_by": "xx,xxx",
         "update_at": "2020-08-31 20:57:22",
         "approve_result": true
     }]
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
| ---------------------- | ------ | -------- |
| sn | string | odd number |
| title | string | document title |
| current_status | string | Current status of the document, RUNNING (processing)/FINISHED (ended)/TERMINATED (terminated) |
| ticket_url | string | ticket address |
| comment_id | string | document comment id |
| updated_by | string | last updated by |
| update_at | string | Last update time |
| approve_result | boolean| Approval result, True means passed, False means rejected|