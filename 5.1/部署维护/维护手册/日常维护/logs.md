# 蓝鲸日常维护

## 查看日志

日志文件统一在 `/data/bkce/logs/` 下，按模块名，组件名分目录存放。

假设需要查看作业平台的日志：

```bash
cd /data/bkce/logs/job
```

组件日志均在对应部署主机 $INSTALL_PATH/logs/$MODULE/ 目录下。

SaaS 较为特殊，在部署了 paas_agent 的主机 `/data/bkce/paas_agent/apps/logs` 下，根据 AppCode 名分目录存放。
