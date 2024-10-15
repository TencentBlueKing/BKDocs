### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_get_result_table_storage/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query the specified storage information of a result table
According to the given result table ID, return the specific storage cluster information of this result table.

### Request interface



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| result_table_list | string | yes | result table ID |
| storage_type | string | yes | storage type |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"result_table_list": "system.cpu",
"storage_type": "elasticsearch"
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
| storage_info | list | Storage cluster information |

###### For storage_info, the contents of each element are described as follows

| Field | Type | Description |
| ------------------- | ------ | -------- |
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
         "system.cpu": {
             "table_id": "system.cpu",
             "storage_info": [{
                 "storage_config": {
                     "index_datetime_format": "%Y%m%h",
                     "slice_size": 400,
                     "slice_gap": 120,
                     "retention": 30
                 },
                 "cluster_config": {
                     "domain_name": "service.consul",
                     "port": 1000,
                     "schema": "http",
                     "is_ssl_verify": false,
                     "cluster_id": 1,
                     "cluster_name": "default_es_storage"
                 },
                 "cluster_type": "elasticsearch",
                 "auth_info": {
                     "username": "admin",
                     "password": "password"
                 }
             }]
         }

     },
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```