
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_time_series_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create a custom timing group ID
Given a data source and business, create an attributed custom time series group ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| bk_data_id | int | yes | data source ID |
| bk_biz_id | int | yes | business ID |
| time_series_group_name | string | Yes | Custom time series group name |
| label | string | Yes | Custom time series grouping label, used to represent monitoring objects. Labels under the [result_table_label] type should be reused |
| operator | string | is | operator |
| metric_info_list | list | No | Custom time series list |

#### metric_info_list specific content description

| Field | Type | Required | Description |
| ------------------- | ------ |-----| -------- |
| field_name | string | Yes | Custom timing name |
| tag | list | yes | dimension list |

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
  "bk_token": "xxxx",
"bk_data_id": 123,
"bk_biz_id": 123,
"time_series_group_name": "Customized time series group name",
"label": "application",
"operator": "system",
"metric_info_list": [{
"field_name": "usage for update",
"tag_list": ["dimension_name"]
     },{
"field_name": "usage for create",
"tag_list": ["dimension_name"]
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
| metric_info_list | list | \custom time series list |

#### data.metric_info_list Specific content description

| Field | Type | Description |
| ----------- | ------ | -------- |
| description | string | description |
| field_name | string | Field name |
| unit | string | unit |
| type | string | unit type |
| tag_list | list | tag list |

#### data.metric_info_list.tag_list Specific instructions

| Field | Type | Description |
| ----------- | ------ | -------- |
| field_name | string | field name |
| description | string | description |
| unit | string | unit |
| type | string | unit type |

#### Example of results

```json
{
    "message":"OK",
    "code":200,
    "data": {
    	"bk_data_id": 123,
    	"bk_biz_id": 123,
        "time_series_group_id": 1,
    	"time_series_group_name": "时序自定义时序分组名",
    	"label": "application",
    	"is_enable": true,
    	"creator": "admin",
    	"create_time": "2019-10-10 10:10:10",
    	"last_modify_user": "admin",
    	"last_modify_time": "2020-10-10 10:10:10",
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
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```