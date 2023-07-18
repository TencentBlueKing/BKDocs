# 查看日志

蓝鲸部署和使用过程中遇到前台提示不明确的问题，需要查询后台日志定位。

本文描述，查看蓝鲸后台日志的方法、技巧。

## 进程启动日志

社区版 6.0 使用 systemd 托管后，进程启动过程中如果有打印标准输出和标准错误日志，会定向到 systemd-journald 服务，通过 `journactl` 命令来查看。定位时常用的命令行参数如下：

1. 查看具体某个服务的日志，以查看 `bk-iam.service` 为例：

    ```bash
    journalctl -u bk-iam
    ```

2. 如果日志过多充满一屏后，请通过翻页查看最新的日志，journalctl 会将日志文本导出给终端定义的 PAGER 程序，一般是 `more` 和 `less`，操作翻页和左右滚动，可以使用相应的快捷键。

3. 只看最新的 50 行日志，并且直接输出，不经过 PAGER 处理：

    ```bash
    journalctl -u bk-iam -n 50 --no-pager
    ```

4. 查看某个时间范围内的日志 ( --since 和 --until 可以组合也可以单独使用)：

    ```bash
    journalctl -u bk-iam.service --since "2021-01-14 11:00" --until "2021-01-14 11:05"
    ```

还有后台进程启动日志，默认将标准输出和标准错误重定向到 `/dev/null` 了，这种进程需要通过调整配置来进行处理。
常见于后台 Python 工程，且使用 supervisord 进行了托管的服务。比如蓝鲸监控后台（bkmonitorv3）。假设监控的 `kernel_api` 进程显示 FAILED，我们需要定位启动失败的原因。

1. 修改监控的 supervisor 配置文件

   ```bash
   # 登录至监控模块所在的机器
   source /data/install/utils.fc
   ssh $BK_MONITORV3_IP0

   # 修改配置文件
   vim /data/bkce/etc/supervisor-bkmonitorv3-monitor.conf
    ```

2. 修改 `[program:kernel_api]` 配置下的 `stdout_logfile` 的值为一个临时路径，比如 `/data/bkce/logs/kernel_api_stdout.log`

3. 重启监控平台

    ```bash
    systemctl restart bk-monitor
    ```

4. 查看服务启动失败的日志

    ```bash
    /data/bkce/logs/kernel_api_stdout.log
    ```

5. 定位到问题后，可以还原 supervisor 配置。

## 蓝鲸后台日志

蓝鲸后台运行日志文件统一在 `$BK_HOME/logs/` 下，按模块名，组件名分目录存放。 `$BK_HOME/` 为安装蓝鲸时定义的目录，默认为 /data/bkce。如有修改，请根据实际安装路径修改相关命令。

假设需要查看作业平台 (job) 的 job-execute 进程的日志：

```bash
# 登录至 JOB 模块所在的机器
source /data/install/utils.fc
ssh $BK_JOB_IP0

# 进入对应目录查看日志
cd /data/bkce/logs/job/job-execute/
ls -lrt *.log
```

由于大多数日志会定期或者按大小滚动，我们查看当前错误的时候，一般只需要看最新的日志。所以使用 `ls` 命令按时间排序 `*.log`，可以确认我们需要继续追查的日志文件名。

例如继续看 execute.log

```bash
tail -f execute.log
```

然后通过浏览器复现当时的错误场景，观察命令行窗口的日志滚动，当出现错误的时候，按下 `Ctrl-C` 中止，请根据文本含义尝试排查错误。实在无法解决时，将对应日志复制到文本文件，前往问答社区或者 QQ 群咨询。

## 蓝鲸 SaaS 日志

SaaS 的日志路径较为特殊。如果是查看正式环境部署的 SaaS 日志，请登录到 APPO 所在主机。切换到 `$BK_HOME/paas_agent/apps/logs` 下，该目录下是根据 SaaS 的 APP_CODE 名进行分目录存放。

## 开源组件日志

- Consul 的日志在 /var/log/consul/ 下，也可以通过 `consul monitor` 命令查看
  
- Redis 的日志在 /var/log/redis/ 下，根据实例名命名的日志文件，比如 服务是 `redis@default.service` 那么日志文件是 /var/log/redis/default.log
  
- MySQL 的日志在 `$BK_HOME/logs/mysql/实例名.mysqld.log` 慢查询日志在 `$BK_HOME/logs/mysql/实例名.slow-query.log`
  
- Nginx 的日志在 `$BK_HOME/logs/nginx/`
  
- MongoDB 的日志在 `$BK_HOME/logs/mongodb/`
  
- RabbitMQ 的日志在 `$BK_HOME/logs/rabbitmq/`
  
- Kafka 的日志在 `/var/log/kafka`
  
- Zookeeper 的日志在 `/var/log/zookeeper`
  
- Elasticsearch7 的日志在 `$BK_HOME/logs/elasticsearch/`
  
- InfluxDB 的日志在 `$BK_HOME/logs/influxdb/`
