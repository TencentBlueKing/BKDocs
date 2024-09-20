### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_list_result_table/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Get storage list
According to the given filtering parameters (none yet), return a list of result tables that meet the conditions

### Request parameters



#### Interface parameters
No request parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| datasource_type | string | No | The type of result table that needs to be filtered, such as system |
| bk_biz_id | int | No | Get the result table information under the specified business |
| is_public_include | int | No | Whether to include the full business result table, 0 means not included, non-0 means include the full business result table |
| is_config_by_user | bool | No | Whether the result table content of non-user configuration needs to be included |

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"bk_biz_id": 123,
"is_public_include": 1,
"datasource_type": "system"
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
| result_table_id | int | result table ID |
| table_name_zh | string | Chinese name of the result table |
| is_custom_table | bool | Whether to customize the result table |
| schema_type | string | Result table schema configuration scheme, free (no schema configuration), dynamic (dynamic schema), fixed (fixed schema) |
| default_storage | string | Default storage scheme |
| storage_list | array | All storage lists, elements are string |
| creator | string | creator |
| create_time | string | Creation time, the format is [2018-10-10 10:00:00] |
| last_modify_user | string | Last modified by |
| last_modify_time | string | Last modification time [2018-10-10 10:00:00] |
| field_list | list | field list |

##### Specific parameter description of data.field_list

| key value | type | description |
| ------------------ | ------ | ----------------------------------------------------- |
| field_name | string | field name |
| field_type | string | Field type, which can be float, string, boolean and timestamp |
| description | string | Field description information |
| tag | string | Field tag, which can be metric, dimemsion, timestamp, group |
| alias_name | string | warehousing alias |
| option | string | Field option configuration, the key is the option name, and the value is the option configuration |
| is_config_by_user | bool | Whether the user enables this field configuration |
| unit | string | field unit |

#### Example of results

```json
{
     "message":"OK",
     "code":200,
     "data":[{
     "table_id": "system.cpu",
     "table_name_zh": "Result table name",
     "is_custom_table": false,
     "scheme_type": "fixed",
     "default_storage": "influxdb",
     "storage_list": ["influxdb"],
     "creator": "username",
     "create_time": "2018-10-10 10:10:10",
     "last_modify_user": "username",
     "last_modify_time": "2018-10-10 10:10:10",
     "field_list": [{
     "field_name": "usage",
     "field_type": "float",
     "tag": "dimension",
     "description": "CPU usage",
     "is_config_by_user": true,
     "unit": "field unit"
     }],
     "bk_biz_id": 0,
     "label": "OS"
     }],
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```