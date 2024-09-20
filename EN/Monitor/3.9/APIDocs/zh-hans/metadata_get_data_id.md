### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_get_data_id/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query the ID of a data source
According to the given data source ID, return the specific information of this result table

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| bk_data_id | int | no | data source ID |
| data_name | string | no | data source name |

> Note:
> 1. One of the above two must be provided, and both cannot be empty at the same time;
> 2. When bk_data_id is provided, data_name is invalid

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"bk_data_id": 1001
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
| bk_data_id | int | data source ID |
| data_name | string | data source name |
| data_description | string | Data source description |
| mq_cluster_info | dict | Message queue cluster information, the sample will have a detailed description |
| etl_config | string | Cleaning configuration name |
| is_custom_source | bool | Whether the user customizes the data source |
| creator | string | creator |
| create_time | string | Creation time, the format is [2018-10-10 10:00:00] |
| last_modify_user | string | Last modified by |
| last_modify_time | string | Last modification time [2018-10-10 10:00:00] |
| token | string | verification code of dataID |

#### data.mq_cluster_info field description

| Field | Type | Description |
| -------------- | ------ | ------------------------------------ |
| storage_config | dict | Storage cluster characteristics, fields are inconsistent under each storage |
| cluster_config | dict | stores cluster information |
| cluster_type | string | Storage cluster type |
| auth_info | dict | Identity authentication information |

#### Example of results
```json
{
    "message":"OK",
    "code": 200,
    "data":{
    	"bk_data_id": 1001,
    	"data_name": "基础数据",
    	"data_description": "基础数据数据源",
    	"mq_cluster_info": {
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
    	"etl_config": "basereport",
    	"is_custom_source": false,
    	"creator": "username",
    	"create_time": "2018-10-10 10:10:10",
    	"last_modify_user": "username",
    	"last_modify_time": "2018-10-10 10:10:10",
    	"source_label": "bk_monitor_collector",
	    "type_label": "time_series",
	    "token": "5dc2353d913c45bea43dd8d931745a05"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```