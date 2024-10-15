# How to set alarm callback

In order to facilitate other applications to access alarm messages, alarm notifications provide a callback function. Users can register a callback address in the alarm group. Each alarm notification will call this address and send the corresponding notification message.

## Function Description

### Set entrance

Location: Navigation → Monitoring Configuration → Alarm Group → Callback Address

![Screenshot of alarm group settings](media/15833979854386.jpg)

### Callback confirmation

In order to ensure that the receiver receives the notification message, we require the return value of the request to be 200, otherwise the request will be considered failed.

### Message retry

In order that the receiver will not fail to receive the message due to short-term network fluctuations, we have a retry mechanism. There are two opportunities to retry, with the time interval increasing each time.

1. After the first request fails, try again after 5 seconds.
2. After the second request fails, try again after 10 seconds.
3. After the third request fails, no more attempts will be made.

### time out

In order to ensure that the callback processing process will not be blocked due to exceptions on the receiver side, the callback request displays the request time, and timeout requests will be considered failed.

The timeout is controlled by the global variable **Webhook timeout**, and the default is 3 seconds.

### Callback message

POST message

```json
{
   "bk_biz_id": 2, # Business ID
   "bk_biz_name": "BlueKing", # Business name
   "latest_anomaly_record":{ # Latest anomaly point information
     "origin_alarm":{
       "anomaly":{ #Exception information
         "1":{ # Alarm level
           "anomaly_message":"avg(usage) >= 0.0, current value 46.17", #Exception message
           "anomaly_time":"2020-03-03 04:10:02", #Exception event
           "anomaly_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540.144.147.1" # Abnormal data ID
         }
       },
       "data":{ # Data information
         "record_id":"48af047a4251b9f49b7cdbc66579c23a.1583208540", # Data ID
         "values":{ # data values
           "usage":46.17,
           "time":1583208540
         },
         "dimensions":{ # Data dimensions
           "bk_topo_node":[
             "module|6"
           ],
           "bk_target_ip":"10.0.0.1",
           "bk_target_cloud_id":"0"
         },
         "value":46.17, # indicator value
         "time":1583208540 # time
       }
     },
     "create_time":"2020-03-03 04:10:02", # Generate event
     "source_time":"2020-03-03 04:09:00", # Data events
     "anomaly_id":6211913 # Anomaly ID
   },
   "type":"ANOMALY_NOTICE", #Notification type ANOMALY_NOTICE exception notification, RECOVERY_NOTICE recovery notification
   "event":{ #Event information
     "create_time":"2020-03-03 03:09:54", #Generation time
     "end_time":"2020-03-03 04:19:00", # End time
     "begin_time":"2020-03-03 03:08:00", # Start time
     "event_id":"48af047a4251b9f49b7cdbc66579c23a.1583204880.144.147.1",
     "level":1, # Alarm level
     "level_name": "fatal", # level name
     "id":8817 #Event ID
   },
   "strategy":{
         "item_list":[
             {
                 "metric_field_name":"usage rate", # metric name
                 "metric_field":"usage" # metric
             }
         ],
         "id":144, # Policy ID
         "name":"test strategy" #Strategy name
     }
}
```