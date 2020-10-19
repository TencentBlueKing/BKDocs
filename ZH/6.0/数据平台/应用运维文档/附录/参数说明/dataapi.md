
# DataAPI

环境变量

bkdata\#dataapi\#conf\#dataapi_settings.py

| 变量                    | 含义                    | 字面值示意(如果带有引号，代表引号也需要填写字面值) | 备注                                                         |
|-------------------------|-------------------------|----------------------------------------------------|--------------------------------------------------------------|
| \__DATAAPI_PORT_\_      | dataapi服务端口         | 8832                                               |                                                              |
| \__LAN_IP_\_            | Dataapi服务绑定的内网IP | x.x.xx                                             | 这个是本机的ip                                               |
| \__RUN_MODE_\_          | 运行模式                | PRODUCT                                            |                                                              |
| \__MONITOR_APP_CODE_\_  | 监控APPCODE             | bk_monitor                                         |                                                              |
| \__MONITOR_APP_TOKEN_\_ | 监控APP Token           | 72125ea1-0f18-4669-9c73-85185fd6e871               |                                                              |
| \__MYSQL_HOST_\_        | Mysql主机               | x.x.x.x                                            |                                                              |
| \__MYSQL_PORT_\_        | Mysql端口               | 3306                                               |                                                              |
| \__MYSQL_USER_\_        | Mysql用户名             | root                                               |                                                              |
| \__MYSQL_PASS_\_        | Mysql密码               | Xxxx                                               |                                                              |
| \__ES_HOST_\_           | Es主机                  | x.x.x.x                                            |                                                              |
| \__ES_PORT_\_           | Es端口                  | 9200                                               |                                                              |
| \__ES_TRANSPORT_PORT_\_ | Es的transport端口       | 9300                                               |                                                              |
| \__ES_CLUSTER_NAME_\_   | Es集群名                | bkee-es                                            |                                                              |
| \__GSE_AGENT_PATH_\_    | GseaAagent安装路径      | /usr/local/gse/gseagent                            |                                                              |
| \__ZK_FOR_GSE_\_        | Gse zookeeper           | x.x.x.x:2181                                       | 如果zk划分目录，这个参数需要到目录级别，如：x.x.x.x:2181/gse |

