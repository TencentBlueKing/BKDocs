# 配置参考文档
## 容器服务 WebConsole

web_console\#backend\#settings\#ce\#prod

| 变量                        | 含义                    | 字面值示意 | 备注 |
|----------------------------|-----------------------|------------|------|
| \__APP_CODE__              | APP_CODE，请求 ESB 使用 | Bk_bcs     |      |
| \__APP_TOKEN__             | APP_TOKEN，请求 ESB 使用| xxx        |      |
| \__HTTP_SCHEMA__           | 请求协议 http 或者 https | http       |      |
| \__DEFAULT_HTTPS_PORT__    | https 默认端口          | 8443       |      |
| \__PAAS_FQDN__             | Paas 的完整域名         |            |      |
| \__PAAS_HOST__             | Paas-内部域名           |            |      |
| \__PAAS_HTTP_PORT__        | Paas-内部 http 端口     |            |      |
| \__REDIS_HOST__            | Redis 的主机地址        |            |      |
| \__REDIS_PORT__            | Redis 的端口           |            |      |
| \__REDIS_PASS__            | Redis 的密码           |            |      |
| \__REDIS_BCS_DB__          | Redis DB               |            |      |
| \__BCS_WEB_CONSOLE_PORT__  | WebConsole 绑定的端口   |            |      |
| \__BCS_API_HOST__          | BCS API 地址           |            |      |
| \__BCS_API_HTTPS_PORT__    | BCS API 端口           |            |      |
| \__HARBOR_PUBLIC_PROJECT__ | Harbor 镜像地址        |            |      |

## 容器监控后台

monitor\#conf\#worker\#settings\#ce\#prod.py

| 变量                         | 含义                    | 字面值示意 | 备注 |
|------------------------------|------------------------|------------|------|
| \__APP_CODE__               | APP_CODE，请求 ESB 使用  | Bk_bcs     |      |
| \__APP_TOKEN__              | APP_TOKEN，请求 ESB 使用 | xxx        |      |
| \__HTTP_SCHEMA__            | 请求协议 http 或者 https | http       |      |
| \__DEFAULT_HTTPS_PORT__     | https 默认端口           | 8443       |      |
| \__PAAS_FQDN__              | Paas 的完整域名          |            |      |
| \__PAAS_HOST__              | Paas-内部域名           |            |      |
| \__PAAS_HTTP_PORT__         | Paas-内部 http 端口     |            |      |
| \__IAM_HOST__               | 权限中心域名            |            |      |
| \__IAM_HTTP_PORT__          | 权限中心端口            |            |      |
| \__REDIS_HOST__             | Redis 的主机地址        |            |      |
| \__REDIS_PORT__             | Redis 的端口            |            |      |
| \__REDIS_PASS__             | Redis 的密码            |            |      |
| \__CONSUL_HTTP_PORT__       | 本地 Consul 端口地址     |            |      |
| \__MYSQL_BCS_MONITOR_USER__ | Mysql 用户              |            |      |
| \__MYSQL_BCS_MONITOR_PASS__ | Mysql 密码              |            |      |
| \__MYSQL_BCS_MONITOR_IP0__  | Mysql 主机地址          |            |      |
| \__MYSQL_BCS_MONITOR_PORT__ | Mysql 端口              |            |      |
| \__THANOS_QUERY_HOST__      | Thanos 请求的地址        |            |      |
| \__THANOS_QUERY_HTTP_PORT__ | Thanos 请求的端口        |            |      |
| \__THANOS_RULE_HOST__       | Thanos 告警的请求地址    |            |      |
| \__THANOS_RULE_HTTP_PORT__  | Thanos 告警的请求端口    |            |      |
| \__INSTALL_PATH__           | 安装目录                |            |      |
|                             |                        |            |      |

grafana\#conf\#ce.ini

| 变量                         | 含义                    | 字面值示意 | 备注 |
|------------------------------|-------------------------|------------|------|
| \__LAN_IP__                 | Grafana 绑定的内网 IP 地址|            |      |
| \__BCS_GRAFANA_HTTP_PORT__  | Grafana 绑定的端口       |            |      |
| \__PAAS_FQDN__              | Paas 的完整域名          |            |      |
| \__HTTP_SCHEMA__            | 请求协议 http 或者 https |            |      |
| \__PAAS_HOST__              | Paas-内部域名           |            |      |
| \__PAAS_HTTP_PORT__         | Paas-内部 http 端口     |            |      |
| \__REDIS_IP0__              | Redis 的主机地址        |            |      |
| \__REDIS_PORT__             | Redis 的端口            |            |      |
| \__REDIS_PASS__             | Redis 的密码            |            |      |
| \__MYSQL_BCS_GRAFANA_USER__ | Mysql 用户              |            |      |
| \__MYSQL_BCS_GRAFANA_PASS__ | Mysql 密码              |            |      |
| \__MYSQL_BCS_GRAFANA_IP0__  | Mysql 主机地址          |            |      |
| \__MYSQL_BCS_GRAFANA_PORT__ | Mysql 端口              |            |      |
| \__INSTALL_PATH__           | 安装目录                |            |      |
|                             |                         |            |      |
|                             |                         |            |      |

## 配置中心

环境变量

\#etc\#bcs\#cc-area.json

| 变量                                | 含义      | 备注           |
|------------------------------------|-----------|----------------|
| \__DNS_MAIN_IP__                   | DNS 主 IP  | 可以找运维确认 |
| \__DNS_BACKUP_IP__                 | DNS 备 IP  | 可以找运维确认 |
| \__HARBOR_SERVER_FQDN__            | HUB 地址   |                |
| \__PYLIST_SEP_LIST_ZK_BCS_SERVER__ | ZK IP 列表 |                |

\#etc\#bcs\#cc-zk.json

| 变量                              | 含义      | 备注           |
|-----------------------------------|-----------|----------------|
| \__COMMA_SEP_LIST_ZK_BCS_SERVER__ | ZK IP 列表 | 可以找运维确认 |

\#etc\#bcs\#cc-k8s.json

| 变量                        | 含义            | 备注           |
|----------------------------|-----------------|----------------|
| \__NGINX_IP__              | Nginx IP        | 主要是用做代理 |
| \__DEFAULT_HTTP_PORT__     | Nginx 服务端口   |                |
| \__HARBOR_SERVER_FQDN__    | HUB 地址        |                |
| \__HARBOR_PUBLIC_PROJECT__ | 公共项目 CODE   |                |
| \__PKG_SRC_PATH__          | 安装包存放路径   |                |
| \__K8S_VERSION__           | K8S 版本        |                |
| \__K8S_AGENT_VERSION__     | KUBE Agent 版本 |                |
| \__INSTALL_PATH__          | K8S 组件安装路径 |                |
