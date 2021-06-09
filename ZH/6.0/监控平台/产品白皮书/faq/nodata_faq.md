## 链路整体说明

  ![](media/16224421704651.jpg)

上图是蓝鲸监控平台采集数据的整体流转过程。下面将会讨论，当链路中出现无数据上报时的排查思路。

## 排查手段

### 1. 排查kafka中是否存在数据
    
首先，我们建议先通过kafka中的数据入手，判断数据异常是出现在采集端还是服务端。用户可以参考一下命令消费kafka中的数据观察
    
```bash
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka.service.consul:9092 --topic 0bkmonitor_10010 
```
    
如果我们是排查某个IP上报失败的情况，那么我们可以通过grep进行过滤
    
```bash
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka.service.consul:9092 --topic 0bkmonitor_10010 | grep $IP
```
    
如果发现kafka中无数据，则需要排查`采集端`，否则需要排查`服务端`。通常是服务端出现异常，无数据情况是大规模跨业务的出现；如果是部分机器存在上报异常，那么更多是采集端异常导致。

### 2. 排查采集端是否正常
 
    
1. 观察采集器日志
    观察是否有上报失败的情况，如果出现
   
    ```log
    2021-05-26T13:36:59+08:00 client.go:152 ERR try 1 times
    2021-05-26T13:37:02+08:00 client.go:152 ERR try 2 times
    2021-05-26T13:37:05+08:00 client.go:169 CRIT connect failed, program quit [dial unix /usr/local/gse_bkte/agent/data/ipc.state.report: connect: connection refused]
    ```
    
    那么表示机器上的GSE agent异常，采集器无法通过domain socket上报数据。此时应该检查GSE Agent状态
   
2. 检查GSE Agent状态
    当检查采集器正常后并确认GSE Agent进程存活后，此时需要关注是否可能GSE Agent到GSE DataServer之间存在问题。可以通过命令
    
    ```bash
    netstat -np | grep 58625
    ```
    
    如果发现S-Q存在阻塞，那么需要检查GSE Agent到GSE DataServer之间的网络是否存在异常情况
    
3. 排查无发现
    如果上述采集端都无异常情况，并确定kafka中无数据，此时需要检查GSE DataServer到kafka的链接是否正常。具体排查方式，请参考GSE DataServer维护手册。

### 3. 排查服务端是否正常

服务端的功能排查，主要集中在`transfer`和`influxdb-proxy`两个模块。两个模块都提供有指标接口，分别可以通过`curl $BK_MONITORV3_TRANSFER_IP:$BK_TRANSFER_HTTP_PORT/metrics`或`curl $BK_MONITORV3_INFLUXDB_PROXY_IP:$BK_INFLUXDB_PROXY_PORT/metrics`的方式获取两个模块的指标数据。下面将分别说明，在排查无数据问题过程中，需要特别注意的指标及其含义


1. 排查transfer是否正常
    - 指标: transfer_pipeline_frontend_dropped_total
      含义: transfer拉取kafka数据失败条数
      处理建议: 如果观察该值不断增长，需要观察transfer日志，排查transfer与kafka的链接是否正常
    - 指标: transfer_pipeline_processor_dropped_total
      含义: transfer处理异常数据丢弃数量
      处理建议: 如果观察该值不断增长，观察日志确认数据被丢弃原因
    - 指标: transfer_pipeline_backend_dropped_total
      含义: transfer数据入库丢弃数量
      处理建议: 如果该值不断增长，可以观察日志确认写入失败原因，同时检查对应的存储(influxdb/ES)是否有异常
    如果观察到是写入异常或无任何异常指标，此时需要观察influxdb-proxy

2. 排查influxdb-proxy及influxdb
 
    - 指标: influxdb_proxy_backend_alive_status
      含义: influxdb-proxy到后端influxdb是否正常
      处理建议: 如果发现有任何一个后端为0，表示此时proxy到influxdb链接异常，需要检查influxdb为何不存活或链接异常
    - 指标: influxdb_proxy_backend_backup_status
      含义: influxdb-proxy异常数据备份数量
      处理建议: 如果该值不断在增长，此时应该检查influxdb-proxy确认influxdb写入异常原因，并对influxdb进行修复



