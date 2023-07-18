# DB 日常备份

- 该备份策略适合于日常的数据备份，升级蓝鲸时需重新进行备份操作。
- 远程备份可放在 NFS 或者 HDFS 来保存。
- 支持手工执行相应脚本备份，业务空闲期。
- 目前支持 MySQL、MongoDB、Redis、InfluxDB 数据库的本地全备。
- 该备份策略默认在每天凌晨 3 点开始备份。如需修改，请自行修改 crontab 定时任务。
- 备份文件统一存放于 /data/src/backup/dbbak。为保险起见，可遵循备份 3-2-1 法则。
- 备份数据默认保留 3 天。如需修改，请自行修改 /data/src/backup/dbbak/*.conf 的 `oldfileleftday` 的值。


## 备份部署

部署备份分四种情况：

1.第一次初始化 (中控机)

```bash
# 中控机执行
source /data/install/utils.fc
ssh root@$BK_MYSQL_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mysql"
ssh root@$BK_MONGODB_IP0 "$CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mongodb"
```

2.故障替换机器 (新机器)

通过 `/data/install/install.config` 涉及对应的 DB 类型机器，进行相应 db 版本部署，如 MySQL，其它类型类似。

```bash
source /data/install/utils.fc
bash $CTRL_DIR/storage/dbbackup/dbbackup_init.sh blueking mysql
```

3.故障机器恢复再使用，不用部署。

4.同类型数据库在一台机器上部署了多实例的情况。例如：MySQL 在一台机器上启动两个实例 3306 和 3307 端口，备份只需要做如下配置，其它类型 DB 可以参考：

```bash
cat > /data/src/backup/dbbak/dbbackup_mysql_3307.conf << EOF

[blueking]
productname=bkee
charset=utf8
cmdpath=/usr/bin
host=本地IP
port=3307
user=root
dataorgrant=all
role=master
backupdir=/data/src/backup/dbbak
dbtype=mysql
oldfileleftday=3
ignoredblist=information_schema mysql test db_infobase performance_schema sys

EOF
```

5.手工发起备份。
dbtype 可支持 MySQL | MongoDB | Redis | InfluxDB

```bash
# ${dbtype} 请使用实际的数据库类型进行替换
source /data/install/utils.fc
nohup bash /data/src/backup/dbbak/dbbackup_mysql.sh /data/src/backup/dbbak/dbbackup_mysql.conf blueking & 
```

## 定点恢复

完整的全备和增量备份的情况下，数据库可以恢复到任意时间点。

**恢复全备和增量备份时对应的应用需要停止，规避数据冲突和不可逆转的问题**
**做任意恢复前一定要先做好备份**

### MySQL(全备 & 增量恢复)

- 全备恢复（在 MySQL 主机上执行）

   ```bash
   # 登录至 MySQL 机器
   source /data/install/utils.fc
   ssh $BK_MYSQL_IP

   # 导入数据
   tar -xvf mysql-blueking-10.0.0.1-3306-xxxxxx.sql.tar.gz
   nohup gunzip < mysql-blueking-10.0.0.1-3306-xxxxx.sql.tar.gz |mysql --login-path=default-root 2>err.log &
   ```

- 增量 BINLOG 恢复，恢复至指定时间点

   1. 找出全备对应的 BINLOG 起始文件(CHANGE MASTER TO 那一行)

      ```bash
      zcat mysql-blueking-10.0.0.1-3306-xxxxx.sql | head -100
      ```

   2. 找出最后恢复时间点的 BINLOG 文件

      ```bash
      cd  /data/bkce/public/mysql/default/binlog

      for i in `seq -w 000001 000012`; do
        mysqlbinlog mysql-bin.0000$i | mysql --login-path=default-root >> restore.sql
      done
      ```

      恢复临近 mysql-bin.000012 指定时间点(即可恢复到的时间点)

      ```bash
      mysqlbinlog -–stop-datetime="2020-12-28 11:25:56" mysql-bin.000012 |mysql --login-path=default-root >> restore.sql
      ```

   3. 导入 BINLOG

      ```bash
      nohup mysql --login-path=default-root <restore.sql 2>err.log
      ```

#### MongoDB(全量&增量恢复)

- 全备恢复

备份方式不一样，恢复的命令不一样，这里以蓝鲸的备份方式来进行恢复：(以 cmdb 为例)

```bash
mongorestore -h $BK_CMDB_MONGODB_HOST:$BK_CMDB_MONGODB_PORT  -u $BK_CMDB_MONGODB_USERNAME -p $BK_CMDB_MONGODB_PASSWORD  --dir=/data/src/backup/dbbak/mongodb_xxxxxxx/cmdb --gzip --db cmdb
```
