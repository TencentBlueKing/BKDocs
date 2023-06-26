# 目录信息

以下， `${PAAS_ROOT}` 为安装时指定根路径，若不指定，默认为 `/data/paas`。具体项目名为：`${PORJECT}` ，即为 `paas/appengine/esb/login` 四者之一

## 项目目录
```bash
# paas
${PAAS_ROOT}/open_paas/paas
# appengine
${PAAS_ROOT}/open_paas/appengine
# esb
${PAAS_ROOT}/open_paas/esb
# login
${PAAS_ROOT}/open_paas/login
# apigw
${PAAS_ROOT}/open_paas/apigw
```

## 配置文件
```bash
# paas
${PAAS_ROOT}/open_paas/paas/conf/settings_production.py
# appengine
${PAAS_ROOT}/open_paas/appengine/controller/settings.py
# esb:
${PAAS_ROOT}/open_paas/esb/configs/default.py
# login:
${PAAS_ROOT}/open_paas/login/conf/settings_production.py
# apigw
${PAAS_ROOT}/open_paas/apigw/api_gateway/configs/open/prod.py
```

## 日志

### paas
```bash
# 应⽤日志
${PAAS_ROOT}/logs/open_paas/paas.log
# uwsgi 日志
${PAAS_ROOT}/logs/open_paas/paas_uwsgi.log
# MySQL 日志
${PAAS_ROOT}/logs/open_paas/paas_mysql.log
# supervisord 日志
${PAAS_ROOT}/logs/open_paas/supervisord/
```

### appengine
```bash
# 应⽤日志
${PAAS_ROOT}/logs/open_paas/logs/appengine.log
# uwsgi 日志
${PAAS_ROOT}/logs/open_paas/logs/appengine_uwsgi.log
# MySQL 日志
${PAAS_ROOT}/logs/open_paas/logs/appengine_mysql.log
# supervisord 日志
${PAAS_ROOT}/logs/open_paas/logs/supervisord/
```

### esb
```bash
# 应⽤日志
${PAAS_ROOT}/logs/open_paas/esb.log
# API 日志
${PAAS_ROOT}/logs/open_paas/esb_api.log
# uwsgi 日志
${PAAS_ROOT}/logs/open_paas/esb_uwsgi.log
# supervisord 日志
${PAAS_ROOT}/logs/open_paas/supervisord/
```

### login
```bash
# 应⽤日志
${PAAS_ROOT}/logs/open_paas/login.log
# uwsgi 日志
${PAAS_ROOT}/logs/open_paas/login_uwsgi.log
# MySQL 日志
${PAAS_ROOT}/logs/open_paas/login_mysql.log
# supervisord 日志
${PAAS_ROOT}/logs/open_paas/supervisord/
```

### apigw
```bash
# 应⽤日志
${PAAS_ROOT}/logs/open_paas/bk_api_gateway.log
# uwsgi 日志
${PAAS_ROOT}/logs/open_paas/apigw_uwsgi.log
# MySQL 日志
${PAAS_ROOT}/logs/open_paas/apigw_mysql.log
# supervisord 日志
${PAAS_ROOT}/logs/open_paas/supervisord/
```
