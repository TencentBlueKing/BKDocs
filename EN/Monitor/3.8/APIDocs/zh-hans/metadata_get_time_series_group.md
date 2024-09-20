### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_get_time_series_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query a custom timing group ID
Given a data source and business, query specific information

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| time_series_group_id | int | Yes | Custom time series group ID |
| with_result_table_info | bool | No | Custom timing group storage information |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"time_series_group_id": 123,
"with_result_table_info": true
}
```

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |
| request_id | string | request ID |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| bk_time_series_group_id | int | Custom time series group ID |
| bk_data_id | int | data source ID |
| bk_biz_id | int | Business ID |
| time_series_group_name | string | Custom time series group name |
| label | string | Custom timing label |
| is_enable | bool | Whether to enable |
| creator | string | creator |
| create_time | string | Creation time |
| last_modify_user | string | Last modified by |
| last_modify_time | string | last modification time |
| metric_info_list | list | Metric list |
| shipper_list | dict | result table configuration information |

#### data.metric_info_list Specific content description

| Field | Type | Description |
| ------------------- | ------ | -------- |
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
     "time_series_group_id": 1001,
     "bk_data_id": 123,
     "bk_biz_id": 123,
     "time_series_group_name": "Customized time series group name",
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
         }],
         "shipper_list": [{
             "cluster_info": {
                 "domain_name": "es.service.consul",
                 "port": 8000
             },
             "cluster_type": "es"
         }]
     },
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```