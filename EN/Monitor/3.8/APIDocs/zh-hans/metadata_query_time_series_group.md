### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_query_time_series_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query custom timing grouping information in batches

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| label | string | No | Custom timing grouping label (monitoring object) |
| time_series_group_name | string | No | Custom time series group name |
| bk_biz_id | int | no | business ID |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"label": "application",
"time_series_group_name": "Customized time series group name",
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
| ----------------------- | ------ | ---------------- |
| time_series_group_id | int | Newly created time series group ID |
| time_series_group_name | string | Time series group name |
| bk_data_id | int | data source id |
| bk_biz_id | int | business id |
| table_id | string | result table ID |
| label | string | event label |
| is_enable | bool | Whether to enable |
| creator | string | creator |
| create_time | string | Creation time |
| last_modify_user | string | Last updated by |
| last_modify_time | string | last updated time |
| metric_info_list | list | Custom time series list |

#### metric_info_list specific content description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| field_name | string | field name |
| description | string | Field description |
| unit | string | unit |
| type | string | field type |
| tag_list | list | dimension list |

#### metric_info_list.tag_list specific content description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| field_name | string | field name |
| description | string | Field description |
| unit | string | unit |
| type | string | field type |

#### Example of results

```json
{
     "message":"OK",
     "code":200,
     "data": [{
         'time_series_group_id': 1,
         'time_series_group_name': 'bkunifylogbeat common metrics',
         'bk_data_id': 1100006,
         'bk_biz_id': 0,
         'table_id': 'bkunifylogbeat_common.base',
         'label': 'service_process',
         'is_enable': True,
         'creator': 'system',
         'create_time': '2021-12-07 03:29:51',
         'last_modify_user': 'system',
         'last_modify_time': '2021-12-07 03:29:51',
         "metric_info_list": [{
             "field_name": "mem_usage",
             "description": "mem_usage_2",
             "unit": "M",
             "type": "double",
             "tag_list": [
                 {
                     "field_name": "test_name",
                     "description": "test_name_2",
                     "unit": "M",
                     "type": "double",
                 }
             ]
         },{
             "field_name": "cpu_usage",
             "description": "mem_usage_2",
             "unit": "M",
             "type": "double",
             "tag_list": [
                 {
                     "field_name": "test_name",
                     "description": "test_name_2",
                     "unit": "M",
                     "type": "double",
                 }
             ]
         }]
     }],
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```