## Overall description of the link

   ![](media/16224421704651.jpg)

The picture above shows the overall flow process of data collected by the BlueKing monitoring platform. The following will discuss the troubleshooting ideas when no data is reported in the link.

## Troubleshooting methods

### 1. Check whether data exists in kafka
    
First, we recommend starting with the data in kafka to determine whether the data anomaly occurs on the collection side or the server side. Users can refer to the data observation in command consumption kafka
    
```bash
./bin/kafka-console-consumer.sh --bootstrap-server kafka.service.sv.consul:9092 --topic 0bkmonitor_10010
```
    
If we are troubleshooting a certain IP reporting failure, then we can filter through grep
    
```bash
./bin/kafka-console-consumer.sh --bootstrap-server kafka.service.sv.consul:9092 --topic 0bkmonitor_10010 | grep $IP
```
    
If it is found that there is no data in kafka, you need to check the `collection end`, otherwise you need to check the `server end`. Usually there is an abnormality on the server side, and the situation of no data is caused by the occurrence of large-scale cross-business; if some machines report exceptions, it is more likely to be caused by exceptions on the collection side.

### 2. Check whether the collection terminal is normal
 
    
1. Observe the collector log
     Observe whether there is any reporting failure. If so,
   
     ```log
     2021-05-26T13:36:59+08:00 client.go:152 ERR try 1 times
     2021-05-26T13:37:02+08:00 client.go:152 ERR try 2 times
     2021-05-26T13:37:05+08:00 client.go:169 CRIT connect failed, program quit [dial unix /usr/local/gse_bkte/agent/data/ipc.state.report: connect: connection refused]
     ```
    
     Then it means that the GSE agent on the machine is abnormal and the collector cannot report data through the domain socket. At this point the GSE Agent status should be checked
   
2. Check GSE Agent status
     After checking that the collector is normal and confirming that the GSE Agent process is alive, you need to pay attention to whether there may be a problem between the GSE Agent and the GSE DataServer. You can pass the command
    
     ```bash
     netstat -np | grep 58625
     ```
    
     If it is found that S-Q is blocked, you need to check whether there is any abnormality in the network between GSE Agent and GSE DataServer.
    
3. No findings found during investigation
     If there are no abnormalities on the above collection ends and it is determined that there is no data in kafka, you need to check whether the link between GSE DataServer and kafka is normal. For specific troubleshooting methods, please refer to the GSE DataServer Maintenance Manual.

### 3. Check whether the server is normal

The server-side function investigation mainly focuses on the two modules `transfer` and `influxdb-proxy`. Both modules provide indicator interfaces, and the indicator data of the two modules can be obtained through `curl $BK_MONITORV3_TRANSFER_IP:$BK_TRANSFER_HTTP_PORT/metrics` or `curl $BK_MONITORV3_INFLUXDB_PROXY_IP:$BK_INFLUXDB_PROXY_PORT/metrics` respectively. The following will explain separately the indicators and their meanings that require special attention in the process of troubleshooting no data problems.


1. Check whether the transfer is normal
     - Indicator: transfer_pipeline_frontend_dropped_total
       Meaning: transfer fails to pull kafka data
       Handling suggestions: If you observe that the value continues to grow, you need to observe the transfer log and check whether the link between transfer and kafka is normal.
     - Indicator: transfer_pipeline_processor_dropped_total
       Meaning: Transfer handles abnormal data discard quantity
       Handling suggestions: If you observe that the value continues to grow, observe the log to confirm the reason why the data was discarded.
     - Indicator: transfer_pipeline_backend_dropped_total
       Meaning: Transfer data is discarded into the database
       Handling suggestions: If the value continues to grow, you can observe the log to confirm the reason for the write failure, and check whether there are any abnormalities in the corresponding storage (influxdb/ES)
     If a write exception or no abnormal indicators are observed, you need to observe influxdb-proxy at this time

2. Troubleshoot influxdb-proxy and influxdb
 
     - Metric: influxdb_proxy_backend_alive_status
       Meaning: Is influxdb-proxy to the backend influxdb normal?
       Handling suggestions: If any backend is found to be 0, it means that the link from proxy to influxdb is abnormal at this time. You need to check why influxdb is not alive or the link is abnormal.
     - Metric: influxdb_proxy_backend_backup_status
       Meaning: influxdb-proxy abnormal data backup number
       Solution: If the value continues to grow, you should check influxdb-proxy to confirm the cause of the influxdb write exception and repair influxdb.