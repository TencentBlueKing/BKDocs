# Monitor

bkdata\#monitor\#project\#settings_env.py

| 变量                  | 含义                                                    | 字面值示意                           | 备注         |
|-----------------------|---------------------------------------------------------|--------------------------------------|--------------|
| \__MONITOR_IP_\_      | 内网ip                                                  | x.x.x.x                              |              |
| \__RUN_MODE_\_        | 运行环境 默认: product product: 正式环境 test: 测试环境 | product                              |              |
| \__BK_PLATFORM_\_     | 环境变量中提取                                          | enterprise                           |              |
| \__PROJECT_NAME_\_    | 环境变量中提取                                          |                                      |              |
| \__WEBSERVER_PORT_\_  | 内部进程占用端口 默认: 8081                             | 8081                                 |              |
| \__APISERVER_PORT_\_  | 内部进程占用端口 默认: 8082                             | 8082                                 |              |
| \__CISERVER_PORT_\_   | 内部进程占用端口 默认: 8083                             | 8083                                 |              |
| \__JOBSERVER_PORT_\_  | 内部进程占用端口 默认: 8084                             | 8084                                 |              |
| \__APP_CODE_\_        | 监控APPCODE                                             | bk_monitor                           |              |
| \__APP_TOKEN_\_       | 监控APP Token                                           | 72125ea1-0f18-4669-9c73-85185fd6e871 |              |
| \__ESB_SUPER_USER_\_  | esb接口调用用户 默认: admin                             |                                      |              |
| \__BK_DOMAIN_\_       | 环境变量中提取                                          |                                      |              |
| \__PAAS_FQDN_\_       | 环境变量中提取                                          |                                      |              |
| \__CMDB_FQDN_\_       | 环境变量中提取                                          |                                      |              |
| \__JOB_FQDN_\_        | 环境变量中提取                                          |                                      |              |
| \__PAAS_HTTP_PORT_\_  | 环境变量中提取                                          |                                      |              |
| \__CMDB_HTTP_PORT_\_  | 环境变量中提取                                          |                                      |              |
| \__JOB_HTTP_PORT_\_   | 环境变量中提取                                          |                                      |              |
| \__MYSQL_USER_\_      | Mysql用户名                                             |                                      |              |
| \__MYSQL_PASS_\_      | Mysql密码                                               |                                      |              |
| \__MYSQL_HOST_\_      | Mysql主机                                               |                                      |              |
| \__MYSQL_PORT_\_      | Mysql端口                                               |                                      |              |
| \__REDIS_HOST_\_      | Redis主机                                               | ['x.x.x.x', 'y.y.y.y']               | 格式特殊要求 |
| \__REDIS_PORT_\_      | 环境变量中提取                                          |                                      |              |
| \__REDIS_PASS_\_      | 环境变量中提取                                          |                                      |              |
| \__BEANSTALKD_HOST_\_ |                                                         | ['x.x.x.x', 'y.y.y.y']               | 格式特殊要求 |
| \__BEANSTALKD_PORT_\_ |                                                         |                                      |              |
| \__KAFKA_HOST_\_      | Kafka主机链接信息                                       | ('x.x.x.x', 'y.y.y.y')               | 格式特殊要求 |
|                       |                                                         |                                      |              |

bkdata\#monitor\#project\#settings.py

| 变量               | 含义           | 字面值示意 | 备注 |
|--------------------|----------------|------------|------|
| \__PROJECT_NAME_\_ | 环境变量中提取 |            |      |
| \__PROJECT_HOME_\_ | 环境变量中提取 |            |      |
| \__LOGS_HOME_\_    | 环境变量中提取 |            |      |
| \__PYTHON_HOME_\_  | 环境变量中提取 |            |      |
|                    |                |            |      |
|                    |                |            |      |
|                    |                |            |      |
