# MySQL FAQ

## MySQL密码更新流程

> 如下指引，若无特殊说明，全部在中控机`/data/install`目录进行

### 停止MySQL

```bash
./bkcec stop mysql

# 确认mysql真正停掉
./bkcec status mysql

# 在mysql机器确认
ps -ef | grep mysql | grep -v grep
```

### 修改mysql密码

修改globals.env里的mysql_PASS值，密码不要包含 `[ ] / : @ ?` 等特殊字符

```
export MYSQL_PASS='新密码'
```

### 同步install目录

```bash
./bkcec sync common
```

### 关闭相关服务

```bash
# 关闭平台服务
echo bkdata gse job paas gse kafka cmdb | xargs -n 1 ./bkcec stop
echo bkdata gse job paas gse kafka cmdb | xargs -n 1 ./bkcec status
```

### 关闭saas应用

在appo服务器上执行

```bash
# 若为单机部署，请使用如下指令
ls /data/bkce/paas_agent/apps/projects | awk '{print $1}' | sed 's/.$//' | xargs -n 1 ./bkcec stop saas-o

# 若为多台部署，请在中控机/data/install目录下使用如下指令
rcmd root@$APPO_IP "ls /data/bkce/paas_agent/apps/projects" | xargs -n 1 ./bkcec stop saas-o

# 不论单机还是多台部署，建议在appo的服务器上确认应用的进程真正停掉，若存在未停掉进程，可以采用强杀方法
ps -ef|grep bk_
for x in `ls /data/bkce/paas_agent/apps/projects | awk '{print $1}' | sed 's/.$//'` ; do ps -ef | grep $x | grep -v grep | awk '{print $2}' | xargs -n 1 kill -9 ; done
```

### 重新生成配置

和mysql相关的模块为mysql，paas，job，bkdata，saas

```bash
echo mysql paas job bkdata | xargs -n 1 ./bkcec render
```

**bkdata**特别注意，有3个地方

```bash
配置1：
/data/bkce/bkdata/databus/conf/redis.cluster.properties  确认  connector.redis.auth=redis密码

配置2：
/data/bkce/bkdata/databus/conf/jdbc.cluster.properties  确认  connector.connection.password=mysql密码

配置3：
/data/bkce/bkdata/databus/conf/etl.cluster.properties  确认  cc.cache.passwd=mysql密码
```

### 更改saas-o应用的密码

```bash
# 在appo服务器上，先测试一下，确认打印出来的是新密码，注意有*的话，注意转义
find /data/bkce/paas_agent/apps/projects/bk_*/conf -name "*.conf" | grep "bk" | xargs grep "老密码" -l | xargs sed "s/老密码/新密码/g"

# 测试没问题，加-i，修改文件
find /data/bkce/paas_agent/apps/projects/bk_*/conf -name "*.conf" | grep "bk" | xargs grep "老密码" -l | xargs sed -i "s/老密码/新密码/g"
```

### 启动MySQL

```bash
./bkcec start mysql
```

### 重新初始化MySQL

```
./bkcec initdata mysql
```

### 重新初始化PaaS

```bash
./bkcec initdata paas
```

### 重新启动平台

```bash
echo paas gse cmdb kafka job bkdata | xargs -n 1 ./bkcec start
```

### 重新初始化APPO

```bash
# 在中控机
./bkcec stop appo
./bkcec initdata appo
./bkcec start appo
./bkcec activate appo
```

### 重新启动应用

```bash
# 若为单机部署，请使用如下指令
ls /data/bkce/paas_agent/apps/projects | awk '{print $1}' | sed 's/.$//' | xargs -n 1 ./bkcec start saas-o

# 若为多台部署，请在中控机/data/install目录下使用如下指令
rcmd root@$APPO_IP "ls /data/bkce/paas_agent/apps/projects" | xargs -n 1 ./bkcec start saas-o
```

### 检查

确保CMDB，JOB，蓝鲸监控等模块功能全部OK

```bash
# 1.确认bkdata任务
$ /data/bkce/bkdata/dataapi/bin/check_databus_status.sh
===========TSDB===============
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   773  100   773    0     0  14599      0 --:--:-- --:--:-- --:--:-- 14865
tsdb_2_system_cpu_summary
{"name":"tsdb_2_system_cpu_summary","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10054"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10054"}]}

===========MYSQL===============
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    27  100    27    0     0   1118      0 --:--:-- --:--:-- --:--:--  1125
jdbc_2_ja_gse_proc_port
{"name":"jdbc_2_ja_gse_proc_port","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10051"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10051"}]}

===========ETL===============
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1040  100  1040    0     0   166k      0 --:--:-- --:--:-- --:--:--  169k
etl_1001_2_system_cpu_summary
{"name":"etl_1001_2_system_cpu_summary","connector":{"state":"RUNNING","worker_id":"10.X.X.X:10052"},"tasks":[{"state":"RUNNING","id":0,"worker_id":"10.X.X.X:10052"}]}

# 2.确认kafka节点数量
$ /data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 ls /common_kafka/brokers/ids
......
WatchedEvent state:SyncConnected type:None path:null
[1, 2, 3]

# 此步主要检查redis内是否有快照数据，在redis服务器上
source /data/install/utils.fc
$ redis-cli -h $REDIS_IP -p $REDIS_PORT -a $REDIS_PASS
10.X.X.X:6379> AUTH "REDIS密码"
OK
10.X.X.X:6379> SUBSCRIBE 2_snapshot
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "2_snapshot"
3) (integer) 1
1) "message"
2) "2_snapshot"
3) "{\"localTime\": \"2018-08-15 11:18:00\", \"data\": \"{\\\"beat\\\":{\\\"address\\\":
```

## MySQL 清理binlog日志方法

> MySQL中的binlog日志记录了数据库中数据的变动，便于对数据的基于时间点和基于位置的恢复，但是binlog也会日渐增大，占用很大的磁盘空间，因此，要对binlog使用正确安全的方法清理掉一部分没用的日志

**注意：如下提供的方法仅供用户参考，具体操作请务必按照自己的实际情况设置**

### 手动清理binlog

若社区版设置了多台mysql，需查看主库和从库正在使用的binlog是哪个文件

```mysql
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

在删除binlog日志之前，首先对binlog日志备份，以防万一

清理方法一：删除指定日期以前的日志索引中binlog日志文件

```mysql
purge master logs before '2018-08-01 17:20:00';
```

清理方法二：删除指定日志文件的日志索引中binlog日志文件

```mysql
purge master logs to'mysql-bin.000006'; 
```

**注意**

- 时间和文件名一定不可以写错，尤其是时间中的年和文件名中的序号，以防不小心将正在使用的binlog删除！！！
- 切勿删除正在使用的binlog！！！
- 使用该语法，会将对应的文件和mysql-bin.index中的对应路径删除！！！

### 自动清理binlog

使用如下方法查询当前binlog的过期时间，若为0表示不过期

```bash
mysql> show variables like 'expire_logs_days'; 
+------------------+-------+ 
| Variable_name    | Value | 
+------------------+-------+ 
| expire_logs_days |   0   | 
+------------------+-------+ 
```

使用如下方法设置binlog过期时间，设置30表示30天后自动清理之前的过期日志

```bash
mysql> set global expire_logs_days = 30;
```

