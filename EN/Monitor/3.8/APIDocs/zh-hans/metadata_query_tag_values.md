### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_query_tag_values/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query the data source to specify the optional value of the specified tag/dimension

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| table_id | string | yes | result table ID |
| tag_name | string | Yes | tag/dimension field name |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
"table_id": "2_bkmonitor_time_series_1500514.base",
"tag_name": "target"
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
| tag_values | list | values of tag/dimension |

#### Example of results

```json
{
     "message":"OK",
     "code": 200,
     "data": {
     "tag_values": ["target1", "target2"]
     },
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```