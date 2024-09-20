# Basic performance data is not reported

## 1. Check whether the CMDB has snapshot data displayed

If there is no data, proceed to the following steps to detect

If there is data, first check whether there is an update_cc_cache.sh project in the crontab of the machine where bkdata is located.

If not, run `bkeec install cron` first. If you have any questions, please contact BlueKing technical support.

## 2. Check the process

Agent machine: ok if there is a process

### 2.1 Linux

>ps -ef | grep basereport

### 2.2 Windows

>tasklist | findstr basereport

## 3. If process detection fails

Check the reason why the process failed to start

### 3.1 Linux

> ./basereport -c ../etc/basereport.conf

### 3.2 Windows

> basereport.exe -c ../etc/basereport.conf

## 4. Check connection

Agent machine: If there is a normal connection ESTABLISHED then it is ok

### 4.1 Linux

>netstat -tnp | grep 58625

### 4.2 Windows

>netstat -ano | grep 58625

If there is a proxy, proxy machine: detect port 58625 as above. And check if the gse_transit process is normal (appears in pairs)

GSE_IP and GSE_IP1 machines: detect port 9092

### 4.3 Linux

>netstat -tnp | grep 9092

### 4.4 Windows

>netstat -ano | grep 9092

## 5. Check configuration

ZK_IP machine: view ZK nodes

```bash
>/data/bkee/service/zk/bin/zkCli.sh -server ip:2181 (ip is usually the zk local intranet IP)
get /gse/config/etc/dataserver/data/1001
```

Normally a data structure similar to the following will appear

```bash
{"server_id": -1, "data_set": "snapshot", "partition": 1, "cluster_ind ex": 0, "biz_id": 2, "msg_system": 1}
```

topic is composed of data_set and biz_id, then topic=snapshot2 can obtain the topic, then OK

## 6. Check data

On the KAFKA_IP machine: Check the latest KAFKA data, wait 1 minute to see if there is data, if there is data, OK

```bash
cd /data/bkee/service/kafka/
zkaddr=`cat config/server.properties | grep common_kafka | cut -d '=' -f 2`
sh bin/kafka-topics.sh --list --zookeeper $zkaddr
sh bin/kafka-console-consumer.sh --bootstrap-server $LAN_IP:9092--topic $topic (queried in step 5)
```

## 7. Check the logs

GSE_IP and GSE_IP1 machines:

```bash
ps -ef | grep gse_data
cd /data/bkee/public/gse/data
ls -l
```

Check if there are any logs named starting with gse_datapid

If yes, tail to view the log content