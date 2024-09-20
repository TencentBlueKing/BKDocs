### Request method

GET


### request address

/api/c/compapi/v2/itsm/get_ticket_info/


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
         "id": 176,
         "catalog_id": 30,
         "service_id": 18,
         "flow_id": 61,
         "sn": "NO2019090414050083",
         "title": "xxxxx",
         "service_type": "change",
         "create_at": "2019-09-04 14:05:00",
         "current_status": "RUNNING",
         "current_steps": [
                 {
                     "action_type": "TRANSITION",
                     "name": "Review Comments",
                     "processors": "admin",
                     "processors_type": "PERSON",
                     "state_id": 8,
                     "status": "RUNNING"
                 }
         ],
         "comment_id": "",
         "is_commented": false,
         "updated_by": "xxxx",
         "update_at": "2019-09-04 14:05:01",
         "end_at": null,
         "creator": "xxx(xxx)",
         "is_biz_need": false,
         "bk_biz_id": 2,
         "fields": [{
                 "id": 1024,
                 "key": "title",
                 "type": "STRING",
                 "name": "Title",
                 "value": "xx",
                 "display_value": "xx",
                 "desc": "Please enter a title",
             },{
                 "id": 1025,
                 "key": "bk_biz_id",
                 "type": "SELECT",
                 "name": "Title",
                 "value": "2",
                 "display_value": "BlueKing,
                 "desc": "Please enter a title",
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
| id | int | document id |
| catalog_id | int | service catalog id |
| service_id | int | service id |
| flow_id | int | process version id |
| sn | string | odd number |
| title | string | document title |
| current_status | string | Current status of the document, RUNNING (processing)/FINISHED (ended)/TERMINATED (terminated) |
| current_steps | array | current step of document |
| comment_id | string | document comment id |
| is_commented | bool | Whether the document has been commented |
| updated_by | string | last updated by |
| update_at | string | Last update time |
| end_at | string | end time |
| creator | string | B/L |
| create_at | string | creation time |
| is_biz_need | bool | Whether related to business |
| bk_biz_id | int | business id |
| fields | array | B/L node fields |

### current_steps (current steps)

| Field | Type | Description |
| --------------- | ---------- | ---------- |
| name | string | step name |
| action_type | string | Action type: TRANSITION (approval)/DISTRIBUTE (distribution)/CLAIM (claim)/AUTOMATIC (automatic processing) |
| processors | string | list of processors |
| processors_type | string | Processor type: CMDB (cmdb role)/GENERAL (general role)/PERSON (individual)/STARTER (bill of lading person)/OPEN (unlimited) |
| state_id | int | node ID |
| status | string | node status |


### status (node status)

| Field | Type | Description |
| --------------- | ---------- | ---------- |
| WAIT | pending |
| RUNNING | Processing |
| RECEIVING | Pending claim |
| DISTRIBUTING | To be distributed |
| TERMINATED | Terminated |
| FINISHED | Ended |
| FAILED | Execution failed |
| SUSPEND | is suspended |


### fields

| Field | Type | Description |
| --------------- | ---------- | ---------- |
| id | int | field id |
| key | string | field unique identifier |
| type | string | field type |
| name | string | field name |
| desc | string | field description |
| value | string | field value |
| display_value | string | field display value |