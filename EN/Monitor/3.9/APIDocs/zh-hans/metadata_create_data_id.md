
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_data_id/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create data source
Create a data source based on the given configuration parameters

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| data_name | string | yes | data source name |
| etl_config | string | Yes |Clean template configuration, prometheus exportor corresponds to "prometheus" |
| operator | string | is | operator |
| mq_cluster | dict | No | The message cluster used by the data source |
| data_description | string | No | Specific description of the data source |
| is_custom_source | bool | No | Whether the user customizes the data source, the default is yes |
| source_label | string | Yes | Data source label, for example: data platform (bk_data), monitoring collector (bk_monitor) |
| type_label | string | Yes | Data type label, for example: time series data (time_series), event data (event), log data (log) |
| custom_label | string | No | Custom label configuration information |
| option | string | No | Data source configuration option content, in the format {`option_name`: `option_value`} |

**Note**: The above `source_label` and `type_label` should be obtained through the `metadata_get_label` interface and should not be created by yourself

#### The options currently available for data sources include

| option name | type | description |
| -------------- | ------ | ----------- |
| group_info_alias | string | Group identification field alias |
| encoding | string | Reported data encoding |
| separator | string | separator, used to separate the character content of the reported log |
| separator_field_list | list | Field allocation after splitting |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"data_name": "basereport",
"etl_config": "basereport",
"operator": "username",
"data_description": "basereport data source",
"type_label": "time_series",
"source_label": "bk_monitor_collector"
}
```

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |
| request_id | string | request id |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| bk_data_id | int | result table ID |

#### Example of results

```json
{
    "message": "OK",
    "code": 200,
    "data": {
    	"bk_data_id": 1001
    },
    "result": true,
    "request_id": "408233306947415bb1772a86b9536867"
}
```