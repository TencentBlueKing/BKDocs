# 安装日志平台详解

蓝鲸日志平台包含：

- 日志平台 SaaS （bk_log_search）
- 日志平台后台 api：log(api)
- 日志平台后台 grafana：log(grafana)

## 配置日志平台

日志平台后台使用 `./bin/04-final/bklog.env` 来做配置渲染。列举一些需要注意的配置如下：

日志平台 SaaS 和监控 SaaS 一样，使用 PaaS 提供的 MySQL 实例：`BK_PAAS_MYSQL_*`

日志平台后台的 grafana 使用单独的 MySQL 实例：`BK_BKLOG_MYSQL_*` 

## 安装日志平台

安装日志平台是先后台再安装 SaaS

```bash
./bkcli sync bklog
./bkcli install bklog
./bkcli start bklog
./bkcli install saas-o bk_log_search
```

