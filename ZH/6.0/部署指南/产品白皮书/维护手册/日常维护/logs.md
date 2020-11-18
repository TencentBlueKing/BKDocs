# 查看日志

- 日志文件统一在 `$CTRL_PATH/logs/` 下，按模块名，组件名分目录存放。 `$CTRL_PATH` 为安装蓝鲸时定义的目录，默认为 /data/bkce。如有修改，请根据实际安装路径修改相关命令。

假设需要查看作业平台的日志：

```bash
cd /data/bkce/logs/job
```

- 组件日志在对应部署主机 `$CTRL_PATH/logs/$MODULE/` 目录下。

- Kafka、Zookeeper 的日志则在 `/var/log/kafka` 、`/var/log/zookeeper` 目录下。

- SaaS 较为特殊，在部署了 paas_agent 的主机 `/data/bkce/paas_agent/apps/logs` 下，根据 AppCode 名分目录存放。


