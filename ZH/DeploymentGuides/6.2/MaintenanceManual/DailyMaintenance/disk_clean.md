# 磁盘清理

可能产生比较大数据量的目录有：

- /data/bkce/logs

- /data/bkce/public

logs 目录可以按需设置自动清理 N 天前的日志。

public 目录一般不能手动删除，一般比较大的组件可能有

- MySQL 数据库太大

- Kafka 数据

- Elasticsearch 数据

- MongoDB 数据

- SaaS 包上传目录

- 作业平台上传文件目录

## MySQL 日志清理

MySQL 中的 binlog 日志记录了数据库中数据的变动，便于对数据的基于时间点和基于位置的恢复，但是 binlog 也会日渐增大，占用很大的磁盘空间，因此，要对 binlog 使用正确安全的方法清理掉一部分没用的日志。

> **注意：** 下述方法仅供参考，具体以实际生产环境情况进行调整。

### 手动清理 binlog

若社区版设置了多台 MySQL，需查看主库和从库正在使用的 binlog 是哪个文件

```bash
    MySQL [(none)]> show master status\G
    *************************** 1. row ***************************
    File: mysql-bin.000006
    Position: 97013298
    Binlog_Do_DB:
    Binlog_Ignore_DB:
    1 row in set (0.00 sec)

    MySQL [(none)]> show slave status\G
    Empty set (0.00 sec)
```

删除 binlog 日志之前，对 binlog 进行备份。

#### 清理方法一：删除指定日期以前的日志索引中 binlog 日志文件

```bash
purge master logs before '201x-xx-xx 00:00:00';
```

#### 清理方法二：删除指定日志文件的日志索引中 binlog 日志文件

```bash
purge master logs to'mysql-bin.00000x';
```

> **注意：**
>
> - 时间和文件名一定不可以写错，尤其是时间中的年和文件名中的序号，以防不小心将正在使用的 binlog 删除。
>
> - 切勿删除正在使用的 binlog。
>
> - 使用该语法，会将对应的文件和 mysql-bin.index 中的对应路径删除。

### 自动清理 binlog 日志

使用如下方法查询当前 binlog 的过期时间，若为 0 表示不过期。

```bash
mysql> show variables like 'expire_logs_days';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| expire_logs_days |   0   |
+------------------+-------+
```

使用如下方法设置 binlog 过期时间，设置 30 表示 30 天后自动清理之前的过期日志。

该方法只是临时启用，重启 MySQL 服务之后则失效。

永久生效则需将参数添加至 MySQL 配置文件。

```bash
mysql> set global expire_logs_days = 30;
```

## Kafka 日志清理

Kafka 将数据持久化到了硬盘上，允许配置一定的策略对数据清理，清理的策略有两个，删除和压缩。

> **注意：** 下面清理策略，请根据实际业务，服务器状况，及需求来定制。

### 方法一：调整配置文件

```bash
# 配置文件位置
/etc/kafka/server.properties

# 可以增加 log.cleanup.policy 这个数据清理方式设置，此行为为删除动作
log.cleanup.policy=delete

# 下面有 2 种方式，保留时间或大小，请自行根据实际情况调整此处设置，1G 为 1073741824 。具体保留大小根据实际情况设置
# 注意：下面为直接删除，删除后的消息不可恢复
log.retention.hours=72（超过指定时间 72 小时后，删除旧的消息）
log.retention.bytes=10737418240（超过指定大小 10G 后，删除旧的消息）

```

设置完毕后，重启服务来生效。

### 方法二：Kafka 设置 Topic 过期时间

```bash
# 设置过期时间，只能用毫秒（retention.ms），或者 bytes（retention.bytes）

[root@kafka ~]# /opt/kafka/bin/kafka-topics.sh --zookeeper zk.service.consul:2181/common_kafka \
--topic 0bkmonitor_10010 --alter --config retention.ms=17280000

WARNING: Altering topic configuration from this script has been deprecated and may be removed in future releases.
         Going forward, please use kafka-configs.sh for this functionality
Updated config for topic "0bkmonitor_10010".

```

## Elasticsearch 日志清理

- 查看目前所有的索引

```bash
source /data/install/utils.fc
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X GET http://$BK_ES7_IP:9200/_cat/indices?v
```

- 删除索引

```bash
# index 是索引名称
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X DELETE http://$BK_ES7_IP:9200/index
```

## MongoDB 数据清理

CMDB 使用 MongoDB 产生的数据量主要来自 cmdb.cc_OperationLog 这个 collection，它对应的是页面的审计日志查询功能。

需要保留的日期越长，它占用的磁盘空间就越大，可以写脚本定期清理。假设保留时间是 1 年：

```bash
# 待补充
```

Job 使用 MongoDB 产生的都是作业平台分发文件和执行脚本的日志文件，按天建立的 collection，可以写脚本定期按天来清理 collection。
假设保留时间是 1 年:

```bash
source ./load_env.sh # 加载变量
before_date=$(date -d '1 year ago' +%Y_%m_%d)
# 生成js
cat <<'EOF' > /tmp/delete_job_outdate_collection.js
var fileCollectionNames = db.getCollectionNames().filter(function (collection) { return /^job_log_file/.test(collection) && collection < "job_log_file_"+beforeDate })
fileCollectionNames.forEach(function(c){print("dropping:" + c);db[c].drop();})
var scriptCollectionNames = db.getCollectionNames().filter(function (collection) { return /^job_log_script/.test(collection) && collection < "job_log_script_"+beforeDate })
scriptCollectionNames.forEach(function(c){print("dropping:" + c);db[c].drop();})
EOF
# 执行清理的js
mongo --quiet "$BK_JOB_LOGSVR_MONGODB_URI" --eval 'var beforeDate="'$before_date'"' /tmp/delete_job_outdate_collection.js
```

## SaaS 包上传目录

通过开发者中心部署上传 S-mart 应用包，时间长了以后，会占用一定的磁盘空间，可以配置作业平台任务定时清理。提供示例脚本如下：
第一个参数为 SaaS 包上传目录绝对路径，第二个参数为每个 app_code 对应的包保留的个数（默认为最近 15 个）

需要注意的是，该脚本需要在两个不同的组件服务器上运行：

- paas 所在服务器的 /data/bkce/open_paas/paas/media/saas_files/ 目录
- appo 和 appt 所在服务器的 /data/bkce/paas_agent/saasapp/ 目录

```bash
dir=${1}
keep_cnt=${2-:15}
cd $dir || { echo "can't change to $dir"; exit 1; }

app_code=$(ls -rt | grep -Po 'bk_[0-9a-z_]+(?=_V)' | sort | uniq -c  | awk -v keep=$keep_cnt '$1 > keep { print $2 }')
if [[ -z "$app_code" ]]; then
    echo "无需清理"
    exit 0
else
    echo "以下app_code需要清理"
    echo "$app_code"
fi

while read app; do 
    ls ${app}_V*.gz -t | sed "1,${keep_cnt}d" | xargs --no-run-if-empty -I{} sh -c 'ls -l {}; rm -v {};'
done <<<"$app_code"
```

## 作业平台上传文件目录

作业平台长时间使用本地上传文件，文件存储目录 `/data/bkce/public/job/localupload` 会持续增长，job 后台默认会每小时自动清理超过 7 天的未被任何
作业引用的本地上传文件（一般是快速分发文件功能落地的），如果本地上传的文件，有被任意作业引用，则即使超过 7 天也不会被自动删除。