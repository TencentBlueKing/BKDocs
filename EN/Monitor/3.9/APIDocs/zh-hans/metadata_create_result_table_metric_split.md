
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_result_table_metric_split/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create a result table CMDB split task
According to the given data source ID, return the specific information of this result table

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| table_id | string | yes | result table ID |
| cmdb_level | string | Yes | CMDB split level name |
| operator | string | is | operator |


#### Request example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "table_id": "system.cpu_summary",
     "cmdb_level": "set",
     "operator": "admin"
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
| bk_data_id | int | Newly created data source ID |
| table_id | string | ID of the newly created result table |


#### Example of results

```json
{
    "message": "OK",
    "code": 200,
    "data": {
    	"bk_data_id": 1001,
    	"table_id": "system.cpu_summary_cmdb_level"
    },
    "result": true,
    "request_id": "408233306947415bb1772a86b9536867"
}
```