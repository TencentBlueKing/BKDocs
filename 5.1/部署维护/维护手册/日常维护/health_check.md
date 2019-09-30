# 蓝鲸日常维护

## 健康检查

蓝鲸产品后台提供了健康检查的接口，用 HTTP GET 请求访问，接口地址和端口用变量表达：

```bash
cd /data/install && source utils.fc

# PAAS 注意 URL 末尾带上/
curl http://$PAAS_FQDN:$PAAS_HTTP_PORT/healthz/

# 配置平台 (beta)，目前版本不够准确
curl http://$CMDB_IP:$CMDB_API_PORT/healthz

# 作业平台
curl http://$JOB_FQDN:$PAAS_HTTP_PORT/healthz
```

蓝鲸监控 SaaS 的监控检查接口，可以用浏览器直接访问:

```bash
http://$PAAS_FQDN:$PAAS_HTTP_PORT/o/bk_monitor/healthz/
```
