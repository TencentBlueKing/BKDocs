 # FAQ 

 ## No Snapshot data in CMDB 

 > this The document description troubleshooting for enterprise versions 4.0 and above 
 > 
 > Snapshot data is not supported for Windows Host 

**Appearance**: The Real time status of the setting Manage system Display `Agent is not installed on the current Host or Agent is Batch`. 

**Reason**

 1. The gse and gse_Agent status are not normal 
 2. Snapshot data task for bkdata does not exist 
 3. abnormal in node or topic data in Kafka 

**Way of thinking**

 - Check module status 

  - To determine whether the status of CMDB, gse, gse_agent, zk, and kafka module is normal, use `./  bkeec status XXX module `to Confirm 

 -**Check CMDB log**

 ```bash 
 Examine the/data/bkee/log/CMDB/cmdb_datacollection.INFO file 
 ccapi.go93] fails to get configure, will get again, indicating normal 
 Return hostsnap.go:xxx] master check : iam still master, which means normal 
 Check the CMDB_datacollection.ERROR file Confirm err:fail to connect zookeeper. err: lookup zk.service. consume, etc. 
 If there is no subChan Close after "subcribing channel 2_snapshot" appears in the log, the data receiving coroutine works normal 
 If the above bars are normal, but there is no "handle xx num mesg, routines xx", it Description that there is no data in the channel. Please go to redis and subscribe ${biz}_snapshot to Confirm whether the channel has no data. Refer to the following method for checking redis data 
 Copy 
 ``` 

 -**Troubleshooting of gse agent Collections end**

 ```bash 
 #Check if the process exists, the basereport process exists and is unique 
 Linux： ps -ef | grep basereport 
 Windows: tasklist | findstr basereport 

 #If the process does not exist, Start Up it manual and check the reason for the failed 
 Linux: cd /usr/local/gse/plugins/bin && ./  basereport -c ../  etc/basereport.conf 
 Windows(cygwin): cd /cygdrive/c/gse/plugins/bin/ && ./  basereport -c ../  etc/basereport.conf 
 Windows(without cygwin) : cd C:/gse/plugins/bin/ && start.bat basereport 

 #Check the data reporting connection, if there is a normal ESTABLISHED link, it is OK 
 #If there is a proxy, log in to the proxy machine: Test port 58625 as above 
 Linux netstat -antp | grep 58625 | grep ESTABLISHED 
 Windows netstat -ano | grep 58625 
 Copy 
 ``` 

 -**GSE service Troubleshooting**

 ```bash 
 #Log in to the GSE backend service and check whether gse_data is connected to port 9092: 
 Linux: lsof -nP -c dataWorker | grep :9092 
 Windows: netstat -ano | grep 9092 

 #See if there is a log named after pid of gse_data. if yes, tail Log Content 
 datapid=$(pgrep -x dataWorker) 
 ls -l /data/bkee/public/gse/data/${datapid}* 
 Copy 
 ``` 

 - Check kafka 
  - Login to any KAFKA machine: view the latest data of KAFKA, wait for 1 minutes to check whether there is data. If there is data, add `after One last line of command| grep $ip` $ip Replace with an ip without snapshot data, and check again to see if there is data 

 ```bash 
 #signIn to the machine where Kafka is located 
 $ source /data/install/utils.fc 
 /data/bkee/service/zk/bin/zkCli.sh -server zk.service.consul:2181 get /gse/config/etc/dataserver/data/1001 
 Confirm the existence of topic 
 zkaddr=`cat /data/bkee/service/kafka/config/server.properties | grep common_kafka | cut -d '=' -f 2` 
 topic=`bash /data/bkee/service/kafka/bin/kafka-topics.sh --list --zookeeper $zkaddr|grep ^snap` 

 view the latest data in the topic 
 bash /data/bkee/service/kafka/bin/kafka-console-consumer.sh --zookeeper $zkaddr --topic $topic 
 #data will be reported every One minutes. If there is data reported, it means normal 
 Copy 
 ``` 

 -**Check bkdata**

 ```bash 
 #Snapshot data corresponds to bkdata, the redis Task of databus. You need to Confirm whether the redis task in databus status exists. 
 $ bash /data/bkee/bkdata/dataapi/bin/check_databus_status.sh 
 #Check if the following redis Task exists 
 ===========REDIS=============== 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current 
                                 Dload  Upload   Total   Spent    Left  Speed 
 100    25  100    25    0     0    142      0 --:--:-- --:--:-- --:--:--   142 
 redis_1001_2_snapshot 
 {"name":"redis_1001_2_snapshot","connector":{"state":"RUNNING","worker_id":"x.x.x.x:10053"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"x.x.x.x:10053"}]} 
 ========================== 

 #If the above Task does not exist, an exception may occur when initializing bkdata data. You can use the following method to create it. First, Confirm whether init_bkdata_snapshot exists. 
 $ ll /data/bkee/.init_bkdata_snapshot 
 $ rm -f /data/bkee/.init_bkdata_snapshot 
 $ deactivate 
 $ source /data/install/utils.fc 
 $ init_bkdata_snapshot 
 #Confirm whether there is a redis Task according to the above 
 Copy 
 ``` 

 - **Check redis channel**

 ```bash 
 #This step mainly checks whether there is snapshot data in the Redis service. 
 source /data/install/utils.fc 
 $ redis-cli -h $REDIS_IP -p $REDIS_PORT -a $REDIS_PASS 
 10.X.X.X:6379> Auth "REDIS password" 
 OK 
 10.X.X.X:6379> SUBSCRIBE 2_snapshot 
 Reading messages... (press Ctrl-C to quit) 
 1) "subscribe" 
 2) "2_snapshot" 
 3) (integer) 1 
 1) "message" 
 2) "2_snapshot" 
 3) "{\"localTime\": \"2018-08-15 11:18:00\", \"data\": \"{\\\"beat\\\":{\\\"address\\\": 
 Copy 
 ``` 

 ## No Host Information in CMDB 

**Appearance**: Host information in CMDB is empty. 

**Reason**

 1. gse Install Abnormal or incorrect gse data initialization 
 2. gse_Agent Install Abnormal 

**Approach**

 Reason 1: Refer to the solution for GSE data initialization failed. You need to Update the initialization program file on_migrate and parse_bizid in the GSE version. The path `/data/bkee/gse/server/bin`. 

 Reason 2: Reinstall gse_agent