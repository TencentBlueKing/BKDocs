
### request method

GET


### request address

/api/c/compapi/v2/itsm/get_ticket_status/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Document status query, support querying the status of the document according to the document number (carrying basic information)

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
         "ticket_url": "https://blueking.com/#/commonInfo?id=6&activeNname=all&router=request",
         "operations": [
             {
                 "can_operate": true,
                 "name": "Cancel order",
                 "key": "WITHDRAW"
             },
             {
                 "can_operate": true,
                 "name": "Restore",
                 "key": "UNSUSPEND"
             }
         ],
         "current_status": "SUSPENDED",
         "current_steps": [
             {
                 "name": "Legal Approval",
                 "state_id": 4,
                 "status": "RUNNING",
                 "action_type": "TRANSITION",
                 "processors_type": "PERSON",
                 "processors": "zhangsan",
                 "operations": [
                     {
                         "can_operate": true,
                         "name": "Submit",
                         "key": "TRANSITION"
                     },
                     {
                         "can_operate": true,
                         "name": "Transfer order",
                         "key": "DELIVER"
                     },
                     {
                         "can_operate": true,
                         "name": "Termination",
                         "key": "TERMINATE"
                     }
                 ],
                 "fields": [
                     {
                         "workflow_id": 1,
                         "meta": {},
                         "id": 8,
                         "regex": "EMPTY",
                         "api_instance_id": 0,
                         "type": "RADIO",
                         "source_uri": "",
                         "validate_type": "REQUIRE",
                         "source_type": "CUSTOM",
                         "key": "SHENPIJIEGUO",
                         "choice": [
                             {
                                 "name": "Agree",
                                 "key": "TONGYI"
                             },
                             {
                                 "name": "Reject",
                                 "key": "JUJUE"
                             }
                         ],
                         "desc": "",
                         "name": "Approval Results",
                         "is_readonly": false,
                         "custom_regex": "",
                         "state_id": 4
                     },
                     {
                         "workflow_id": 1,
                         "meta": {},
                         "id": 9,
                         "regex": "EMPTY",
                         "api_instance_id": 0,
                         "type": "TEXT",
                         "source_uri": "",
                         "validate_type": "REQUIRE",
                         "source_type": "CUSTOM",
                         "key": "SHENPIBEIZHU",
                         "choice": [],
                         "desc": "",
                         "name": "Approval Remarks",
                         "is_readonly": false,
                         "custom_regex": "",
                         "state_id": 4
                     }
                 ]
             }
         ],
         "is_commented": false
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
| current_status | string | The current status of the document, RUNNING (processing)/FINISHED (ended)/TERMINATED (terminated)/SUSPENDED (suspended)/REVOKED (revoked) |
| current_steps | array | list of current steps of the document |
| operations | array | list of operations currently supported by the document |
| is_commented | bool | Whether the document has been commented |
| ticket_url | string | Ticket details link |


### operations (operations supported by documents)

| Field | Type | Description |
| ------------- | ------ | ------- |
| key | string | Operation identifier, including: SUSPEND (suspend)/UNSUSPEND (resume)/WITHDRAW (undo)/TERMINATE (terminate node and document) |
| name | string | operation name |
| can_operate | string | Can operate (extended field, always true) |

### current_steps (current steps)

| Field | Type | Description |
| --------------- | ---------- | ---------- |
| name | string | step name |
| action_type | string | Action type: TRANSITION (approval)/DISTRIBUTE (distribution)/CLAIM (claim)/AUTOMATIC (automatic processing) |
| processors | string | list of processors |
| processors_type | string | Processor type: CMDB (cmdb role)/GENERAL (general role)/PERSON (individual)/STARTER (bill of lading person)/OPEN (unlimited) |
| state_id | int | node ID |
| status | string | node status |
| operations | array | list of operations supported by the current step of the document |
| fields | array | list of form fields in the current step of the document |

### operations (operations supported by nodes)

| Field | Type | Description |
| ------------- | ------ | ------- |
| key | string | Operation identifier, including: TRANSITION (approval)/CLAIM (claim)/DISTRIBUTE (dispatch order)/DELIVER (transfer order)/TERMINATE (termination node and document) |
| name | string | operation name |
| can_operate | string | Can operate (extended field, always true) |


### fields (node fields)

| Field | Type | Description |
| ------------- | ------ | ------- |
| id | int | field id |
| key | string | field unique identifier |
| type | string | field type |
| name | string | field name |
| desc | string | field description |
| choice | array | options |
| validate_type | string | validation rules |
| regex | string | regular check rule |
| meta | object | custom table format |


### type (field type)

| Type Key | Type |
| ------------- | ------ |
| STRING | single line of text |
| STRING | single line of text|
| TEXT | Multi-line text |
| int | number|
| DATE | date |
| DATETIME | time|
| DATETIMERANGE | time interval|
| TABLE | Table |
| SELECT | Single-select drop-down box|
| MULTISELECT | Multi-select drop-down box|
| CHECKBOX | check box |
| RADIO | radio box |
| MEMBERS | Multi-choice personnel selection|
| RICHTEXT | Rich Text |
| FILE | Attachment Upload|
| CUSTOMTABLE | Custom Forms |
| TREESELECT | tree selection|
| CASCADE | Cascading |

### meta

| Field | Type | Description |
| ------- | ----- | --- |
| columns | array | columns |

### columns

| Field | Type | Description |
| ------- | ------ | ---- |
| choice | array | options |
| display | string | display form |
| key | string | unique identifier |
| name | string | first name |


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