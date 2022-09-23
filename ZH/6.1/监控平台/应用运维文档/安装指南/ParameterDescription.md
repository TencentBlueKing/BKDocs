# 参数说明

## Monitor

### monitor#conf#worker#production#enterprise.py

| 变量                          | 含义                         | 字面值示意                           |
| ----------------------------- | ----------------------------| ------------------------------------|
| BK_HOME                       | 蓝鲸根目录                   | /data/bkee                          |
| MODULE_NAME                   | 模块名                      | bkdata                               |
| LAN_IP                        | 内网 IP                     | 10.0.0.10                            |
| WEBSERVER_PORT                | 内部进程占用端口 默认：8081  | 8081                                 |
| APISERVER_PORT                | 内部进程占用端口 默认：8082  | 8082                                 |
| CISERVER_PORT                 | 内部进程占用端口 默认：8083  | 8083                                 |
| JOBSERVER_PORT                | 内部进程占用端口 默认：8084  | 8084                                 |
| APP_CODE                      | 监控 APPCODE                | bk_monitor                           |
| APP_TOKEN                     | 监控 APP Token              | 72125ea1-0f18-4669-9c73-85185fd6e871 |
| ESB_SUPER_USER                | esb 接口调用用户 默认：admin |                                      |
| BK_DOMAIN                     | 蓝鲸根域名                   |                                      |
| PAAS_FQDN                     | PAAS 域名                    |                                      |
| CMDB_FQDN                     | CMDB 域名                    |                                      |
| JOB_FQDN                      | JOB 域名                     |                                      |
| PAAS_HTTP_PORT                | PAAS 端口                    |                                      |
| CMDB_HTTP_PORT                | CMDB 端口                    |                                      |
| JOB_HTTP_PORT                 | JOB 端口                     |                                      |
| MYSQL_USER                    | Mysql 用户名                 |                                      |
| MYSQL_PASS                    | Mysql 密码                   |                                      |
| MYSQL_HOST                    | Mysql 主机                   |                                      |
| MYSQL_PORT                    | Mysql 端口                   |                                      |
| REDIS_HOST                    | Redis 主机                   | x.x.x.x                              |
| REDIS_PORT                    | Redis 端口                   |                                      |
| REDIS_CLUSTER_HOST            | Redis 集群主机               | x.x.x.x                              |
| REDIS_CLUSTER_PORT            | Redis 集群端口               |                                      |
| REDIS_PASS                    | Redis 密码                   |                                      |
| BEANSTALKD_HOST               | Beanstalk 地址               | ['x.x.x.x', 'y.y.y.y']               |
| BEANSTALKD_PORT               | Beanstalk 端口               |                                      |
| KAFKA_HOST                    | Kafka 主机链接信息           | ('x.x.x.x', 'y.y.y.y')               |
| CERT_PATH                     | 证书地址                     |                                      |
| LICENSE_HOST                  | 证书服务域名                 |                                      |
| LICENSE_PORT                  | 证书服务端口                 |                                      |
| LOGS_HOME                     | 日志目录                     |                                      |
| RABBITMQ_HOST                 | Rabbit 队列主机              |                                      |
| RABBITMQ_PORT                 | Rabbit 队列端口              |                                      |
| BKMONITOR_INFLUXDB_PROXY_HOST | influxdb-proxy 域名          |                                      |
| BKMONITOR_INFLUXDB_PROXY_PORT | influxdb-proxy 端口          |                                      |

### Influxdb-proxy#etc#influxdb-proxy.yml

| 变量          | 含义              |
| ------------- | ----------------- |
| INFLUXDB_IPx  | Influxdb 实例 IP  |
| INFLUXDB_PORT | Influxdb 实例端口 |

### Transfer#transfer.yaml

| 变量             | 含义                 |
| ---------------- | -------------------- |
| CONSUL_HTTP_PORT | Consul 服务端口      |
| PAAS_HOST        | PaaS 服务域名        |
| PAAS_HTTP_PORT   | PaaS 服务端口        |
| APP_CODE         | 监控 APPCODE         |
| APP_TOKEN        | 监控 APP TOKEN       |
| LAN_IP           | 部署机器内网 IP 地址 |
