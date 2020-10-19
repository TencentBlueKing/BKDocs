# 维护说明

1.  总线服务分发数据到数据库，在数据库停机维护时间较长会超出进程的重试次数导致任务失败，建议数据库和总线服务同时进行停机，避免数据丢失或任务异常

    重启命令如下

```bash
$BK_HOME/.envs/databus/bin/supervisorctl -c $BK_HOME/etc/supervisor-bkdata-databus.conf restart all
```
2.  数据模块服务日志目录主要文件说明如下：
```bash
├── azkaban
│   ├── azkaban-access.log
│   ├── azkaban-execserver.log
│   ├── azkaban-exec-server-supervisord.log
│   ├── azkaban-exec-server-supervisord.pid
│   ├── azkaban-exec-server-supervisor.sock
│   ├── azkaban-executor-stderr---supervisor-MMndHM.log
│   ├── azkaban-executor-stdout---supervisor-U89LIr.log
│   ├── azkaban-webserver-supervisord.log
│   ├── azkaban-webserver-supervisord.pid
│   ├── azkaban-webserver-supervisor.sock
│   └── azkaban-web-supervisor.log
├── bkdata
│   ├── crontab.log
│   ├── data_access.log
│   ├── dataapi
│   ├── processorapi
│   ├── dataapi-celery-worker1-1.log
│   ├── dataapi-celery-worker2-1.log
│   ├── dataapi-celery-worker3-1.log
│   ├── dataapi-proc_dataapi.log
│   ├── dataapi-supervisord.log
│   ├── dataapi-supervisord.pid
│   ├── dataapi-supervisor.sock
│   ├── databus_es.log
│   ├── databus_etl.log
│   ├── databus_hdfs.log
│   ├── databus_jdbc.log
│   ├── databus_offline.log
│   ├── databus_redis.log
│   ├── databus-supervisord.log
│   ├── databus-supervisord.pid
│   ├── databus-supervisor.sock
│   ├── databus_tsdb.log
│   ├── datamanager
│   ├── datamanager.log
│   ├── datamanager-supervisord.log
│   ├── datamanager-supervisord.pid
│   ├── datamanager-supervisor.sock
│   ├── es_gc.log.0
│   ├── etl_gc.log.0
│   ├── gunicorn-access.log
│   ├── gunicorn-error.log
│   ├── hdfs_gc.log.0
│   ├── jdbc_gc.log.0
│   ├── kernel.2017-11-13.log
│   ├── kernel.2017-11-14.log
│   ├── kernel.2017-11-15.log
│   ├── kernel.2017-11-16.log
│   ├── kernel.2017-11-17.log
│   ├── kernel.log
│   ├── monitor-supervisord.log
│   ├── monitor-supervisord.pid
│   ├── monitor-supervisor.sock
│   ├── offline_gc.log.0
│   ├── offline_gc.log.0.current
│   ├── offline_gc.log.1.current
│   ├── redis_gc.log.0
│   ├── redis_gc.log.0.current
│   ├── redis_gc.log.1.current
│   ├── tsdb_gc.log.0
│   ├── tsdb_gc.log.0.current
│   └── tsdb_gc.log.1.current
├── consul
├── consul.log
├── consul.pid
├── es
├── hadoop
│   ├── hadoop-master-supervisord.log
│   ├── hadoop-master-supervisord.pid
│   ├── hadoop-master-supervisor.sock
│   ├── hadoop-root-journalnode-\${HOSTNAME}.site.log
│   ├── hadoop-root-journalnode-\${HOSTNAME}.site.out
│   ├── hadoop-root-namenode-\${HOSTNAME}.site.log
│   ├── hadoop-root-namenode-\${HOSTNAME}.site.out
│   ├── hadoop-root-zkfc-\${HOSTNAME}.site.log
│   ├── hdfs-journalnode-supervisor.log
│   ├── hdfs-namenode-supervisor.log
│   ├── hdfs-zkfc-supervisor.log
│   ├── mapred-jobhistory-supervisor.log
│   ├── namenode-gc.log.0.current
│   ├── resourcemanager-gc.log.0.current
│   ├── SecurityAuth-root.audit
│   ├── spark-jobhistory-supervisor.log
│   ├── yarn
│   ├── yarn-proxyserver-supervisor.log
│   └── yarn-resourcemanager-supervisor.log
├── kafka
├── spark
│   ├── jobserver
│   ├── spark_jobserver-supervisord.log
│   ├── spark_jobserver-supervisord.pid
│   ├── spark_jobserver-supervisor.sock
│   ├── spark-jobsvr-stderr---supervisor-ir4oNj.log
│   ├── spark-jobsvr-stdout---supervisor-9kkCkp.log
│   ├── spark-root-org.apache.spark.deploy.history.HistoryServer-1-\${HOSTNAME}.site.out
│   ├── spark-supervisord.log
│   ├── spark-supervisord.pid
│   └── spark-supervisor.sock
└── storm
    ├── nimbus.log
    ├── storm-nimbus.log
    ├── storm-nimbus-supervisord.log
    ├── storm-nimbus-supervisord.pid
    ├── storm-nimbus-supervisor.sock
    ├── storm-supervisor.log
    ├── storm-supervisor-supervisord.log
    ├── storm-supervisor-supervisord.pid
    ├── storm-supervisor-supervisor.sock
    ├── storm-ui.log
    ├── supervisor.log
    ├── ui.log
    └── worker-6700.log

```
3.  一些开源组件（Azkaban、JobSvr）自身的清理功能不足，运行一段时间会导致系统不可用。对这些组件需要加清理：

- JobServer

在所有 jobsvr 机器上加入 crontab 作业：
```bash
/bin/find __LOG_HOME__/job-server -type d -mtime +7 | xargs -r rm -rfv &>
/tmp/clean-spark-jobserver-logs.log
```
- Azkaban

在所有azkaban executor机器上加入crontab作业：
```bash
/bin/find __LOG_HOME__/azkaban -type d -mtime +7 | xargs -r rm -rfv &>
/tmp/clean-spark-jobserver-logs.log
```