## 适用范围

6.0.5 升级至 6.1.0

## 说明

- 文中所述的目录路径均以默认为主，如与实际有出入，请以升级实际路径为主。
- 如无特殊说明，所述操作均在中控机执行。
- 本次升级仅面向涉及到的产品，未更新的产品不做阐述，请知悉。详细请见官网文档：[组件更新](https://bk.tencent.com/docs/document/6.0/127/7774)。
- 本次升级会停止部分服务，请避开业务高峰期进行升级，以免影响业务正常运行。

## 获取更新产品信息

本次社区版 6.1.0 更新涉及产品，请查看 [版本日志](https://bk.tencent.com/docs/document/6.0/156/11922)。

获取目前自身环境下的版本，以避免升级过程带来的问题：

```bash
# 获取版本
cd /data/src; grep . VERSION

# 蓝鲸各产品版本
cd /data/src; grep . */*VERSION */*/VERSION
```

## 前置准备

1. 下载相关产品包。请前往 [蓝鲸下载页](https://bk.tencent.com/download/) 下载。

   - 基础套餐包 (bkce_basic_suite-6.1.1-beta1.tgz)
   - 监控告警及日志服务套餐包 (bkce_co_package-6.1.0.tgz)

2. 将相关产品包上传至服务器 /data 目录。

3. 准备新版本部署脚本以及产品包

    ```bash
    # 创建新版本产品临时存放目录
    mkdir /data/tmp

    #将基础套餐包、监控告警及日志服务套餐包解压至临时存放目录
    tar xf bkce_basic_suite-6.1.1-beta1.tgz -C /data/tmp/
    tar xf bkce_co_package-6.1.0.tgz -C /data/tmp/

    # 解压增强包监控平台、日志平台、故障自愈整包
    cd /data/tmp/
    for i in *.tgz; do tar xf $i; done

    # 解压后会有各产品的目录，包含各产品的后台包以及 SaaS 包，需要将其拷贝 /data/tmp/src 目录下
    # 拷贝各产品后台包
    for pkg in $(find bklog bkmonitorv3 fta -name "bk*.tgz" -o -name "fta*.tar.gz"); do cp -a $pkg src; done

    # 拷贝各产品 SaaS 包
    for pkg in $(find bklog bkmonitorv3 fta -name "bk_*.tar.gz"); do cp -a $pkg src/official_saas/; done
    ```

## 数据备份

### 备份 MySQL

该备份方式仅供参考，可自行选择备份方式。

- 登陆至 MySQL 机器，创建备份目录

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

    dblist="$(mysql --login-path=default-root -Nse "show databases;"|grep -Ewv "$ignoredblist"|xargs echo)"

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

- 登陆至 MongoDB 机器，创建备份目录

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

    本次升级，新增了监控的 monitorv3(unify-query) 模块，请合理评估机器资源后，将其分布在 install.config 文件中。可参考下述默认的模块分布。

    ```config
    10.0.0.1 iam,ssm,usermgr,gse,license,redis,consul,es7,monitorv3(influxdb-proxy),monitorv3(monitor),monitorv3(grafana)
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
for module in open_paas-apigw open_paas-appengine open_paas-console open_paas-esb open_paas-login open_paas-paas; do pcmd -m paas "rmvirtualenv $module"; done

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

### 更新 PaaS-Agent

1. 更新 appo 以及 appt 环境

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

    >工具参数说明：
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
    >--dataidpath arg data id path dataid在源zk集群上的路径，企业版路径 (/gse/config/etc/dataserver/data)
    >
    >--storagepath arg storage id path kafka集群，redis 配置在 zk 上路径，企业版 (/gse/config/etc/dataserver/storage/all)
    >
    >-h [ --help ] this message
    >
    >-v [ --version ] get version info

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
    pcmd -m gse " systemctl stop bk-gse-syncdata.service && systemctl disable bk-gse-syncdata.service"
    ./bkcli check gse
    ```
	
### 配置平台

```bash
mysql --login-path=mysql-default -e "use bk_iam; insert into authorization_authapiallowlistconfig(creator, updater, created_time, updated_time, type, system_id, object_id) value('', '', now(), now(), 'authorization_instance', 'bk_cmdb', '*');"

./bkcli sync cmdb
./bkcli install cmdb
./bkcli restart cmdb
./bkcli status cmdb
./bkcli initdata cmdb
./bkcli check cmdb
```

### 作业平台

#### 开始升级

```bash
./bkcli upgrade job
./bkcli check job
````

#### 升级后操作

详细请参考 [作业平台升级说明](https://github.com/Tencent/bk-job/blob/master/UPGRADE.md)

```bash
ssh $BK_JOB_IP
source /data/install/utils.fc

# from_version 升级前 JOB 版本， to_version 需要的 JOB 版本，实际升级过程中请注意替换为实际的版本号
from_version=xxxx
to_version=xxxx


/usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version BEFORE_UPDATE_JOB

/usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Djob.manage.server.address=$BK_JOB_IP:10505 -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version AFTER_UPDATE_JOB
```

##### 清理旧配置文件

```bash
rm -fv /data/bkce/etc/job/job-*/*.properties
```

##### 迁移 CMDB 业务集

1. 获取 changeBizSetId.js 文件，该文件在中控机的 /data/src/job/support-files/bk-cmdb/ 目录

2. 在执行上述步骤的当前目录会生成 biz_set_list.json 文件，将其中的数据替换 changeBizSetId.js 脚本文件中的占位符${biz_set_list}

3. 将 changeBizSetId.js 同步至 MongoDB 的 /data 目录

   ```bash
   source /data/install/utils.fc
   rsync -avgz /data/src/job/support-files/bk-cmdb/changeBizSetId.js root@$BK_MONGODB_IP:/data
   ```

4. 执行完成 CMDB 中的业务集 ID 更改命令

   ```bash
   ssh $BK_MONGODB_IP
   source /data/install/utils.fc

   mongo cmdb -u $BK_CMDB_MONGODB_USERNAME -p $BK_CMDB_MONGODB_PASSWORD --host $BK_CMDB_MONGODB_HOST --port $BK_CMDB_MONGODB_PORT /data/changeBizSetId.js
   ```

5. 确认需要迁移的业务集均已在CMDB存在且ID与原Job中ID一致

    ```bash
    ssh $BK_JOB_IP
    source /data/install/utils.fc

    # from_version 升级前 JOB 版本， to_version 需要升级的 JOB 版本，实际升级过程中请注意替换为实际的版本号
    from_version=xxx
    to_version=xxxx
    /usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH/logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Dtarget.tasks=BizSetMigrationStatusUpdateTask -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version MAKE_UP true
    ```

6. 对迁移后的业务集进行授权 (权限有效期为一年，过期后需要重新申请)

   ```bash
   /usr/bin/java -Dfile.encoding=utf8 -Djob.log.dir=$INSTALL_PATH//logs/job -Dconfig.file=$INSTALL_PATH/etc/job/upgrader/upgrader.properties -Dtarget.tasks=BizSetAuthMigrationTask -jar $INSTALL_PATH/job/backend/upgrader-$to_version.jar $from_version $to_version MAKE_UP

   ```

### 更新节点管理

```bash
./bkcli stop bknodeman

# 同步新版本文件至节点管理机器
./bkcli sync bknodeman

# 更新节点管理新版本文件至安装目录下
pcmd -m nodeman "rsync -a --delete --exclude=media --exclude="environ.sh" /data/src/bknodeman/ /data/bkce/bknodeman/"

# 渲染节点管理配置文件
./bkcli render bknodeman
```

#### 特殊操作

- 登陆至节点管理

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

- 开始执行

  ```bash
  export BK_FILE_PATH="/data/bkee/bknodeman/cert/saas_priv.txt"
  source bin/environ.sh
  ./bin/manage.sh migrate node_man
  ```

- 更新数据

  ```bash
  # 大约需要 10s，执行失败会 cat 日志
  ./bin/manage.sh upgrade_old_data >> /tmp/nodeman_upgrade_old_data.log || cat /tmp/nodeman_upgrade_old_data.log
  ```

- 升级周边系统关联订阅

  ```bash
  # 查询 DB 中订阅 ID的最大值  `$SUB_MAX` ，并作为迁移脚本的输入参数
  # 切换至中控机执行查询
  mysql --login-path=mysql-default -D$BK_NODEMAN_MYSQL_NAME -P$BK_NODEMAN_MYSQL_PORT -N -s -e 'select max(id) from node_man_subscription;'
  ```

- 开始升级

  ```bash
  # $SUB_MAX 为上述数据查询的最大订阅值，请注意替换
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
  [1]   Running               nohup ./bin/manage.sh transfer_old_sub 1 635 >> xxx 2>&1  &
  [2]-  Running               nohup ./bin/manage.sh transfer_old_sub 636 1270 >> xxx 2>&1  &
  [3]+  Running               nohup ./bin/manage.sh transfer_old_sub 1271 1905 >> xxx 2>&1 &
  ```

- 查询数据升级进度

  ```bash
  # 进入脚本输出的日志所在目录，以实际的为主
  cd /tmp/node_man_upgrade_1_xx_xxxxxx_enable
  
  # 查询执行进度
  grep -E '.*([[:digit:]]+[[:space:]]/[[:space:]][[:digit:]]+|total_cost)' *
  
  # 执行完成标志，该目录下的所有日志文件都匹配到total_cost
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

### 监控平台

```bash
# 更新监控平台 SaaS
./bkcli install saas-o bk_monitorv3

# 更新后台服务
./bkcli sync bkmonitorv3
pcmd -m monitorv3 "rmvirtualenv bkmonitorv3-monitor"
./bkcli install bkmonitorv3
./bkcli restart bkmonitorv3
./bkcli status bkmonitorv3

# 建议等待 10s 后再 check
sleep 10 && ./bkcli check bkmonitorv3
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

### 故障自愈

```bash
./bkcli install saas-o bk_fta_solutions
```

### 标准运维

```bash
./bk_install saas-o bk_sops
```

### 流程服务

> 升级流程服务时，当前版本不能低于 2.6.0 版本，如果低于该版本，请先升级至 2.6.0 版本
查看当前 ITSM 版本：前往【PaaS平台】- 打开【开发者中心】-【S-mart 应用】

#### 中间版本升级（可选）

  - 如果已经通过单产品更新的用户请忽略该步骤，可直接进入下述步骤 (2.6.1) 版本升级
  - 下载 2.6.0 的 SaaS 包 [点击下载](https://bkopen-1252002024.file.myqcloud.com/ce/d64e32f/bk_itsm_V2.6.0.365-ce-bkofficial.tar.gz)
  ```bash
  cd /data/src/official_saas && wget https://bkopen-1252002024.file.myqcloud.com/ce/d64e32f/bk_itsm_V2.6.0.365-ce-bkofficial.tar.gz
  ```
  
  - 开始更新
  ```bash
  cd /data/install && ./bkcli install saas-o bk_itsm=2.6.0.365
  ```

#### 开始升级

1. 执行相关兼容操作

    详细升级指南请参考：[V2.6.0 -> V2.6.1升级指南](https://github.com/TencentBlueKing/bk-itsm/blob/v2.6.x_develop/docs/install/V2_6_0_to_V2_6_1_upgrade_guide.md)

    ```bash
    # 网页端访问
    http://$BK_DOMAIN/o/bk_itsm/helper/db_fix_for_blueapps_after_2_6_0/
    ```

2. 开始升级

    ```bash
    ./bk_install saas-o bk_itsm=2.6.1.385
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
    cat << EOF >>/data/install/install.config
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

- 升级完成后，请前往节点管理页面升级/重装 agent、Proxy以及采集器相关插件。

- 如果之前有部署 bkci 以及 bcs 的用户，请按照该方式将相关包进行还原 (`没有部署请忽略该步骤`)

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

如更新过程有任何疑问及问题，请前往蓝鲸社区群 (495299374) 联系值班蓝鲸助手获取技术支持，或者在本帖进行回复。
