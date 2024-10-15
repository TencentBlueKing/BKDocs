
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_result_table/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create results table
Create a results table based on the given configuration parameters

### Request parameters



#### Interface parameters

| Field | Type | Is it required | Description |
| -------------- | ------ | ---- | ----------- |
| bk_data_id | int | yes | data source ID |
| table_id | string | Yes | Result table ID, the format should be library.table (for example, system.cpu) |
| table_name_zh | string | Yes | Chinese name of the result table |
| is_custom_table | bool | yes | whether the user customizes the result table |
| schema_type | string | Yes | Result table field configuration scheme, free (no schema configuration), fixed (fixed schema) |
| operator | string | is | operator |
| default_storage | string | Yes | Default storage type, currently supports influxdb |
| default_storage_config | dict | No | Default storage information, according to each different storage, there will be different configuration content, if not provided, the default value will be used; for details, please refer to the specific instructions below |
| field_list | list | No| Field information, the array element is object, for example, the fields include field_name (field name), field_type (field type), tag (field type, metirc -- indicator, dimension -- dimension), alias_name (field alias) |
| bk_biz_id | int | No | Business ID, if not provided, the default is 0 (all services) result table; if non-zero, the result table naming convention will be verified |
| label | string | Yes | Result table label, what is recorded here is the second-level label, and the corresponding first-level label will be derived from the second-level label |
| external_storage | list | No | Additional storage configuration in the format {${storage_type}: ${storage_config}}, storage_type can be kafka, influxdb, redis; storage_config is consistent with default_storage_config |
| is_time_field_only | bool | No | Whether the default field only requires time, the default is False |
| option | list | No | Additional configuration information for the result table, in the format {`option_name`: `option_value`} |
| time_alias_name | string | No | Other field names need to be used when uploading the time field |

**Note**: The above `label` should be obtained through the `metadata_get_label` interface and should not be created by yourself.

#### Currently the options available for the result table include
| option name | type | description |
| -------------- | ------ | ----------- |
| cmdb_level_config | list | CMDB level split configuration |
| group_info_alias | string | Group identification field alias |
| es_unique_field_list | list | ES generates the field list of doc_id |

###### Parameters: default_storage_config and storage_config -- parameters supported under influxdb

| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | ---| ---|
| storage_cluster_id | int | no | The default storage cluster to use for this storage type | Specify the storage cluster |
| database | string | no | dotted first part of table_id | stored database |
| real_table_name | string | No | The dotted second part of table_id | The actual storage table name |
| source_duration_time | string | No | 30d | Metadata storage time, needs to comply with influxdb format |

###### Parameters: default_storage_config and storage_config -- parameters supported under kafka
| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- |--- | --- |
| storage_cluster_id | int | no | The default storage cluster to use for this storage type | Specify the storage cluster |
| topic | string | no | 0bkmonitor_storage_${table_id} | stored topic configuration |
| partition | int | No | 1 | The number of storage partitions. Note: This is just a record. If the configuration is more than 1 topic, you need to manually expand it through the kafka command line tool |
| retention | int | No | 1800000 | kafka data retention duration, the default is half an hour, unit ms |

###### Parameters: default_storage_config and storage_config -- parameters supported under redis
| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| storage_cluster_id | int | no | The default storage cluster to use for this storage type | Specify the storage cluster |
| key | string | No | table_id name | Store key value |
| db | int | no | 0 | use db configuration |
| command | string | no | PUBLISH | store command |
| is_sentinel | bool | No | False | Whether to use sentinel mode |
| master_name | string | No | "" | Master name in sentry mode |

**Note**: Since redis uses queue mode by default and discards it after consumption, the duration is not configured.

###### Parameters: default_storage_config and storage_config -- parameters supported under elasticsearch

| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| storage_cluster_id | int | no | - |The default storage cluster using this storage type
| retention | int | No | 30 | Retention index time, in days, default retention is 30 days |
| date_format | string | No | %Y%m%d%H | Time format, the default is to the hour |
| slice_size | int | No | 500 | The size threshold that needs to be sliced, in GB, the default is 500GB |
| slice_gap | int | No | 120 | index slice interval, in minutes, default 2 hours |
| index_settings | string | Yes | - | Index creation configuration, json format |
| mapping_settings | string | No | - | Index mapping configuration, **does not include field definitions**, json format |

**Note**: The actual index construction method is `${table_id}_${date_format}_${current_index}`

###### Parameter: Specific parameter description of field_list

| Key value | Type | Is it required | Default value | Description |
| ---- | --- | --- | --- | --- |
| field_name | string | yes | - | field name |
| field_type | string | Yes | - | Field type, can be float, string, boolean and timestamp |
| description | string | No | "" | Field description information |
| tag | string | Yes | - | Field tag, which can be metric, dimemsion, timestamp, group |
| alias_name | string | No | None | Storage alias |
| option | string | No | {} | Field option configuration, the key is the option name, and the value is the option configuration |
| is_config_by_user | bool | yes | true | Whether the user enables this field configuration |

Currently available options include:
| option name | type | description |
| -------------- | ------ | ----------- |
| es_type | string | es configuration: map actual field type |
| es_include_in_all | bool | es configuration: whether to include it in the _all field |
| es_format | string | es configuration: time format |
| es_doc_values | bool | es configuration: whether dimension |
| es_index | string | es configuration: whether to segment words, the value can be true or false |
| time_format | string | Data source time format for Transfer to parse and report time |
| time_zone | int | Time zone configuration, for Transfer to parse and report the time as UTC, the value range is [-12, +12] |

#### Request example

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_data_id": 1001,
    "table_id": "system.cpu_detail",
    "table_name_zh": "CPU记录",
    "is_custom_table": true,
    "schema_type": "fixed",
    "operator": "username",
    "default_storage": "influxdb",
    "default_storage_config": {
        "storage": 1,
        "source_duration_time": "30d"
    },
    "field_list": [{
        "field_name": "usage",
        "field_type": "double",
        "description": "field description",
        "tag": "metric",
        "alias_name": "usage_alias",
        "option": [],
        "is_config_by_user": true
    }],
    "label": "OS",
    "external_storage": {
        "kafka": {
            "expired_time": 1800000
        }
    }
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
| table_id | string | result table ID |

#### Example of results

```json
{
    "message": "OK",
    "code": 200,
    "data": {
    	"table_id": "system.cpu_detail"
    },
    "result": true,
    "request_id": "408233306947415bb1772a86b9536867"
}
```