
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_modify_result_table/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Modify the configuration of a results table
According to the given data source ID, return the specific information of this result table

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| table_id | string | yes | result table ID |
| operator | string | is | operator |
| field_list | list | No | Full field list |
| table_name_zh | string | No | Chinese name of the result table |
| default_storage | string | No | Default storage type of result table |
| label | string | Yes | Result table label, what is recorded here is the second-level label, and the corresponding first-level label will be derived from the second-level label |
| is_time_field_only | bool | No | Whether the default field only requires time, the default is False, this field only takes effect when the field_list parameter is non-empty |
| external_storage | dict | No | Additional storage configuration in the format {${storage_type}: ${storage_config}}, storage_type can be kafka, influxdb, redis; storage_config is consistent with default_storage_config |
| is_enable | bool | no | whether to enable the result table |


**Note**: The above `label` should be obtained through the `metadata_get_label` interface and should not be created by yourself.

###### Parameters: default_storage_config and storage_config -- parameters supported under influxdb
| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| source_duration_time | string | No | 30d | Metadata storage time, needs to comply with influxdb format |

###### Parameters: default_storage_config and storage_config -- parameters supported under kafka
| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| partition | int | No | 1 | The number of storage partitions. Note: This is just a record. If the configuration is more than 1 topic, you need to manually expand it through the kafka command line tool |
| retention | int | No | 1800000 | kafka data retention duration, the default is half an hour, unit ms |

###### Parameters: default_storage_config and storage_config -- parameters supported under redis

| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| is_sentinel | bool | No | False | Whether to use sentinel mode |
| master_name | string | No | "" | Master name in sentry mode |

**Note**: Since redis uses queue mode by default and discards it after consumption, the duration is not configured.

###### Parameters: default_storage_config and storage_config -- parameters supported under elasticsearch
| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| retention | int | No | 30 | Retention index time, in days, default retention is 30 days |
| slice_size | int | No | 500 | The size threshold that needs to be sliced, in GB, the default is 500GB |
| slice_gap | int | No | 120 | index slice interval, in minutes, default 2 hours |
| index_settings | string | Yes | - | Index creation configuration, json format |
| mapping_settings | string | No | - | Index mapping configuration, **does not include field definitions**, json format |
| alias_name | string | No | None | Storage alias |
| option | string | No | {} | Field option configuration, the key is the option name, and the value is the option configuration |

**Note**: Whether the above information can be modified mainly depends on whether modifying the parameters will cause the loss of historical data.

| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| filed_name | string | yes | - | field name |
| field_type | string | yes | - | field type |
| description | string | No | "" | Field description |
| tag | string | Yes | - | field type, can be metric or dimension |
| alias_name | string | No | "" | Field alias, you can change it to this alias when entering the database |
| option | list | No | [] | Field configuration options |
| is_config_by_user | bool | no | true | whether to enable |

#### Request example

```json
{
    "bk_app_code": "xxx",
  	"bk_app_secret": "xxxxx",
  	"bk_token": "xxxx",
	"table_id": "system.cpu",
	"operator": "username",
	"field_list": [{
		"filed_name": "usage",
		"field_type": "double",
		"description": "field description",
		"tag": "metric",
        "alias_name": "usage_alias",
		"option": [],
		"is_config_by_user": true
	}],
	"label": "OS",
	"table_name_zh": "CPU性能数据",
	"default_storage": "influxdb"
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
| table_id | int | result table ID |
| table _name_zh | string | Chinese name of the result table |
| is_custom_table | boolean | Whether to customize the result table |
| schema_type | string | Result table schema configuration scheme, free (no schema configuration), dynamic (dynamic schema), fixed (fixed schema) |
| default_storage | string | Default storage scheme |
| storage_list | list | All storage lists, elements are string |
| creator | string | creator |
| create_time | string | Creation time, the format is [2018-10-10 10:00:00] |
| last_modify_user | string | Last modified by |
| last_modify_time | string | Last modification time [2018-10-10 10:00:00] |
| label | string | result table label |
| field_list | list | field list |

#### data.field_list field description

| key value | type | description |
| ------------------ | ------ | ------------------------------------------------------ |
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
    "data":{
    	"table_id": "system.cpu",
    	"table_name_zh": "结果表名",
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
    		"description": "CPU用量",
    		"is_config_by_user": true,
            "unit": "字段单位"
    	}],
    	"label": "OS"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```