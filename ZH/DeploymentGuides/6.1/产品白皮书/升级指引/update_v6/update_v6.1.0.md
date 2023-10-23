## 适用范围

6.0.5 升级至 6.1.2

## 说明

- 文中所述的目录路径均以默认为主，如与实际有出入，请以升级实际路径为主。
- 如无特殊说明，所述操作均在中控机执行。
- 本次升级仅面向涉及到的产品，未更新的产品不做阐述，请知悉。详细请见官网文档：[组件更新](../../维护手册/日常维护/update.md)。
- 本次升级会停止部分服务，请避开业务高峰期进行升级，以免影响业务正常运行。

## 获取更新产品信息

本次社区版 6.1.2 更新涉及产品，请查看 [版本日志](../../../../../VersionLog/6.1/v612.md)。

获取目前自身环境下的版本，以避免升级过程带来的问题：

```bash
# 获取版本
cd /data/src; grep . VERSION

# 蓝鲸各产品版本
cd /data/src; grep . */*VERSION */*/VERSION
```

## 前置准备

1. 下载相关产品包。请前往 [蓝鲸下载页](https://bk.tencent.com/download/) 下载。

   - 基础套餐包 (bkce_basic_suite-6.1.2.tgz)
   - 监控告警及日志服务套餐包 (bkce_co_package-6.1.2.tgz)

2. 将相关产品包上传至服务器 /data 目录。

3. 准备新版本部署脚本以及产品包

    ```bash
    # 创建新版本产品临时存放目录
    mkdir /data/tmp

    #将基础套餐包、监控告警及日志服务套餐包解压至临时存放目录
    tar xf bkce_basic_suite-6.1.2.tgz -C /data/tmp/
    tar xf bkce_co_package-6.1.2.tgz -C /data/tmp/

    # 解压增强包监控平台、日志平台整包
    cd /data/tmp/
    for i in *.tgz; do tar xf $i; done

    # 解压后会有各产品的目录，包含各产品的后台包以及 SaaS 包，需要将其拷贝 /data/tmp/src 目录下
    # 拷贝各产品后台包
    for pkg in $(find bklog bkmonitorv3 -name "bk*.tgz"); do cp -a $pkg src; done

    # 拷贝各产品 SaaS 包
    for pkg in $(find bklog bkmonitorv3 -name "bk_*.tar.gz"); do cp -a $pkg src/official_saas/; done
    ```

## 数据备份

### 备份 MySQL

该备份方式仅供参考，可自行选择备份方式。

- 登录至 MySQL 机器，创建备份目录

    ```bash
    source /data/install/utils.fc
    ssh $BK_MYSQL_IP

    # 创建备份目录
    source /data/install/utils.fc
    mkdir -p /data/dbbak
    cd /data/dbbak
    ```

- 生成备份脚本

    ```bash
    # MySQL 机器上执行
    source /data/install/utils.fc

    cat >dbbackup_mysql.sh <<\EOF
    #!/bin/bash

    ignoredblist='information_schema|mysql|test|db_infobase|performance_schema|sys'

    dblist="$(mysql --login-path=default-root -Nse"show databases;"|grep -Ewv "$ignoredblist" | xargs echo)"

    mysqldump --login-path=default-root --skip-opt --create-options --default-character-set=utf8mb4 -R  -E -q -e --single-transaction --no-autocommit --master-data=2 --max-allowed-packet=1G  --hex-blob  -B  $dblist > /data/dbbak/bk_mysql_alldata.sql

    EOF
    ```

- 开始备份

    ```bash
    # 执行备份操作
    bash dbbackup_mysql.sh

    # 请检查导出是否正确
    grep 'CREATE DATABASE' bk_mysql_alldata.sql
    ```

### 备份 MongoDB

该备份方式仅供参考，可自行选择备份方式。

- 登录至 MongoDB 机器，创建备份目录

    ```bash
    source /data/install/utils.fc
    ssh $BK_MONGODB_IP

    # 创建备份目录
    mkdir -p /data/mongodb_bak
    ```

- 开始备份 MongoDB

    ```bash
    # MongoDB 机器上执行
    source /data/install/utils.fc

    mongodump --host $BK_MONGODB_IP -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD --oplog --gzip --out /data/mongodb_bak
    ```

### 备份 install、src 目录

```bash
# 中控机执行
cp -a -r /data/install /data/install_$(date +%Y%m%d%H%M)
mv /data/src /data/src.bak
```

## 更新软件包及相关文件

1. 替换部署脚本、各产品版本包。

    ```bash
    # 替换 src 目录
    mv /data/tmp/src /data/

    # 替换部署脚本
    rsync -avz --delete --exclude=".*" --exclude="install.config" --exclude="bin/0[1234]-*" /data/tmp/install/ /data/install/

    # 解压 src 下各个产品软件包
    cd /data/src/; for f in *gz;do tar xf $f; done

    # 还原证书
    cp -a /data/src.bak/cert /data/src/

    # 还原 backup 目录
    cp -a /data/src.bak/backup /data/src/
    ```

2. 配置 install.config

    本次升级，新增了监控的 monitorv3(unify-query)，monitorv3(ingester) 模块，请合理评估机器资源后，将其分布在 install.config 文件中。可参考下述默认的模块分布。

    ```config
    10.0.0.1 iam,ssm,usermgr,gse,license,redis,consul,es7,monitorv3(influxdb-proxy),monitorv3(monitor),monitorv3(grafana),monitorv3(ingester)
    10.0.0.2 nginx,consul,mongodb,rabbitmq,appo,influxdb(bkmonitorv3),monitorv3(transfer),fta,beanstalk,monitorv3(unify-query)
    10.0.0.3 paas,cmdb,job,mysql,zk(config),kafka(config),appt,consul,log(api),nodeman(nodeman),log(grafana)
    ```

3. 新增所需变量

    ```bash
    source /data/install/utils.fc

    # 新增变量值
    echo "BK_NODEMAN_REDIS_HOST=${BK_REDIS_IP0}" >> /data/install/bin/03-userdef/bknodeman.env
    echo "BK_BKLOG_REDIS_PASSWORD=${BK_REDIS_ADMIN_PASSWORD}" >> /data/install/bin/03-userdef/bklog.env
    echo "BK_JOB_ENCRYPT_PASSWORD=$(rndpw 16)" >> /data/install/bin/03-userdef/job.env
    echo "BK_JOB_MANAGE_SERVER_HOST0=${BK_JOB_IP0}" >> /data/install/bin/03-userdef/job.env
    echo "BK_USERMGR_REDIS_PASSWORD=${BK_REDIS_ADMIN_PASSWORD}" >> /data/install/bin/03-userdef/usermgr.env
    echo "BK_MONITOR_TRANSFER_REDIS_PASSWORD=${BK_REDIS_ADMIN_PASSWORD}" >> /data/install/bin/03-userdef/bkmonitorv3.env
    echo "BK_MONITOR_ALERT_ES7_PASSWORD=${BK_ES7_ADMIN_PASSWORD}" >> /data/install/bin/03-userdef/bkmonitorv3.env
    echo "BK_PAAS_ES7_ADDR=elastic:${BK_ES7_ADMIN_PASSWORD}@es7.service.consul:9200" >> /data/install/bin/03-userdef/paas.env
    ```

4. 同步部署脚本

    ```bash
    ./bkcli install bkenv
    ./bkcli sync common
    ```

5. 更新 python 解释器

    ```bash
    # 备份原 /opt 目录下的 py 解释器
    for ip in ${ALL_IP[@]};do ssh $ip 'for py in py27 py27_e py36 py36_e; do [[ -d /opt/$py ]] ; mv /opt/$py /opt/"$py"_bak; done'; done

    # 开始更新
    pcmd -m ALL "sed -i 's/python//g' ${INSTALL_PATH}/.installed_module"
    for ip in $(awk -F '[ ,]' '{gsub(/\(.*\)/," ");}1 {print $2}' install.config); do ./bkcli install python $ip; done
    ```

## 开始更新

### PaaS 平台

```bash
# 清理 paas 虚拟环境
for module in open_paas-apigw open_paas-appengine open_paas-esb open_paas-login open_paas-paas; do pcmd -m paas "rmvirtualenv $module"; done

# 开始更新
./bkcli sync paas
./bkcli install paas
./bkcli restart paas

# 检查 paas 服务状态
./bkcli check paas

# 加载相关新增 SaaS 环境变量
source tools.sh
add_saas_environment
```

### 同步 console nginx 配置文件

```bash
pcmd -m nginx "rsync -av --delete /data/install/support-files/templates/nginx/*.conf /etc/consul-template/templates"
pcmd -m nginx "systemctl  reload consul-template.service"
```

### 部署 paas_plugins

```bash
./bk_install paas_plugin
```

### 更新 PaaS-Agent

更新 appo 以及 appt 环境

```bash
./bkcli sync appo
./bkcli sync appt

./bkcli upgrade appo
./bkcli upgrade appt
```

### 权限中心

```bash
./bkcli upgrade bkiam
./bkcli status bkiam
./bkcli check bkiam

./bkcli install saas-o bk_iam
```

### 用户管理

```bash
./bkcli install saas-o bk_user_manage

pcmd -m usermgr "rmvirtualenv usermgr-api"
./bkcli sync usermgr
./bkcli install usermgr
./bkcli restart usermgr
./bkcli status usermgr
```

### 管控平台

1. 升级管控平台

    ```bash
    # 新增 gse_config 服务，需要走部署逻辑
    ./bkcli sync gse
    ./bkcli install gse
    ./bkcli restart gse
    ./bkcli status gse
    ```

2. 迁移数据

    > 工具参数说明：
    >
    >--szkhost arg src zkhost dataid 源 zkhost
    >
    >--szkauth arg src zkauthdataid 源 zkhost 的 zkauth
    >
    >--dzkhost arg dest zkhostdataid 同步到目标 zkhost
    >
    >--dzkauth arg dest zkauth dataid 同步到目标 zkauth
    >
    >--dataidfile arg data id file 可选参数，需要同步 dataid 的文件列表，不指定 默认源 zk 的全部文件
    >
    >--dataidpath arg data id path dataid 在源 zk 集群上的路径，企业版路径 (/gse/config/etc/dataserver/data)
    >
    >--storagepath arg storage id path kafka 集群，redis 配置在 zk 上路径，企业版 (/gse/config/etc/dataserver/storage/all)
    >
    >-h [--help] this message
    >
    >-v [--version] get version info

    ```bash
    source /data/install/utils.fc
    ssh $BK_GSE_IP

    cd /data/bkce/gse/tools/bin

    # $auth：可以查看 /data/bkce/etc/gse 下的 zkauth <grep zkauth /data/bkce/etc/gse -r>，密码格式为：zkuser:XXXXX

    auth=$(grep "zkauth" /data/bkce/etc/gse/api.conf | awk -F "\"" '{print $4}')

    # 执行完确认是否有问题请参考步骤 3
    ./dataid_migrate_tool --szkhost zk.service.consul:2181 --szkauth "$auth" --dzkhost zk.service.consul:2181 --dzkauth "$auth" --dataidpath /gse/config/etc/dataserver/data --storagepath /gse/config/etc/dataserver/storage/all

    ```

3. 输出参考信息

    ```bash
    init channelid zk(zkhost:zk.service.consul:2181, zkauth:zkuser:xxxx)
    start to migrate data id
    begin parse data id
    migrate data id finished, migrate count:27, total count:27  # 只要数据一致（27），则表示迁移正常
    migrate storage id finished, mgrate count:2
    ```

4. 下线 gse_syncdata 服务

    ```bash
    pcmd -m gse "systemctl stop bk-gse-syncdata.service && systemctl disable bk-gse-syncdata.service"
    ./bkcli check gse
    ```

### 配置平台

#### 升级前检查

由于 v3.10 版本对模型实例与关系相关的的产品形态、功能管理、数据存储等进行了全面的梳理；并结合后续 bk-cmdb 对资源数据的管理需求增长的需求，对通用模型实例与关系管理的后台架构进行了调整，并对产品侧做了一些调整、优化。所以在升级之前，需要对低版本的数据进行检查。更多详情请参考 [
v3.10 版本升级指引](https://github.com/Tencent/bk-cmdb/issues/5308)

`注意：` 不符合唯一校验规则的数据，需要根据 ERROR 提示清理对应的唯一校验规则。如未进行清理，请勿继续升级，否则在升级完成后相关的功能会存在问题。

- 对全部数据进行校验，包括 `唯一校验规则` 和 `无进程关系` 的进程数据的校验

    ```bash
    source /data/install/utils.fc
    cd /data/src/cmdb/server/bin

    # 关注 ERROR 级别的错误
    ./tool_ctl migrate-check --check-all=true --mongo-uri="mongodb://$BK_CMDB_MONGODB_USERNAME:$BK_CMDB_MONGODB_PASSWORD@mongodb.service.consul:27017/cmdb" --mongo-rs-name="rs0"
    ```

- 仅校验 `唯一校验规则`，输出不符合规则的数据

    ```bash
    # 关注 ERROR 级别的错误
    ./tool_ctl migrate-check unique --mongo-uri="mongodb://$BK_CMDB_MONGODB_USERNAME:$BK_CMDB_MONGODB_PASSWORD@mongodb.service.consul:27017/cmdb" --mongo-rs-name="rs0"
    ```

- 仅校验 `无进程关系` 的进程数据，输出不符合规则的数据

    ```bash
    ./tool_ctl migrate-check process --mongo-uri="mongodb://$BK_CMDB_MONGODB_USERNAME:$BK_CMDB_MONGODB_PASSWORD@mongodb.service.consul:27017/cmdb" --mongo-rs-name="rs0"
    ```

    `注意：` 请确认上述命令输出 ERROR 不符合规则的数据是否可以清理。如果校验 `无进程关系` 的进程数据全部都可以清理，可使用下述命令进行清理，如果不可以，则需要手动确认处理这些数据。如未进行清理，请勿继续升级，否则在升级完成后相关的功能会存在问题。

    ```bash
    ./tool_ctl migrate-check process --clear-proc=true --mongo-uri="mongodb://$BK_CMDB_MONGODB_USERNAME:$BK_CMDB_MONGODB_PASSWORD@mongodb.service.consul:27017/cmdb" --mongo-rs-name="rs0"
    ```

注意：**当且仅当所有的校验都通过时** 才可以进行正常的升级流程。

#### 开始升级

```bash
mysql --login-path=mysql-default -e "use bk_iam; insert into authorization_authapiallowlistconfig(creator, updater, created_time, updated_time, type, system_id, object_id) value('', '', now(), now(),'authorization_instance','bk_cmdb','*');"

./bkcli sync cmdb
./bkcli install cmdb
./bkcli restart cmdb
./bkcli status cmdb  # 主要关注 bk-cmdb-admin.service 是否为 active 即可
./bkcli initdata cmdb
./bkcli check cmdb
```

### 作业平台

#### 开始升级

```bash
# upgrade 需要较长的时间，请耐心等待
./bkcli upgrade job
./bkcli check job
````

#### 升级后操作

详细请参考 [作业平台升级说明](https://github.com/Tencent/bk-job/blob/master/UPGRADE.md)

```bash
ssh $BK_JOB_IP
source /data/install/utils.fc

# from_version 为升级前的 JOB 版本， to_version 为需要升级的 JOB 版本，实际升级过程中请注意替换为实际的版本号
# from_version 可在中控机使用该命令查询：cat /data/src.bak/job/VERSION
# to_version 可在中控机使用该命令查询：cat /data/src/job/VERSION
from_version=xxxx
to_version=xxxx

# 执行完两个命令后，会在执行命令的当前目录生成 biz_set_list.json 文件
/usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version BEFORE_UPDATE_JOB

/usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Djob.manage.server.address=$BK_JOB_IP:10505 -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version AFTER_UPDATE_JOB
```

##### 清理旧配置文件

```bash
rm -fv /data/bkce/etc/job/job-*/*.properties
```

##### 迁移 CMDB 业务集

1. 在执行完上述两个 `/usr/bin/java` 命令的当前目录会生成 biz_set_list.json 文件，并使用 `biz_set_list.json` 中的数据替换 changeBizSetId.js 脚本文件中的占位符 ${biz_set_list}，该文件位于中控机的 /data/src/job/support-files/bk-cmdb/ 目录下。

    ```bash
    # 中控机操作
    vim /data/src/job/support-files/bk-cmdb/changeBizSetId.js

    # 替换前
    var jsonVal=${biz_set_list};

    # 替换后，请以实际生成 biz_set_list.json 中的数据为准
    var jsonVal=[{"biz_set_id":9991001,"biz_set_name":"BlueKing"}]
    ```

2. 将 changeBizSetId.js 同步至 MongoDB 的 /data 目录

   ```bash
   source /data/install/utils.fc
   rsync -avgz /data/src/job/support-files/bk-cmdb/changeBizSetId.js root@$BK_MONGODB_IP:/data
   ```


3. 执行完成 CMDB 中的业务集 ID 更改命令

   ```bash
   ssh $BK_MONGODB_IP
   source /data/install/utils.fc

   mongo cmdb -u $BK_CMDB_MONGODB_USERNAME -p $BK_CMDB_MONGODB_PASSWORD --host $BK_CMDB_MONGODB_HOST --port $BK_CMDB_MONGODB_PORT /data/changeBizSetId.js

   #如果输出内容如下则表示正常
   MongoDB shell version v4.2.3
   connecting to: mongodb://mongodb.service.consul:27017/cmdb?compressors=disabled&gssapiServiceName=mongodb
   Implicit session: session {"id" : UUID("xxx-xxx-xxx-xxxx-xxxx") }
   MongoDB server version: 4.2.3
   ```

4. 确认需要迁移的业务集均已在 CMDB 存在且 ID 与原 Job 中 ID 一致

    ```bash
    ssh $BK_JOB_IP
    source /data/install/utils.fc

    # from_version 为升级前的 JOB 版本， to_version 为需要升级的 JOB 版本，实际升级过程中请注意替换为实际的版本号
    # from_version 可在中控机使用该命令查询：cat /data/src.bak/job/VERSION
    # to_version 可在中控机使用该命令查询：cat /data/src/job/VERSION
    from_version=xxx
    to_version=xxxx
    /usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Dtarget.tasks=BizSetMigrationStatusUpdateTask -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version MAKE_UP true
    ```

5. 对迁移后的业务集进行授权 (权限有效期为一年，过期后需要重新申请)

   ```bash
   /usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH//logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Dtarget.tasks=BizSetAuthMigrationTask -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version MAKE_UP
   ```

### 更新节点管理

#### 备份节点管理

为了避免在升级节点管理出现失败，建议单独备份节点管理数据库。

```bash
# 中控机执行
pcmd -m nodeman "systemctl stop bk-nodeman.service"
./bkcli stop saas-o bk_nodeman

# 登录至 mysql 机器开始备份
ssh $BK_MYSQL_IP
mysqldump --login-path=default-root \
    --skip-opt --create-options \
    --default-character-set=utf8mb4 -R \
    -E -q -e --single-transaction \
    --no-autocommit --master-data=2 \
    --max-allowed-packet=1G --hex-blob \
    -B "bk_nodeman" > /data/dbbak/bk_nodeman-$(date +%Y%m%d%H%M%S).sql
```


#### 更新节点管理后台代码

```bash
# 同步新版本文件至节点管理机器
./bkcli sync bknodeman

# 更新节点管理新版本文件至安装目录下
pcmd -m nodeman "rsync -a --delete --exclude=deploy --exclude="environ.sh" /data/src/bknodeman/ /data/bkce/bknodeman/"

# 渲染节点管理配置文件
./bkcli render bknodeman
```

#### 特殊操作

- 登录至节点管理

  ```bash
  source /data/install/utils.fc
  ssh $BK_NODEMAN_IP

  LANG="zh_CN.UTF-8"
  rmvirtualenv bknodeman-nodeman

  # 重建新版本虚拟环境
  /data/install/bin/install_py_venv_pkgs.sh -e -p "/opt/py36_e/bin/python3.6" -n "bknodeman-nodeman" -w "/data/bkce/.envs" -a "/data/bkce/bknodeman/nodeman" -r "/data/bkce/bknodeman/nodeman/requirements.txt" -s "/data/bkce/bknodeman/support-files/pkgs"

  cp -a /opt/py36_e/bin/python3.6_e /data/bkce/.envs/bknodeman-nodeman/bin/python

  workon bknodeman-nodeman
  ```

- migrate

> 在执行前，请确保节点管理服务是停止状态

  ```bash
  systemctl status bk-nodeman.service
  ```


##### 方案一
>调整原来的升级过程，将表结构变更过程交由后台执行

  ```bash
  export BK_FILE_PATH="/data/bkce/bknodeman/cert/saas_priv.txt"
  source bin/environ.sh
  ./bin/manage.sh migrate node_man
  ```

##### 方案二

> 提前执行原生的变更 SQL，在不调整升级顺序的情况下完成大数据表变更，防止 SaaS 安装超时

1. 获取当前时间
   
   ```bash
   date +%F" "%T:%S
   ```

2. 登录数据库
   
   ```bash
   mysql --login-path=mysql-nodeman
   use bk_nodeman;
   ```

3. 执行数据变更`sql`
   
   ```sql
   ALTER TABLE `node_man_host` ADD COLUMN `bk_host_name` varchar(128) DEFAULT '' NULL;
   ALTER TABLE `node_man_host` ALTER COLUMN `bk_host_name` SET DEFAULT NULL;
   ALTER TABLE `node_man_subscriptioninstancerecord` MODIFY `instance_id` varchar(128) NOT NULL;
   CREATE INDEX `node_man_host_bk_host_name_0931be75` ON `node_man_host` (`bk_host_name`);
   ALTER TABLE `node_man_subscriptionstep` DROP INDEX `node_man_subscriptionstep_subscription_id_index_7a8cc815_uniq`;
   ```

4. 插入`migrate`标记记录，需要替换以下`sql`内的时间字段为当前时间
   
   ```sql
   INSERT INTO `django_migrations` (`app`, `name`, `applied`) VALUES ("node_man", "0064_auto_20220721_1557", "2022-09-26 12:08:45");
   INSERT INTO `django_migrations` (`app`, `name`, `applied`) VALUES ("node_man", "0065_alter_subscriptionstep_unique_together", "2022-09-26 12:08:45");
    ```

#### 更新数据

  ```bash
  # 大约需要 10s，执行失败会 cat 日志
  ./bin/manage.sh upgrade_old_data >> /tmp/nodeman_upgrade_old_data.log || cat /tmp/nodeman_upgrade_old_data.log
  ```

#### 升级周边系统关联订阅

  ```bash
  # 查询 DB 中订阅 ID 的最大值  `$SUB_MAX` ，并作为迁移脚本的输入参数
  # 切换至中控机执行查询，或者对应机器安装 mysql 命令：yum -y install mysql-community-client.x86_64
  source /data/install/utils.fc
  SUB_MAX=$(mysql -h$BK_MYSQL_IP -u$BK_MYSQL_ADMIN_USER -p$BK_MYSQL_ADMIN_PASSWORD -N -s -e 'select max(id) from bk_nodeman.node_man_subscription;')
  ```

- 开始升级周边系统关联订阅

  ```bash
  # 执行前请确认 SUB_MAX 已渲染为数据库中查询的值
  ./upgrade/2.0to2.1/batch_transfer_old_sub.sh --help
  ./upgrade/2.0to2.1/batch_transfer_old_sub.sh -b 1 -e $SUB_MAX -E -s 3
  ```

- 脚本输出解释

  ```bash
  # 日志所在目录
  /tmp/node_man_upgrade_1_xxx_xxxx-xxxx
  ```

- 分片执行任务预览

  ```bash
    [1]-  Running                 nohup ./bin/manage.sh transfer_old_sub 1 3 --enable >> /tmp/node_man_upgrade_1_5_20220819-101928_enable/transfer_old_sub_1_3.log 2>&;1 &;
    [2]+  Running                 nohup ./bin/manage.sh transfer_old_sub 4 6 --enable >> /tmp/node_man_upgrade_1_5_20220819-101928_enable/transfer_old_sub_4_6.log 2>&;1 &;
    check_command -> grep -E '.*([[:digit:]]+[[:space:]]/[[:space:]][[:digit:]]+|total_cost)' /tmp/node_man_upgrade_1_5_20220819-101928_enable/transfer_old_sub_*
  ```

- 查询数据升级进度

  ```bash
  # 进入脚本输出的日志所在目录，以实际的为主
  cd /tmp/node_man_upgrade_1_xx_xxxxxx_enable

  # 查询执行进度，
  grep -E '.*([[:digit:]]+[[:space:]]/[[:space:]][[:digit:]]+|total_cost)' *

  # 执行完成标志，该目录下的所有日志文件都匹配到 total_cost
  grep total_cost *
  ```

#### 更新节点管理

```bash
./bkcli install saas-o bk_nodeman
./bkcli install bknodeman
./bkcli start bknodeman
```

#### 更新插件

```bash
./bkcli initdata nodeman
```

### 标准运维

```bash
./bk_install saas-o bk_sops
```

### 监控平台、故障自愈

由于在 6.1 的版本里，故障自愈合入了监控平台，所以本次升级将监控平台以及故障自愈一起说明。

#### 重要说明

##### 迁移影响

由于故障自愈产品形态后台架构完全不同，因此本次迁移仅作数据迁移，以下几点需要在迁移之后进行人工确认

1. 告警源： 由于监控告警源对接为新模块，其中 rest 推送和 zabbix 告警源在迁移之后，需要根据新版本的说明重新进行推送事件的配置才能生效。原有的监控 3.2 对接不再支持
2. 部分组合套餐包含了内置套餐（进程 CPU 和 MEM TOP10 发送, 磁盘清理）和 使用了标准运维套餐为节点的，由于迁移不支持子流程迁移， 需要用户手动配置确认
3. 所有的自愈接入策略迁移之后，将会关闭原有自愈接入，新版本默认为不开启状态，需要用户确认
4. 原对接监控平台的自愈接入，如果设置了监控目标，请注意检查原策略是否设置了有设置监控目标，如果无， 请设置为全业务，否则小目标范围优先生效的规则将不生效。

##### 迁移内容

1. 内置处理套餐的迁移

    包括以下五项，均通过调用标准运维流程实现， 其中原有的磁盘清理迁移之后为标准运维磁盘清理流程，可通过选择标准运维类型套餐来进行内置磁盘清理配置
    - 【快捷套餐】微信发送内存使用率 Top 10 进程
    - 【快捷套餐】微信发送 CPU 使用率 Top 10 进程
    - 【快捷套餐】转移主机至故障机模块
    - 【快捷套餐】转移主机至空闲机模块
    - 【自愈套餐】磁盘清理 (适用于 Linux)

2. 普通套餐的迁移

    - 原有的作业平台和标准运维套餐保持类型不变
    - 原有的 http 回调调整为 webhook 回调
    - 原有的通知不做迁移，默认使用监控的通知
    - 原有的组合套餐迁移采用标准运维流程实现，现有自愈不再支持组合套餐功能

3. 告警源的迁移， 目前支持以下四个告警源

    - rest 拉取
    - rest 推送
    - zabbix
    - 原有的监控平台对接直接接入新版监控策略

4. 自愈接入的迁移

    - 所有自愈接入的内容，将会在监控策略对应业务下创建对应的策略
    - 原有自愈接入的通知方式和人员信息，将以告警组的方式进行迁移
    - 原有的全局防御，目前迁移为同策略下的告警防御策略，见策略详情告警处理部分

#### 开始升级

1. 迁移需要配置  `BKAPP_NEED_MIGRATE_FTA = True` 环境变量。步骤：访问 【PaaS 平台】 - 【开发者中心】 - 选择【监控平台】- 添加 【环境变量】
2. 迁移是通过直连故障自愈的 DB 进行数据迁移，故障自愈 DB 如果在默认的 MySQL 服务器上，则不需要配置 DB 信息，如果自愈为独立 DB，则需要配置以下几个环境变量

    - BKAPP_FTA_DB_NAME： DB 名称
    - BKAPP_FTA_DB_USERNAME： 用户名
    - BKAPP_FTA_DB_PASSWORD： 密码
    - BKAPP_FTA_DB_HOST： 服务器 IP 或域名
    - BKAPP_FTA_DB_PORT： DB 端口

```bash
# 更新监控平台 SaaS
./bkcli install saas-o bk_monitorv3

# 更新后台服务
./bkcli sync bkmonitorv3
pcmd -m monitorv3 "rmvirtualenv bkmonitorv3-monitor"
./bkcli install bkmonitorv3
./bkcli restart bkmonitorv3
./bkcli status bkmonitorv3

./bkcli check bkmonitorv3
```

#### 检查数据迁移情况

访问 PaaS 平台，打开【监控平台】-【配置】- 【处理套餐】查看数据是否迁移过来。

如果自动迁移失败，需要手动尝试，可通过在 APPO 的机器上手动执行：bk_biz_id 为对应的业务 ID，多个以逗号分隔

```bash
source /data/install/utils.fc
ssh $BK_APPO_IP

# 请注意替换 <bk_biz_id> 为实际的业务 ID
docker exec -i $(docker ps -aqf "name=^bk_monitorv3-")  bash <<EOF
export BK_FILE_PATH=/data/app/code/conf/saas_priv.txt
cd /data/app/code/
/cache/.bk/env/bin/python manage.py migrate_fta_strategy <bk_biz_id>
EOF
```

### 日志平台

```bash
./bkcli install saas-o bk_log_search

./bkcli sync bklog
pcmd -m log "rmvirtualenv bklog-api"
./bkcli install bklog
./bkcli restart bklog
./bkcli status bklog
```

### 流程服务

> 升级流程服务时，当前版本不能低于 2.6.0 版本，如果低于该版本，请先升级至 2.6.0 版本
查看当前 ITSM 版本：前往【PaaS 平台】- 打开【开发者中心】-【S-mart 应用】

#### 中间版本升级（可选）

- 如果已经通过单产品更新的用户请忽略该步骤，可直接进入下述步骤 (2.6.1) 版本升级

- 下载 2.6.0 的 SaaS 包

    ```bash
    cd /data/src/official_saas && wget https://bkopen-1252002024.file.myqcloud.com/ce/d64e32f/bk_itsm_V2.6.0.365-ce-bkofficial.tar.gz
    ```

- 开始更新

    ```bash
    cd /data/install && ./bkcli install saas-o bk_itsm=2.6.0.365
    ```

#### 开始升级

1. 执行相关兼容操作

    详细升级指南请参考：[V2.6.0 -> V2.6.1 升级指南](https://github.com/TencentBlueKing/bk-itsm/blob/v2.6.x_develop/docs/install/V2_6_0_to_V2_6_1_upgrade_guide.md)

    ```bash
    # 网页端访问
    http://$BK_DOMAIN/o/bk_itsm/helper/db_fix_for_blueapps_after_2_6_0/
    ```

2. 开始升级

    ```bash
    ./bk_install saas-o bk_itsm=2.6.2
    ```

### 升级拓扑

- 此步骤只针对蓝鲸业务拓扑中，不存在自定义层级、自定义服务模板的场景，如遇自定义升级的场景，请用户根据自身情况进行处理
- 升级过程中会删除蓝鲸业务当前的所有业务拓扑，服务模板与集群模板
- 蓝鲸后台服务部署完成后，方可执行相关业务拓扑升级操作

#### 转移主机

1. 确认蓝鲸后台服务器中 /data/bkce/.installed_module 内容，该文件描述了蓝鲸后台部署分布，用作蓝鲸后台服务器 IP 转移至蓝鲸业务对应的模块
2. 转移蓝鲸业务中所有的主机至蓝鲸业务空闲机

#### 删除原有拓扑结构

1. 蓝鲸后台服务器请求 CMDB 接口，开放页面修改蓝鲸业务拓扑限制

    ```bash
    source /data/install/utils.fc
    curl -H 'BK_USER:admin' -H 'BK_SUPPLIER_ID:0' -H 'HTTP_BLUEKING_SUPPLIER_ID:0' -X POST $BK_CMDB_IP0:9000/migrate/v3/migrate/system/user_config/blueking_modify/true
    ```

2. 删除蓝鲸业务各个集群

    上一步执行成功后，蓝鲸业务集群的节点信息中即可看到 `删除节点` 选项，请手动删除所有蓝鲸业务下的集群

    ![delete_topo](../../assets/bk_topo.png)

3. 删掉所有的蓝鲸集群模板与进程模板

```bash
/opt/py36/bin/python ${CTRL_DIR}/bin/create_blueking_set.py -c ${BK_PAAS_APP_CODE}  -t ${BK_PAAS_APP_SECRET} --delete
```

#### 重建蓝鲸业务拓扑

```bash
# 中控机执行
# 去除 fta 安装标记
pcmd -m fta "sed -i '/fta/d' /data/bkce/.installed_module"
./bkcli initdata topo
```

### 刷新版本信息

```bash
source /data/install/tools.sh
_update_common_info
```

### 检查所有服务状态

```bash
cd /data/install && echo bkssm bkiam usermgr paas cmdb gse job consul bklog bkmonitorv3 | xargs -n1 ./bkcli check
```

### 部署 bkiam_search_engine (可选)

> 该服务为权限中心增强功能。为用户自行选择是否部署。

1. 添加 bkiam_search_engine 模块分布

    ```bash
    cat <<EOF>>/data/install/install.config
    [iam_search_engine]
    10.0.0.2 iam_search_engine
    EOF
    ```

2. 获取权限中心的 app_token，并将获取到的 app_token 做为 bkiam_search_engine 的 secret

    ```bash
   echo BK_IAM_SAAS_APP_SECRET=$(mysql --login-path=mysql-default -e "use open_paas; select * from paas_app where code='bk_iam'\G"| awk '/auth_token/{print $2}') >> /data/install/bin/03-userdef/bkiam_search_engine.env
    ```

3. 渲染 bkiam_search_engine 变量

    ```bash
   ./bkcli install bkenv
   ./bkcli sync common
    ```

4. 开始部署

    ```bash
   ./bk_install bkiam_search_engine
    ```

## 升级后操作

### 升级 agent 以及相关插件

- 升级完成后，请前往节点管理页面操作

    1. 升级 agent、p-agent 以及采集器相关插件
    2. 重装 Proxy （涉及 proxy 二进制改动，gse_data 将取代 gse_transit，gse_transit 也在 6.1 版本下线）
    3. 由于在 6.1.2 及后续版本中，basereport、processbeat 合入了 bkmonitorbeat，所以升级后需要将所有的机器安装 bkmonitorbeat 插件

    ![install_bkmonitorbeat](../../assets/install_bkmonitorbeat.png)

    1. 停止所有机器上的 basereport、processbeat 插件（该步骤需要在步骤 3 操作完后方可操作）

    ![stop_bp](../../assets/stop_bp.png)

    1. 停用 basereport、processbeat 插件（该步骤需要在步骤 4 操作完后方可操作）

    ![disable_bp](../../assets/disable_bp.png)

### 下架故障自愈

1. 确保故障自愈再升级迁移数据无问题后再进行操作

```bash
pcmd -m fta "systemctl disable --now bk-fta.service"
sed -i 's/fta,//g' /data/install/install.config
./bkcli sync common

# 清理 fta 版本信息
mysql --login-path=mysql-default -e "delete from bksuite_common.production_info where code='fta';"
```

2. 前往【PaaS 平台】-【开发者中心】-【S-mart 应用】 下架故障自愈。

### 还原 bkci 以及 bcs 软件包

如果之前有部署 bkci 以及 bcs 的用户，请按照该方式将相关包进行还原 `没有部署请忽略该步骤`

```bash
# bkci
mv /data/src.bak/ci/ /data/src/

# bcs
mv /data/src.bak/public-images-community.tar.gz /data/src/
mv /data/src.bak/bcs_cc-ce-1.0.28.tar.gz /data/src/
mv /data/src.bak/python.tar.gz /data/src/
mv /data/src.bak/docker-18.09.5.tgz /data/src/
mv /data/src.bak/etcd-v3.3.12-linux-amd64.tar.gz /data/src/
mv /data/src.bak/mongodb-linux-x86_64-2.4.10.tgz /data/src/
mv /data/src.bak/jdk8.tar.gz /data/src/
mv /data/src.bak/bk_bcs_app_V1.3.21.tar.gz /data/src/
mv /data/src.bak/bcs-prom-k8s-ce-1.1.1.tar.gz /data/src/
mv /data/src.bak/harbor_api_ce-1.1.1.tgz /data/src/
mv /data/src.bak/docker-compose /data/src/
mv /data/src.bak/kubeops-ce_v1.tar.gz /data/src/
mv /data/src.bak/cryptools /data/src/
mv /data/src.bak/etcd-v3.4.13-linux-amd64.tar.gz /data/src/
mv /data/src.bak/harbor_charts-1.0.6.tar.gz /data/src/
mv /data/src.bak/bcs-service.ce.1.18.10-20.11.05.2011052349.tar.gz /data/src/
mv /data/src.bak/harbor_server-v1.7.6.tar.gz /data/src/
mv /data/src.bak/bk_bcs_monitor_V1.5.4.tar.gz /data/src/
mv /data/src.bak/devops-ce-1.0.29.11.tgz /data/src/
mv /data/src.bak/bcs_web_console-ce-V1.3.21.tar.gz /data/src/
mv /data/src.bak/java8.tgz /data/src/
mv /data/src.bak/bcs-monitor-ce-1.2.12-1.el7.x86_64.rpm /data/src/
mv /data/src.bak/bcs-thanos-ce-1.2.12-1.el7.x86_64.rpm /data/src/
```

如更新过程有任何疑问及问题，请前往蓝鲸社区群 (495299374) 联系值班蓝鲸助手获取技术支持。
