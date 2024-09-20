### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/metadata_list_label/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Get data labels
According to the requested parameters, each request data label is returned, including data source labels and labels at all levels of the result table.

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| label_type | string | Yes | Label classification, `source_label`, `type_label` or `result_table_label` |
| level | int | Yes | Label level, the level is calculated from 1, this configuration only takes effect when `label_type` is `result_table` |
| include_admin_only | bool | Yes | Whether to display labels visible to administrators |


#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
     "include_admin_only": True,
"level": 1,
"label_type": "source_label"
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
| label_id | string | Label ID (English name)
| label_name | string | Label name (Chinese name) |
| label_type | string | Label classification |
| level | int | label level |
| parent_label | string | Parent label ID |
| index | int | Sorting order of tags at the same level |


#### Example of results

```json
{
     "message":"OK",
     "code":200,
     "data": {
         "source_label": [{
             "label_id": "bk_monitor_collector",
             "label_name": "BlueKing Monitoring Collector",
             "label_type": "source_label",
             "level": null,
             "parent_label": null,
             "index": 0
         }],
         "type_label": [{
             "label_id": "time_series",
             "label_name": "Time series data",
             "label_type": "type_label",
             "level": null,
             "parent_label": null,
             "index": 0
         }],
         "result_table_label": [{
             "label_id": "OS",
             "label_name": "operating system",
             "label_type": "result_table_label",
             "level": 2,
             "parent_label": "host",
             "index": 0
         }, {
             "label_id": "host",
             "label_name": "host",
             "label_type": "result_table_label",
             "level": 1,
             "parent_label": null,
             "index": 1
         }]
     },
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```