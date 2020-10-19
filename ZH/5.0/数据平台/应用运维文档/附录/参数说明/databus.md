# DataBus

bkdata\#databus\#conf\#es.cluster.properties

| 变量                      | 含义                     | 字面值示意                                   | 备注       |
|---------------------------|--------------------------|----------------------------------------------|------------|
| \__ZK_FOR_KAFKA_\_        | Kafka链接的zk服务器      | x.x.x.x:2181/common_kafka                    |            |
| \__KAFKA_HOST_\_          | Kafka主机                | x.x.x.x:9092, x.x.x.x:9092                   |            |
| \__DATABUS_IP_\_          | 绑定的内网ip             | x.x.x.x.                                     | 本机内网ip |
| \__CONNECTOR_ES_PORT_\_   | Es分发集群rest服务端口号 | 10002                                        |            |
| \__DATAAPI_SERVER_IP_\_   | Dataapi ip               | x.x.x.x                                      |            |
| \__DATAAPI_SERVER_PORT_\_ | Dataapi端口号            | 8833                                         |            |
| \__CERT_PATH_\_           | 证书文件目录             | /data/bksuite_ce-3.0.20-beta/datasvr/bk_conf |            |
| \__CERT_HOST_\_           | 证书服务器               | x.x.x.x                                      |            |

bkdata\#databus\#conf\#jdbc.cluster.properties

| 变量                       | 含义                        | 字面值示意                                   | 备注       |
|----------------------------|-----------------------------|----------------------------------------------|------------|
| \__ZK_FOR_KAFKA_\_         | Kafka链接的zk服务器         | x.x.x.x:2181/common_kafka                    |            |
| \__KAFKA_HOST_\_           | Kafka主机                   | x.x.x.x:9092, x.x.x.x:9092                   |            |
| \__DATABUS_IP_\_           | 绑定的内网ip                | x.x.x.x                                      | 本机内网IP |
| \__CONNECTOR_MYSQL_PORT_\_ | MYSQL分发集群rest服务端口号 | 10002                                        |            |
| \__DATAAPI_SERVER_IP_\_    | Dataapi ip                  | x.x.x.x                                      |            |
| \__DATAAPI_SERVER_PORT_\_  | Dataapi端口号               | 8833                                         |            |
| \__CERT_PATH_\_            | 证书文件目录                | /data/bksuite_ce-3.0.20-beta/datasvr/bk_conf |            |
| \__CERT_HOST_\_            | 证书服务器                  | x.x.x.x                                      |            |

bkdata\#databus\#conf\#etl.cluster.properties

| 变量                      | 含义                       | 字面值示意                                   | 备注       |
|---------------------------|----------------------------|----------------------------------------------|------------|
| \__ZK_FOR_KAFKA_\_        | Kafka链接的zk服务器        | x.x.x.x:2181/common_kafka                    |            |
| \__KAFKA_HOST_\_          | Kafka主机                  | x.x.x.x:9092,x.x.x.x:9092                    |            |
| \__DATABUS_IP_\_          | 绑定的内网ip               | x.x.x.x                                      | 本机内网IP |
| \__CONNECTOR_ETL_PORT_\_  | 清洗分发集群rest服务端口号 | 10002                                        |            |
| \__DATAAPI_SERVER_IP_\_   | Dataapi ip                 | x.x.x.x                                      |            |
| \__DATAAPI_SERVER_PORT_\_ | Dataapi端口号              | 8833                                         |            |
| \__CERT_PATH_\_           | 证书文件目录               | /data/bksuite_ce-3.0.20-beta/datasvr/bk_conf |            |
| \__CERT_HOST_\_           | 证书服务器                 | x.x.x.x                                      |            |
