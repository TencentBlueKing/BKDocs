### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_modify_data_id/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Modify data source name

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| data_name | string | no | data source name |
| data_id | int | yes | data source ID |
| operator | string | is | operator |
| data_description | string | no | data source description |
| option | string | No | Data source configuration option content, in the format {`option_name`: `option_value`} |
| is_enable | bool | no | whether the data source is enabled |


#### Request example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "operator": "adminn",
     "data_id": 123,
     "data_name": "basereport",
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
| bk_data_id | int | result table ID |
| data_id | int | result table ID |
| mq_config | dict | Message queue cluster information |
| etl_config | string | Cleaning configuration |
| result_table_list | list | result information table |
| option | dict | Data source configuration option content |
| type_label | string | data type label |
| source_label | string | Data source label |
| token | string | Report verification token |
| transfer_cluster_id | string | transfer cluster ID |

#### data.mq_config field description

| Field | Type | Description |
| -------------- | ------ | --------------------------------- |
| storage_config | dict | Storage cluster characteristics, fields are inconsistent under each storage |
| cluster_config | dict | stores cluster information |
| cluster_type | string | Storage cluster type |
| auth_info | dict | Identity authentication information |

#### Example of results

```json
{
     "message":"OK",
     "code":200,
     "data":{
         "bk_data_id": 1001,
         "data_id": 1001,
         "mq_config": {
             "storage_config": {
"topic": "bk_monitor_1001",
"partition": 1,
},
     "cluster_config": {
                "domain_name": "kafka.domain.cluster",
                "port": 80,
            },
            "cluster_type": "kafka"
         },
         'etl_config': '',
         'result_table_list': [],
         'option': {},
         'type_label': 'time_series',
         'source_label': 'bk_monitor',
         'token': 'xxxxxx',
         'transfer_cluster_id': 'default'
     },
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```