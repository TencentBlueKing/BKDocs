
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_event_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create an event group ID
Given a data source and business, create an attributed event group ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| bk_data_id | int | yes | data source ID |
| bk_biz_id | int | yes | business ID |
| event_group_name | string | Yes | Event group name |
| label | string | Yes | Event grouping label, used to represent event monitoring objects. Labels under the [result_table_label] type should be reused |
| operator | string | is | operator |
| event_info_list | list | no | event list |

#### event_info_list specific content description

| Field | Type | Required | Description |
| ------------------- | ------ | -------- | -------- |
| event_name | string | yes | event name |
| dimension | list | yes | dimension list |

#### Request example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_data_id": 123,
     "bk_biz_id": 123,
     "event_group_name": "Event group name",
     "label": "application",
     "operator": "system",
     "event_info_list": [{
         "event_name": "usage for update",
         "dimension_list": ["dimension_name"]
     },{
         "event_name": "usage for create",
         "dimension_list": ["dimension_name"]
     }]
}
```

### Return results

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| event_group_id | int | New event group ID |
| bk_data_id | int | data source ID |
| bk_biz_id | int | Business ID |
| event_group_name | string | event group name |
| label | string | label |
| is_enable | bool | Whether to enable |
| creator | string | creator |
| create_time | string | Creation time |
| last_modify_user | string | Last updated by |
| last_modify_time | string | last updated time |
| event_info_list | list | event list |

#### event_info_list Description

| Field | Type | Description |
| -------------- | ------ | -------- |
| bk_event_id | int | event id |
| event_name | string | event name |
| dimension_list | list | dimension list |

#### Example of results
```json
{
    "message":"OK",
    "code":200,
    "data": {
    	"event_group_id": 1001,
    	"bk_data_id": 123,
    	"bk_biz_id": 123,
    	"event_group_name": "事件分组名",
    	"label": "application",
    	"is_enable": true,
    	"creator": "admin",
    	"create_time": "2019-10-10 10:10:10",
    	"last_modify_user": "admin",
    	"last_modify_time": "2020-10-10 10:10:10",
    	"event_info_list": [{
          "bk_event_id": 1,
          "event_name": "usage for update",
          "dimension_list": [{
            "dimension_name": "field_name"
          }]
        },{
          "bk_event_id": 2,
          "event_name": "usage for create",
          "dimension_list": [{
            "dimension_name": "field_name"
          }]
        }]
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```