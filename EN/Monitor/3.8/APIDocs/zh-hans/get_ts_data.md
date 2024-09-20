
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/get_ts_data/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Chart data query
Query the specified storage engine based on the given sql expression

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| sql | string | Yes | SQL query statement |
| prefer_storage | string | no | query engine (default influxdb) |
| bk_username | string | No | Whitelist app_code required |

#### Request example

```json
{
     "bk_app_code": "xxx",
     "bk_app_secret": "xxxxx",
     "bk_token": "xxxx",
     "bk_username":"admin",
     "sql":"select max(in_use) as _in_use from 3_system.disk where time >= \"1m\" group by ip, bk_cloud_id, bk_supplier_id, device_name, minute1 order by time desc limit 1"
}
```

>The result table name in sql is biz_id + db_name + table_name
>
>Biz_id: business id
>Db_name: database name
>Table_name: Data table name
>Example: 2_system.cpu_detail: cpu_detail table of the system library under business 2
>SQL statement to query single-core CPU usage within an hour:
>Select Mean(usage) as usage from 2_system.cpu_detail where time > '1h' group by ip,device_name,minute1 limit 10

>The result table 3_system.disk in the above request example represents: the disk table in the system library under business 3

>Note: The above libraries and tables do not correspond to the actual physical libraries and tables in time series storage. It refers to the library table of the 'source data management module'

### Return results

| Field | Type | Description |
| ---------- | ------ | ------------------ |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | list | Successfully updated policy id table |
| request_id | string | request id |

#### data field description

| Field | Type | Description |
| ------------ | ------ | -------- |
| list | list | query results |
| totalRecords | int | total number of records |
| timetaken | float | Query time taken |
| device | string | query engine |

#### data.list

The content here is the relevant content searched by sql

#### Example of results

```json
{
    "message":"OK",
    "code":200,
    "data":{
        "list":[
            {
                "ip":"x.x.x.x",
                "time":1543487700000,
                "bk_supplier_id":"0",
                "device_name":"C:",
                "_in_use":27.0269684761,
                "bk_cloud_id":"0",
                "minute1":1543487700000
            },
            {
                "ip":"x.x.x.x",
                "time":1543487700000,
                "bk_supplier_id":"0",
                "device_name":"\/",
                "_in_use":8.3368418991,
                "bk_cloud_id":"0",
                "minute1":1543487700000
            }
        ],
        "timetaken":0.0059459209,
        "totalRecords":2,
        "device":"influxdb"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```
