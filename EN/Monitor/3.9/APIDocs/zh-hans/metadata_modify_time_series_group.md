
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_modify_time_series_group/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Modify a custom timing group ID
Given a custom timing group ID, modify some specific information

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| time_series_group_id | int | yes | Custom timing group ID |
| time_series_group_name | string | Yes | Custom time series group name |
| label | string | No | Event grouping label, used to represent custom timing monitoring objects, labels under the [result_table_label] type should be reused |
| operator | string | no | operator |
| metric_info_list | bool | no | custom time series list |
| is_enable | bool | no | whether to disable the custom timing group |
| field_list | list | no | field list |

##### Specific parameter description of field_list

| Key value | Type | Is it required | Default value | Description |
| ------------------ | ------ | -------- | ------ | ----------------------------------------------------------- |
| field_name | string | yes | - | field name |
| field_type | string | Yes | - | Field type, can be float, string, boolean and timestamp |
| description | string | No | "" | Field description information |
| tag | string | Yes | - | Field tag, which can be metric, dimemsion, timestamp, group |
| alias_name | string | No | None | Storage alias |
| option | string | No | {} | Field option configuration, the key is the option name, and the value is the option configuration |
| is_config_by_user | bool | yes | true | Whether the user enables this field configuration |

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"time_series_group_id": 123,
"time_series_group_name": "Customized timing development",
"operator": "system",
"description": "what the group use for.",
"is_enable": true,
"field_list": [{
"filed_name": "usage",
"field_type": "double",
"description": "field description",
"tag": "metric",
         "alias_name": "usage_alias",
"option": [],
"is_config_by_user": true
}]
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
| ----------- | ------ | -------- |
| field_name | string | field name |
| description | string | Field description |
| unit | string | unit |
| type | string | field type |
| tag_list | list | dimension list |

#### metric_info_list.tag_list specific content description

| Field | Type | Description |
| ----------- | ------ | -------- |
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