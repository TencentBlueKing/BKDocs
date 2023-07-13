# MySQL

[MySQL](https://www.mysql.com/) 是一个通用型关系数据库。在蓝鲸后台架构中，主要为以下平台提供存储服务：

- PaaS 平台的核心数据
- 权限中心的核心数据
- 所有官方 SaaS 的核心存储
- 作业平台（Job）的核心存储

本文从安装部署到日常维护，描述 MySQL 运维相关的内容。

## 安装部署

蓝鲸使用 MySQL Community Server 5.7 版本，通过官方 rpm 包安装。

参考官方文档：[Installing MySQL on Linux Using RPM Packages from Oracle](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/linux-installation-rpm.html)

蓝鲸部署脚本为了简化部署和便于多 MySQL 实例管理，封装了脚本 `./bin/install_mysql.sh`，主要逻辑如下：

1. 安装服务端 rpm 包：mysql-community-server-5.7.27.rpm
2. 创建必要的数据和日志目录，给 mysql 用户授权
3. 生成自定义的 /etc/mysql/xxx.my.cnf 配置文件
4. 生成 mysql@.service 和 mysql.target 两个 systemd unit，为了多实例管理。
5. 第一次部署初始化数据库，并从日志文件中获取临时 root 密码
6. 启动 mysqld 进程，并修改 root 密码为脚本命令行指定的密码

关于 systemd 管理 MySQL 多实例可以参考官方文档：[Managing MySQL Server with systemd](https://dev.mysql.com/doc/refman/5.7/en/using-systemd.html#systemd-multiple-mysql-instances)

1. 定义一个 systemd service 的模板文件：/etc/systemd/system/mysql@.service （官方包有一个自带的 /usr/lib/systemd/system/mysqld@.service，蓝鲸部署脚本未使用这个定义文件）
2. 根据传入的 MySQL 实例名，比如 `-n default`，生成 配置文件 /etc/mysql/default.my.cnf 
3. 使用命令行 `systemctl start mysql@default` 启动这个实例
4. 使用命令行 `systemctl status mysql@default` 查看状态
5. 使用命令行 `systemctl enable mysql@default` 配置开机启动

假设启动失败，需要查看启动错误信息：

1. 查看 journalctl 的日志：`journalctl -u mysql@default`
2. 查看 mysqld 的日志：`/data/bkce/logs/mysql/default.mysqld.log`

## 配置 MySQL 连接信息

MySQL 运行成功后，在继续配置账户之前，先介绍下 `mysql` 命令行连接 mysqld 实例的方法: 利用 `mysql_config_editor` 命令生成 `~/.mylogin.cnf`，然后使用 `mysql --login-path=xxxx` 来登录。详见[官方文档](https://dev.mysql.com/doc/refman/5.7/en/mysql-config-editor.html)

mysql_config_editor 默认使用交互式来输入密码，部署脚本 `./bin/setup_mysql_loginpath.sh` 利用 expect 实现非交互式自动输入密码。

下面以配置 PaaS 平台使用的数据库为例介绍如何使用：

1. 配置本机使用 root 账号通过 mysql socket 来连接本机 mysqld 的配置

    ```bash
    ./bin/setup_mysql_loginpath.sh -n default-root -h /var/run/mysql/default.mysql.socket -u root -p $BK_MYSQL_ADMIN_PASSWORD
    ```

2. 使用 `mysql --login-path=default-root` 验证是否能以 root 用户连上 mysql

## 授权访问

配置好本机的 root 账号后，给需要访问它的主机授权访问，运行 mysql 的 grant 命令。
蓝鲸部署脚本为了简化授权，统一使用固定的脚本 `./bin/grant_mysql_priv.sh`，授权的 db 和表名为"*.*"。 

假设 paas 部署的主机 ip 为 `$BK_PAAS_IP`，需要访问的 mysqld 实例是上一节配置好的 `default-root`，paas 使用用户名`$BK_PAAS_MYSQL_USER`，密码为`$BK_PAAS_MYSQL_PASSWORD`。在 mysqld 主机上运行命令：

```bash
./bin/grant_mysql_priv.sh -n default-root -u "$BK_PAAS_MYSQL_USER" -p "$BK_PAAS_MYSQL_PASSWORD" -H "$BK_PAAS_IP"
```

由于蓝鲸的部署模式是从中控机运行各个模块的 sql 文件导入，授权的时候，还需要添加上中控机的 IP 地址（$CTRL_IP）。

实际的部署脚本采取比较粗放的方式，给所有蓝鲸的机器授权所有的 DB 和表的权限。

## 配置中控机

在完成授权后，中控机具备访问所有 MySQL 实例的账号权限。可以使用 `./bin/setup_mysql_loginpath.sh` 来配置各个 DB 的访问了。
虽然社区版只有一个 MySQL 实例，这是物理部署上原因。从逻辑部署上，蓝鲸的 MySQL 数据库是应该拆分为：

- mysql-paas: PaaS 后台和 SaaS 使用的实例。
- mysql-job: 作业平台（job） 后台使用的实例。
- mysql-iam: 权限中心（iam） 后台使用的实例。
- mysql-ssm: 凭证管理（ssm） 后台使用的实例。
- mysql-usermgr：用户管理（usermgr） 后台使用的实例。
- mysql-nodeman: 节点管理（nodeman）后台使用的实例
- mysql-monitor: 蓝鲸监控（monitorv3）后台使用的实例。
- mysql-fta: 故障自愈（fta）后台使用的实例
- mysql-ci: 蓝盾（ci）后台使用的实例

这样逻辑拆分的目的是为了，假设用户资源充足，且使用某个后台的量级比较大，假设 mysql-monitor 需要拆分一个新的实例，这样只需要通过 `mysql_config_editor` 更新下 `mysql-monitor` 这个 login-path 的指向，无需修改脚本的参数。

以配置中控机上的 `mysql-paas` 为例：

```bash
./bin/setup_mysql_loginpath.sh -n mysql-paas -h "$BK_PAAS_MYSQL_HOST" -u "$BK_PAAS_MYSQL_USER" -p "$BK_PAAS_MYSQL_PASSWORD"
```

## SQL 文件管理

部署依赖 MySQL 的后台第一步是创建库表结构，蓝鲸使用统一规范的目录存放后台包依赖的 sql 文件。

- ./模块名/support-files/sql/4 位序号_工程_日期—时间_mysql.sql 
- ./模块名/support-files/sql/子模块/4 位序号_工程_日期—时间_mysql.sql 

蓝鲸部署脚本封装导入 sql 的脚本为：`./bin/sql_migrate.sh` 

以导入 open_paas 的 sql （`open_paas/support-files/sql/0001_open_paas_20180710-1600_mysql.sql`）为例：

```bash
./bin/sql_migrate.sh -n mysql-paas /data/src/open_paas/support-files/sql/*.sql
```

以导入 job 的 sql（`job/support-files/sql/*/*.sql`）为例：

```bash
./bin/sql_migrate.sh -n mysql-job /data/src/job/support-files/sql/*/*.sql
```

导入成功后，在 `~/.migrate/` 下生成同名 sql 文件的标记文件，并使用 `chattr +i` 限制删除，这样下次运行相同的`sql_migate.sh` 脚本时，会自动跳过已经导入成功的 sql 文件，实现蓝鲸后台的 sql migrate。

## 常用配置

如果需要自定义 mysql 配置，请修改对应实例名的配置文件：/etc/mysql/实例名.my.cnf 

配置选项含义参考[官方文档](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html)

## 常见问题
