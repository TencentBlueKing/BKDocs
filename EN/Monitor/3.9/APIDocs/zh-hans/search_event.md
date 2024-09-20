
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/search_event/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query events

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---------- | ------ | ---- | ------------------------------------------------------------ |
| bk_biz_ids | list | Yes | Business ID list |
| time_range | string | No | The time range for the end of the event, the format is: 2020-02-26 00:00:00 -- 2020-02-28 23:59:59 |
| days | int | No | Query the time in the last few days. This parameter exists, but time_range is invalid |
| conditions | list | No | Query conditions |
| page | int | No | Page number, if not passed, no paging |
| page_size | int | No | Number of pages, default 100 |

> It should be noted that the current unrecovered events are not subject to time conditions, that is, no matter what time range is selected, the current unrecovered events will be detected unless conditions are used to filter the event status.

#### conditions

Conditions are used to filter events by other fields related to the event. They consist of key and value, which means that events with key fields in the value list are filtered out.

The following matching conditions mean that events whose event status is "Recovered" are filtered out.

```json
[
   {
     "key":"event_status",
     "value":["RECOVERED"]
   }
]
```

Available fields are:

1. strategy_id - the strategy ID associated with the event

2. id - event ID

3. level - Alarm level

    1. 1 - Fatal
    2. 2 - Early Warning
    3. 3 - Reminder

4. event_status - event status

    1. ABNORMAL - Not restored
    2. CLOSED - closed
    3. RECOVERED - recovered

5. data_source - data source and type

    It is a string separated by `|`, with the data source on the left and the data type on the right, such as `bk_monitor|time_series`

    Data sources include:

    1. bk_monitor - monitoring collection
    2. bk_data - data platform
    3. bk_log_search – Log retrieval
    4. custom - user-defined

    Data types are:

    1. time_series - time series data
    2. event - event
    3. log - log keyword

#### Sample data
```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_biz_ids":[2],
    "time_range":"2020-02-26 00:00:00 -- 2020-02-28 23:59:59",
    "conditions":[
        {
            "key":"event_status",
            "value":[
                "RECOVERED"
            ]
        },
        {
            "key":"data_source",
            "value":[
                "bk_monitor|time_series"
            ]
        }
    ],
    "page": 1,
    "page_size": 100
}
```

### response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | list | data |

#### data field description

| Field | Type | Description |
| ------------- | ------ | ------------------------------------------------------------ |
| bk_biz_id | int | Business ID |
| is_ack | bool | Confirm or not |
| level | int | Alarm level, 1 (execution) 2 (warning) 3 (reminder) |
| origin_alarm | dict | Exception point data when the event occurs |
| origin_config | dict | Alarm policy configuration when the event occurs. For data, please refer to the alarm policy API related documents |
| strategy_id | int | Alarm strategy ID |
| id | int | Increment ID of event table |
| is_shielded | bool | Whether it is shielded |
| event_id | string | Exception event ID |
| status | int | event status, ABNORMAL (not recovered) CLOSED (closed) RECOVERED (recovered) |
| create_time | string | The time when the event is generated, in the format of yyyy-mm-dd hh:mm:ss |
| begin_time | string | The creation time of the first exception point associated with this event, in the format of yyyy-mm-dd hh:mm:ss |
| end_time | string | The end time of the event, in the format of yyyy-mm-dd hh:mm:ss |
| target_key | string | Event target, empty string if it does not exist |
| p_event_id | string | Parent event ID, default is empty |

#### target key

Indicates the monitoring target corresponding to the current event. The data format is as follows:

- Host: host|ip|bk_cloud_id
     eg: host|10.0.0.1|0
- Service instance: service|bk_target_service_instance_id
     eg: service|13
- Topology node: topo|bk_obj_id|$bk_inst_id
     eg: topo|biz|2
- none: ""

#### origin_alarm

Represents the abnormal point data when the event occurs

| Field | Type | Description |
| ----------------------- | ------ | --------------- |
| data | dict | data |
| data.dimensions | dict | data dimensions |
| data.values | dict | Values of outliers |
| data.time | int | Timestamp of abnormal point |
| dimension_translation | dict | Dimension display information |
| anomaly | dict | exception information |
| anomaly.key | string | Alarm level |
| anomaly.anomaly_message | string | exception description |
| anomaly.anomaly_time | string | abnormal time |
| anomaly.anomaly_id | string | Abnormal location ID |

#### origin_alarm.dimension_translation - Dimension display information

Translate the dimensions into content displayed to the user, corresponding to the information in data.dimensions

1. display_name - dimension name
2. display_value - the value of the dimension
3. value - the original value of the dimension

```json
{
   "bk_topo_node":{
     "display_name":"bk_topo_node",
     "display_value":[
       {
         "bk_obj_name":"Cluster",
         "bk_inst_name":"Idle pool"
       },
       {
         "bk_obj_name":"Business",
         "bk_inst_name":"BlueKing"
       },
       {
         "bk_obj_name":"module",
         "bk_inst_name":"Idle machine"
       }
     ],
     "value":[
       "set|2",
       "biz|2",
       "module|3"
     ]
   },
   "bk_target_cloud_id":{
     "display_name":"bk_target_cloud_id",
     "display_value":0,
     "value":0
   },
   "bk_target_ip":{
     "display_name":"bk_target_ip",
     "display_value":"10.0.0.1",
     "value":"10.0.0.1"
   }
}
```

#### Sample data

```json
{
    "code": 200,
    "result": true,
    "message": "ok",
    "data": [
        {
            "status": "ABNORMAL",
            "bk_biz_id": 2,
            "is_ack": false,
            "level": 1,
            "origin_alarm": {
                "data": {
                    "record_id": "d751713988987e9331980363e24189ce.1574439900",
                    "values": {
                        "count": 10,
                        "dtEventTimeStamp": 1574439900
                    },
                    "dimensions": {},
                    "value": 10,
                    "time": 1574439900
                },
                "trigger": {
                    "level": "1",
                    "anomaly_ids": [
                        "d751713988987e9331980363e24189ce.1574439660.88.118.1",
                        "d751713988987e9331980363e24189ce.1574439720.88.118.1",
                        "d751713988987e9331980363e24189ce.1574439780.88.118.1",
                        "d751713988987e9331980363e24189ce.1574439840.88.118.1",
                        "d751713988987e9331980363e24189ce.1574439900.88.118.1",
                        "d751713988987e9331980363e24189ce.1574439960.88.118.1",
                        "d751713988987e9331980363e24189ce.1574440020.88.118.1",
                        "d751713988987e9331980363e24189ce.1574440080.88.118.1",
                        "d751713988987e9331980363e24189ce.1574440140.88.118.1"
                    ]
                },
                "anomaly": {
                    "1": {
                        "anomaly_message": "count >= 1.0, 当前值10.0",
                        "anomaly_time": "2019-11-22 16:31:06",
                        "anomaly_id": "d751713988987e9331980363e24189ce.1574439900.88.118.1"
                    }
                },
                "dimension_translation": {},
                "strategy_snapshot_key": "bk_bkmonitor.ee.cache.strategy.snapshot.88.1574411061"
            },
            "target_key": "",
            "strategy_id": 88,
            "id": 1364253,
            "is_shielded": false,
            "event_id": "d751713988987e9331980363e24189ce.1574439660.88.118.1",
            "create_time": "2019-11-22 16:31:07",
            "end_time": null,
            "begin_time": "2019-11-22 16:25:00",
            "origin_config": {},
            "p_event_id": ""
        }
    ]
}
```