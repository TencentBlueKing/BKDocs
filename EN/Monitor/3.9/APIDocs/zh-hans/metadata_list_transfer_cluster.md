### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_list_transfer_cluster/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Get all transfer cluster information

### Request parameters



#### Interface parameters

No request parameters

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
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
| ---------- | ------ | --------------- |
| cluster_id | string | transfer cluster ID |

#### Example of results

```json
{
     "message": "OK",
     "code": 200,
     "data": [
         {
             "cluster_id": "default"
         },
         {
             "cluster_id": "bkmonitorv3-na"
         }
     ],
     "result": true,
     "request_id": "408233306947415bb1772a86b9536867"
}
```