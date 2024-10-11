### Request method

POST


### Request address

/api/c/compapi/v2/bk_log/esquery_search/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Log query interface

### Request parameters

#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| indices | string | yes | index list |
| scenario_id | string | No | ES access scenario (not required) Default is log, native ES: es log collection: log |
| storage_cluster_id | int | No | Need to be passed in when scenario_id is es or log |
| time_field | string | No | Time field (not required, bkdata internally is dtEventTimeStamp, external time field needs to be specified if the time range is passed in) |
| start_time | string | no | start time |
| end_time | string | no | end time |
| time_range | string | No | Time identifier ["15m", "30m", "1h", "4h", "12h", "1d", "customized"] (optional, default 15m) |
| query_string | string | No | Search statement query_string (optional, default is *) |
| filter | list | No | Search filter conditions (not required, the default is no filter, the default operator is is) The operator supports is, is one of, is not, is not one of |
| start | int | No | Starting position (optional, similar to array slicing, default is 0) |
| size | int | No | Number of entries (optional, controls the returned entries) |
| aggs | dict | no | Aggregation parameters for ES |
| highlight | dict | no | highlight parameters |


### Request parameter example

```json
{
     "bk_app_code": "replace_me_with_bk_app_code",
     "bk_app_secret": "replace_me_with_bk_app_secret",
     "bk_username": "replace_me_with_bk_username",

     "indices": "2_bklog.bk_log_search_api",
     "scenario_id": "log",
     "storage_cluster_id": 3,
     "use_time_range": true,
     "time_range": "customized",
     "time_field": "dtEventTimeStamp",
     "start_time": "2022-03-14 18:26:33",
     "end_time": "2022-03-14 18:41:33",
     "query_string": "*",
     "filter": [],
     "sort_list": [
         [
             "dtEventTimeStamp",
             "desc"
         ],
         [
             "gseIndex",
             "desc"
         ],
         [
             "iterationIndex",
             "desc"
         ]
     ],
     "start": 0,
     "size": 1,
     "aggs": {},
     "highlight": {
         "pre_tags": [
             "<mark>"
         ],
         "post_tags": [
             "</mark>"
         ],
         "fields": {
             "*": {
                 "number_of_fragments": 0
             }
         },
         "require_field_match": false
     }
}
```

### Response parameters

| Field | Type | Description |
| ------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | return log content |
| request_id | string | Request ID |


### Return the log content field
| Field | Type | Description |
| ------- | ------ | ------------ |
| took | int | time spent |
| timed_out | bool | timed out |
| _shards | dict | shards request status |
| hits | dict | original log content in ES |


### Return result example

```json
{
     "result": true,
     "data": {
         "took": 17,
         "timed_out": false,
         "_shards": {
             "total": 3,
             "successful": 3,
             "skipped": 0,
             "failed": 0
         },
         "hits": {
             "total": 13606,
             "max_score": null,
             "hits": [
                 {
                     "_index": "v2_2_bklog_bk_log_search_api_20220310_0",
                     "_type": "_doc",
                     "_id": "1603fe2e851dd02b76cff2681052e0da",
                     "_score": null,
                     "_source": {
                         "cloudId": 0,
                         "dtEventTimeStamp": "1647254492000",
                         "gseIndex": 41041,
                         "iterationIndex": 9,
                         "log": "i am log message",
                         "path": "/host/path/log/type.log",
                         "serverIp": "127.0.0.1",
                         "time": "1647254492000"
                     },
                 }
             ]
         }
     },
     "code": 0,
     "message": "",
     "request_id": "ce9d1b034d9a423cb736af285041b978"
}
```