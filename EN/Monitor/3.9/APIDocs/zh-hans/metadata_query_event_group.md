
### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_query_event_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query event group information in batches

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| label | string | No | Event grouping label (monitoring object) |
| event_group_name | string | No | Event group name |
| bk_biz_id | int | no | business ID |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"label": "application",
"event_group_name": "Event group name",
"bk_biz_id": 123
}
```

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | list | data |
| request_id | string | request ID |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| event_group_id | int | event group ID |
| bk\_data_id | int | data source ID |
| bk\_biz_id | int | Business ID |
| event\_group_name | string | event group name |
| label | string | event label |
| is_enable | bool | Whether to enable |
| creator | string | creator |
| create_time | string | Creation time |
| last_modify_user | string | Last modified by |
| last_modify_time | string | last modification time |
| event_info_list | list | event list |

#### data.event_info_list specific content description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| bk\_event_id | int | event ID |
| event_name | string | event name |
| dimension | list | dimension list |

#### data.event_info_list.dimension Specific content description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| dimension_name | string | dimension name |
| dimension_ch_name | string | Dimension Chinese name |

#### Example of results

```json
{
    "message":"OK",
    "code":200,
    "data": [{
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
    }],
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```