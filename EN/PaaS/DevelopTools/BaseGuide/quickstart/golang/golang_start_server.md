# 运行项目

环境配置完成后，我们还需要做一些额外配置，才能让项目顺利跑起来。

## 配置项目数据库连接

### 确保数据库运行

检查你的数据库 server 的地址、端口、运行状态，确保数据库服务正常运行。

### 修改本地数据库配置信息

在 `conf/app.conf` 文件中将 `dev` 项下的信息修改为您本地数据库的信息，其中 `dbname` 建议设置为应用 ID。

```bash
[dev]
logdir = logs/
dbname = 应用ID
dbuser = root
dbpasswd = ""
dbhost = 127.0.0.1
dbport = 3306
```

### 创建数据库

将下面语句中的 数据库名称 换为 **应用 ID** 后，然后执行：

```sql
mysql> CREATE DATABASE `... ...` default charset utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.01 sec)
```

### 初始化数据库

bee 的数据库迁移命令如下：[bee migrate-命令](https://beego.gocn.vip/beego/zh/developing/bee/#bee-%E5%B7%A5%E5%85%B7%E5%91%BD%E4%BB%A4%E8%AF%A6%E8%A7%A3) 

```bash
bee migrate [-driver=mysql] [-conn="root:@tcp(127.0.0.1:3306)/test"]
    run all outstanding migrations
    -driver: [mysql | postgresql | sqlite], the default is mysql
    -conn:   the connection string used by the driver, the default is root:@tcp(127.0.0.1:3306)/test
```

例如 mysql 运行在本地，端口为 3306，dbuser 为 root，dbpasswd 为空，APP_ID 为 go-guide，使用以下命令来完成 migration。

```bash
$ cd $GOPATH/src/{APP_ID}
$ bee migrate -conn="root:@tcp(127.0.0.1:3306)/go-guide"
______
| ___ \
| |_/ /  ___   ___
| ___ \ / _ \ / _ \
| |_/ /|  __/|  __/
\____/  \___| \___| v1.10.0
2020/06/05 11:49:40 INFO     ▶ 0001 Using 'mysql' as 'driver'
2020/06/05 11:49:40 INFO     ▶ 0002 Using 'root:@tcp(127.0.0.1:3306)/go-guide' as 'conn'
2020/06/05 11:49:40 INFO     ▶ 0003 Running all outstanding migrations
2020/06/05 11:49:43 INFO     ▶ 0004 |> 2020/06/05 11:49:41.058 [I]  total success upgrade: 0  migration
2020/06/05 11:49:43 SUCCESS  ▶ 0005 Migration successful!
```

如果没有报错，代表你的数据库已经初始化成功啦！


## 启动开发服务器

### 配置 hosts

首先，本地需要配置 hosts 文件，添加如下内容

```bash
# 内部版应用
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名)
```

### 本地启动项目

可以有两种启动项目的方式。

#### 使用 bee 启动项目

您可以使用 bee 命令直接启动项目。在项目根目录下执行如下命令：

```bash
$ cd $GOPATH/src/{APP_ID}
$ bee run
```

接着在浏览器访问 http://dev.xxx.xxx:5000 就可以看到项目首页啦。

您也可以在 `conf/app.conf` 下修改 dev 下的 `httpport` 来修改本地启动的端口。[beego 参数配置](https://beego.gocn.vip/beego/zh/developing/)

#### 使用 go 命令编译运行

您也可以先编译为二进制文件，再运行。在项目根目录下执行如下命令，编译生成名为应用名的二进制。

```bash
go build -o {APP_ID} .
```

接着执行该二进制，就可以在浏览器访问 http://dev.xxx.xxx:5000 就可以看到项目首页啦。
