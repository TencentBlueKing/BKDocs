# ProcessorAPI

环境变量

bkdata\#processorapi\#conf\#dataapi_settings.py

| 变量                     | 含义                         | 字面值示意(如果带有引号，代表引号也需要填写字面值) | 备注           |
|--------------------------|------------------------------|----------------------------------------------------|----------------|
| \__PROCESSORAPI_PORT_\_  | processorapi服务端口         | 8832                                               |                |
| \__LAN_IP_\_             | processorapi服务绑定的内网IP | x.x.xx                                             | 这个是本机的ip |
| \__BK_HOME_\_            | 安装根目录                   | /data/bkee                                         |                |
| \__RUN_MODE_\_           | 运行模式                     | PRODUCT                                            |                |
| \__APP_CODE_\_           | 监控APPCODE                  | bk_bkdata                                          |                |
| \__APP_TOKEN_\_          | 监控APP Token                | 72125ea1-0f18-4669-9c73-85185fd6e871               |                |
| \__MYSQL_IP_\_           | Mysql主机                    | x.x.x.x                                            |                |
| \__MYSQL_PORT_\_         | Mysql端口                    | 3306                                               |                |
| \__MYSQL_USER_\_         | Mysql用户名                  | root                                               |                |
| \__MYSQL_PASS_\_         | Mysql密码                    | Xxxx                                               |                |
| \__REDIS_PASS_\_         | REDIS密码                    | Xxxx                                               |                |
| \__REDIS_HOST_\_         | REDIS主机                    | x.x.x.x                                            |                |
| \__REDIS_PORT_\_         | REDIS端口                    | 9300                                               |                |
| \__REDIS_CLUSTER_HOST_\_ | REDIS sentinel主机           | x.x.x.x                                            |                |
| \__REDIS_MASTER_NAME_\_  | REDIS sentinel名             | mymaster                                           |                |
| \__REDIS_CLUSTER_PORT_\_ | REDIS sentinel端口           | 9300                                               |                |
| \__AZKABAN_IP_\_         | Azkaban主机                  | x.x.x.x                                            |                |
| \__AZKABAN_PORT_\_       | Azkaban端口                  | 9300                                               |                |
| \__AZKABAN_USER_\_       | Azkaban登录用户名            | Azkaban                                            |                |
| \__HADOOP_IP_\_          | Hadoop主机                   | x.x.x.x                                            |                |
| \__NAMENODE_HTTP_PORT_\_ | Namenode HTTP 端口           | 9300                                               |                |
| \__RM_HTTP_PORT_\_       | ResourceManager HTTP 端口    | 9300                                               |                |
| \__SPARK_JOBSVR_USER_\_  | Spark JobServer登录用户      | Bk_jobsvr                                          |                |
| \__SPARK_JOBSVR_PASS_\_  | Spark JobServer密码          | Xxxx                                               |                |
| \__CRATE_HOST_\_         | CRATEDB 主机                 | x.x.x.x                                            |                |
| \__CRATE_HTTP_PORT_\_    | CRATEDB 端口                 | 9300                                               |                |
| \__CONSUL_HTTP_PORT_\_   | Consul 端口                  | 9300                                               |                |
| \__RABBITMQ_HOST_\_      | RabbitMQ 主机                | x.x.x.x                                            |                |
| \__RABBITMQ_PORT_\_      | RabbitMQ 端口                | 9300                                               |                |
| \__BKSQL_HOST_\_         | BKSQL主机                    | x.x.x.x                                            |                |
| \__BKSQL_PORT_\_         | BKSQL端口                    | 9300                                               |                |
| \__KAFKA_HOST_\_         | KAFKA主机                    | x.x.x.x                                            |                |
| \__KAFKA\_ PORT \_\_     | KAFKA端口                    | 9300                                               |                |
| \__STORM_IP_\_           | STORM主机                    | x.x.x.x                                            |                |
