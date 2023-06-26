## 常用环境变量

安装或维护过程中，可能需要获取环境的一些变量值，可以通过以下方法获取：

```bash
source /data/install/load_env.sh
echo [$VAR_NAME]
# Example，get bcs mysql ip addr
echo $MYSQL_BCS_IP0
```

变量列表如下：

| 变量名 | 变量说明 |
| ---- | ---- |
| HTTP_SCHEMA | HTTP 协议 |
| HTTPS_SCHEMA | HTTPS 协议 |
| DEFAULT_HTTP_PORT | 默认 HTTP 监听端口 |
| DEFAULT_HTTPS_PORT | 默认 HTTPS 监听端口 |
| MYSQL_BCS_IP0 | BCS MYSQL IP 地址 |
| MYSQL_PORT | BCS MYSQL 监听端口 |
| MYSQL_BCS_USER | BCS MYSQL 用户名 |
| MYSQL_BCS_PASS | BCS MYSQL 密码 |
| BCS_REDIS_IP | BCS REDIS IP 地址 |
| BCS_REDIS_PORT | BCS REDIS 监听端口 |
| BCS_REDIS_PASS | BCS_REDIS 密码 |
| BCS_REDIS_BCS_DB | BCS_REDIS DB 名 |
| BCS_MONGO_IP | MongoDB IP 地址 |
| BCS_MONGO_PORT | MongoDB 监听端口 |
| BCS_MONGO_USER | MongoDB 管理员用户 |
| BCS_MONGO_PASS | MongoDB 管理员密码 |
| BCS_MONGO_ENCODE_PASS | 加密后的 MongoDB 管理员密码 |
| HARBOR_SERVER_FQDN | Harbor 仓库 URL |
| HARBOR_SERVER_HTTP_PORT | Harbor 服务 HTTP 监听端口 |
| HARBOR_SERVER_HTTPS_PORT | Harbor 服务 HTTPS 监听端口 |
| HARBOR_API_PORT | Harbor APi 监听端口 |
| HARBOR_SERVER_LOG_PORT | Harbor 服务日志端口 |
| HARBOR_PUBLIC_PROJECT | Harbor 公共镜像存放路径 |
| HARBOR_SERVER_ADMIN_USER| Harbor 管理员用户名 |
| HARBOR_SERVER_ADMIN_PASS | Harbor 管理员密码 |
| DEVOPS_NAVIGATOR_FQDN | BCS SaaS 访问域名 |
| DEVOPS_NAVIGATOR_HTTP_PORT | BCS SaaS 访问 HTTP 端口 |
| DEVOPS_NAVIGATOR_HTTPS_PORT | BCS SaaS 访问 HTTPS 端口 |
| DEVOPS_NAVIGATOR_API_HTTP_PORT |BCS 导航页 HTTP API 端口 |
| DEVOPS_NAVIGATOR_API_HTTPS_PORT |BCS 导航页 HTTPS API 端口 |
| DEVOPS_NAVIGATOR_PM_PORT | BCS 导航页项目端口 |
| MYSQL_DEVOPS_PORT | BCS 导航页使用的 mysql 端口 |
| THANOS_QUERY_HOST | BCS 监控 QUERY 服务访问地址 |
| THANOS_QUERY_HTTP_PORT | BCS 监控 QUERY 服务 HTTP 端口 |
| THANOS_QUERY_GRPC_PORT | BCS 监控 QUERY 服务 GRPC 端口 |
| THANOS_QUERY_CLUSTER_PORT | BCS 监控 QUERY 服务 CLUSTER 端口 |
| THANOS_RULER_HOST | BCS 监控 RULER 服务访问地址 |
| THANOS_RULE_HTTP_PORT | BCS 监控 RULE 服务 HTTP 端口 |
| THANOS_RULE_GRPC_PORT | BCS 监控 RULE 服务 GRPC 端口 |
| IAM_VERSION | BCS 使用权限中心版本号 |
| BCS_GRAFANA_HOST | BCS 监控 GRAFANA 组件部署地址 |
| BCS_GRAFANA_HTTP_PORT | BCS 监控 GRAFANA 组件监听端口 |
| BCS_WEB_CONSOLE_IP | BCS Web Conosle 服务访问地址 |
| BCS_WEB_CONSOLE_PORT | BCS Web Conosle 服务监听端口 |
| BCS_OPS_HOST | BCS OPS 服务访问地址 |
| BCS_OPS_PORT | BCS OPS 服务监听端口 |
| BCS_API_IP | BCS API 服务 HTTP 监听端口 |
| BCS_API_HTTP_PORT | BCS API 服务 HTTPS 监听端口 |
| BCS_API_INSECURE_PORT | BCS API 服务不安全监听端口 |
| BCS_STORAGE_PORT | BCS Strorage 服务监听端口 |
| BCS_DNS_SERVICE_PORT | BCS Service DNS 服务监听端口 |
| BCS_CC_IP | BCS CC 服务访问地址 |
| BCS_CC_PORT | BCS CC 服务监听端口 |
| K8S_VERSION | K8S 版本号 |
| K8S_WATCH_VERSION | BCS Data Watch 组件版本号 |
| K8S_AGENT_VERSION | BCS Agent 组件版本号 |
