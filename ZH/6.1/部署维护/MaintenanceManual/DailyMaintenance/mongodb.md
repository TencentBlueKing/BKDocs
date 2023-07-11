# MongoDB

[MongoDB](https://www.mongodb.com/) 是一种通用文档型数据库。在蓝鲸后台架构中，主要为以下平台提供存储服务：

- 配置平台（CMDB）的核心数据
- 作业平台（Job）的执行日志
- 管控平台（GSE）的插件信息

本文从安装部署到日常问题处理，描述 MongoDB 运维相关的内容。

## 安装部署

蓝鲸的配置平台依赖 MongoDB 4.2 及以上版本，安装参考[官方文档](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/)

1. 安装 rpm 包
2. 配置 /etc/mongod.conf
3. 创建必要的目录，设置好正确的权限
4. 启动进程

蓝鲸安装脚本使用 `./bin/install_mongodb.sh` 封装了这些步骤，简化安装。使用方法：

```bash
./bin/install_mongodb.sh -b <本机IP> -p 27017 -d <MongoDB数据目录> -l <MongoDB日志目录> 
```

### 生产环境配置

蓝鲸默认部署的参数，并没有完全参考官方的生产环境配置来处理，因为混合部署了其他模块。假设用户给 MongoDB 单独的机器来搭建，可以参考官方的[生产环境配置要求](https://docs.mongodb.com/manual/administration/production-notes/):

#### 硬件规格

- 给每个 MongoDB 实例分配至少 2 核 CPU
- 内存通过 /etc/mongod.conf 中的 storage.wiredTiger.engineConfig.cacheSizeGB 配置
- SSD 磁盘

#### 系统配置

关于 Swap，如果系统发生 swapping，会让 MongoDB 的性能受到影响，所以建议：

1. 不分配 swap 空间，并调整内核参数禁用 swap (vm.swappiness = 0)
2. 分配 swap 空间，但是调整内核参数只当系统内存使用率非常高时才允许 swapping (vm.swappiness = 1)

关于 ulimit 相关的配置，参考[官方文档](https://docs.mongodb.com/manual/reference/ulimit/)

### ReplicaSet 集群配置

通过前面的 `install_mongodb.sh` 安装的只是一个单实例的 MongoDB，而蓝鲸使用 MongoDB 的模式默认为 ReplicaSet，所以需要将单实例的 Mongod 变为 ReplicaSet 模式。
参考官方文档： [集群搭建指南](https://docs.mongodb.com/v4.2/administration/replica-set-deployment/)

值得一提的是，社区版为了节约资源，默认只配置了一台 MongoDB，如果资源充足，可以直接搭建三个节点的 MongoDB，组成高可用集群。

蓝鲸部署脚本为了简化配置，封装了脚本：`./bin/setup_mongodb_rs.sh` 分两步来完成：

1. 配置所有 MongoDB 单实例的机器，开启 key 认证

    ```bash
    # 不带参数运行，会输出命令行的帮助信息
    # [ -a, --action          [必填] "动作：[ config | init ] config的动作需要在多台mongodb实例上。init的动作只在任选一台上操作。 ]
    # [ -e, --encrypt-key     [必填] "动作为 config 时，指定内部集群认证的key，长度为6~1024的base64字符集的字符串" ]
    # 
    ./bin/setup_mongodb_rs.sh -a config -e ${BK_MONGODB_KEYSTR_32BYTES}
    ```

2. 在任意一台 MongoDB 实例上，执行 ReplicaSet 初始化命令：

    ```bash
    # [ -j, --join            [必填] "动作为 init 时，集群的ip列表逗号分隔，奇数（3，5，7）个" ]
    # [ -u, --username        [选填] "动作为 init 时，配置mongodb集群的超级管理员用户名。]
    # [ -p, --password        [选填] "动作为 init 时，配置mongodb集群的超级管理员密码。]
    # [ -P, --port            [选填] "动作为 init 时，配置mongodb的监听端口，默认为27017。]
    ./bin/setup_mongodb_rs.sh -a init -j ${BK_MONGODB_IP_COMMA} -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD -P 27017
    ```

### 配置 Consul 服务名

蓝鲸服务访问 MongoDB 使用域名链接，默认配置为 mongodb.service.consul 且 CMDB、GSE、Job 访问同一个 MongoDB 集群。严格的生产环境下，如果机器资源允许，建议各自访问独立的 MongoDB 集群实例。譬如按上面的步骤搭建三个集群，然后配置服务名分别为：mongodb-cmdb.service.consul、mongodb-gse.service.consul、mongodb-job.service.consul。

这里以默认的 mongodb.service.consul 为例，创建 consul 的服务定义文件如下，需要在组成集群的所有 MongoDB 实例机器上运行：

```bash
./bin/reg_consul_svc -n mongodb -p 27017 -a <本机IP> -D > /etc/consul.d/service/mongodb.json

consul reload
```

### 验证集群

MongoDB 成功组成集群后，可以通过 `mongo` 命令行来连接。本文使用 [mongodb uri 格式](https://docs.mongodb.com/manual/reference/connection-string/)来连接。

```bash
mongo mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@mongodb.service.consul:27017/?replicaSet=rs0
```

如果能连上，会出现提示符：

```bash
rs0:PRIMARY>
```

输入命令查看 ReplicaSet 的状态：

```bash
rs0:PRIMARY> rs.status().ok
1
```

返回为 **1** 表示成功，**0** 表示失败

## 用户角色管理

安装部署好集群后，默认只创建了超级管理员账号。接着需要给应用创建普通用户账号来访问对应的数据库。关于 MongoDB 用户角色管理参考[官方文档](https://docs.mongodb.com/manual/tutorial/manage-users-and-roles/)

蓝鲸部署脚本为了方便调用，封装了 `./bin/add_mongodb_user.sh` 脚本。用法如下：

```bash
用法: 
    add_mongodb_user.sh [ -h --help -?  查看帮助 ]
            [ -d, --db              [必填] "授权的db名"
            [ -i, --url             [必填] "链接mongodb的url"
            [ -u, --username        [必填] "db的用户名"
            [ -p, --password        [必填] "db的密码"
            [ -v, --version         [可选] "查看脚本版本号" ]
```

1. 创建 cmdb 使用的账号（授权的 db 名为 cmdb）

    ```bash
    ./bin/add_mongodb_user.sh -d cmdb -i mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@mongodb.service.consul:27017/admin?replicaSet=rs0 -u <cmdb的访问用户名> -p <cmdb的访问密码>
    ```

2. 创建 gse 使用的账号（授权的 db 名为 gse）

    ```bash
    ./bin/add_mongodb_user.sh -d gse -i mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@mongodb.service.consul:27017/admin?replicaSet=rs0 -u <gse的访问用户名> -p <gse的访问密码>
    ```

3. 创建 job 使用的账号（授权的 db 名为 joblog）

    ```bash
    ./bin/add_mongodb_user.sh -d joblog -i mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@mongodb.service.consul:27017/admin?replicaSet=rs0 -u <job的访问用户名> -p <job的访问密码>
    ```

4. 创建集群监控用的账号：

    ```bash
    # 请替换 <username> 和 <password>
    cat > create_monitor_user.js <<EOF
    use admin
    db.createUser(
       {
         user: "<username>",
         pwd: "<password>",
         roles: [ { role: "clusterMonitor", db: "admin" } ]
       }
    )
    EOF

    mongo mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@mongodb.service.consul:27017/admin?replicaSet=rs0 < create_monitor_user.js
    ```

    测试监控账号是否正常：

    ```bash
    mongostat --uri=mongodb://<username>:<password>@mongodb.service.consul:27017/admin
    ```

## 配置文件

mongod 默认安装的配置文件在 `/etc/mongod.conf` 中，如果需要修改，请参考官方文档的[配置选项](https://Vdocs.mongodb.com/v4.2/reference/configuration-options/)

修改后，需要重启进程生效：`systemctl restart mongod`

### 日志滚动策略修改

修改默认的日志滚动方式为 `reopen`，配合系统的 `logrotate` 来实现滚动。

1. 修改 /etc/mongod.conf 增加配置项 systemLog.logRotate 为 reopen：

    ```bash
    sed -i '/logAppend/a\    logRotate: reopen' /etc/mongod.conf
    ```

2. 重启 mongod：`systemctl restart mongod`
3. 增加 logrotate 的配置（请根据实际日志路径修改 /var/log/mongodb/ 目录）

    ```bash
    cat > /etc/logrotate.d/mongodb <<EOF 
    /var/log/mongodb/*.log {
        daily
        rotate 14
        size 100M
        compress
        dateext
        missingok
        notifempty
        sharedscripts
        postrotate
            /bin/kill -SIGUSR1 `cat /var/run/mongodb/mongod.pid 2> /dev/null` 2> /dev/null || true
        endscript
    }
    EOF
    ```

4. 通过强制滚动验证 logrotate 是否正常：

    ```bash
    logrotate --force /etc/logrotate.d/mongodb
    ls -l /var/log/mongodb/ 
    ```

## 常用操作

- 启动进程： `systemctl start mongod`
- 停止进程： `systemctl stop mongod`
- 设置开机启动：`systemctl enable mongod`
- 命令行连上 ReplicaSet 的集群：`mongo mongodb://<username>:<password>@mongodb.service.consul:27017/admin?replicaSet=rs0`
- 查看当前 RS 集群的主节点：

    ```bash
    mongo mongodb://<username>:<password>@mongodb.service.consul:27017/admin?replicaSet=rs0 --eval 'rs.status().members.find(r=>r.state===1).name'
    ```
