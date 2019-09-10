# 数据平台FAQ

## initdata bkdata失败

**表象**：在`./bkcec initdata bkdata`时，会出现类似如下报错


```bash
ERROR:init_snapshot_config (databus.tests.DatabusHealthTestCase)
ConnectionError:HTTPConnectionPool(host='databus.service.consul', port=10052):Max retried exceeded with url: /connectors (Caused by NewConnectionError('<requests.packages.urllib3.connection.HTTPConnection object at 0x7f90939a7110>: Failed to establish a new connection: [Errno -2] Name or service not known',))
```

**思路方法**

> 升级用户：确认在升级前，若需要初始化bkdata数据，先删除bkdata服务器`/data/bkce/.dataapi_snaphost`和`/data/bkce/.init_bkdata_snapshot`文件

> 注意：如下操作，要求安装路径为/data/bkce，源路径为`/data/install`

1. 确认databus日志是否有Exception的错误，示例如下

  ```bash
grep -nE "Exception" /data/bkce/logs/bkdata/databus_etl.log /data/bkce/logs/bkdata/databus_tsdb.log
199:org.apache.kafka.common.errors.wakeupException
12:Exception in thread "main" org.apache.kafka.common.config.configException: Invalid value for configuration rest.port: Not a number of type INT
  ```

2. 若有1的错误存在，确认端口配置，10054端口是否返回，若为空需要添加上

  ```bash
grep -nE port /data/bkce/bkdata/databus/conf/tsdb.cluster.properties
16:cluster.rest.port=10054
  ```

3. 确认`/data/bkce/bkdata/dataapi/bin/check_databus_status.sh`状态，不能出现有`Failed connect to databus.service.consul:10054; connection refused`或者`JSON object could be decoded`错误输出

4. 确认kafka，若社区版为3台部署的，必须返回[1, 2, 3]才正常，示例如下

	若brokers ids不为[1, 2, 3]，可能存在`/data/bkce/public/kafka/.lock`文件，有的话，删除此文件，再重新使用`./bkcec stop kafka`和`./bkcec start kafka`重启kafka，重启完再次确认状态

	```bash
	[root@rbtnode1 /data/install]# /data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 ls /common_kafka/brokers/ids
	Connecting to zk.service.consul:2181
	log4j:WARN No appenders could be found for logger (org.apache.zookeeper.ZooKeeper).
	log4j:WARN Please initialize the log4j system properly.
	log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.

	WATCHER::

	WatchedEvent state:SyncConnected type:None path:null
	[1, 2, 3]
	```

5. 若上述1，2，3，4均OK，采用如下方法重新进行初始化数据
	```bash
	# 在bkdata机器：
	rm -rf /data/bkce/.dataapi_snaphost /data/bkce/.init_bkdata_snapshot

	# 在中控机停掉bkdata
	./bkcec stop bkdata

	# 在中控机重新初始化bkdata，此处正常会等很久，出现很多add xxx connector的输出，若出现的话，等它全部正常结束
	./bkcec initdata bkdata
	[10.X.X.X]20180821-095319 120   migrate bkdata(dataapi) done
	[10.X.X.X]20180821-095320 78   starting bkdata(ALL) on host: 10.X.X.X
	[10.X.X.X]20180821-095334 85   going to init snapshot data. this may take a while.
	......
	http://databus.service.consul:10052/connectors
	init data of snapshot and components
	add etl connector of 2_uptimecheck_heartbeat
	add etl connector of 2_uptimecheck_http
	add etl connector of 2_redis_cpu
	add etl connector of 2_redis_client
	......
	add tsdb connector of 2_mysql_performance
	add tsdb connector of 2_mysql_rep

	# 等待上述完成，再启动bkdata
	./bkcec start bkdata
	```

**如何确认`initdata bkdata`的结果是正常**

1. 确认在`initdata bkdata`，最后有如下的正常输出

  ```bash
  update reserved dataids DONE
  [10.X.X.X]20180821-095319 120   migrate bkdata(dataapi) done
  [10.X.X.X]20180821-095320 78   starting bkdata(ALL) on host: 10.X.X.X
  [10.X.X.X]20180821-095334 85   going to init snapshot data. this may take a while.
  ......
  http://databus.service.consul:10052/connectors
  init data of snapshot and components
  add etl connector of 2_uptimecheck_heartbeat
  add etl connector of 2_uptimecheck_http
  add etl connector of 2_redis_cpu
  add etl connector of 2_redis_client
  ......
  add tsdb connector of 2_mysql_performance
  add tsdb connector of 2_mysql_rep
  add tsdb connector of 2_apache_net
  add tsdb connector of 2_apache_performance
  .
  ----------------------------------------------------------------------
  Ran 1 test in 156.952s

  OK
  ```

2. 确认在bkdata服务器上，`check_databus_status.sh`，不能出现有`Failed connect to databus.service.consul:10054; connection refused`或者`JSON object could be decoded`错误输出。正常的输出示例如下

  ```bash
  [root@rbtnode1 /data/install]# /data/bkce/bkdata/dataapi/bin/check_databus_status.sh
  ===========TSDB===============
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100   773  100   773    0     0  14599      0 --:--:-- --:--:-- --:--:-- 14865
  tsdb_2_system_cpu_summary
  {"name":"tsdb_2_system_cpu_summary","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10054"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10054"}]}

  ===========MYSQL===============
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100    27  100    27    0     0   1118      0 --:--:-- --:--:-- --:--:--  1125
  jdbc_2_ja_gse_proc_port
  {"name":"jdbc_2_ja_gse_proc_port","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10051"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10051"}]}

  ===========ETL===============
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100  1040  100  1040    0     0   166k      0 --:--:-- --:--:-- --:--:--  169k
  etl_1001_2_system_cpu_summary
  {"name":"etl_1001_2_system_cpu_summary","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10052"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10052"}]}
  ```

## bkdata常见问题排查

- ZK配置错误，数据无法发送
- agent制定IP有误，和CMDB无法管理
- crontab未设置，未启动定时同步IP到业务映射，导致监控无数据
- consul服务异常，导致kafka及其他consul模块无法解析
- tsdb-proxy未启动
- RabbitMQ密码错误，celery启动失败
- kafka broker启动失败，或者节点缺失
- cmdb未启动，初始化databpi失败
