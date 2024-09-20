### Request method

GET


### Request address

/api/c/compapi/v2/monitor_v3/get_event_log/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query event flow records

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---- | ------ | ---- | ------ |
| id | string | yes | alarm ID |

#### Sample data

```json
{
   "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
   "id": 164239028644167
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |

#### data field description

| Field | Type | Description |
| ----------- | ------ | -------- |
| status | string | status |
| event_id | string | event ID |
| message | string | record message |
| operate | string | record type |
| extend_info | dict | other data |
| create_time | string | Creation time |

#### operate - record type

* CREATE - Alarm generation
* CONVERGE - alarm convergence
* RECOVER - Alarm recovery
* CLOSE - Alarm closed
* DELAY_RECOVER - delayed recovery
* ABORT_RECOVER - interrupt recovery
* SYSTEM_RECOVER - Alarm recovery
* SYSTEM_CLOSE - Alarm closed
* ACK - Alarm acknowledgment
* SEVERITY_UP - Alarm level adjustment
* ACTION - processing action

#### status - status

*SUCCESS - successful

#### extend_info

Different types of records have different data

##### ANOMALY_NOTICE - Alarm notification

* action - notification configuration (refer to the action_list description in the "Query Event" interface document)

```json
{
     "action": {}
}
```

##### CONVERGE - Alarm convergence

* process_time - the processing time period for converged data points
* anomaly_count - the number of convergence anomaly points
* data_time - the data time period for the converged data point
* anomaly_record - abnormal point record (refer to the origin_alarm description in the "query event" interface document)

```json
{
     "process_time": {
         "max": 1583914154,
         "min": 1583911227
     },
     "anomaly_record": {},
     "data_time": {
         "max": 1583914020,
         "min": 1583911080
     },
     "anomaly_count": 50
}
```

#### Sample data

```json
{
     "result": true,
     "code": 200,
     "message": "ok",
     "data": [
         {
             "status": "SUCCESS",
             "event_id": "164239028644167",
             "message": "",
             "operate": "CREATE",
             "extend_info": "",
             "create_time": "2020-01-01 00:00:00"
         }
     ]
}
```

|
|