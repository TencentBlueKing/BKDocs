### Request method

POST


### request address

/api/c/compapi/v2/itsm/create_ticket/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | Application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create document interface

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ------ | --- | -------------------------- |
| service_id | int | no | service id |
| creator | string | yes | document creator |
| fields | array | yes | bill of lading fields |
| fast_approval| boolean | No | Whether it is a single-point fast approval form |
| meta| dict | no | extended information |

### fields

| Field | Type | Required | Description |
| ---------------------- | ------ | -------- |------|
| key | string |yes| the unique identifier of the bill of lading field|
| value | string | yes | bill of lading field value |

### meta

| Field | Type | Required | Description |
| ---------------------- | ------ | -------- |------|
| callback_url | string |No| Callback url, if there is a callback will be triggered|
| state_processors | object |No | Node processor, if there is, it will be set according to this processor when the document is transferred|


### Request parameter example

```json
{
"bk_app_secret": "xxxx",
"bk_app_code": "xxxx",
"bk_token": "xxxx",
"service_id": 17,
"creator": "xxx",
"fields": [{
"key": "title",
"value": "Test built-in approval"
}, {
"key": "APPROVER",
"value": "xx,xxx,xxxx"
}, {
"key": "APPROVAL_CONTENT",
"value": "This is an approval ticket"
}],
"fast_approval": false,
"meta": {
"callback_url": "http://***",
"state_processors": {
"407": "xxx,xxxx"
}
}
}
```

### return result example

```json
{
"result": true,
"message": "success",
"code": 0,
"data": {
"sn": "NO2019090519542603",
"id": 101,
"ticket_url": "http://bk_itsm/#/ticket/detail?id=101"
}
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
| sn | string | odd number |
| id | int | document ID |
| ticket_url | string | ticket link |