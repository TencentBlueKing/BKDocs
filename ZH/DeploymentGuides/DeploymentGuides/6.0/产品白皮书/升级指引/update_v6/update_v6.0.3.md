# 社区版 5.1 - 6.0.3 升级指引

## 适用范围

- 社区版 5.1 - 6.0.3

## 准备机器

### 套餐拆分说明

1. 从社区版 6.0.3 开始，原社区版完整包已拆分为基础套餐与监控日志套餐：
   - **基础套餐**：PaaS 平台、配置平台、作业平台、权限中心、用户管理、节点管理、标准运维、流程服务。
   - **监控日志套餐**：监控平台、日志平台、故障自愈。
2. 为了保证环境的稳定，建议各个套餐使用单独的机器资源部署

### 配置评估

1. 社区版 5.1 的最低机器配置要求为：1 台 4 核 16G + 2 台 4 核 8G
2. 社区版 6.0 基础套餐的最低机器配置要求为：3 台 4 核 16G
3. 社区版 6.0 监控日志套餐的最低机器配置要求为：1 台 8 核 16G

### 机器准备建议

1. 现有环境机器配置满足：3 台 4 核 16G，则需要增加 1 台 8 核 16G 部署监控日志套餐，升级请参考 [新增主机进行升级](./update_install_config_for_v6.md#新增主机进行升级)
2. 现有环境机器配置满足：3 台 8 核 32G，可不增加机器直接升级（不建议），升级请参考 [原机器配置进行升级](./update_install_config_for_v6.md#原机器配置进行升级)

## 风险提示

- 请仔细阅读本升级文档，避免因未注意相关细节造成误操作。
- 如无特殊说明，所述操作均在中控机执行。
- 原蓝鲸官方 SaaS 必须提前下架，否则将影响 SaaS 升级部署。
- 请严格按照本文档步骤进行升级，如升级过程存在问题，请先解决该问题后再继续往下执行升级。
- 非标准私有 IP 用户需在解压新的脚本后，需要按照以前修改 [非标准私有 IP](../../基础包安装/环境准备/get_ready.md) 的方式重新修改。
- 如果 MySQL 备份参考本升级文档的备份方式，涉及到有自行开发的 SaaS 应用，请重新前往 MySQL 重新授权。
- 本次升级务必保证 MySQL/MongoDB 机器磁盘空间充足，避免磁盘空间不足导致备份失败。
- 本升级方案不负责迁移 5.1 中的监控数据，包括开源组件中 influxdb 和 es 的数据，监控数据将会丢失，请知悉。
- 本次升级方案为停服更新，包含多个开源组件版本、官方组件版本的升级，升级时间较长，请避开业务繁忙时期进行升级。
- 本次升级相关产品有新增进程等，请在升级前先对原主机资源(内存、CPU 等)进行评估是否足够，可参考官网给出的 [机器配置](https://bk.tencent.com/download/) 进行评估。
- 本升级方案仅适用于未做过任何改造的用户，若有定制化调整（如接入企业登录，新增 API 以及接入其他企业内部系统），或部分产品为开源产品不适用本升级指引，需自行维护特殊化部分功能。

## 重点提前知

**升级完之后：**

- 请前往节点管理升级 agent、proxy 以及各插件至最新版本。
- 因社区版 6.0 相关接口变化，升级完成后会导致服务商的 SaaS 不可用，请知悉。
  
## 升级前置准备

下述所有升级步骤均以默认的安装目录 `/data/bkce` 为例，如使用自定义安装目录请在相关操作前进行替换。

1.下载软件包以及迁移工具，并将其放置 /data 目录

|软件包|下载地址|MD5|备注|
|---|---|---|---|
|bkce_src_6.0.3.tar.gz|[https://bkopen-1252002024.file.myqcloud.com/ce/bkce_src-6.0.3.tgz](https://bkopen-1252002024.file.myqcloud.com/ce/bkce_src-6.0.3.tgz)|565d48217a1ff1002fe181130637b170|蓝鲸完整包|
|迁移工具合集|[https://bkopen-1252002024.file.myqcloud.com/ce/ce6.0_upgrade_tools.zip](https://bkopen-1252002024.file.myqcloud.com/ce/ce6.0_upgrade_tools.zip)|5a7632530948e0733368f859c4db609d|包含下表所有迁移工具|
|upgrade.py|-|4683f0f7d5136c1799b5010f8960d7e3 |节点管理升级脚本|
|migrate_old_environ_v2.sh|-|4ae6c6f2a1ccb4658c7a124857561d67|旧变量转换脚本|
|iam_v3_legacy_1.0.16_for_ce.tgz|-|106f8a90f243be85743ff7baf1d0eafc|权限中心迁移脚本|
|job-migration-ce_0.1.2_Linux_x86_64.tar.gz|-|3949713d37668535915bf03a4dd09a6e|JOB 升级脚本|
|job-account-perm-migration_v0.0.0-next_Linux_x86_64.tar.gz|-|5eebb26767debc18d2620ec0840573bf|JOB 帐户迁移|

2.升级前，请检查环境各主机资源情况，避免升级过程中出现内存或者磁盘不足等情况。配置请参考 [蓝鲸官网下载页](https://bk.tencent.com/download/) 。

3.当数据库的数据量过大时，可以考虑使用 truncate 或 delete 的方式，清空监控告警表的数据 **（该项由用户自主决定是否清理该表的数据）**。

- 库名：bkdata_monitor_alert
- 表名：ja_alarm_alarminstance

### 下架官方 SaaS

请访问蓝鲸 PaaS 平台，通过【开发者中心】->【 S-mart 应用】下架所有官方 SaaS。

### 解压迁移工具包

```bash
unzip ce6.0_upgrade_tools.zip -d /data/
```

### 迁移配置文件相关变量

将社区版 5.1 的环境变量转换成社区版 6.0 的环境变量。请保存好生成的文件。
该脚本会在中控机生成 `${HOME}/.tag/dbadmin.env` 标记文件，请在正式升级时确认该文件是否存在。

```bash
source /data/install/utils.fc

cd /data
bash migrate_old_environ_v2.sh
```

### 蓝鲸用户检查

社区版 6.0 中蓝鲸组件统一由 `blueking` 用户管控，需要在所有蓝鲸后台服务器中创建 id 为 10000 的 blueking 用户。
如已存在 id 为 10000 的用户，请自行处理。

```bash
source /data/install/utils.fc
for ip in ${ALL_IP[@]}; do
	ssh ${ip} "if id 10000 > /dev/null; then echo "${ip} 已存在 id 为 10000 的用户";fi"
done
```

### 停止相关服务进程

```bash
source /data/install/utils.fc
# 停止蓝鲸相关服务
echo fta bkdata appo appt gse job cmdb paas redis nginx license kafka es beanstalk influxdb zk rabbitmq consul | xargs -n1 ./bkcec stop

# 观察进程是否已经停止，如果没有停止，可手动强制停止
echo fta bkdata appo appt gse job cmdb paas redis nginx license kafka es beanstalk influxdb zk rabbitmq consul | xargs -n1 ./bkcec status
```

## 数据备份

### 备份 MySQL

**备份前，请确认使用到 MySQL 的相关服务已停止，避免出现数据不一致的问题。**
该备份方式仅供参考，可自行选择备份方式。

- 登录至 MySQL 机器，创建备份目录

```bash
source /data/install/utils.fc
ssh $MYSQL_IP

# 创建备份目录
source /data/install/utils.fc
mkdir -p /data/dbbak
cd /data/dbbak
```

- 生成备份脚本

**注意:** 该备份方式不包含 MySQL 默认库的备份，所以涉及自行开发的 SaaS 应用使用到的帐户密码会丢失。如无，可参考如下方式进行备份。

```bash
# joblog 在升级的过程中可以不需要备份，可以加入到 ignoredblist 列表里。但是为了后续回滚，请确保 joblog 已存在有一份备份数据。

cat >dbbackup_mysql.sh <<EOF
#!/bin/bash

ignoredblist='information_schema|mysql|test|db_infobase|performance_schema|sys'

dblist="\$(mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_IP -P$MYSQL_PORT -Nse "show databases;"|grep -Ewv "\$ignoredblist"|xargs echo)"

mysqldump -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_IP -P$MYSQL_PORT  --skip-opt --create-options --default-character-set=utf8mb4 -R  -E -q -e --single-transaction --no-autocommit --master-data=2 --max-allowed-packet=1G  --hex-blob  -B  \$dblist > /data/dbbak/bk_mysql_alldata.sql

EOF
```

- 开始备份

```bash
# 如果不存在 mysql 命令可以手动安装（非必选）
yum -y install mysql

# 执行备份操作
bash dbbackup_mysql.sh

# 请检查导出是否正确
grep 'CREATE DATABASE' bk_mysql_alldata.sql
```

- 停止服务

```bash
# 中控机操作
./bkcec stop mysql
./bkcec status mysql

# 查看是否存在残余进程
rcmd "root@$MYSQL_IP" "ps -ef | grep mysql"
```

### 备份 MongoDB

该备份方式仅供参考，可自行选择备份方式。

- 登录至 MongoDB 机器，创建备份目录

```bash
source /data/install/utils.fc
ssh $MONGODB_IP

# 创建备份目录
mkdir -p /data/mongodb_bak
```

- 开始备份 MongoDB

```bash
source /data/install/utils.fc
# 备份 MongoDB 数据：
mongodump --host $MONGODB_IP -u $MONGODB_USER -p $MONGODB_PASS --oplog --gzip --out /data/mongodb_bak
```

- 停止 MongoDB

```bash
./bkcec stop mongodb
```

- 备份 MongoDB 数据目录

```bash
source /data/install/utils.fc

for ip in ${MONGODB_IP[@]}; do
    backup_dir=/data/mongodb_dirbak_$(date +%F);
    rcmd root@"$ip" "if ! [[ -d $backup_dir ]];then mkdir $backup_dir;fi; tar czfP $backup_dir/mongodb.tar.gz $INSTALL_PATH/public/mongodb/";
done
```

- 拉起 MongoDB 服务

```bash
./bkcec start mongodb
```

### 备份 Zookeeper

- 备份 Zookeeper 数据目录

```bash
for ip in ${ZK_IP[@]};do
    backup_dir=/data/zk_dirbak_$(date +%F);
    rcmd root@"$ip" "if ! [[ -d $backup_dir ]];then mkdir $backup_dir;fi; tar czfP $backup_dir/zk.tar.gz $INSTALL_PATH/public/zk/";
done
```

### 备份 Rabbitmq

- 备份 Rabbitmq 数据目录

```bash
for ip in ${RABBITMQ_IP[@]}; do
    backup_dir=/data/rabbitmq_dirbak_$(date +%F);
    ssh root@"$ip" "if ! [[ -d $backup_dir ]];then mkdir $backup_dir;fi; tar czfP $backup_dir/rabbitmq.tar.gz $INSTALL_PATH/public/rabbitmq/";
done
```

### 备份 src 目录

```bash
# 中控机执行，请用 mv 备份 src 目录。
mv /data/src/ /data/src.bak
```

### 备份 install 目录

```bash
# 请不要使用 mv 命令备份，一定要使用 cp 备份 install 目录，不然会导致 install/.app.token发生改变
cp -a /data/install /data/install.bak
```

### 备份 Python 解释器

```bash
source /data/install/utils.fc
for i in ${ALL_IP[@]};do ssh $i 'for py in py27 py27_e py36 py36_e; do [[ -d /opt/$py ]] && mv /opt/$py /opt/"$py"_bak; done'; done
```

### 备份模块分布标记文件

```bash
source /data/install/utils.fc
for i in ${ALL_IP[@]};do ssh $i 'mv /data/bkce/.installed_module /data/bkce/.installed_module.bak'; done
```

### 备份模块安装标记文件

```bash
source /data/install/utils.fc
for i in ${ALL_IP[@]};do ssh $i 'mv /data/install/.bk_install.step /data/install/.bk_install.step.bak'; done
```

## 更新软件包及相关文件

### 更新 V6.0 软件包

```bash
tar xvf bkce_src-6.0.3.tgz -C /data
```

### 解压各个产品包

```bash
cd /data/src/; for f in *gz;do tar xf $f; done
```

### 拷贝 rpm 包文件夹到/opt/目录

```bash
cp -a /data/src/yum /opt
```

### 恢复环境变量文件

```bash
cp /tmp/install/bin/01-generate/* /data/install/bin/01-generate/
cp /tmp/install/bin/03-userdef/* /data/install/bin/03-userdef/
```

### 更新 install.config 配置

请参考 [社区版 5.1-6.0 install.config 配置](./update_install_config_for_v6.md)

### 主机免密

<font color="#dd0000">仅新增主机升级需要操作。</font>

```bash
./configure_ssh_without_pass
```

### 恢复证书

- 如原 license 模块分布未发生改变，请按下述步骤操作：

```bash
cp -a /data/src.bak/cert /data/src/
```

- 如原 license 模块分布发生改变，请按下述步骤操作：

请前往 [蓝鲸官网](https://bk.tencent.com/download_ssl/) 重新生成证书。将生成的证书包上传至中控机 /data 目录

```bash
install -d -m 755 /data/src/cert
tar xf /data/ssl_certificates.tar.gz -C /data/src/cert/
```

### 初始化操作

生成蓝鲸部署时所需的环境变量以及资源。

```bash
./bk_install common
```

### 初始化资源检查

```bash
cd /data/install
./health_check/check_bk_controller.sh
```

## 开源组件升级

### 升级 consul

```bash
./bkcli install consul && echo "install consul" >> /data/install/.bk_install.step
./bkcli start consul && echo "start consul" >> /data/install/.bk_install.step
```

### 升级 MySQL

```bash
./bkcli install mysql && echo "install mysql" >>/data/install/.bk_install.step
./bkcli start mysql && echo "start mysql" >>/data/install/.bk_install.step
```

#### 恢复 MySQL 数据

```bash
# 登录至 MySQL 机器
source /data/install/utils.fc
ssh $BK_MYSQL_IP

# 恢复数据
mysql --login-path=default-root --default-character-set=utf8  < /data/dbbak/bk_mysql_alldata.sql
```

### 升级 MongoDB

参考 [蓝鲸社区版 5.1 mongodb 升级文档](./update_mongodb_for_v6.md)

### 解决 Rabbitmq 依赖冲突

```bash
# 卸载之前的依赖
./pcmd.sh -H $BK_RABBITMQ_IP "yum -y remove rabbitmq-server.noarch  erlang-*"
```

### 升级 Kafka

```bash
./bkcli install kafka  && echo "install kafka" >> /data/install/.bk_install.step
```

<font color="#dd0000">新增机器请忽略该步骤</font>

由于 Kafka 版本原因，以及由原来的集群变为单点。所以配置文件中的 `broker.id` 会有所变化，在启动 Kafka 时会报错。所以需要先做如下修改，修改后再启动 kafka :

```bash
# 登录至 Kafka 机器
source /data/install/utils.fc
ssh $BK_KAFKA_IP

# 查看升级 Kafka 后的 server.properties 文件中的 broker.id。将 meta.properties 中的 broker.id 与 server.properties文件中的保持一致
# x 为实际的 broker.id
grep "broker.id" /data/bkce/public/kafka/meta.properties
broker.id=x

# 替换 server.properties 中的 broker.id 。 请将下述的 x 替换成实际的值
sed -i "s/broker.id=.*/broker.id=x/g" /etc/kafka/server.properties

# 修改 kakfa 数据目录属组属主
chown -R kafka.kafka /data/bkce/public/kafka
```

## 升级蓝鲸组件

### 升级 PaaS 平台

**注意：** 确定所有的 SaaS 已下线

- 升级前需先生成前置 SQL 文件，并将该 SQL 文件导入指定数据库。

```bash
# 生成前置 SQL 文件
cat > /data/change_paas.sql <<EOF
use open_paas;
insert into django_migrations(app, name, applied) value('bkcore', '0010_auto_20171110_1004', Now());
insert into django_migrations(app, name, applied) value('bkcore', '0011_auto_20171116_1205', Now());
insert into django_migrations(app, name, applied) value('bkcore', '0012_auto_20180622_1815', Now());
insert into django_migrations(app, name, applied) value('home', '0004_auto_20200714_1627', Now());
delete from auth_permission where content_type_id in (select id from django_content_type where app_label='app' and model='desktopsettings');
delete from django_content_type where app_label='app' and model='desktopsettings';
EOF
```

- 导入 SQL 文件并验证

```bash
# 导入 SQL 文件
mysql --login-path=mysql-default < /data/change_paas.sql

# 查询验证
mysql --login-path=mysql-default  -e "use open_paas;select  app,name,applied from django_migrations where app='bkcore' order by name desc  limit 5;"
```

- 由于 5.1 的 PaaS 是未加密版本，所以在升级的过程中，会出现加密的报错。需先删掉 PaaS 的旧虚拟环境后再升级 PaaS。

```bash
source /data/install/utils.fc

./pcmd.sh -H $BK_PAAS_IP "rmvirtualenv open_paas-apigw open_paas-appengine open_paas-esb open_paas-login open_paas-paas"
```

- 开始升级

```bash
./bk_install paas
```

### 升级 app_mgr

```bash
./bk_install app_mgr
```

### 部署权限中心和用户管理

```bash
./bk_install saas-o bk_iam
./bk_install saas-o bk_user_manage
```

#### 迁移用户管理数据

> 验证：执行完下述命令后，打开用户管理 -> 组织架构 -> 默认目录 -> 总公司。检查原 5.1 上的用户是否存在。

```bash
# 登录 usermgr 服务器，执行脚本
source /data/install/utils.fc
ssh $BK_USERMGR_IP

# 进入用户管理虚拟环境
workon usermgr-api

source /data/install/utils.fc
# 加载相关环境变量
export MYSQL_IP0=$BK_PAAS_MYSQL_HOST
export MYSQL_PORT=$BK_PAAS_MYSQL_PORT
export MYSQL_USER=$BK_PAAS_MYSQL_USER
export MYSQL_PASS=$BK_PAAS_MYSQL_PASSWORD
export DJANGO_SETTINGS_MODULE=config.ce.prod
export BK_FILE_PATH="/data/bkce/usermgr/cert/saas_priv.txt"

# 迁移数据前，查看迁移内容
python manage.py migrate_from_ce_5dot1 --dry_run   # WARNING 输出为正常

# 迁移内容无误后，开始迁移
python manage.py migrate_from_ce_5dot1 > migrate.log
```

### 升级 CMDB

```bash
./bk_install cmdb

# 授权原主机导入的 xlsx 目录
./pcmd.sh -m cmdb "chown -R blueking.blueking /tmp/template"
```

### 升级作业平台

```bash
./bk_install job
```

#### JOB 数据迁移

- 在执行 JOB 数据迁移时，请先执行如下命令，将 JOB 加入至权限中心白名单

```bash
# 添加白名单 （中控机执行）
mysql --login-path=mysql-default -e "insert into bk_iam.authorization_authapiallowlistconfig(creator, updater, created_time, updated_time, type, system_id, object_id) value('', '', now(), now(), 'authorization_instance', 'bk_job', 'use_account');"

# 确认是否已插入
mysql --login-path=mysql-default -e "select * from bk_iam.authorization_authapiallowlistconfig where type='authorization_instance' and system_id='bk_job'"
```

- 开始迁移

	下载迁移工具：job-migration-ce_0.1.2_Linux_x86_64.tar.gz

	```bash
	# 请按照仔细阅读目录下 README.md 文档
	tar -xvf /data/job-migration-ce_0.1.2_Linux_x86_64.tar.gz -C /data
	cd /data/job-migration-ce_0.1.2_Linux_x86_64
	```

	- 加载环境变量

	```bash
	source /data/install/utils.fc
	```

	- 生成 config.toml 文件。`生成后请检查该文件内的相关变量是否转化成具体的值。`

	```bash
	cat > config.toml << EOF
	jobManageHost = "http://$BK_JOB_IP:$BK_JOB_MANAGE_SERVER_PORT"
	jobCrontabHost = "http://$BK_JOB_IP:$BK_JOB_CRONTAB_SERVER_PORT"
	processScript = true
	processPlan = true
	processCron = true
	processWhiteList = true
	offset = 0
	includeAppId = ""
	excludeAppId = ""
	test = false

	# 如果不需要更改业务 ID 则可以去掉。配置成 1=1 也不影响
	[appMapper]
	1 = 1

	[mysql]
	host = "$BK_MYSQL_IP"
	port = 3306
	username = "$BK_MYSQL_ADMIN_USER"
	password = "$BK_MYSQL_ADMIN_PASSWORD"
	database = "job"

	[log]
	level = "info"

	[jwt]
	RSAPublicKey = "$BK_JOB_SECURITY_PUBLIC_KEY_BASE64"

	RSAPrivateKey = "$BK_JOB_SECURITY_PRIVATE_KEY_BASE64"

	EOF
	```

	- 迁移 JOB 脚本数据

	```bash
	./job-migration-ce
	```

#### JOB 账号迁移

下载迁移工具：job-account-perm-migration_v0.0.0-next_Linux_x86_64.tar.gz

```bash
# 请按照仔细阅读目录下 README.md 文档
tar -xvf /data/job-account-perm-migration_v0.0.0-next_Linux_x86_64.tar.gz -C /data/
cd /data/job-account-perm-migration_v0.0.0-next_Linux_x86_64
```

- 加载环境变量

```bash
source /data/install/utils.fc
```

- 生成 config.toml 文件。 `生成后请检查该文件内的相关变量是否转化成具体的值。`

```bash
cat > config.toml << EOF

jobGatewayHost = "http://$BK_JOB_GATEWAY_HTTP_PRIVATE_ADDR"
esbHost = "http://$BK_PAAS_PRIVATE_ADDR"
includeAppId = ""
excludeAppId = ""
appCode = "$BK_JOB_APP_CODE"
appSecret = "$BK_JOB_APP_SECRET"
iamHost = "$BK_IAM_PRIVATE_URL"

[appMapper]

[mysql]
host = "$BK_MYSQL_IP0"
port = 3306
username = "$BK_MYSQL_ADMIN_USER"
password = "$BK_MYSQL_ADMIN_PASSWORD"
database = "job"

[log]
level = "info"
EOF
```

- 执行升级脚本

```bash
./job-account-perm-migration
```

#### 迁移 JOB 上传文件目录

```bash
# 这里以默认的 /data/bkce/ 目录为例，升级过程请以实际的为准
source /data/install/utils.fc
ssh $BK_JOB_IP

cd /data/bkce/public/job/

# 如果未进行过文件分发，不会生成 localupload ，可手动创建
mkdir localupload
cp -a -r  data1/localupload/* localupload/
chown -R blueking.blueking /data/bkce/public/job/localupload/
```

### 升级节点管理

- 如有涉及到 proxy 请参考 [开启 Proxy](https://bk.tencent.com/docs/document/6.0/127/7917)

#### 升级前置准备

- 同步节点管理文件

```bash
./bkcli sync nodeman
```

- 同步升级脚本文件

```bash
# 中控机
cd /data/install
./sync.sh nodeman /data/upgrade.py /data/
```

##### 创建节点管理升级环境

- 登录到节点管理机器，创建升级所需目录

```bash
source /data/install/load_env.sh
ssh $BK_NODEMAN_IP

# 创建升级文件存放目录
mkdir /data/bkce/nodeman_update

# 将 upgrade.py 放置 /data/bkce/nodeman_update 目录下，假设原先该文件放置于 /data 目录
cp -a /data/upgrade.py /data/bkce/nodeman_update/
```

- 生成 requirements.txt 文件

```bash
cat > /data/bkce/nodeman_update/requirements.txt << EOF
pymysql
requests
pycryptodome
pycryptodomex
EOF
```

- 创建节点管理升级虚拟环境目录

```bash
cd /data/install
./bin/install_py_venv_pkgs.sh -e -p /opt/py36/bin/python -n nodeman_update -a /data/bkce/nodeman_update -s /data/src/bknodeman/support-files/pkgs  -r /data/bkce/nodeman_update/requirements.txt
```

- 执行升级脚本

```bash
source /data/install/utils.fc
workon nodeman_update

# 注意：$NODEMAN_APP_CODE 和 $NODEMAN_APP_SECRET 是指节点管理 SaaS 的应用 ID 和应用 TOKEN。且此时的 SaaS 状态处于下线状态，需要将隐藏的 SaaS 显示才能找到节点管理的应用。
# 可以在 "PaaS 平台 -> 开发者中心 ->  S-mart 应用 -> 显示已下架应用 -> 节点管理" 进行查看，然后使用实际的值进行替换即可。

python upgrade.py -a $NODEMAN_APP_CODE  -s $NODEMAN_APP_SECRET -t $BK_MYSQL_IP0 -u $BK_NODEMAN_MYSQL_USER -p $BK_NODEMAN_MYSQL_PASSWORD -o $BK_NODEMAN_MYSQL_PORT
```

#### 开始升级

```bash
./bk_install bknodeman
```

- 迁移 SaaS 数据：

```bash
# 登录至 APPO 机器
source /data/install/utils.fc
ssh $BK_APPO_IP

# 进入节点管理容器内
docker exec -it $(docker ps |awk '/bk_nodeman/{print $1}') /bin/bash

# 开始数据迁移。
export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"
/cache/.bk/env/bin/python /data/app/code/manage.py sync_cmdb_cloud_area
/cache/.bk/env/bin/python /data/app/code/manage.py sync_cmdb_host
/cache/.bk/env/bin/python /data/app/code/manage.py sync_agent_status
/cache/.bk/env/bin/python /data/app/code/manage.py sync_plugin_status
```

### 监控平台

#### 升级监控平台

```bash
./bk_install bkmonitorv3
```

#### 监控配置迁移

**注意：** 不支持原 5.1 的组件监控迁移。

监控平台部署完成后，请登录蓝鲸监控平台，进入到监控平台 Web 页面，在左侧导航栏中找到【配置升级】然后开始数据迁移

- 迁移步骤：
  - 点击开始迁移。
  - 选择迁移的内容后，点击开始迁移，然后查看迁移状态。
  - 迁移完成后，会存在相同的监控策略，为避免重复告警，请停用旧的监控策略。

![bkmonitorv3](../../assets/update_bkmonitorv3.png)

### 日志平台

**日志平台迁移后，只是将原采集配置任务迁移，需要手动重新下发任务才能生效，请知悉。**

#### 支持&不支持迁移的内容

- 迁移内容
  - 支持迁移
  - 采集配置项数据
    - 迁移的字段：`采集 IP`，`采集路径`。不支持迁移 `排除文件类型` 和 `过期时间`
    - 迁移后为草稿状态，此时未下发采集配置。需要点击保存方可下发配置
  - 不支持迁移
  - ES 数据
  - 监控策略
  - 角色权限

- 升级日志平台

```bash
./bk_install bklog
```

- 执行变更脚本

```bash
# 在 APPO 机器执行以下命令
source /data/install/utils.fc
ssh $BK_APPO_IP

# 进入 bk_log_search 的 docker 容器
docker exec -it $(docker ps |awk '/bk_log_search/{print $1}') /bin/bash

# 进入容器后，修改语言配置、进入工作目录
export LC_ALL=en_US.UTF-8
cd /data/app/code

# 查看升级用户名单（仅展示但不执行，用于做确认）
# bk_biz_id 可选，不提供则代表全业务
export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"
/cache/.bk/env/bin/python manage.py iam_list_upgrade [bk_biz_id]

# 执行升级，向权限中心同步操作权限
# bk_biz_id 可选，不提供则代表全业务
/cache/.bk/env/bin/python manage.py iam_do_upgrade [bk_biz_id]

# 执行配置迁移
/cache/.bk/env/bin/python manage.py migrate_v2_config
```

### 升级故障自愈

- 升级故障自愈之前，需要对原来的日志目录权限做下修改，6.0 之前的启动用户是 root，在启动故障自愈时会出现权限问题，所以需要将原来的属主属组修改成 blueking。<font color="#dd0000">新增机器请忽略该步骤</font>

```bash
# 中控机执行
./pcmd.sh -H $BK_FTA_IP  "chown -R blueking.blueking $BK_HOME/logs/fta/"
```

- 开始升级

```bash
./bk_install fta
```

### 升级标准运维

```bash
./bk_install saas-o bk_sops

# # 在 APPO 机器执行以下命令
source /data/install/utils.fc
ssh $BK_APPO_IP

# 进入 bk_sops 的 docker 容器
docker exec -it $(docker ps |awk '/bk_sops/{print $1}') /bin/bash

export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"
cd /data/app/code && python manage.py task_model_migrate
```

### 流程服务

```bash
./bk_install saas-o bk_itsm
```

### 权限中心同步用户组织架构

同步用户管理数据，确保是最新的组织架构数据

> 依赖 IAM V3 后台服务、IAM V3 SaaS、用户管理 和 PaaS（ESB）、必须保证需要迁移权限的系统，对应权限模型已注册

```bash
# 登录至 APPO 机器
source /data/install/utils.fc
ssh $BK_APPO_IP

# 进入 iam 容器内
docker exec -it $(docker ps | grep -Fw bk_iam | awk '{print $1}') bash

# 同步架构数据
export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"
/cache/.bk/env/bin/python /data/app/code/manage.py shell

from backend.apps.organization.tasks import sync_organization
sync_organization()
```

### 迁移权限中心数据

- 将权限中心的升级包下载至中控机的 `/data` 目录后解压

```bash
tar -xvf /data/iam_v3_legacy_1.0.16_for_ce.tgz -C /data
cd /data/iam_v3_legacy_1.0.16_for_ce
```

- 执行 v3 相关权限数据导出到文件

```bash
bash mysqldump_bk_iam_data.sh -d bk_iam -p $BK_MYSQL_ADMIN_PASSWORD -P 3306 -b $BK_MYSQL_IP0
```

- 执行导出配置业务和标准运维项目数据到 CSV 文件

```bash
bash ./edition/mysqldump_bk_sops_data.sh -d bk_sops -p $BK_MYSQL_ADMIN_PASSWORD -P 3306 -b $BK_MYSQL_IP0

/opt/py27/bin/python -m edition.dump_biz_data -s $BK_IAM_APP_SECRET <iam SaaS 的 app secret，可由页面获取>  -t $BK_PAAS_PRIVATE_ADDR
```

### 创建对应业务运维组

**在升级的过程中，默认只创建对应业务下的运维组，如之前涉及的开发、测试等角色人员，需自行创建对应的用户组。**

> 验证：执行完下述命令后，打开权限中心 -> 右上角切换身份至超级管理 -> 用户组。查看是否建立了对应业务的用户组。

```bash
/opt/py27/bin/python -m edition.migrate_biz_group -s $BK_IAM_APP_SECRET <iam SaaS的app secret，可由页面获取>  -t $BK_PAAS_PRIVATE_ADDR
```

### 创建对应业务运维模板

**在升级的过程中，默认只创建对应业务下的运维模板，如之前涉及的开发、测试等角色人员，需自行创建对应的模板。**

- 创建 CMDB 的业务模板

> 验证：执行完下述命令后，打开权限中心 ->  右上角切换身份至超级管理 -> 权限模版。查看是都建立对对应业务的配置平台运维模版。

```bash
/opt/py27/bin/python -m edition.migrate_biz_policy -s $BK_IAM_APP_SECRET <iam SaaS 的 app secret，可由页面获取>  -t $BK_PAAS_PRIVATE_ADDR -e bk_cmdb -E ce -f <配置平台空闲机目录 ID，获取方式请往下看>
```

**配置平台空闲机目录 ID 查询方式：**

```bash
# 登录至 mongodb 机器
source /data/install/utils.fc
ssh $BK_MONGODB_IP

# 登录 MongoDB 查询
source /data/install/utils.fc
mongo -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD mongodb://$BK_MONGODB_IP:27017/admin?replicaSet=rs0


# "bk_module_id" : NumberLong(1) 中的 1 即为配置平台空闲机目录ID
use cmdb
db.cc_ModuleBase.find({default: 1, bk_biz_id: db.cc_ApplicationBase.findOne({default:1, bk_supplier_account:"0"}).bk_biz_id},{bk_module_id:1,bk_module_name:1,_id:0}).pretty()
```

- 创建 JOB、节点管理、监控平台、日志平台、标准运维权限模板

```bash
# bk_iam_app_secret 中的值请使用实际的值替换。可由页面获取权限中心 SaaS 的 应用 TOKEN

bk_iam_app_secret="xxxxxxxx"
modules=(bk_job bk_nodeman bk_monitorv3 bk_log_search bk_sops)

for module in ${modules[@]}
do
    /opt/py27/bin/python -m edition.migrate_biz_policy -s ${bk_iam_app_secret} -t $BK_PAAS_PRIVATE_ADDR -e ${module} -E ce
done
```

## 蓝鲸业务拓扑升级

从 5.1 升级到 6.0 后，如果没有对原拓扑进行升级，蓝鲸监控会出现端口或者进程不存在的告警。**<该类告警可忽略>**

升级请见 ：[社区版 5.1-6.0 蓝鲸业务拓扑升级](./update_bktopo_for_v6.md)
