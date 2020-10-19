# DataFlow

| 变量                               | 建议值                                                | 说明                                    | 备注 |
|------------------------------------|-------------------------------------------------------|-----------------------------------------|------|
| \__TIME_ZONE_\_                    | Asia/Shanghai                                         | 时区配置                                |      |
| \__LOG_HOME_\_                     |                                                       |                                         |      |
|                                    |                                                       |                                         |      |
| \__AZKABAN_MYSQL_HOST_\_           | 无                                                    | Azkaban 对应MYSQL实例域名               |      |
| \__AZKABAN_MYSQL_PORT_\_           | 无                                                    | Azkaban 对应MYSQL端口                   |      |
| \__AZKABAN_MYSQL_USER_\_           | 无                                                    | Azkaban 对应MYSQL用户                   |      |
| \__AZKABAN_MYSQL_PASS_\_           | 无                                                    | Azkaban 对应MYSQL密码                   |      |
| \__AZKABAN_EXECUTOR_PORT_\_        | 无                                                    | Azkaban Executor端口                    |      |
| \__AZKABAN_EXECUTOR_MAX_THREAD_\_  | 600                                                   | Azkban Executor最大线程                 |      |
| \__AZKABAN_EXECUTOR_FLOW_THREAD_\_ | 480                                                   | Azkban Executor Flow线程                |      |
| \__AZKABAN_HOST_\_                 | 无                                                    | Azkaban Web Server机器                  |      |
| \__AZKABAN_PORT_\_                 | 无                                                    | Azkaban Web Server端口                  |      |
| \__AZKABAN_USER_\_                 | 无                                                    | Azkaban 用户名                          |      |
| \__AZKABAN_PASSWORD_\_             | 无                                                    | Azkaban 用户密码                        |      |
| \__AZKABAN_PYTHON_HOME_\_          | 无                                                    | Azkaban 使用PYTHON环境                  |      |
| \__AZKABAN_PATH_\_                 | 无                                                    | Azkaban安装目录                         |      |
| \__AZKABAN_SSL_PORT_\_             | 无                                                    | Azkaban SSL 端口                        |      |
| \__AZKABAN_MAX_THREAD_\_           | 25                                                    | Azkban Web最大线程                      |      |
| \__AZKABAN_OPTS_\_                 | \-Xms8G -Xmx8G -XX:PermSize=256M -XX:MaxPermSize=512M | Azkaban Jvm 参数                        |      |
|                                    |                                                       |                                         |      |
| \__JOBSVR_MYSQL_HOST_\_            | 无                                                    | Spark Jobserver 对应MYSQL实例域名       |      |
| \__JOBSVR_MYSQL_PORT_\_            | 无                                                    | Spark Jobserver 对应MYSQL端口           |      |
| \__JOBSVR_MYSQL_USER_\_            | 无                                                    | Spark Jobserver 对应MYSQL用户           |      |
| \__JOBSVR_MYSQL_PASS_\_            | 无                                                    | Spark Jobserver对应MYSQL密码            |      |
| \__JOBSVR_MAX_APP_\_               | 30                                                    | 每个APP占1G内存(建议30%内存)            |      |
| \__JOBSVR_CPU_CORES_\_             | 4                                                     |                                         |      |
| \__JOBSVR_MEM_PER_NODE_\_          | 12g                                                   |                                         |      |
| \__JOBSVR_USER_NAME_\_             | bkdata                                                |                                         |      |
| \__JOBSVR_PASS_\_                  | bkdata                                                |                                         |      |
| \__JOBSVR_MANAGER_PORT_\_          | 8090                                                  |                                         |      |
| \__JOBSVR_CONSUL_ADDR_\_           | jobsvr.service.consul                                 |                                         |      |
| \__JOBSVR_LIB_LOC_\_               |                                                       |                                         |      |
| \__JOBSVR_INSTALL_DIR_\_           |                                                       | JOBSVR安装目录                          |      |
| \__JOBSVR_SERVICE_ID_\_            | "1"                                                   |                                         |      |
|                                    |                                                       |                                         |      |
| \__SPARK_VERSION_\_                | 1.6.1                                                 |                                         |      |
| \__SPARK_HOME_\_                   |                                                       |                                         |      |
| \__SPARK_HISTORY_PORT_\_           | 8081                                                  |                                         |      |
|                                    |                                                       |                                         |      |
| \__HADOOP_HOME_\_                  | 无                                                    | Hadoop安装目录                          |      |
| \__HDFS_DEFAULT_FILESYSTEM_\_      | hdfsOnline                                            | HDFS默认文件系统                        |      |
| \__HDFS_WORK_DIR_\_                |                                                       | HDFS运行时目录                          |      |
| \__HDFS_HANDLER_COUNT_\_           | 24                                                    | 等于cpu core                            |      |
| \__HDFS_NN_HANDLER_COUNT_\_        | 48                                                    | 2 \* cpu core                           |      |
| \__NAMENODE_HOST_1_\_              | 无                                                    | 主NameNode                              |      |
| \__NAMENODE_HOST_2_\_              | 无                                                    | 备NameNode                              |      |
| \__NAMENODE_MEM_GB_\_              | 40                                                    | NameNode最大内存，GB.建议最大内存的50%  |      |
| \__NAMENODE_HTTP_PORT_\_           | 8081                                                  | NameNode HTTP端口                       |      |
| \__NAMENODE_RPC_PORT_\_            | 9000                                                  | NameNode RPC端口                        |      |
| \__DATANODE_MEM_GB_\_              |                                                       | DataNode最大内存，GB.                   |      |
| \__DATANODE_DATA_DIR_\_            | /data1/dfs/data,/data2/data/data                      | DataNode数据目录，逗号分隔              |      |
|                                    |                                                       |                                         |      |
| \__RM_HOST_1_\_                    | 无                                                    | 主ResourceManager                       |      |
| \__RM_HOST_2_\_                    | 无                                                    | 备ResourceManager                       |      |
| \__RM_PORT_\_                      | 8091                                                  | ResourceManager端口                     |      |
| \__RM_CONSUL_ADDR_\_               | yarn.service.consul                                   | 主RM 名字服务                           |      |
| \__RM_JAVA_HEAP_MB_\_              | 2048                                                  | ResourceManager Java Heap配置，MB       |      |
| \__RM_CLUSTER_ID_\_                | yarn_cluster_bk                                       | ResourceManager集群ID                   |      |
| \__RM_HTTP_PORT_\_                 | 8088                                                  | ResourceManager HTTP端口                |      |
| \__NM_CPU_VCORES_\_                | 等于cpu core                                          |                                         |      |
| \__MM_MEMORY_MB_\_                 | 40960                                                 | NM分配内存，MB。建议60%内存             |      |
| \__MM_MEMORY_MIN_MB_\_             | 2048                                                  | NM最小分配内存，MB                      |      |
|                                    |                                                       |                                         |      |
| \__SSH_PORT_\_                     | 36000                                                 |                                         |      |
| \__SSH_USERNAME_\_                 | root                                                  |                                         |      |
| \__SSH_PRIVATE_KEY_PATH_\_         | /root/.ssh/id_rsa                                     |                                         |      |
|                                    |                                                       |                                         |      |
| \__ZK_CONSUL_SERVICE_\_            |                                                       | ZK Consul服务名                         |      |
| \__ZK_PORT_\_                      |                                                       | ZK端口                                  |      |
|                                    |                                                       |                                         |      |
| \__JOURNAL_HOST_1_\_               |                                                       | JournalNode第一个节点                   |      |
| \__JOURNAL_HOST_2_\_               |                                                       | JournalNode第二个节点                   |      |
| \__JOURNAL_HOST_3_\_               |                                                       | JournalNode第三个节点                   |      |
| \__JOURNAL_PORT_\_                 | 8485                                                  | JournalNode端口                         |      |
|                                    |                                                       |                                         |      |
| \__STORM_ZK_\_                     |                                                       | zk地址                                  |      |
| \__STORM_ZK_ROOT_\_                | /bkdata_storm                                         | 假如有多个集群，需保证每个storm集群唯一 |      |
| \__STORM_ZK_PORT_\_                | 2181                                                  |                                         |      |
| \__STORM_NIMBUS_\_                 |                                                       | nimbus的ip地址                          |      |
| \__STORM_SLOTS_\_                  | Worker个数和cpu个数 1：1, eg: [6701，6702]            | 每台机器的worker个数(按端口递增)        |      |
| \__STORM_DATA_DIR_\_               |                                                       | 保存本地元数据目录(数据量小)            |      |
| \__STORM_WORKER_MEM_\_             | 3G(跟计算的groupby组合数成正比)                       | 每个worker的内存大小                    |      |
| \__STORM_INSTALL_DIR_\_            |                                                       |                                         |      |
|                                    |                                                       |                                         |      |
| \__DATAAPI_CONSUL_SERVICE_\_       |                                                       |                                         |      |
| \__DATAAPI_PORT_\_                 |                                                       |                                         |      |
| \__DATAAPI_HOST_\_                 |                                                       |                                         |      |
| \__RUN_MODE_\_                     |                                                       |                                         |      |
| \__MONITOR_APP_CODE_\_             |                                                       |                                         |      |
| \__MONITOR_APP_TOKEN_\_            |                                                       |                                         |      |
| \__PAAS_FQDN_\_                    |                                                       |                                         |      |
| \__MONITOR_DB_NAME_\_              |                                                       |                                         |      |
| \__MYSQL_HOST_\_                   |                                                       |                                         |      |
| \__MYSQL_PORT_\_                   |                                                       |                                         |      |
| \__MYSQL_USER_\_                   |                                                       |                                         |      |
| \__MYSQL_PASS_\_                   |                                                       |                                         |      |
| \__ES_HOST_\_                      |                                                       |                                         |      |
| \__ES_PORT_\_                      |                                                       |                                         |      |
| \__ES_TRANSPORT_PORT_\_            |                                                       |                                         |      |
| \__ES_CLUSTER_NAME_\_              |                                                       |                                         |      |
|                                    |                                                       |                                         |      |
| \__COMMON_REDIS_AUTH_\_            |                                                       |                                         |      |
| \__COMMON_REDIS_DNS_\_             |                                                       |                                         |      |
| \__COMMON_REDIS_PORT_\_            |                                                       |                                         |      |
| \__GSE_AGENT_PATH_\_               |                                                       |                                         |      |
| \__GSE_ZK_HOST_\_                  |                                                       |                                         |      |
| \__CONNECTOR_MYSQL_HOST_\_         |                                                       |                                         |      |
| \__CONNECTOR_MYSQL_PORT_\_         |                                                       |                                         |      |
| \__CONNECTOR_ES_HOST_\_            |                                                       |                                         |      |
| \__CONNECTOR_ES_PORT_\_            |                                                       |                                         |      |
| \__CONNECTOR_ETL_HOST_\_           |                                                       |                                         |      |
| \__CONNECTOR_ETL_PORT_\_           |                                                       |                                         |      |
| \__CONNECTOR_REDIS_HOST_\_         |                                                       |                                         |      |
| \__CONNECTOR_REDIS_PORT_\_         |                                                       |                                         |      |
| \__CONNECTOR_OFFLINE_HOST_\_       |                                                       |                                         |      |
| \__CONNECTOR_OFFLINE_PORT_\_       |                                                       |                                         |      |
| \__CONFIG_META_REDIS_HOST_\_       |                                                       |                                         |      |
| \__CONFIG_META_REDIS_PASSWORD_\_   |                                                       |                                         |      |
| \__CONFIG_META_REDIS_PORT_\_       |                                                       |                                         |      |
| \__CONFIG_CRATE_HOST_\_            |                                                       |                                         |      |
| \__CONFIG_CRATE_PORT_\_            |                                                       |                                         |      |
|                                    |                                                       |                                         |      |
| \__CONSUL_BIND_IP_\_               |                                                       | 本机绑定Consul的IP                      |      |
|                                    |                                                       |                                         |      |
| \__FABIO_INSTALL_DIR_\_            |                                                       | Fabio安装目录                           |      |
| \__FABIO_PORT_\_                   | 2345                                                  |                                         |      |
