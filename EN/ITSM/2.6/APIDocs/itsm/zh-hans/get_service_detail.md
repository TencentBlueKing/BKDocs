### Request method

GET


### Request address

/api/c/compapi/v2/itsm/get_service_detail/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Service details query, support querying service details based on the specified service ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---------- | --- | --- | ---- |
| service_id | int | yes | service id, obtained from `data["id"]` field in `service list query` |

### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "service_id": 1
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": {
         "service_id": 5,
         "workflow_id": 15,
         "name": "test3",
         "service_type": "event",
         "desc": "",
         "fields": [
             {
                 "id": 1,
                 "key": "title",
                 "type": "STRING",
                 "name": "Title",
                 "desc": "Please enter a title",
                 "choice": [],
                 "validate_type": "REQUIRE",
                 "regex": "",
                 "meta": {}
             },
             {
                 "id": 96,
                 "key": "CESHILEIXING",
                 "type": "SELECT",
                 "name": "Test Type",
                 "desc": "",
                 "choice": [
                     {
                         "name": "Change",
                         "key": "BIANGENG"
                     },
                     {
                         "name": "Request",
                         "key": "QINGQIU"
                     }
                 ],
                 "validate_type": "REQUIRE",
                 "regex": "EMPTY",
                 "meta": {}
             },
             {
                 "id": 97,
                 "key": "ZIDINGYIBIAOGE",
                 "type": "CUSTOMTABLE",
                 "name": "Custom Form",
                 "desc": "",
                 "choice": [],
                 "validate_type": "REQUIRE",
                 "regex": "EMPTY",
                 "meta": {
                     "columns": [
                         {
                             "choice": [],
                             "display": "input",
                             "key": "TEST",
                             "name": "test"
                         },
                         {
                             "choice": [
                                 {
                                     "name": "a",
                                     "key": "A"
                                 },
                                 {
                                     "name": "b",
                                     "key": "B"
                                 }
                             ],
                             "display": "select",
                             "key": "TEST2",
                             "name": "test2"
                         }
                     ]
                 }
             }
         ]
     },
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ----------------------------------- |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | object | return data |

### data

| Field | Type | Description |
| ------------ | ------ | ---- |
| service_id | int | service id |
| workflow_id | int | service process id |
| name | string | service name |
| service_type | string | service type |
| desc | string | service description |
| fields | array | bill of lading fields |

### fields

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