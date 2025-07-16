>**注意**
>
>为了防止意外修改 `INSTALL_DIR` 变量内容导致备份失败，本文硬编码了目录地址，请自行替换。

# 备份部署脚本

备份当前的 部署 目录
```bash
cp -a -r ~/bkce7.1-install{,$(date +%Y%m%d-%H%M%S).bak}
```

# 备份数据库

## MySQL

### 蓝鲸公共实例 bk-mysql

目前蓝鲸公共 MySQL 尚未开启 binlog，你可以直接备份。

建议变更启用 binlog 后备份。期间需要重启 MySQL，执行前请确认不会对业务造成影响。

#### 启用 binlog
配置：
```bash
cd ~/bkce7.1-install/blueking
# 开启 bin-log，请注意在[mysqld]中配置
yq '.master.config' environments/default/mysql-values.yaml.gotmpl  > /tmp/mysql_master_config.txt
sed -i '/\[mysqld\]/a\server-id=1\n\log_bin=/bitnami/mysql/binlog.bin' /tmp/mysql_master_config.txt
yq -n  '.master.config = "'"$(< /tmp/mysql_master_config.txt)"'"' >> environments/default/mysql-custom-values.yaml.gotmpl
# 检查配置
yq '.master.config' environments/default/mysql-custom-values.yaml.gotmpl
```

重启 MySQL：
``` bash
# 更新 configmap
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql apply
# 检查配置是否生效
kubectl describe configmaps -n blueking bk-mysql-mysql-master
# 重启mysql master
kubectl rollout restart statefulset -n blueking bk-mysql-mysql-master
```

等待 MySQL 启动完成后，查看 binlog 是否生效：
``` bash
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -pblueking -e "SHOW VARIABLES LIKE '%log_bin%';"
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -pblueking -e "SHOW MASTER STATUS;"
```

#### 开始备份

1. 创建 MySQL 备份目录
``` bash
install -dv /data/bkmysql_bak
```
2. 生成备份脚本
``` bash
cat >/data/dbbackup_mysql.sh <<'EOF'
#!/bin/bash
MYSQL_USER=root
MYSQL_HOST=127.0.0.1
MYSQL_PASSWD=
MYSQL_CONN="mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD -NB"
ignoredblist='information_schema|mysql|test|db_infobase|performance_schema|sys'
dblist="$(mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD -Nse"show databases;"|grep -Ewv "$ignoredblist" | xargs echo)"
mysqldump -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD --skip-opt --create-options --default-character-set=utf8mb4 -R -E -q -e --single-transaction --no-autocommit --master-data=2 --max-allowed-packet=1G --hex-blob -B $dblist > /tmp/bk_mysql_alldata.sql

# 导出创建用户语句
echo """select concat('show create user \"',user,'\"@\"',host,'\";') from mysql.user where user not in('mysql.session','mysql.sys','root');""" | $MYSQL_CONN | $MYSQL_CONN | sed 's/$/;/' >> /tmp/bk_mysql_alldata.sql
# 导出授权语句
echo """select concat('show grants for \"',user,'\"@\"',host,'\";') from mysql.user where user not in('mysql.session','mysql.sys','root');""" | $MYSQL_CONN | $MYSQL_CONN | sed 's/$/;/' >> /tmp/bk_mysql_alldata.sql
EOF
```
3. 替换脚本中的密码
``` bash
mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')
sed -i "s#MYSQL_PASSWD=.*#MYSQL_PASSWD=\"${mysql_passwd}\"#" /data/dbbackup_mysql.sh
```
4. 将备份脚本 cp 到 pod 内执行
``` bash
sed -i "s#MYSQL_PASSWD=.*#MYSQL_PASSWD=\"${mysql_passwd}\"#" /data/dbbackup_mysql.sh
kubectl cp -n blueking /data/dbbackup_mysql.sh bk-mysql-mysql-master-0:/tmp/dbbackup_mysql.sh
kubectl  exec -it -n blueking bk-mysql-mysql-master-0 -- bash /tmp/dbbackup_mysql.sh
kubectl cp -n blueking bk-mysql-mysql-master-0:/tmp/bk_mysql_alldata.sql /data/bkmysql_bak/bk_mysql_alldata.sql
# 检查备份文件
grep 'CREATE DATABASE' /data/bkmysql_bak/bk_mysql_alldata.sql
```

### 蓝鲸其他 MySQL 实例
可以参考上述方法进行。

命名空间及 Pod 名如下：
``` plain
bcs-system bcs-mysql-0
blueking bk-ci-kubernetes-manager-mysql-0
blueking bk-ci-mysql-0
blueking bk-mysql-mysql-master-0
```

### 自定义 MySQL 服务
你的自定义存储服务需要自行备份。

可以借鉴上述文档，使用 `mysqldump` 命令或者其他工具完成备份。


## MongoDB

### 蓝鲸公共实例 bk-mongodb

``` bash
install -dv mongodb_bak

mongodb_user=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mongodb.rootUsername')
mongodb_password=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mongodb.rootPassword')

kubectl exec -it -n blueking bk-mongodb-0 -- mongodump -u $mongodb_user -p $mongodb_password --oplog --gzip --out /tmp/mongodb_bak
kubectl cp -n blueking bk-mongodb-0:/tmp/mongodb_bak /data/mongodb_bak
```

### 蓝鲸其他 MongoDB 实例
可以参考上述方法进行。

命名空间及 Pod 名如下：
``` plain
bcs-system bcs-mongodb-随机ID
blueking bk-ci-mongodb-0
blueking bk-codecc-mongodb-0
blueking bk-mongodb-0
```

### 自定义 MongoDB 服务
你的自定义存储服务需要自行备份。

可以借鉴上述文档，使用 `mongodump` 命令或者其他工具完成备份。

# 备份其他资源

## bkrepo 存储对象

bkrepo 存储使用默认 pvc 提供的 pv。请根据 pv 类型自行备份完整目录。


## itsm 附件
itsm 要求配置本地存储，或者 nfs 存储附件。

请备份所在的 pv ，或者 nfs 服务器里的文件。

