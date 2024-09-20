
### Request method

GET


### request address

/api/c/compapi/v2/itsm/get_workflow_detail/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Service process details query, support querying service process details according to the specified service process ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---------- | --- | --- | ---- |
| workflow_id | int | yes | service process id, obtained from `data["workflow_id"]` field in `service details query` interface |

### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "workflow_id": 1
}
```

### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": {
         "name": "Question follow-up",
         "flow_type": "other",
         "desc": "Problem follow-up process",
         "version_number": "20191105212408",
         "states": [
             {
                 "processors_type": "OPEN",
                 "can_deliver": false,
                 "id": 27,
                 "is_terminable": false,
                 "processors": "",
                 "api_instance_id": 0,
                 "type": "START",
                 "assignors": "",
                 "workflow": 4,
                 "delivers_type": "EMPTY",
                 "delivers": "",
                 "distribute_type": "PROCESS",
                 "name": "Start",
                 "fields": [],
                 "assignors_type": "EMPTY"
             },
             {
                 "processors_type": "STARTER",
                 "can_deliver": false,
                 "id": 32,
                 "is_terminable": false,
                 "processors": "",
                 "api_instance_id": 0,
                 "type": "NORMAL",
                 "assignors": "",
                 "workflow": 4,
                 "delivers_type": "PERSON",
                 "delivers": "",
                 "distribute_type": "PROCESS",
                 "name": "Implementation Acceptance",
                 "fields": [
                     36
                 ],
                 "assignors_type": "EMPTY"
             },
             {
                 "processors_type": "GENERAL",
                 "can_deliver": true,
                 "id": 31,
                 "is_terminable": true,
                 "processors": "4",
                 "api_instance_id": 0,
                 "type": "NORMAL",
                 "assignors": "",
                 "workflow": 4,
                 "delivers_type": "PERSON",
                 "delivers": "zhangsan",
                 "distribute_type": "PROCESS",
                 "name": "Implementation Plan",
                 "fields": [
                     38
                 ],
                 "assignors_type": "EMPTY"
             },
             {
                 "processors_type": "GENERAL",
                 "can_deliver": false,
                 "id": 30,
                 "is_terminable": false,
                 "processors": "2",
                 "api_instance_id": 0,
                 "type": "NORMAL",
                 "assignors": "",
                 "workflow": 4,
                 "delivers_type": "PERSON",
                 "delivers": "",
                 "distribute_type": "CLAIM_THEN_PROCESS",
                 "name": "problem location",
                 "fields": [],
                 "assignors_type": "EMPTY"
             },
             {
                 "processors_type": "OPEN",
                 "can_deliver": false,
                 "id": 28,
                 "is_terminable": false,
                 "processors": "",
                 "api_instance_id": 0,
                 "type": "NORMAL",
                 "assignors": "",
                 "workflow": 4,
                 "delivers_type": "PERSON",
                 "delivers": "",
                 "distribute_type": "PROCESS",
                 "name": "Bill of Lading",
                 "fields": [
                     34,
                     42,
                     43,
                     47
                 ],
                "assignors_type": "EMPTY"
            },
            {
                "processors_type": "OPEN",
                "can_deliver": false,
                "id": 29,
                "is_terminable": false,
                "processors": "",
                "api_instance_id": 0,
                "type": "END",
                "assignors": "",
                "workflow": 4,
                "delivers_type": "PERSON",
                "delivers": "",
                "distribute_type": "PROCESS",
                "name": "END",
                "fields": [],
                "assignors_type": "EMPTY"
            }
        ],
"transitions": [
             {
                 "from_state": 30,
                 "to_state": 31,
                 "workflow": 4,
                 "name": "default",
                 "condition_type": "default",
                 "id": 11,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "key": "G_INT_1",
                                     "condition": "==",
                                     "value": 1
                                 }
                             ],
                             "type": "and"
                         }
                     ],
                     "type": "and"
                 }
             },
             {
                 "from_state": 28,
                 "to_state": 30,
                 "workflow": 4,
                 "name": "default",
                 "condition_type": "default",
                 "id": 10,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "key": "G_INT_1",
                                     "condition": "==",
                                     "value": 1
                                 }
                             ],
                             "type": "and"
                         }
                     ],
                     "type": "and"
                 }
             },
             {
                 "from_state": 32,
                 "to_state": 29,
                 "workflow": 4,
                 "name": "default",
                 "condition_type": "default",
                 "id": 13,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "key": "G_INT_1",
                                     "condition": "==",
                                     "value": 1
                                 }
                             ],
                             "type": "and"
                         }
                     ],
                     "type": "and"
                 }
             },
             {
                 "from_state": 31,
                 "to_state": 32,
                 "workflow": 4,
                 "name": "default",
                 "condition_type": "default",
                 "id": 12,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "key": "G_INT_1",
                                     "condition": "==",
                                     "value": 1
                                 }
                             ],
                             "type": "and"
                         }
                     ],
                     "type": "and"
                 }
             },
             {
                 "from_state": 32,
                 "to_state": 31,
                 "workflow": 4,
                 "name": "Acceptance failed",
                 "condition_type": "by_field",
                 "id": 14,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "value": "BUTONGGUO",
                                     "source": "field",
                                     "key": "YANSHOUJIEGUO",
                                     "choiceList": [],
                                     "type": "SELECT",
                                     "condition": "=="
                                 }
                             ],
                             "type": "and",
                             "checkInfo": false
                         }
                     ],
                     "type": "and"
                 }
             },
             {
                 "from_state": 27,
                 "to_state": 28,
                 "workflow": 4,
                 "name": "",
                 "condition_type": "default",
                 "id": 8,
                 "condition": {
                     "expressions": [
                         {
                             "expressions": [
                                 {
                                     "key": "G_INT_1",
                                     "condition": "==",
                                     "value": 1
                                 }
                             ],
                            "type": "and"
                        }
                    ],
                    "type": "and"
                }
            }
        ],
        "fields": [
            {
                "workflow_id": 4,
                "meta": {},
                "id": 38,
                "regex": "EMPTY",
                "api_instance_id": 0,
                "type": "TEXT",
                "source_uri": "",
                "validate_type": "REQUIRE",
                "source_type": "CUSTOM",
                "key": "SHISHIJIHUA",
                "choice": [],
"desc": "Implementation Plan Description",
                 "name": "Implementation Plan",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 31
             },
             {
                 "workflow_id": 4,
                 "meta": {},
                 "id": 47,
                 "regex": "EMPTY",
                 "api_instance_id": 3,
                 "type": "SELECT",
                 "source_uri": "",
                 "validate_type": "REQUIRE",
                 "source_type": "API",
                 "key": "JIQUNXINXI",
                 "choice": [],
                 "desc": "Select cluster information",
                 "name": "Cluster Information",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 28
             },
             {
                 "workflow_id": 4,
                 "meta": {},
                 "id": 42,
                 "regex": "EMPTY",
                 "api_instance_id": 0,
                 "type": "TEXT",
                 "source_uri": "",
                 "validate_type": "REQUIRE",
                 "source_type": "CUSTOM",
                 "key": "WENTIMIAOSHU",
                 "choice": [],
                 "desc": "Detailed description of the problem",
                 "name": "Problem Description",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 28
             },
             {
                 "workflow_id": 4,
                 "meta": {},
                 "id": 43,
                 "regex": "EMPTY",
                 "api_instance_id": 0,
                 "type": "SELECT",
                 "source_uri": "",
                 "validate_type": "REQUIRE",
                 "source_type": "CUSTOM",
                 "key": "WENTILAIYUAN",
                 "choice": [
                     {
                         "name": "Artificial",
                         "key": "RENGONG"
                     },
                     {
                         "name": "Auto",
                         "key": "ZIDONG"
                     }
                 ],
                 "desc": "The source of the problem's discovery",
                 "name": "problem source",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 28
             },
             {
                 "workflow_id": 4,
                 "meta": {},
                 "id": 34,
                 "regex": "EMPTY",
                 "api_instance_id": 0,
                 "type": "STRING",
                 "source_uri": "",
                 "validate_type": "REQUIRE",
                 "source_type": "CUSTOM",
                 "key": "title",
                 "choice": [],
                 "desc": "Please enter a title",
                 "name": "Title",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 28
             },
             {
                 "workflow_id": 4,
                 "meta": {},
                 "id": 36,
                 "regex": "EMPTY",
                 "api_instance_id": 0,
                 "type": "SELECT",
                 "source_uri": "",
                 "validate_type": "REQUIRE",
                 "source_type": "CUSTOM",
                 "key": "YANSHOUJIEGUO",
                 "choice": [
                     {
                         "name": "pass",
                         "key": "TONGGUO"
                     },
                     {
                         "name": "Failed",
                         "key": "BUTONGGUO"
                     }
                 ],
                 "desc": "Acceptance result of implementation plan",
                 "name": "Acceptance Result",
                 "is_readonly": false,
                 "custom_regex": "",
                 "state_id": 32
             }
         ]
     },
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
| ------- | --------- | ------------------------------------ |
| result | bool | return result, true means success, false means failure |
| code | int | Return code, 0 means success, other values mean failure |
| message | string | error message |
| data | object | return data |

### data

| Field | Type | Description |
| ------------ | ------ | ---- |
| name | string | process name |
| flow_type | string | flow type |
| desc | string | process description |
| states | array | process node list |
| transitions | array | process connection list |
| fields | array | list of process fields |

### states

| Field | Type | Description |
| ------------- | ------ | ------- |
| id | int | field id |
| key | string | field unique identifier |
| type | string | field type |
| name | string | field name |
| desc | string | field description |
### transitions

| Field | Type | Description |
| ------------- | ------ | ------- |
| id | int | field id |
| key | string | field unique identifier |
| type | string | field type |
| name | string | field name |
| desc | string | field description |


### Fields

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

### Meta

| Field | Type | Description |
| ------- | ----- | --- |
| columns | array | columns |

### Columns

| Field | Type | Description |
| ------- | ------ | ---- |
| choice | array | options |
| display | string | display form |
| key | string | unique identifier |
| name | string | first name |