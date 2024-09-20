### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_upgrade_result_table/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Modify a single business result table to upgrade it to a full business result table

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| table_id_list | list | Yes | List of result table IDs |
| operator | string | is | operator |

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
     "operator": "admin",
"table_id_list": ["2_system.cpu", "3_system.cpu"],
}
```

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | null | data |
| request_id | string | request ID |

#### Example of results

```json
{
     "message":"OK",
     "code": 200,
     "data": null,
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```