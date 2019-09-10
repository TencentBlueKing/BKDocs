## 教你一步步安装蓝鲸社区版

### 导言

本文档主要目的是阐述如何不依赖官方脚本，通过手动运行 Linux 命令，一步步安装单机蓝鲸社区版的步骤，学习了解每个组件的依赖关系，配置文件，启停方法。供有一定Linux系统基础，对蓝鲸本身不了解的运维阅读。实际安装使用，请使用官方安装脚本和文档进行。

### 环境准备

- 一台Centos 7.x系统的服务器，虚拟机，物理机均可
- 建议最低配置4核16G
- 下载官方蓝鲸产品软件包：bkce_product-5.0.4.tgz
- 生成证书文件：ssl_certificates.tar

### 安装方法论

蓝鲸组件及其依赖的开源组件安装部署方法不外乎四个步骤：

1. 安装软件本身

   1. 通过rpm等包管理工具安装

   2. 拷贝二进制到指定目录，创建日志目录，数据目录，运行账号

2. 生成或者修改配置文件
3. 初始化软件依赖的资源
4. 配置启动方式运行软件

对于第一次接触某个组件的运维来说，安装应该关注的重点是配置文件如何修改，
每个配置项的详细文档、初始化资源的过程。

对于像Nginx、Redis、MySQL等这些开源组件，组件的官方文档和网上的资源足够丰富
本文档尽量使用开源组件官方的安装方式来描述它们的安装、配置修改和启动。

对于蓝鲸的组件，部分已经开源，比如PaaS、CMDB。尽量使用Github上的安装
步骤进行。

文档涉及的命令均以root用户运行。

### 系统初始化

开始正式安装之前，我们需要对系统进行一些操作，准备好安装环境。

```bash
mkdir -p /data/src /data/bkce
tar -xf bkce_product-5.0.4.tgz -C /data
tar -xf ssl_certificates.tar -C /data/src/cert
```

创建/data/src目录用于解压的安装包，/data/bkce用作安装蓝鲸的目标目录。
解压证书文件到/data/src/cert目录。

打开编辑器，创建一个环境变量文件（EnvironmentFile）/data/blueking.env。
文件使用Bash语法格式，用于定义环境变量。随着安装的进行，我们会逐步追加配置到这个文件。
此时，可以先写入两个最主要的路径变量：

```bash
PKG_SRC_PATH=/data/src
INTALL_PATH=/data/bkce
```

接着，我们需要获取安装蓝鲸服务器的IP地址并赋予变量`LAN_IP`。它的应用场景是，服务进程在配置文件和启动时，需要监听本机网卡的端口。一般而言，服务进程可以选择监听0.0.0.0（所有可用网卡），或者本机回环地址（127.0.0.1）。蓝鲸产品的配置文件规范里，统一要求组件监听一个明确的地址，一般是内网的网卡。本文档也遵循此惯例。假设本机的网卡地址是10.0.0.1，那么追加

```bash
LAN_IP="10.0.0.1"
```

更新到 /data/blueking.env。下文如果配置文件中出现10.0.0.1字符串时，请自行用实际的IP地址进行替换。Linux命令中，则会使用 `$LAN_IP` 来表示。

参考腾讯云文档，配置yum的EPEL源：https://mirrors.cloud.tencent.com/help/epel.html

接下来通过yum安装蓝鲸全局依赖的软件包和工具。

```bash
yum install zip unzip sysvinit-tools procps-ng rsync gawk curl lsof tar sed iproute uuid psmisc wget openssl-devel readline-devel libcurl-devel libxml2-devel glibc-devel zlib-devel bind-utils python-devel
```

系统准备工作完毕。

### 安装 PaaS

蓝鲸社区版PaaS已经开源，具体介绍参见：https://github.com/tencent/bk-paas
开源版的部署文档可以作为本章节的参考：https://github.com/Tencent/bk-PaaS/blob/master/docs/install/ce_paas_install.md

首先安装PaaS依赖的第三方开源组件: MySQL、Redis、Nginx

#### 安装 MySQL

MariaDB是MySQL的开源社区版本，蓝鲸社区版使用MariaDB 5.5.x系列。其他版本可能会有兼容性问题。（为了方便起见，下文用mysql指代mariadb）

```bash
yum install mariadb-server mariadb
```

#### 配置 MySQL

编辑系统安装的mysql配置文件。

1. 配置mysql server：编辑/etc/my.cnf.d/server.cnf (如果不存在，则直接编辑/etc/my.cnf）。在 `[mysqld]` 段下新增如下配置：

        character-set-server = utf8
        bind-address = 10.0.0.1
        max_connections = 3000
        event_scheduler=ON
        innodb_file_per_table=1
        expire_logs_days=7
    > 注：bind-address中的10.0.0.1 请替换为实际的LAN_IP
2. 配置 mysql 客户端：编辑/etc/my.cnf.d/client.cnf（如果不存在，则直接编辑/etc/my.cnf）。在 `[client]` 段下新增如下配置：

        default-character-set = utf8

往 /data/blueking.env 文件中追加以下配置，依次为蓝鲸连接mysql使用的用户名、密码、mysqld的监听端口：

```bash
MYSQL_USER=blueking
MYSQL_PASS='Bluek34d'
MYSQL_PORT=3306
```

> 注：mysql 用户名和密码请自行修改，文档仅为范例。

#### 启动 MySQL

由于使用yum安装，可以直接使用systemctl启动mysqld服务，并确认启动成功：

```bash
systemctl start mariadb
systemctl status mariadb
```

#### 初始化 MySQL

成功启动mysqld后，需要创建$MYSQL_USER用户，且密码为$MYSQL_PASS，为了简单起见，赋予这个账户所有数据库的所有权限。运行以下命令进行授权：

```bash
source /data/blueking.env # 加载配置的环境变量
mysql -u root -e "GRANT ALL ON *.* TO $MYSQL_USER@$LAN_IP IDENTIFIED BY '$MYSQL_PASS' "   # 授权通过-h $LAN_IP的访问。
mysql -u root -e "GRANT ALL ON *.* TO $MYSQL_USER@localhost IDENTIFIED BY '$MYSQL_PASS' "   # 授权通过localhost的访问。
```

若有需要访问这个mysql的实例，均可以用类似的命令授权，注意替换掉$LAN_IP为实际的访问IP即可。

#### 安装 Redis

Redis 也通过 yum安装，使用3.x，4.x版本均可。

```bash
yum install redis
```

#### 配置 Redis

修改默认配置文件中 /etc/redis.conf 添加如下选项：

```txt
bind 10.0.0.1
port 6379
requirepass Foo_bar1d
```

> - bind 即监听的IP： $LAN_IP
> - port 即监听的端口：$REDIS_PORT
> - requirepass 配置 redis 鉴权的密码：$REDIS_PASS

将配置的Redis密码和监听的端口，追加写入文件/data/blueking.env。

```bash
REDIS_PASS='Foo_bar1d'
REDIS_PORT=6379
```

#### 启动 Redis

```bash
systemctl start redis  # 启动redis-server服务
systemctl status redis # 查看redis的状态
```

#### 安装 Nginx

Nginx 通过 yum安装，使用1.10.x以上版本均可。

```bash
yum install nginx
```

#### 配置 Nginx（上）

在CentOS上通过yum安装的nginx，使用 /etc/nginx/nginx.conf 作为主配置。/etc/nginx/conf.d/ 放置用户自定义的server配置，该目录下的配置通过主配置文件include指令而生效。对于PaaS需要的nginx配置，编辑/etc/nginx/conf.d/paas.conf即可。蓝鲸其他依赖Nginx做反向代理的组件同理。

编辑 /etc/nginx/conf.d/paas.conf

```nginx
# 以下upstream定义分别对应open_paas下的各工程，端口均为默认值
# max_fails=1 和 fail_timeout配置根据经验设置。
# 需要特别说明的是，fail的次数和timeout是单个worker内统计的。这些状态不会跨worker共享。
# 意味如果worker数量为N，那理论上即使max_fails=1，也可能会产生N次失败，才会使用Next server。
# 具体文档请参考：https://nginx.org/en/docs/http/ngx_http_upstream_module.html#upstream
upstream OPEN_PAAS_APPENGINE {
    server __PAAS_IP0__:8000 max_fails=1  fail_timeout=30s;
}
upstream OPEN_PAAS {
    server __PAAS_IP0__:8001 max_fails=1  fail_timeout=30s;
}
upstream OPEN_PAAS_ESB {
    server __PAAS_IP0__:8002 max_fails=1  fail_timeout=30s;
}
upstream OPEN_PAAS_LOGIN {
    server __PAAS_IP0__:8003 max_fails=1  fail_timeout=30s;
}

# 这里定义正式环境SaaS使用的二级Nginx的入口，指向的是appo所属机器上的nginx
upstream PAAS_AGENT_PROD {
    server __APPO_IP0__:__APP_NGXPROXY_PORT__ max_fails=1  fail_timeout=30s;
}

# 设置何种情况下，请求会传给upstream中定义的下一个server。
# 需要注意的是，对于非幂等（non-idempotent）的请求(POST, LOCK, PATCH)，默认是不会
# 传递给下一个Server的，如果它已经传给一个Server去处理了（虽然失败了）
# 具体参考：https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_next_upstream
proxy_next_upstream  http_502 http_504 error timeout invalid_header;

server {
    listen __PAAS_HTTP_PORT__;
    server_name  __PAAS_FQDN__ __PAAS_HOST__;

    client_max_body_size    512m;
    access_log  /var/log/nginx/paas_access.log;

    # ============================ paas ============================
    # PAAS_SERVICE HOST/PORT
    location / {
        proxy_pass http://OPEN_PAAS;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }

    # PAAS_SERVICE HOST/PORT, for doc
    location ~ ^/doc/(.*) {
        proxy_pass http://OPEN_PAAS/static/doc/$1$is_args$args;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;

    }


    # ============================ appengine ============================
    # ENGINE_SERVICE HOST/PORT
    location ~ ^/v1 {
        proxy_pass http://OPEN_PAAS_APPENGINE;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_read_timeout 600;
    }

    # ============================ esb ============================
    # ESB_SERVICE HOST/PORT
    location ~ ^/api/(.*) {
        proxy_pass http://OPEN_PAAS_ESB/$1$is_args$args;
        proxy_pass_header Server;
        proxy_set_header X-Request-Uri $request_uri;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }


    # ============================ login ============================
    # LOGIN_SERVICE HOST/PORT
    location ~ ^/login/(.*) {
        proxy_pass http://OPEN_PAAS_LOGIN/$1$is_args$args;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }

    # for apps prod
    location ~ ^/o/ {
        proxy_pass http://PAAS_AGENT_PROD;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }
}
```

了解Nginx配置的运维，会发现这个配置文件并不符合nginx配置文件语法，因为有不少形如 `"__XXXX_IP0__"` 的字符串。上面的配置文件在蓝鲸社区版的`bkce_common-1.0.0.tgz`包中。解压后的文件路径为 `src/service/support-files/templates/#etc#nginx#paas.conf`

为了方便后面的叙述，以及了解社区版安装脚本使用的模版渲染原理。先插入一节模版渲染原理。

#### 模版渲染原理

先引入一个概念，配置文件**占位符**，我们约定软件配置文件中需要在部署时动态替换的地方，使用占位符，而不写死值(hardcode)。在部署时根据用户的自定义配置文件（比如本文中的/data/blueking.env)，和安装环境自动获取这些**占位符**真实对应的值，然后调用sed命令进行替换。这就叫做模版渲染。

占位符的形式用正则表达式简化表达为：`"__[0-9A-Z_]+__"`。用人话说就是：以2个连续下划线开头，两个连续下划线结尾，中间是一串由大写字母、数字、单个下划线组成的变量名（但不能以下划线和数字开头，也不能以下划线结尾）。

通过以下命令我们可以找出一个配置文件模版中有哪些占位符需要替换：

```bash
$ grep -wEo '__[0-9A-Z_]+__' /etc/nginx/conf.d/paas.conf | sort -u
__APP_NGXPROXY_PORT__
__APPO_IP0__
__PAAS_FQDN__
__PAAS_HOST__
__PAAS_HTTP_PORT__
__PAAS_IP0__
```

所以渲染的关键是找出这些值应该替换为什么，是的paas.conf成为一个合法可用的配置文件。蓝鲸的安装脚本为了简便起见，使用环境变量来一一对应占位符的方法，用sed命令来处理替换。

于是为了替换`__PAAS_FQDN__`占位符，我们先定义一个PAAS_FQDN的环境变量。本教程为了简化，统一使用开头提到的/data/blueking.env来定义。

了解Bash基础的运维，应该知道，通过KEY=Value可以定义一个变量。把KEY=Value写入一个文件blueking.env，然后使用`source`可以加载这些变量，通过`echo`可以查看当前变量：

```bash
source /data/blueking.env
echo "$MYSQL_USER"
blueking
```

但编写Bash脚本时，经常用到管道，调用外部脚本，这时命令执行的环境都在子Shell下，父Shell下通过source加载的变量，如果没有export，子shell下读取时会为空。例如：

```bash
source /data/blueking.env
echo $MYSQL_USER
blueking
bash # 进入子shell
echo $MYSQL_USER

```

所以我们在加载定义的环境变量前，打开一个shell选项`shopt -s allexport`或者`set -a`。

> -a      Automatically mark variables and functions which are modified  or
>     created for export to the environment of subsequent commands.

例如：

```bash
$  set -a
$  source /data/blueking.env
$  set +a # 关闭开关，防止之后的定义不小心被export
$  bash
$  echo $MYSQL_USER
blueking
```

有了以上基础知识做准备，我们开始替换占位符。假设已经运行了上面加载的环境变量，且export了。

```bash
# 找出所有需要替换的占位符
place_holders=$(grep -wEo '__[0-9A-Z_]+__' /etc/nginx/conf.d/paas.conf | sort -u )

for p in $place_holders
do
    k=$(echo $p | sed 's/^__//; s/__$//;')  # 将占位符的首尾双下划线去掉
    v=${!k}  # 使用间接引用读取变量值
    echo "s|$p|$v|g" >> /tmp/paas.sed # sed替换，使用竖线分割符生成sed脚本
done

# 实际替换生效
sed -i -f /tmp/paas.sed /etc/nginx/conf.d/paas.conf
```

#### 配置 Nginx（下）

接上上节，配置 Nginx（上）

通过模版渲染原理一节的学习。我们知道需要在/data/blueking.env中追加需要替换的占位符变量的值：

```bash
PAAS_FQDN="paas.bk.com"
PAAS_HOST="paas.service.consul"
PAAS_HTTP_PORT=80
PAAS_IP0=10.0.0.1
APPO_IP0=10.0.0.1
APP_NGXPROXY_PORT=8010
```

要了解这些值的取值，需要理解Nginx配置文件本身配置项目的含义。比如
PAAS_FQDN、PAAS_HOST在paas.conf中，属于 [server_name](http://nginx.org/en/docs/http/server_names.html) 字段的值。了解HTTP原理和Nginx配置后，我们知道，定义这个字段是Nginx为了区分不同HTTP请求头部的 `Host:` 值，用不同的配置逻辑处理，这样实现只有一个IP地址，却能反向代理不同域名的功能。

对于蓝鲸而言，访问PaaS的服务，有浏览器页面直接发起访问的，比如登录，打开开发者中心文档，上下架SaaS的页面等。也有从后台调用ESB的api接口。虽然提供这些服务的模块都是同一个，为了规范化的区分，我们定义从浏览器访问PaaS的域名叫外部域名（PAAS_FQDN），通过内网通信的叫内部域名（PAAS_HOST）。

PAAS_FQDN的域名解析，可以通过企业的dns服务器、本地的hosts文件来实现。PAAS_HOST的域名解析，蓝鲸社区版通过consul服务来实现。本教程为了简化逻辑，均使用/etc/hosts来提供内部域名的解析。有关consul的使用，有单独的文档详细描述。

- `PAAS_HTTP_PORT`对应`Listen`的值，是nginx默认监听的端口，取80
- `PAAS_IP0` 表示部署PaaS模块的第一个IP，PaaS模块可以横向扩展，所以如果有其他空闲的机器，可以多配置一个upstream的server定义，让nginx可以将请求负载均衡的转发。这时这台机器就可以定义为PAAS_IP1，依此类推。
- `APPO_IP0` 表示部署paas_agent模块的第一个IP，开发者中心里注册的正式环境服务器。因为本文档是介绍单机部署，所以凡是涉及到IP的值，均为10.0.0.1
- `APP_NXGPROXY_PORT` 表示蓝鲸SaaS接入层对应的二级Nginx监听的端口，默认取8010，这个变量后面介绍paas_agent部署时会再次用到。

至此，替换paas.conf所需要的变量准备完毕。我们使用上一节模版渲染原理里的命令来替换/etc/nginx/conf.d/paas.conf

PAAS_FQDN和PAAS_HOST的域名，如果没有内部dns服务器，使用/etc/hosts取代，这时可以运行下面命令来添加本地的域名解析：

```bash
source /data/blueking.env
echo "$LAN_IP $PAAS_FQDN $PAAS_HOST" >> /etc/hosts
```

这时大家应该能明白环境变量的一种功用了吧，写脚本或者写文档时能屏蔽掉环境的差异。这也是环境变量之所以叫环境变量的来由吧。微服务，容器盛行的今天，它们也不过是用环境变量来屏蔽差异。所以深刻理解和活用环境变量，对于运维来说至关重要。

#### 启动 Nginx

启动前先确认nginx配置语法正确。

```bash
nginx -t
systemctl start nginx
systemctl status nginx
```

启动后我们访问 paas.service.consul 域名测试：

```bash
$  curl paas.service.consul
<html>
<head><title>502 Bad Gateway</title></head>
<body bgcolor="white">
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.6.3</center>
</body>
</html>
```

这是符合预期的，502，表示nginx转发请求到后端服务，后端服务不可用，正因为我们的PaaS还没部署呢。

#### 安装 open_paas

先安装 "安装PaaS的pip模块" 时依赖的系统包：

```bash
yum install gcc mysql-devel libevent-devel \
            bzip2-devel sqlite-devel tk-devel \
            gdbm-devel db4-devel libpcap-devel \
            xz-devel pcre-devel svn
```

安装PaaS先将模块目录从原目录拷贝到目标安装目录：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/open_paas $INSTALL_PATH/
```

注意：

1. `$PKG_SRC_PATH/open_paas` 后面不要有 **/** ，否则rsync会将open_paas下面的子目录拷贝到 $INSTALL_PATH/
2. `--exclude=support-files` 将排除这个安装辅助目录，因为运行paas时，并不需要它们。

PaaS下各子模块都是用uwsgi启动的Django工程，安装的差别在于配置文件，python模块依赖不同。

先安装paas工程：

paas的代码目录在open_paas/paas下，定义的python模块依赖文件为 requirements.txt。我们首先给paas创建一个virutalenv：

1. 如果系统自带的Python在2.7.9版本以上，则默认安装了pip工具，否则需要手动安装pip工具（这里介绍离线安装的方法）：

    1. 从官网下载最新的setuptools和pip的源码包：https://pypi.org/project/setuptools/#files https://pypi.org/project/pip/#files
    2. 解压包，并安装

        ```bash
        unzip setuptools-41.0.1.zip  && cd setuptools-41.0.1 && python setup.py install
        tar xf pip-19.0.3.tar.gz && cd pip-19.0.3 && python setup.py install
        ```

    3. 校验是否安装成功

        ```bash
        pip --version
        ```

2. 修改$HOME/.pip/pip.conf 自定义pip源。以腾讯云为例：https://mirrors.cloud.tencent.com/help/pypi.html

3. 安装virtualenv所需要的工具：

    ```bash
    pip install pbr virtualenvwrapper
    ```

4. 设定virtualenv的工作环境，并添加到 $HOME/.bashrc 中：

    ```bash
    export INSTALL_PATH=/data/bkce
    export WORKON_HOME=$INSTALL_PATH/.envs
    source $(which virtualenvwrapper.sh)
    ```

5. 加载 $HOME/.bashrc 让virtualenv等命令生效：

    ```bash
    source $HOME/.bashrc
    ```

6. 安装paas的virtualenv，使用-a 参数指定项目的路径。运行成功后，当前目录会自动切换到$INSTALL_PATH/open_paas/paas下

    ```bash
    mkvirtualenv -a $INSTALL_PATH/open_paas/paas paas
    ```

7. 执行以下命令安装paas的依赖包，因为paas的pip依赖包以及包含在$PKG_SRC_PATH/open_paas/support-files/pkgs/下，方便离线安装。如果安装某个python模块有报错，可以自行搜索对应报错的包名，先解决安装问题再继续下面的步骤。

    ```bash
    pip install --no-index --find-links=$PKG_SRC_PATH/open_paas/support-files/pkgs -r requirements.txt
    ```

paas工程安装完毕，对于其他工程esb,login,appengine也同样执行第五和第六步。注意项目目录和virtualenv的名字区分即可：

```bash
mkvirtualenv -a $INSTALL_PATH/open_paas/login login && pip install --no-index --find-links=$PKG_SRC_PATH/open_paas/support-files/pkgs -r requirements.txt
mkvirtualenv -a $INSTALL_PATH/open_paas/esb esb && pip install --no-index --find-links=$PKG_SRC_PATH/open_paas/support-files/pkgs -r requirements.txt
mkvirtualenv -a $INSTALL_PATH/open_paas/appengine appengine && pip install --no-index --find-links=$PKG_SRC_PATH/open_paas/support-files/pkgs -r requirements.txt
```

#### 配置 PaaS

从上节知道，paas的工程代码目录在open_paas/paas下。它启动需要读取的配置文件是$INSTALL_PATH/open_paas/paas/conf/settings_production.py。大家会发现包里并没有这个文件，这是因为如果配置文件需要编辑才能使用的，都会在打包时以某个约定的规则放到该模块目录下的support-files/templates/目录下。比如/$INSTALL_PATH/open_paas/paas/conf/settings_production.py就对应$PKG_SRC_PATH/open_paas/support-files/templates/paas#conf#settings_production.py.tpl

通过观察，应可以猜出，这个约定的规则如下：

1. 模板文件的文件名，将 **#** 替换为 **/**，然后追加到该模块安装根目录后面即最终配置文件所在路径
2. paas是工程，它所属的模块是open_paas，open_paas的安装根目录是 $INSTALL_PATH/open_paas
3. 所以$INSTALL_PATH/open_paas + paas/conf/settings_production.py.tpl得到$INSTALL_PATH/open_paas/paas/conf/settings_production.py.tpl， 末尾的.tpl会去掉，得到$INSTALL_PATH/open_paas/paas/conf/settings_production.py

复习上面模板渲染原理后，我们观察这个配置文件需要替换哪些占位符：

```bash
$ grep -wEo '__[0-9A-Z_]+__' $PKG_SRC_PATH/open_paas/support-files/templates/paas#conf#settings_production.py.tpl  | sort -u
__BK_DOMAIN__
__CMDB_FQDN__
__DATAAPI_HOST__
__DATAAPI_PORT__
__DEFAULT_HTTPS_PORT__
__ESB_SECRET_KEY__
__ESB_TOKEN__
__FTA_API_PORT__
__FTA_HOST__
__GSEAPISERVER_PORT__
__GSE_HOST__
__HTTP_SCHEMA__
__JOB_FQDN__
__LAN_IP__
__MYSQL_IP0__
__MYSQL_PASS__
__MYSQL_PORT__
__MYSQL_USER__
__PAAS_FQDN__
__PAAS_HOST__
__PAAS_HTTP_PORT__
__PAAS_HTTPS_PORT__
```

看到这里，可能第一次接触蓝鲸的人会一头雾水。我们遵循运维的直觉进行吧。

第一个__BK_DOMAIN__的配置，在模板文件里通过搜索定位上下文：

```bash
# cookie访问域
BK_COOKIE_DOMAIN = '.__BK_DOMAIN__'
```

这个配置的作用是决定cookies应该放置在哪个域下面。我们配置了PAAS_FQDN为paas.bk.com，所以BK_DOMAIN应该配置为"bk.com"， 追加到/data/blueking.env中

```bash
BK_DOMAIN="bk.com"
```

另外一个关乎全局的配置：HTTP_SCHEMA，决定了一些组件的访问方式是http还是https，本文档演示默认的http方式。

```bash
HTTP_SCHEMA=http
```

接下来的几个HOST和FQDN，直接给出默认值，大家添加到/data/blueking.env中：

```bash
CMDB_FQDN="cmdb.bk.com"
JOB_FQDN="job.bk.com"
DEFAULT_HTTPS_PORT=80 # 这里为啥不是443，是因为我们这次安装并不启用https，所以用http的端口代替。
PAAS_HTTPS_PORT=$DEFAULT_HTTPS_PORT # 这里可以使用前面定义过的变量
GSE_HOST="gse.service.consul"
GSEAPISERVER_PORT=59313
DATAAPI_HOST=dataapi.service.consul
DATAAPI_PORT=10011
FTA_HOST=fta.service.consul
FTA_API_PORT=13031
```

ESB_SECRET_KEY ESB_TOKEN这两个变量在src包里有定义(/data/src/blueking.env)，直接复制过来即可。当然你也可以自己用`uuid`等命令随机生成一个长度和规则一样的字符串。

```bash
ESB_TOKEN="14947652-BE94-4364-9860-2F7D03B2FCDB"
ESB_SECRET_KEY="a2i4DaAOcmx0PXn3b3a8eiWDqj85inCTQt21nZxPV2By8bgUeW"
```

最后，还要填补一个MYSQL_IP0的变量定义，它是paas需要访问的数据库IP地址

MYSQL_IP0=10.0.0.1

至此填充$PKG_SRC_PATH/open_paas/support-files/templates/paas#conf#settings_production.py.tpl的变量已经就绪。

有人可能会问，如何确保没有遗漏的定义呢？这是个好问题。穿插一段Bash代码，来看看我们如何寻找遗漏的变量定义：

```bash
source /data/blueking.env
place_holders=$(grep -wEo '__[0-9A-Z_]+__' $PKG_SRC_PATH/open_paas/support-files/templates/paas#conf#settings_production.py.tpl  | sort -u)
for p in $place_holders
do
    k=$(echo $p | sed 's/^__//; s/__$//;')
    v=${!k}
    [[ -z $v ]] && echo "$p is empty"
done
```

假设我们去掉/data/blueking.env中的MYSQL_IP0定义。然后重新登录这台机器（为了快速让变量unset），运行上述代码，会发现输出：

```txt
__MYSQL_IP0__ is empty
```

这就提醒我们环境变量文件中缺少MYSQL_IP0的定义。

回到主线来，这个文件我们没法用sed -i-f /tmp/paas.sed的方法来进行。不过可以直接用重定向的方法，这里假设你已经重新生成了/tmp/paas.sed脚本(参考上面nginx的paas.conf配置渲染）：

```bash
sed -f /tmp/paas.sed $PKG_SRC_PATH/open_paas/support-files/templates/paas#conf#settings_production.py.tpl > $INSTALL_PATH/open_paas/paas/conf/settings_productions.py
```

用同样的方法，我们配置好PaaS平台的其他工程的配置文件分别如下：

- appengine: $PKG_SRC_PATH/open_paas/support-files/templates/appengine#controller#settings.py.tpl
- esb: $PKG_SRC_PATH/open_paas/support-files/templates/esb#configs#default.py.tpl
- login: $PKG_SRC_PATH/open_paas/support-files/templates/login#conf#settings_production.py.tpl

以及各工程的uwsgi配置文件：

- $PKG_SRC_PATH/open_paas/support-files/templates/#etc#uwsgi-open_paas-appengine.ini
- $PKG_SRC_PATH/open_paas/support-files/templates/#etc#uwsgi-open_paas-esb.ini
- $PKG_SRC_PATH/open_paas/support-files/templates/#etc#uwsgi-open_paas-login.ini
- $PKG_SRC_PATH/open_paas/support-files/templates/#etc#uwsgi-open_paas-paas.ini

我们使用以下shell命令，来统一获取上面模板文件里的所有占位符：

```bash
source /data/blueking.env
place_holders=$(cd $PKG_SRC_PATH/open_paas/support-files/templates && cat * | grep -wEo '__[0-9A-Z_]+__' | sort -u)
for p in $place_holders
do
    k=$(echo $p | sed 's/^__//; s/__$//;')
    v=${!k}
    [[ -z $v ]] && echo "$p"
done
```

等到输出如下：

```txt
__BK_HOME__
__BKSQL_HOST__
__BKSQL_PORT__
__CERT_PATH__
__CICDKIT_DCLOUD_PORT__
__CICDKIT_FQDN__
__CMDB_API_PORT__
__CMDB_DIRECT_HOST__
__CMDB_HOST__
__CMDB_HTTP_PORT__
__DEVOPS_HOST__
__DEVOPS_PORT__
__GSE_CACHEAPI_HOST__
__GSE_CACHEAPI_PORT__
__GSE_IP0__
__GSE_IP1__
__GSE_PMS_HOST__
__GSE_PMS_PORT__
__GSEPROC_PORT__
__JOB_API_PORT__
__JOB_DIRECT_HOST__
__MODELFLOW_API_PORT__
__MODELFLOW_HOST__
__MONITOR_HOST__
__MONITOR_KERNELAPI_PORT__
__PAAS_ADMIN_PASS__
__PAAS_ADMIN_USER__
__PROCESSORAPI_HOST__
__PROCESSORAPI_PORT__
__REDIS_IP0__
__REDIS_MASTER_NAME__
```

其中有一些变量是暂时社区版功能没有用到的，可以忽略。真正需要配置的变量如下：

```txt
__BK_HOME__
__CERT_PATH__
__CMDB_API_PORT__
__CMDB_DIRECT_HOST__
__CMDB_HOST__
__CMDB_HTTP_PORT__
__GSE_CACHEAPI_HOST__
__GSE_CACHEAPI_PORT__
__GSE_IP0__
__GSE_IP1__
__GSE_PMS_HOST__
__GSE_PMS_PORT__
__GSEPROC_PORT__
__JOB_API_PORT__
__JOB_DIRECT_HOST__
__MONITOR_HOST__
__MONITOR_KERNELAPI_PORT__
__PAAS_ADMIN_PASS__
__PAAS_ADMIN_USER__
__REDIS_IP0__
__REDIS_MASTER_NAME__
```

我们直接在/data/blueking.env 里增加这些配置，具体含义见注释：

```bash
# 蓝鲸安装目录，等价于$INSTALL_PATH
BK_HOME='/data/bkce'
# 蓝鲸的证书存放目录
CERT_PATH='/data/bkce/cert'
# CMDB 直连的域名，这个域名解析后是cmdb_webserver所在的机器
CMDB_DIRECT_HOST=cmdb-direct.service.consul
# CMDB 外层域名，这个域名解析后是Nginx机器
CMDB_HOST=cmdb.server.consul
# CMDB_APISERVER的端口
CMDB_API_PORT=33031
# CMDB对外服务的端口
CMDB_HTTP_PORT=80

# GSE各个服务的内部域名和端口
GSE_IP0=10.0.0.1
GSE_IP1=
GSE_CACHEAPI_HOST=gse.service.consul
GSE_CACHEAPI_PORT=59313
GSE_PMS_HOST=gse.service.consul
GSE_PMS_PORT=52030
GSEPROC_PORT=52025

# JOB各个服务的内部域名和端口
JOB_API_PORT=8444
JOB_DIRECT_HOST=job-direct.service.consul

# 监控后台服务的内部域名和端口
MONITOR_HOST=monitor.service.consul
MONITOR_KERNELAPI_PORT=10045

# PaaS初始的管理员账号和密码
PAAS_ADMIN_PASS=blueking
PAAS_ADMIN_USER=admin

# Redis IP
REDIS_IP0=10.0.0.1
```

> 注： REDIS_MASTER_NAME 这个变量是哨兵模式的redis cluster需要配置，社区版没有使用。如果配置了会出现job启动失败的问题。

编辑保存后，我们渲染paas的所有配置：

```bash
set -a
source /data/blueking.env
set +a
cd /data/src/open_paas/support-files/templates
place_holder=$(cat *#* | grep -wEo '__[0-9A-Z_]+__' | sort -u )
 > /tmp/paas.sed
for p in $place_holder
do
    k=$(echo $p | sed 's/^__//; s/__$//;')
    v=${!k}  # 间接引用
    echo "s|$p|$v|g" >> /tmp/paas.sed
done

convert_to_target_file () {
   local module=$1
    local tpl_file=${2##*/}

    if [ "${tpl_file:0:1}" != "#" ]; then
        if [ "${tpl%%#*}" == "$module" ]; then
            local _target_file=$INSTALL_PATH/${tpl_file//#//}
        else
            local _target_file=$INSTALL_PATH/$module/${tpl_file//#//};
        fi
    else
        local _target_file=$INSTALL_PATH/${tpl_file//#//};
    fi

    echo ${_target_file%.tpl}
}

for f in *#*; do
    target_file=$(convert_to_target_file open_paas $f)
    mkdir -p $(dirname $target_file)
    sed -f /tmp/paas.sed $f > $target_file
done
```

### 初始化 PaaS

配置生成完毕，在启动PaaS进程前，还需要初始化mysql的库表结构：

1. 创建open_paas数据库：

    ```bash
    source /data/blueking.env
    mysql -u$MYSQL_USER -p$MYSQL_PASS < $PKG_SRC_PATH/open_paas/support-files/sql/0001_open_paas_20180710-1600_mysql.sql
    ```

2. 初始化paas：

    ```bash
    workon paas
    export BK_ENV=production
    python manage.py migrate
    ```

3. 初始化esb:  

    ```bash
    workon esb
    export BK_ENV=production
    python manage.py sync_data_at_deploy
    ```

4. 初始化login:

    ```bash
    workon login
    export BK_ENV=production
    python manage.py migrate
    ```

### 启动 PaaS

数据库表结构初始化后，可以启动进程。进程使用uwsgi拉起，uwsgi由于没有安装全局的命令，所以可以切换到各自的virtualenv下拉起：

```bash
workon paas ; uwsgi --ini /data/bkce/etc/uwsgi-open_paas-paas.ini &
workon esb; uwsgi --ini /data/bkce/etc/uwsgi-open_paas-esb.ini &
workon login; uwsgi --ini /data/bkce/etc/uwsgi-open_paas-login.ini &
workon appengine; uwsgi --ini /data/bkce/etc/uwsgi-open_paas-appengine.ini &
```

手动启动和停止这些命令比较繁琐，我们可以编写supervisor配置文件或systemd的配置文件托管这些进程。达到2个目的：

1. 进程监控，失败时自动拉起
2. 统一启动停止方式

先介绍supervisor的托管方式，在渲染模板时应该注意到templates下有一个#etc#supervisor-open_paas.conf的模板，替换后，生成为 $INSTALL_PATH/etc/supervisor-open_paas.conf。

接下来我们先在系统的python环境下安装好supervisor工具:

1. 退出其他虚拟环境：`deactivate`
2. 安装supervisor: `pip install supervisor`

在使用supervisor托管之前，我们可以先杀掉刚才手动用uwsgi拉起的进程：

```bash
pkill -9 -x uwsgi
sleep 3
ps -ef | grep uwsgi # 检查是否还有残留
```

确认uwsgi都退出后，启动supervisord，拉起进程：

```bash
supervisord -c /data/bkce/etc/supervisor-open_paas.conf
```

supervisor常用操作

- 检查进程状态：

    ```bash
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf status all
    ```

- 重启所有进程：

    ```bash
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf restart all
    ```

- 停止所有进程：

    ```bash
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf stop all
    ```

- 停止所有进程后，退出supervisord：

    ```bash
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf stop all
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf shutdown
    ```

- 只重启esb进程：

    ```bash
    supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf restart esb
    ```

更多supervisor的信息，请参考官方文档： http://supervisord.org

除了使用supervisor托管也可以使用系统自带的systemd方式，这需要编辑几个systemd的service和target文件：

编辑 paas.service.tpl

```ini
[Unit]
Description=BlueKing PaaS(%i) uWSGI app
After=network-online.target

[Service]
ExecStart=/bin/bash -c 'cd /data/bkce/.envs; source %i/bin/activate; uwsgi --ini /data/bkce/etc/uwsgi-open_paas-%i.ini'
Restart=on-failure
KillSignal=SIGQUIT
Type=notify
StandardError=syslog
NotifyAccess=all

[Install]
WantedBy=paas.target
```

批量生成四个组件的service文件：

```bash
for p in paas esb login appengine
do
    sed "s/%i/$p/g" paas.service.tpl > /etc/systemd/system/paas.${p}.service
done
rm -f paas.service.tpl
```

编辑/etc/systemd/system/paas.target

```ini
[Unit]
Description=PaaS target to allow start/stop all paas.*.service at once

[Install]
WantedBy=multi-user.target
```

在使用systemd托管之前，请确保停止了supervisor托管及uwsgi进程。

启用paas的工程到paas.target下：

```bash
for p in login paas esb appengine
do
    systemctl enable paas.$p
done
```

启动paas的所有进程：

```bash
systemctl start paas.target
```

查看paas的所有进程：

```bash
systemctl status paas.*
```

查看esb的进程：

```bash
systemctl status paas.esb
```

停止paas的所有进程：

```bash
systemctl stop paas.*
```

设置开机启动paas：

```bash
systemctl enable paas.target
```

### 安装 CMDB

cmdb本身运行的依赖有zookeeper，mongodb，redis，nginx。

自动获取主机信息的功能依赖 gse后台。

redis和nginx前面已经安装，我们先部署zookeeper和mongodb

#### 安装 Zookeeper

安装Zookeeper可以手动下载zookeeper的官方包，然后解压运行。也可以通过apache的[bigtop仓库](https://www.apache.org/dist/bigtop/stable/repos/centos7/bigtop.repo)进行，本文档选择前者，因为更灵活。

1. 从官网下载安装包:

    ```bash
    wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
    ```

2. 安装JDK(蓝鲸统一使用1.8.x版本）：

    ```bash
    yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel
    java -version # 确认版本
    ```

3. 解压下载的zookeeper到/opt/，并重命名为zookeeper:

    ```bash
    tar xf zookeeper-3.4.13.tar.gz -C /opt
    mv /opt/zookeeper-3.4.13 /opt/zk
    ```

4. 创建Zk的日志目录和数据目录：

    ```bash
    mkdir -p /var/log/zk /var/lib/zk
    ```

### 配置 Zookeeper

1. 编辑~/.bashrc 配置系统环境变量，并加载：

    ```bash
    export  ZOOKEEPER_HOME=/opt/zk
    export PATH=$PATH:$ZOOKEEPER_HOME/bin
    ```

2. 创建一个单机使用的zoo.cfg的模板：

    ```bash
    tickTime=2000
    initLimit=10
    syncLimit=20
    dataDir=/var/lib/zk/data
    dataLogDir=/var/lib/zk/datalog
    clientPortAddress=__LAN_IP__
    clientPort=__ZK_PORT__
    maxClientCnxns=60
    autopurge.snapRetainCount=5
    autopurge.purgeInterval=8
    ```

3. 上述模板需要两个变量，`LAN_IP`, `ZK_PORT`，我们仅需要新增`ZK_PORT`为2181到/data/blueking.env中

4. 使用上一节渲染paas模板的方法，替换这个模板后生成配置到/opt/zk/conf/zoo.cfg。由于后面需要频繁用到模板渲染，所以我们把那段代码写成一个脚本，放到$HOME/render_tpl.sh下。编辑$HOME/render_tpl.sh:

    ```bash
    #!/bin/bash

    set -a
    source /data/blueking.env
    set +a

    trap 'rm -f $sed_script' EXIT TERM
    sed_script=$(mktemp /tmp/XXXXXX.sed)

    place_holders=$(cat $1 | grep -wEo '__[0-9A-Z_]+__' | sort -u)
    for p in $place_holders
    do
        k=$(echo $p | sed 's/^__//; s/__$//;')
        v=${!k}
        echo "s|$p|$v|g" >> $sed_script
    done

    sed -f $sed_script $1
    ```

5. 运行上面脚本，生成zoo.cfg的配置：

    ```bash
    chmod +x $HOME/render_tpl.sh
    ~/render_tpl.sh zoo.cfg.tpl > /opt/zk/conf/zoo.cfg
    ```

#### 启动 Zookeeper

手动启动 Zookeeper:

```bash
cd /opt/zk/bin/ && ./zkServer.sh start
```

等待几秒后，验证 Zookeeper 是否启动正常：

```bash
echo stat | nc 10.0.0.1 2181
```

停止 Zookeeper：

```bash
cd /opt/zk/bin/ && ./zkServer.sh stop
```

将 Zookeeper纳入systemd托管的方法：

编辑文件：/etc/systemd/system/zk.service

```ini
[Unit]
Description=zookeeper.service
After=network-online.target

[Service]
Type=forking
Environment=ZOO_LOG_DIR=/var/log/zk
ExecStart=/opt/zk/bin/zkServer.sh start
ExecStop=/opt/zk/bin/zkServer.sh stop
ExecReload=/opt/zk/bin/zkServer.sh restart
PIDFile=/var/lib/zk/data/zookeeper_server.pid
LimitNOFILE=102400

[Install]
WantedBy=multi-user.target
```

- 启动 ZK: `systemctl start zk`
- 设置开机启动：`systemctl enable zk`

#### 安装 MongoDB

mongodb官方提供了rpm包下载，分别下载以下几个rpm：

```bash
wget https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.6/x86_64/RPMS/mongodb-org-server-3.6.11-1.el7.x86_64.rpm
wget https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.6/x86_64/RPMS/mongodb-org-tools-3.6.11-1.el7.x86_64.rpm
wget https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.6/x86_64/RPMS/mongodb-org-shell-3.6.11-1.el7.x86_64.rpm

```

使用RPM安装：

```bash
rpm -ivh mongodb-org-*.rpm
```

#### 配置 MongoDB

编辑配置文件模板：mongod.conf.tpl

```yaml
processManagement:
   fork: false
net:
   bindIp: 127.0.0.1,__LAN_IP__
   port: __MONGODB_PORT__
storage:
   dbPath: /var/lib/mongo
systemLog:
   destination: file
   path: /var/log/mongodb/mongod.log
   logAppend: true
storage:
   journal:
      enabled: true
replication:
   replSetName: rs0
security:
   keyFile: /var/lib/mongo/mongod.key
```

在/data/blueking.env中增加MONGODB_PORT这个变量：

```bash
MONGODB_PORT=27017
```

生成 /etc/mongod.conf配置：

```bash
~/render_tpl.sh mongod.conf.tpl  > /etc/mongod.conf
```

生成mongod.key:

```bash
openssl rand -base64 756 > /var/lib/mongo/mongod.key
chown mongod.mongod /var/lib/mongo/mongod.key
Chmod 400 /var/lib/mongo/mongod.key
```

#### 启动 MongoDB

配置好/etc/mongod.conf，生成key文件后，可以启动MongoDB实例。

编辑sytemctl配置：

```bash
mkdir /etc/systemd/system/mongod.service.d/
cat <<EOF > /etc/systemd/system/mongod.service.d/process.conf
[Service]
Type=simple
EOF
```

因为mongod.service自带的service定义是用daemon方式启动，我们mongod.conf中改为了前台进程启动，所以service定义需要修改。

```bash
systemctl daemon-reload # 重新加载
systemctl start mongod  # 启动进程
```

#### 初始化 MongoDB

1. 默认mongodb运行单实例模式，我们将它设置为ReplicaSet模式，方便今后扩展和高可用：

    ```bash
    mongo --eval 'rs.initiate( { _id: "rs0", members: [ { _id: 0, host: "10.0.0.1:27017" }] })'
    mongo --eval 'rs.status()' # 确认设置是否成功
    ```

2. 创建管理员角色。先确定管理员的用户名和密码，我们新增两个变量到/data/blueking.env

    ```bash
    MONGODB_USER=root
    MONGODB_PASS=Bluek34d
    ```

    创建超级管理员账号：

    ```bash
    source /data/blueking.env
    mongo --port $MONGODB_PORT <<END
    admin = db.getSiblingDB("admin")
    admin.createUser(
    {
      user: "$MONGODB_USER",
      pwd: "$MONGODB_PASS",
      roles: [ { role: "root", db: "admin" } ]
    }
    )
    END
    ```

3. 创建 CMDB 连接 mongodb 的账户和密码。蓝鲸产品我们遵循一个规则，使用bk_${module}作为用户名，对于cmdb模块，为bk_cmdb，密码使用$(uuid -v4)随机生成一个字符串。

    ```bash
    APP_CODE=bk_cmdb
    APP_TOKEN=$(uuid -v4)
    ```

    生成后，我们将app_code和app_token写入到/data/app.list文件中记录保存，方便后面使用。

    ```bash
    echo $APP_CODE $APP_TOKEN >> /data/app.list
    ```

    创建cmdb数据库的账号和密码并授权：

    ```bash
    mongo -u $MONGODB_USER -p $MONGODB_PASS --port $MONGODB_PORT --authenticationDatabase admin <<END
    use cmdb
    db.createUser( {user: "$APP_CODE",pwd: "$APP_TOKEN",roles: [ { role: "readWrite", db: "cmdb" } ]})
    END
    ```

#### 安装 cmdb

将cmdb的目录从PKG_SRC_PATH拷贝到INSTALL_PATH下：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/cmdb $INSTALL_PATH/
```

创建日志目录：

```bash
mkdir -p $INSTALL_PATH/logs/cmdb
```

#### 配置 cmdb

查看cmdb的配置文件模板的占位符，有哪些是空值的。这里我们继续优化之前的render_tpl.sh脚本，加入一个-c参数，表示检查模板里的占位符渲染后为空的并打印出来。

```bash
#!/bin/bash

set -a
source /data/blueking.env
set +a

trap 'rm -f $sed_script' EXIT TERM
sed_script=$(mktemp /tmp/XXXXXX.sed)

while getopts c arg; do
    case $arg in
        c) CHECK=1 ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

place_holders=$(cat $* | grep -wEo '__[0-9A-Z_]+__' | sort -u)

for p in $place_holders
do
    k=$(echo $p | sed 's/^__//; s/__$//;')
    v=${!k}
    [[ $CHECK -eq 1 ]] && [[ -z "$v" ]] && echo "EMPTY PLACE_HOLDER: $p"
    echo "s|$p|$v|g" >> $sed_script
done

sed -f $sed_script $*
```

查找cmdb模板中，还未配置的变量：

```bash
~/render_tpl.sh -c $PKG_SRC_PATH/cmdb/support-files/templates/*
EMPTY PLACE_HOLDER: __APP_CODE__
EMPTY PLACE_HOLDER: __APP_TOKEN__
EMPTY PLACE_HOLDER: __CMDB_ADMIN_PORT__
EMPTY PLACE_HOLDER: __CMDB_AUDIT_CTRL_PORT__
EMPTY PLACE_HOLDER: __CMDB_DATACOLLECTION_PORT__
EMPTY PLACE_HOLDER: __CMDB_EVENT_PORT__
EMPTY PLACE_HOLDER: __CMDB_HOST_CTRL_PORT__
EMPTY PLACE_HOLDER: __CMDB_HOST_PORT__
EMPTY PLACE_HOLDER: __CMDB_HTTPS_PORT__
EMPTY PLACE_HOLDER: __CMDB_NGXPROXY_PORT__
EMPTY PLACE_HOLDER: __CMDB_OBJECT_CTRL_PORT__
EMPTY PLACE_HOLDER: __CMDB_PROC_CTRL_PORT__
EMPTY PLACE_HOLDER: __CMDB_PROC_PORT__
EMPTY PLACE_HOLDER: __CMDB_TOPO_PORT__
EMPTY PLACE_HOLDER: __CMDB_WEB_PORT__
EMPTY PLACE_HOLDER: __MONGODB_HOST__
EMPTY PLACE_HOLDER: __MONGODB_IP0__
EMPTY PLACE_HOLDER: __NGINX_WORKER__
EMPTY PLACE_HOLDER: __REDIS01_IP0__
EMPTY PLACE_HOLDER: __ZK_HOST__
EMPTY PLACE_HOLDER: __ZK_IP0__
EMPTY PLACE_HOLDER: __ZK_IP1__
EMPTY PLACE_HOLDER: __ZK_IP2__
EMPTY PLACE_HOLDER: __ZK_PASS__
EMPTY PLACE_HOLDER: __ZK_USER__
```

所以我们需要补全这些信息到/data/blueking.env。

这时需要提到几个特殊的变量：

- `ZK_IP0` `ZK_IP1` `ZK_IP2`，因为默认模板是假设有三台节点的zk集群，我们部署的是单实例。所以这几个值都指向本机ip即可。

- `REDIS01_IP0`，这里是cmdb表示他们想用一个单独的redis实例，以区分其他组件用的REDIS实例（默认REDIS_IP），但为了简化部署，我们公用一个（公用并不影响功能）。所以它的取值也等于REDIS_IP
- `CMDB_*_PORT` 不再赘述，就是cmdb的诸多进程监听的端口，这里直接用默认值即可。
- `ZK_PASS` `ZK_USER 是用来解密gse在zk中的加密节点信息。
- `NGINX_WORKER` 表示nginx.conf中配置启动多少个nginx worker，auto表示使用cpu核数。

于是，增加以下变量到 /data/blueking.env

```bash
NGINX_WORKER=auto
REDIS01_IP0=10.0.0.1
ZK_USER=bkzk
ZK_PASS='bkzk321'
ZK_HOST=zk.service.consul
ZK_IP0=10.0.0.1
ZK_IP1=10.0.0.1
ZK_IP2=10.0.0.1
MONGODB_IP0=10.0.0.1
MONGODB_HOST=mongodb.service.consul
CMDB_HTTPS_PORT=80
CMDB_NGXPROXY_PORT=8029
CMDB_OBJECT_CTRL_PORT=31001
CMDB_HOST_CTRL_PORT=31002
CMDB_PROC_CTRL_PORT=31003
CMDB_AUDIT_CTRL_PORT=31004
CMDB_HOST_PORT=32001
CMDB_TOPO_PORT=32002
CMDB_PROC_PORT=32003
CMDB_ADMIN_PORT=32004
CMDB_EVENT_PORT=32005
CMDB_WEB_PORT=33083
CMDB_DATACOLLECTION_PORT=33084
```

而 APP_CODE 和 APP_TOKEN 占位符，不同模块安装时取值不同，所以没法写死在/data/blueking.env。所以我们可以动态用命令行参数传入，或者直接在渲染前export它们。这里为了统一，都使用命令行参数传入。继续改造下render_tpl.sh脚本，让它支持 -E key=value  这样的参数：

```bash
#!/bin/bash

set -a
source /data/blueking.env
set +a

trap 'rm -f $sed_script' EXIT TERM
sed_script=$(mktemp /tmp/XXXXXX.sed)

usage () { echo "Usage: $0 [-c] -m module [-E k=v, -E k=v] tpl_path" ; exit 0; }
vine_to_target_file () {
    local module=$1
    local tpl_file=${2##*/}

    if [ "${tpl_file:0:1}" != "#" ]; then
        if [ "${tpl%%#*}" == "$module" ]; then
            local _target_file=$INSTALL_PATH/${tpl_file//#//}
        else
            local _target_file=$INSTALL_PATH/$module/${tpl_file//#//};
        fi
    else
        local _target_file=$INSTALL_PATH/${tpl_file//#//};
    fi

    echo ${_target_file%.tpl}
}

DRY_RUN=0
CHECK=0
while getopts ncm:E: arg; do
    case $arg in
        n) DRY_RUN=1 ;;
        c) CHECK=1 ;;
        m) MODULE="$OPTARG" ;;
        E) EXTRA_ENV+=("$OPTARG") ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

# 载入额外变量
if [[ ${#EXTRA_ENV[@]} -ge 1 ]]; then
    set -a
    . <(printf "%s\n" "${EXTRA_ENV[@]}")
    set +a
fi

place_holders=$(cat $* | grep -wEo '__[0-9A-Z_]+__' | sort -u)

for p in $place_holders
do
    k=$(echo $p | sed 's/^__//; s/__$//;')
    v=${!k}
    [[ $CHECK -eq 1 ]] && [[ -z "$v" ]] && echo "EMPTY PLACE_HOLDER: $p"
        echo "s|$p|$v|g" >> $sed_script
done

# 仅检查变量
[[ $CHECK -eq 1 ]] && exit 0

for file in "$@"; do
    # 是否真正替换变量到目标路径
    if [[ $DRY_RUN -eq 0 ]]; then
        [[ -z "$MODULE" ]] && echo "模块名(module), -m 不能为空" && exit 1
        target_file=$(vine_to_target_file $MODULE $file)
        echo "render $file -> $target_file"
        mkdir -p ${target_file%/*}
        sed -f $sed_script $file > $target_file
    else
        sed -f $sed_script $file
    fi
done
```

接着使用如下命令来渲染模板：

```bash
~/render_tpl.sh -m cmdb \
    -E APP_CODE=bk_cmdb \
    -E APP_TOKEN=$(awk '$1 == "bk_cmdb" { print $NF}' /data/app.list) \
    $PKG_SRC_PATH/cmdb/support-files/templates/*
```

输出如下（省略部分）：

```bash
render #etc#admin.conf -> /data/bkce//etc/admin.conf
render #etc#nginx#cmdb_direct.conf -> /data/bkce//etc/nginx/cmdb_direct.conf
render #etc#nginx.conf -> /data/bkce//etc/nginx.conf
render #etc#supervisor-cmdb-server.conf -> /data/bkce//etc/supervisor-cmdb-server.conf
render server#conf#apiserver.conf -> /data/bkce/cmdb/server/conf/apiserver.conf
render server#conf#auditcontroller.conf -> /data/bkce/cmdb/server/conf/auditcontroller.conf
render server#conf#datacollection.conf -> /data/bkce/cmdb/server/conf/datacollection.conf
```

cmdb 也依赖 nginx 配置，具体细节可以参考 /data/bkce//etc/nginx/cmdb_direct.conf 这个文件。这个nginx配置的作用是做一些业务逻辑的rewrite规则来兼容新老版本的api。

另外，通过浏览器访问cmdb页面时，需要增加一个nginx的配置段，这个配置模板并不包含在cmdb的软件包内，这里单独提供如下，将以下内容保存到 $PKG_SRC_PATH/cmdb/support-files/templates/#etc#nginx#cmdb.conf

```nginx
upstream OPEN_CMDB{
        server __CMDB_IP0__:__CMDB_NGXPROXY_PORT__ weight=1;
}

server {
        listen __CMDB_HTTP_PORT__;
        server_name __CMDB_FQDN__;

        access_log /var/log/nginx/cmdb_fqdn_access.log  main;

        underscores_in_headers on;

        location / {
                proxy_pass http://OPEN_CMDB;
                proxy_pass_header Server;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_read_timeout 600;
        }

}

server {
        listen __CMDB_HTTP_PORT__ ;
        server_name __CMDB_HOST__;

        access_log  /var/log/nginx/cmdb_inner_access.log  main;

        underscores_in_headers on;

        location / {
                proxy_pass http://OPEN_CMDB;
                proxy_pass_header Server;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_read_timeout 600;
        }

}
```

这文件引入了一个新的变量，CMDB_IP0，也追加到 /data/blueking.env

```bash
CMDB_IP0=10.0.0.1
```

修改配置文件模板， $PKG_SRC_PATH/cmdb/support-files/templates/#etc#nginx#cmdb_direct.conf 统一nginx的日志路径：

```bash
sed -i '/access_log/s,__BK_HOME__/logs,/var/log,p' \
    $PKG_SRC_PATH/cmdb/support-files/templates/#etc#nginx#cmdb_direct.conf
```

重新渲染模板文件。然后将生成得 $INSTALL_PATH/etc/nginx/cmdb.conf 和 $INSTALL_PATH/etc/nginx/cmdb_direct.conf 拷贝到/etc/nginx/conf.d/下，重新加载 nginx

```bash
nginx -t
systemctl reload nginx
```

安装 PaaS 时我们编辑写入了 /etc/hosts 的方式来配置域名解析，CMDB也同样需要：

```bash
source /data/blueking.env
cat <<EOF >> /etc/hosts
$LAN_IP $CMDB_FQDN $CMDB_HOST $CMDB_DIRECT_HOST
$LAN_IP $MONGODB_HOST $ZK_HOST
EOF
```

#### 启动 cmdb {#TODO}

启动 cmdb：

```bash
supervisord -c $INSTALL_PATH/etc/supervisor-cmdb-server.conf
```

#### 初始化 cmdb

检查cmdb各进程是否都监听了端口，看监听端口数 >= 12即可

```bash
lsof -c cmdb_ | grep -c LISTEN
```

调用migrate接口初始化数据

```bash
source /data/blueking.env

curl  -X POST \
    -H 'Content-Type:application/json' \
    -H 'BK_USER:migrate' \
    -H 'HTTP_BLUEKING_SUPPLIER_ID:0' \
    "http://$LAN_IP:$CMDB_ADMIN_PORT/migrate/v3/migrate/enterprise/0"
```

返回success则初始化成功。

通过浏览器打开cmdb.bk.com测试是否正常（本机的hosts文件需要配置）

### 安装 GSE

安装 cmdb之后，安装job之前，我们需要安装gse后台服务，这样job平台才能有管控服务的接口。

GSE的依赖有zk, mongodb, redis，这几个组件都已经安装启动，但是还有一些配置需要调整。我们先安装gse，然后观察它们的配置文件占位符有哪些需要替换。

#### 安装 gse

将gse的目录从PKG_SRC_PATH拷贝到INSTALL_PATH下：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/gse $INSTALL_PATH/
```

拷贝证书目录：

```bash
rsync -a $PKG_SRC_PATH/cert $INSTALL_PATH/
```

#### 配置 gse

首先生成 APP_CODE 和 APP_TOKEN：

```bash
echo "bk_gse $(uuid -v4)" >> /data/app.list
```

再用模板渲染脚本检查哪些占位符为空：

```bash
~/render_tpl.sh -m gse \
    -E APP_CODE=bk_gse \
    -E APP_TOKEN=$(awk '$1 == "bk_gse" { print $NF}' /data/app.list) \
    -c $PKG_SRC_PATH/gse/support-files/templates/*
```

输出为：

```txt
EMPTY PLACE_HOLDER: __APP_CODE__
EMPTY PLACE_HOLDER: __APP_TOKEN__
EMPTY PLACE_HOLDER: __BIZ_ID__
EMPTY PLACE_HOLDER: __GSE_AGENT_HOME__
EMPTY PLACE_HOLDER: __GSE_IP1__
EMPTY PLACE_HOLDER: __GSE_SYNCDATA_PORT__
EMPTY PLACE_HOLDER: __GSE_TASK_APIV2_PORT__
EMPTY PLACE_HOLDER: __GSETASK_PORT__
EMPTY PLACE_HOLDER: __GSE_WAN_IP0__
EMPTY PLACE_HOLDER: __GSE_WAN_IP1__
EMPTY PLACE_HOLDER: __LOGS_HOME__
EMPTY PLACE_HOLDER: __WAN_IP__
```

- BIZ_ID 这个值默认为0。
- GSE_AGENT_HOME 默认为/usr/local/gse，可以修改，影响agent的部署路径。
- GSE_SYNCDATA_PORT GSE_TASK_APIV2_PORT 为进程监听端口，下面给出默认值。
- LOGS_HOME 其实等价于BK_HOME/logs/gse 存放gse的日志文件路径。我们使用 -E 参数来动态指定
- GSE_WAN_IP0 GSE_WAN_IP1 是gse服务所在机器的外网IP（安装跨云的proxy，proxy用这个ip取连接gse）
- WAN_IP 是配置btsvr的外网ip

这里我们不考虑跨云情况时，都保持和内网ip一致即可。

增加以下变量到 /data/blueking.env ：

```bash
BIZ_ID=0
GSE_AGENT_HOME="/usr/local/gse"
GSE_IP1=10.0.0.1
GSE_SYNCDATA_PORT=52050
GSE_TASK_APIV2_PORT=48673
GSETASK_PORT=48534
WAN_IP=10.0.0.1
GSE_WAN_IP0=10.0.0.1
GSE_WAN_IP1=10.0.0.1
```

渲染模板：

```bash
~/render_tpl.sh  -m gse \
    -E LOGS_HOME=/data/bkce/logs/gse -E APP_CODE=bk_gse \
    -E APP_TOKEN=$(awk '$1 == "bk_gse" { print $NF}' /data/app.list) \
    /data/src/gse/support-files/templates/*
```

其中 APP_CODE APP_TOKEN的占位符在 $INSTALL_PATH/etc/gse/procmgr.conf配置中使用。
作为 gse_procmgr 进程连接 mongodb 使用的用户名和密码。所以需要在 mongodb 中给gse用户授权。

```bash
APP_CODE=bk_gse
APP_TOKEN=$(awk '$1 == "bk_gse" { print $NF}' /data/app.list)
source /data/blueking.env
mongo -u $MONGODB_USER -p $MONGODB_PASS --port $MONGODB_PORT --authenticationDatabase admin <<END
use gse
db.createUser( {user: "$APP_CODE",pwd: "$APP_TOKEN",roles: [ { role: "readWrite", db: "gse" } ]})
END
```

#### 初始化 gse

启动 gse 进程之前，还需要在zookeeper中初始化一些配置信息。这些信息由gse包中的一个shell脚本提供：
`$INSTALL_PATH/gse/server/bin/on_migrate`

我们对它稍作修改，适应本文档的手动部署方式：

将第五行的 `. $CTRL_DIR/utils.fc` 修改为 `. /data/blueking.env`

然后运行 `bash $INSTALL_PATH/gse/server/bin/on_migrate`

忽略输出中提示的`log` 命令找不到的报错。

该初始化脚本主要是写入gse集群的一些配置信息，和后面bkdata模块会用到的相关配置信息。

#### 启动 gse

启动gse的服务, 我们使用systemd托管：
首先生成gse的service服务定义：

```bash
#!/bin/bash

source /data/blueking.env
cd $INSTALL_PATH/gse/server/bin
for cmd in gse_*; do
    short_cmd=${cmd#gse_}
    cat <<EOF > /etc/systemd/system/gse.${short_cmd}.service
[Unit]
Description=GSE($cmd) Service
After=network-online.target
PartOf=gse.target

[Service]
Type=forking
ExecStart=$INSTALL_PATH/gse/server/bin/gsectl start ${short_cmd}
ExecStop=$INSTALL_PATH/gse/server/bin/gsectl stop ${short_cmd}
Restart=on-failure
LimitNOFILE=102400

[Install]
WantedBy=gse.target
EOF
done

cat <<EOF > /etc/systemd/system/gse.target
[Unit]
Description=Gse target to allow start/stop all gse.*.service at once
[Install]
WantedBy=multi-user.target
EOF
```

然后启动服务：

```bash
cd /etc/systemd/system/ && systemctl enable gse.*
systemctl start gse.dba
systemctl start gse.*
```

gse.dba服务比较特殊，需要先启动起来。然后启动其他gse后台进程。

#### 生成 gse_agent 的安装包

上面部署启动gse的服务端后台进程后，可以安装gse的客户端，也就是gse agent
首先我们要打包生成gse的客户端包，方便后续分发安装需要管控的节点。

gse agent 跟随着gse的后台包一起提供(位于$PKG_SRC_PATH/gse/下），它们存放的目录按照
角色_平台_cpu架构，三个要素组成的名字来命名。

- 角色分为：client,proxy,plugins
- 平台分为: linux,windows,aix
- cpu架构有：x86,x86_64,powerpc

其中proxy角色只能部署在linux的x86_64上，故目录直接叫做proxy

这里我们仅以打包linux x86_64和windows x86_64为例介绍，其他平台类似：

打包 Linux x86_64 的gse agent包：

```bash
source /data/blueking.env
tmpdir=$(mktemp -d); cd $tmpdir # 新建一个临时目录并进入
cp -a $INSTALL_PATH/gse/agent_linux_x86_64 agent  # 拷贝agent二进制
cp -a $INSTALL_PATH/gse/plugins_linux_x86_64 plugins #拷贝插件二进制
cp -a $INSTALL_PATH/cert/* agent/cert #拷贝证书文件

tar czf $HOME/gse_client-linux-x86_64.tgz agent plugins #打包
rm -rf $tmpdir #删除临时目录
```

打包 windows x86_64 的 gse agent包：

```bash
source /data/blueking.env
tmpdir=$(mktemp -d); cd $tmpdir # 新建一个临时目录并进入
cp -a $INSTALL_PATH/gse/agent_win_x86_64 gseagentw/  # 拷贝agent二进制
cp -a $INSTALL_PATH/gse/plugins_windows_x86_64 plugins #拷贝插件二进制
cp -a $INSTALL_PATH/cert/* gseagentw/cert #拷贝证书文件

tar czf $HOME/gse_client-windows-x86_64.tgz gseagentw plugins #打包
rm -rf $tmpdir #删除临时目录
```

我们得到的 $HOME/gse_client*.tgz 先放在这。后面用到的时候再提到如何安装它们。

### 安装 Job

我们开始安装作业平台Job，Job新增了一个开源组件依赖rabbitmq。

#### 安装 RabbitMQ

rabbitmq 组件通过 yum 可以直接安装：

```bash
yum -y install rabbitmq-server
```

需要注意的是，蓝鲸依赖的rabbitmq必须是3.0以上，支持web management的插件。

安装后，我们先开启管理插件：

```bash
rabbitmq-plugins enable rabbitmq_management
```

启动rabbitmq，并设置开机启动：

```bash
systemctl start rabbitmq-server
systemctl status rabbitmq-server
systemctl enable rabbitmq-server
```

rabbitmq开启管理插件后，需要给它设定一个带鉴权的管理员账号
我们将这对账户密码写入/data/blueking.env如下：

```bash
MQ_USER=admin
MQ_PASS=blueking
```

增加管理账户：

```bash
source /data/blueking.env
rabbitmqctl add_user "$MQ_USER" "$MQ_PASS"
rabbitmqctl set_user_tags $MQ_USER administrator
```

删除默认的guest用户：

```bash
rabbitmqctl delete_user guest
```

#### 安装 job

将job的目录从PKG_SRC_PATH拷贝到INSTALL_PATH下：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/job $INSTALL_PATH/
```

拷贝证书目录：

```bash
rsync -a $PKG_SRC_PATH/cert $INSTALL_PATH/
```

#### 配置 job

给job生成 APP_CODE APP_TOKEN 用于调用esb接口:

```bash
APP_CODE=bk_job
APP_TOKEN=$(uuid -v4)
echo $APP_CODE $APP_TOKEN >> /data/app.list
```

生成后，将APP_CODE和APP_TOKEN写入到/data/app.list文件中记录保存，方便后面模板渲染使用。

job依赖rabbitmq做消息队列，使用独立的vhost，蓝鲸内部约定使用APP_CODE来作为rabbitmq vhost的名称
APP_CODE:APP_TOKEN用作rabbitmq vhost的用户名和密码，所以配置job使用的rabbitmq vhost相关：

```bash
APP_CODE=bk_job
APP_TOKEN=$(awk '/bk_job/ { print $NF}' /data/app.list )
rabbitmqctl add_user $APP_CODE $APP_TOKEN
rabbitmqctl set_user_tags  $APP_CODE management
rabbitmqctl add_vhost $APP_CODE
rabbitmqctl set_permissions -p $APP_CODE $APP_CODE ".*" ".*" ".*"
```

用模板渲染脚本检查变量：

```bash
~/render_tpl.sh -c -m job \
    -E APP_CODE=bk_job -E APP_TOKEN=$(awk '/bk_job/ { print $NF}' /data/app.list ) \
    $PKG_SRC_PATH/job/support-files/templates/*
EMPTY PLACE_HOLDER: __GSE_KEYTOOL_PASS__
EMPTY PLACE_HOLDER: __JOB_HTTPS_PORT__
EMPTY PLACE_HOLDER: __JOB_KEYTOOL_PASS__
EMPTY PLACE_HOLDER: __JOB_NGXPROXY_PORT__
EMPTY PLACE_HOLDER: __LICENSE_HOST__
EMPTY PLACE_HOLDER: __LICENSE_PORT__
EMPTY PLACE_HOLDER: __PAAS_IP1__
EMPTY PLACE_HOLDER: __RABBITMQ_ADMIN_PORT__
EMPTY PLACE_HOLDER: __RABBITMQ_DIST_PORT__
EMPTY PLACE_HOLDER: __RABBITMQ_HOST__
EMPTY PLACE_HOLDER: __RABBITMQ_PORT__
EMPTY PLACE_HOLDER: __REDIS_CLUSTER_HOST__
EMPTY PLACE_HOLDER: __REDIS_CLUSTER_PORT__
```

RABBITMQ_开头的，我们可以先补全，均为rabbitmq的默认监听端口值：

```bash
RABBITMQ_ADMIN_PORT=25672
RABBITMQ_DIST_PORT=15672
RABBITMQ_PORT=5672
RABBITMQ_HOST=rabbitmq.service.consul
REDIS_CLUSTER_HOST=redis_cluster.service.consul
REDIS_CLUSTER_PORT=16379
```

> 注：REDIS_CLUSTER_HOST和REDIS_CLUSTER_PORT是企业版使用，社区版这里不会用到，不过为了配置文件完整，补全这两个变量。

```bash
JOB_NGXPROXY_PORT=8008  # 这个端口是job监听的，被nginx反向代理的web端口。
JOB_HTTPS_PORT=80       # JOb对外提供服务的nginx监听端口，默认80
```

KEYTOOL_PASS这2个值，从/data/src/blueking.env中拷贝填入。它们是默认生成job 启动需要的keystore文件用的密码。

```bash
JOB_KEYTOOL_PASS=
GSE_KEYTOOL_PASS=
```

license是证书服务器，也是job依赖的组件。它是一个使用https的接口服务，用来鉴权证书是否合法。我们先写上它的默认值。

```bash
LICENSE_HOST=license.service.consul
LICENSE_PORT=8443
```

补全完 /data/blueking.env 文件后，可以真正渲染模板配置：

```bash
~/render_tpl.sh -m job \
    -E APP_CODE=bk_job -E APP_TOKEN=$(awk '/bk_job/ { print $NF}' /data/app.list ) \
    $PKG_SRC_PATH/job/support-files/templates/*
render /data/src/job/support-files/templates/#etc#job.conf -> /data/bkce//etc/job.conf
render /data/src/job/support-files/templates/job#bin#job.sh -> /data/bkce/job/job/bin/job.sh
```

刚才提到了证书服务（license）模块，这里插入下它的部署，因为非常简单就不单独成章节了：

- 安装 license

    ```bash
    rsync -a  --exclude=support-files $PKG_SRC_PATH/license $INSTALL_PATH/
    rsync -a  --exclude=support-files $PKG_SRC_PATH/cert $INSTALL_PATH/
    ```

- 创建日志目录

    ```bash
    mkdir -p $INSTALL_PATH/logs/license
    ```

- 渲染模板

    ```bash
    ~/render_tpl.sh -m license -E LOGS_HOME=$INSTALL_PATH/logs/license \
    $PKG_SRC_PATH/license/support-files/templates/*
    render /data/src/license/support-files/templates/#etc#license.json -> /data/bkce//etc/license.json
    ```

- 配置 license 的systemd service unit定义: /etc/systemd/system/license.service

    ```ini
    [Unit]
    Description="Blueking License Server"
    Requires=network-online.target
    After=network-online.target
    ConditionFileNotEmpty=/data/bkce/etc/license.json

    [Service]
    User=root
    Group=root
    ExecStart=/data/bkce/license/license/bin/license_server -config /data/bkce/etc/license.json
    KillMode=process
    Restart=on-failure
    LimitNOFILE=102400

    [Install]
    WantedBy=multi-user.target
    ```

- 启动 license

    ```bash
    systemctl start license
    ```

启动成功后的，license，rabbitmq，我们使用域名方式访问，所以写入/etc/hosts，以下项目：

```txt
10.0.1.1 rabbitmq.service.consul license.service.consul
```

配置job的最后一步是，生成需要的证书keystore和truststore文件：

```bash
source /data/blueking.env
cd $INSTALL_PATH/cert/
keytool -importkeystore -v -srckeystore gse_job_api_client.p12 -srcstoretype pkcs12 -destkeystore gse_job_api_client.keystore -deststoretype jks -srcstorepass "$GSE_KEYTOOL_PASS" -deststorepass "$GSE_KEYTOOL_PASS" -noprompt

keytool -importkeystore -v -srckeystore job_server.p12 -srcstoretype pkcs12 -destkeystore job_server.keystore -deststoretype jks -srcstorepass "$JOB_KEYTOOL_PASS" -deststorepass "$JOB_KEYTOOL_PASS" -noprompt;

keytool -keystore gse_job_api_client.truststore -alias ca -import -trustcacerts -file gseca.crt -storepass "$GSE_KEYTOOL_PASS" -noprompt;

keytool -keystore job_server.truststore -alias ca -import -trustcacerts -file job_ca.crt -storepass "$JOB_KEYTOOL_PASS" -noprompt;
```

#### 初始化 job

导入job的sql文件，初始化数据库:

```bash
source /data/blueking.env
for sql in $PKG_SRC_PATH/job/support-files/sql/*.sql
do
    mysql -u$MYSQL_USER -p$MYSQL_PASS < $sql
done
```

> 注：job在启动时还会自己根据记录初始化一些库表结构。

#### 启动 job

配置job的service unit定义： /etc/systemd/system/job.service

```ini
[Unit]
Description=job.service
After=network-online.target
[Service]
Type=forking
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/root/bin
Environment=JAVA_HOME=/usr/lib/jvm/java
ExecStart=/data/bkce/job/job/bin/job.sh start
ExecStop=/data/bkce/job/job/bin/job.sh stop
LimitNOFILE=102400
[Install]
WantedBy=multi-user.target
```

启动job：

```bash
systemctl start job
```

job启动后，我们可以直接访问还需要设置一个nginx反向代理和cmdb，paas同理。

编辑配置模板：job.conf.tpl

```nginx
upstream OPEN_JOB {
    server __JOB_IP0__:__JOB_NGXPROXY_PORT__ max_fails=1  fail_timeout=30s;
}

server {
        listen __JOB_HTTP_PORT__;
        server_name __JOB_FQDN__;

        access_log /var/log/nginx/job_fqdn_access.log main;

        location / {
            #internal;
            proxy_pass http://OPEN_JOB;
            proxy_pass_header Server;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_read_timeout 600;
        }
}

server {
        listen __JOB_HTTP_PORT__;
        server_name __JOB_HOST__;

        access_log /var/log/nginx/job_inner_access.log main;

        location / {
            #internal;
            proxy_pass http://OPEN_JOB;
            proxy_pass_header Server;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_read_timeout 600;
        }
}
```

检查变量替换：

```bash
~/render_tpl.sh -c -m job job.conf.tpl
EMPTY PLACE_HOLDER: __JOB_HOST__
EMPTY PLACE_HOLDER: __JOB_HTTP_PORT__
EMPTY PLACE_HOLDER: __JOB_IP0__
```

于是往 /data/blueking.env 里增加以下变量：

```bash
JOB_HOST=job.service.consul
JOB_HTTP_PORT=80
JOB_IP0=10.0.0.1
```

进行真实的替换：

```bash
~/render_tpl.sh -n -m job job.conf.tpl  > /etc/nginx/conf.d/job.conf
```

让 Nginx 生效：

```bash
nginx -t
systemctl reload nginx
```

在Linux机器上/etc/hosts里增加相关的域名：

```txt
10.0.0.1 job.bk.com job.service.consul job-direct.service.consul
```

在客户端机器上（chrome浏览器所在机器）的hosts文件，也配置job.bk.com这些域名:

```txt
10.0.0.1 job.bk.com paas.bk.com cmdb.bk.com
```

这时，通过浏览器访问 job.bk.com，会发现输入用户名和密码后还是跳回到登录界面。

我们查看open_paas的日志

```bash
cd $INSTALL_PATH/logs/open_paas/ && tail -f *
```

然后浏览器页面触发一下登录，发现esb的日志有滚动一个错误：

```json
{"req_message": "Invalid APP Code [bk_app_code=bk_job], please confirm if the APP Code has been registered"
```

这是由于不是从PaaS平台创建的SaaS应用，分配的app_code，paas平台是不会默认识别的。所以需要手动添加到paas的某个表中：

```bash
app_code=bk_job
app_token=$(awk '/bk_job/ { print $NF }' /data/app.list )
app_desc=job
tstr="$(date +%Y-%m-%d\ %H:%M:%S)"
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "insert into esb_app_account values ('', '$app_code', '$app_token', '$app_desc', '$tstr')"
```

接着，由于bk_job后台调用esb某些接口时，没有用户登陆态和token，所以需要加入免验证登陆的白名单：

```bash
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "update esb_function_controller set wlist=concat(wlist, ',$app_code')"
```

### 安装 PaaS Agent

#### 安装 paas_agent

paas_agent是，蓝鲸应用引擎Agent，golang编写。现已开源：[bk-paas](https://github.com/tencent/bk-paas)

安装程序包

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/paas_agent $INSTALL_PATH/
rsync -a $PKG_SRC_PATH/cert $INSTALL_PATH/
rsync -a $PKG_SRC_PATH/paas_agent/support-files/pkgs $INSTALL_PATH/paas_agent/support-files/
```

安装yum包依赖:

```bash
yum -y install mysql-devel gcc libevent-devel git svn nfs-utils
```

添加apps用户：

```bash
useradd -d $INSTALL_PATH/paas_agent apps
```

安装python虚拟环境(paas_agent):

```bash
mkvirtualenv -a $INSTALL_PATH/paas_agent/paas_agent paas_agent
workon paas_agent
pip install -r requirements.txt \
            --no-cache --no-index \
            --find-links=$INSTALL_PATH/paas_agent/support-files/pkgs
```

#### 配置 paas_agent

渲染模板：

```bash
~/render_tpl.sh -c -m paas_agent -E LOGS_HOME=$INSTALL_PATH/logs/paas_agent $PKG_SRC_PATH/paas_agent/support-files/templates/*
EMPTY PLACE_HOLDER: __APPO_HOST__
EMPTY PLACE_HOLDER: __PAAS_AGENT_PORT__
EMPTY PLACE_HOLDER: __SID__
EMPTY PLACE_HOLDER: __TOKEN__
```

添加到 /data/blueking.env:

```bash
APPO_HOST=appo.service.consul
PAAS_AGENT_PORT=4245
```

SID和TOKEN需要动态地从paas接口返回里获取，无法直接渲染。所以这两个配置会为空

```bash
~/render_tpl.sh -m paas_agent -E LOGS_HOME=$INSTALL_PATH/logs/paas_agent $PKG_SRC_PATH/paas_agent/support-files/templates/*
```

paas_agent目前读取的配置文件路径是固定的需要做一个软链接：

```bash
ln -sf $INSTALL_PATH/etc/paas_agent_config.yaml $INSTALL_PATH/paas_agent/paas_agent/etc/paas_agent_config.yaml
```

为了获取SID和TOKEN，我们需要调用paas的注册agent接口，

这里以正式环境为例：

```bash
source /data/blueking.env
mode=prod (注意:测试环境就需要设置为mode=test)
curl --connect-timeout 10 -s \
        -H 'Content-Type:application/x-www-form-urlencoded' \
        -X POST \
        -d "agent_ip=$LAN_IP&mode=prod&agent_port=4245&web_port=$APP_NGXPROXY_PORT" \
        "http://$PAAS_IP0:8000/v1/agent/init/"
```

如果注册成功返回的日志里token和sid的值，将这两个值填入$INSTALL_PATH/etc/paas_agent_config.yaml中

#### 启动 paas agent

编辑启动service文件： /etc/systemd/system/paasagent.service

```ini
[Unit]
Description=BlueKing PaaS agent Server
After=network-online.target

[Service]
WorkingDirectory=/data/bkce/paas_agent/paas_agent
Environment=PATH="/data/bkce/.envs/paas_agent/bin"
ExecStart=/data/bkce/paas_agent/paas_agent/bin/paas_agent
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

启动paas agent:

```bash
systemctl start paasagent
```

启动paas_agent后，还需要调用paas激活接口，来正式启动这个agent的环境。

```bash
source /data/blueking.env
NGINX_IP=10.0.0.1 # 注意这里换成你的nginx监听的ip地址
curl -s -X GET -H "Host: $PAAS_HOST" "http://$NGINX_IP:$PAAS_HTTP_PORT/v1/agent/init/?agent_ip=$LAN_IP"
```

接口返回为{"agent_ip": "$LAN_IP"} 则成功

由于大多数蓝鲸SaaS都需要使用celery，celery依赖rabbitmq队列，所以paas需要知道这个环境可以使用的rabbitmq的集群管理员信息。paas在上下架启用了celery功能的saas时，会自动申请mq的vhost，分配账号密码等操作。

注册激活rabbitmq集群信息：

```bash
    curl  --connect-timeout 10 \
        -H 'Content-Type:application/x-www-form-urlencoded' \
        -X POST \
        -d "mq_ip=$RABBITMQ_HOST&username=$MQ_USER&password=$MQ_PASS" \
        "http://$PAAS_IP0:8000/v1/rabbitmq/init/"
```

paas agent分正式环境和测试环境，上文以正式环境为例。测试环境除了注册paas_agent的接口时 mode=test，其他安装，启动方法并没有任何区别。

### 安装 BKDATA

bkdata分为dataapi，databus和monitor（蓝鲸监控后台）三个模块

- databus依赖存储：kafka, elasticsearch, influxdb
- monitor依赖 beanstalk

所以我们先安装这些基础依赖

#### 安装 Kafka

1. 下载安装包（蓝鲸目前使用0.10.2.x系列）：

    ```bash
    wget https://archive.apache.org/dist/kafka/0.10.2.2/kafka_2.11-0.10.2.2.tgz
    ```

2. 解压到/opt下：

    ```bash
    tar -xf kafka_2.11-0.10.2.2.tgz -C /opt; mv /opt/kafka_2.11-0.10.2.2 /opt/kafka
    ```

3. 编辑/opt/kafka/config/server.properties，记得替换IP地址:

    ```txt
    broker.id=1
    listeners=PLAINTEXT://10.0.0.1:9092
    port=9092
    num.network.threads=4
    num.io.threads=4
    socket.send.buffer.bytes=102400
    socket.receive.buffer.bytes=102400
    socket.request.max.bytes=104857600
    log.dirs=/var/lib/kafka/
    default.replication.factor=1
    num.partitions=1
    num.recovery.threads.per.data.dir=1
    log.retention.hours=168
    log.segment.bytes=1073741824
    log.retention.check.interval.ms=300000
    zookeeper.connect=10.0.0.1:2181/common_kafka
    zookeeper.connection.timeout.ms=6000
    delete.topic.enable=true
    ```

4. 编辑 /etc/systemd/system/kafka.service

    ```ini
    [Unit]
    Description=Apache Kafka server (broker)
    Documentation=http://kafka.apache.org/documentation.html
    Requires=network.target remote-fs.target
    After=network.target zk.service

    [Service]
    Type=simple
    Environment=JAVA_HOME=/usr/lib/jvm/java
    ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
    ExecStop=/opt/kafka/bin/kafka-server-stop.sh

    [Install]
    WantedBy=multi-user.target
    ```

5. 创建数据目录

    ```bash
    mkdir /var/lib/kafka
    ```

6. 启动kafka

    ```bash
    systemctl start kafka
    ```

#### 安装 elasticsearch

1. 下载安装包：

    ```bash
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.tar.gz
    ```

2. 解压elasticsearch：

    ```bash
    tar -xf elasticsearch-5.4.0.tar.gz -C /opt/ && mv /opt/elasticsearch-5.4.0 /opt/elasticsearch
    ```

3. 编辑/opt/elasticsearch/config/elasticsearch.yml文件：

    ```yaml
    cluster.name: bkee-es
    node.name: es-1
    node.attr.tag: cold
    path.data: /var/lib/es
    path.logs: /var/log/es
    bootstrap.memory_lock: false
    bootstrap.system_call_filter: false
    network.host: "10.0.0.1"
    http.port: 10004
    transport.tcp.port: 9300
    thread_pool.search.size: 1000
    thread_pool.search.queue_size: 1000
    thread_pool.bulk.queue_size: 1000
    cluster.routing.allocation.same_shard.host: true
    ```

4. 创建es用户和目录：

    ```bash
    useradd -m es
    install -o es -g es -d /var/{run,lib,log}/es
    ```

5. 修改属性：

    ```bash
    chown es.es -R /opt/elasticsearch/
    ```

6. 编辑systemd文件 /etc/systemd/system/es.service：

    ```ini
    [Unit]
    Description=Elasticsearch
    Documentation=http://www.elastic.co
    Wants=network-online.target
    After=network-online.target

    [Service]
    Environment=ES_HOME=/opt/elasticsearch
    Environment=CONF_FILE=/opt/elasticsearch/config/elasticsearch.yml
    Environment=JAVA_HOME=/usr/lib/jvm/java
    Environment=LOGS_HOME=/var/log/es
    User=es
    Group=es
    ExecStart=/opt/elasticsearch/bin/elasticsearch -p /var/run/es/es.pid

    # Connects standard output to /dev/null
    StandardOutput=null
    # Connects standard error to journal
    StandardError=journal
    # When a JVM receives a SIGTERM signal it exits with code 143
    SuccessExitStatus=143
    LimitNOFILE=102400
    # Shutdown delay in seconds, before process is tried to be killed with KILL (if configured)
    TimeoutStopSec=20

    [Install]
    WantedBy=multi-user.target
    ```

7. 启动es:

    ```bash
    systemctl start es
    ```

### 安装 beanstalkd

beanstalkd 在EPEL源里存在，可以直接yum安装启动：

```bash
yum install beanstalkd
systemctl start beanstalkd
```

### 安装 influxdb

官方给的文档通过添加仓库后:

```bash
cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

通过yum安装启动：

```bash
yum install influxdb
systemctl start influxdb
```

也可以直接根据仓库地址，找到对应的influxdb rpm包后，通过rpm安装。

#### 安装 bkdata

将bkdata的目录从PKG_SRC_PATH拷贝到INSTALL_PATH下：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/bkdata $INSTALL_PATH/
rsync -a $PKG_SRC_PATH/cert $INSTALL_PATH/
```

安装编译依赖包：

```bash
yum install -y openssl-devel ncurses-devel mysql-devel python-devel gcc gcc-c++ make cmake bison-devel ncurses-devel pcre-devel readline-devel snappy-devel patch snappy snappy-devel
```

安装虚拟环境(dataapi):

```bash
mkvirtualenv -a $INSTALL_PATH/bkdata/dataapi dataapi
workon dataapi
pip install -r requirements.txt \
    --no-cache --no-index \
    --find-links=/data/src/bkdata/support-files/pkgs
```

同理，安装虚拟环境(monitor)：

```bash
mkvirtualenv -a $INSTALL_PATH/bkdata/monitor monitor
workon monitor
pip install -r requirements.txt \
    --no-cache --no-index \
    --find-links=/data/src/bkdata/support-files/pkgs
```

### 配置 bkdata

生成 APP_CODE和 APP_TOKEN

```bash
APP_CODE=bk_bkdata
APP_TOKEN=$(uuid -v4)
echo "$APP_CODE $APP_TOKEN" >> /data/app.list
```

检查模板变量渲染：

```bash
source /data/blueking.env
~/render_tpl.sh -c -m bkdata -E APP_CODE=bk_bkdata \
    -E APP_TOKEN=$(awk '/bk_bkdata/ { print $NF}' /data/app.list) \
    -E MODULE_HOME=$INSTALL_PATH/bkdata -E MODULE_NAME=bkdata \
    -E LOGS_HOME=$INSTALL_PATH/logs/bkdata \
    /data/src/bkdata/support-files/templates/*
```

这里会输出大量的为空的变量，限于篇幅，不粘贴了。

直接给出需要补全的默认值：追加到/data/blueking.env中：

```bash
# 监控用的
WEBSERVER_PORT=10041
APISERVER_PORT=10042
JOBSERVER_PORT=10043
CISERVER_PORT=10044
MONITOR_KERNELAPI_PORT=10045

# dataapi databus
CONNECTOR_ES_PORT=10050
CONNECTOR_MYSQL_PORT=10051
CONNECTOR_ETL_PORT=10052
CONNECTOR_REDIS_PORT=10053
CONNECTOR_TSDB_PORT=10054
CONNECTOR_HDFS_PORT=10055
CONNECTOR_OFFLINE_PORT=10056

DATABUS_ES_PORT=10050
DATABUS_MYSQL_PORT=10051
DATABUS_ETL_PORT=10052
DATABUS_REDIS_PORT=10053
DATABUS_TSDB_PORT=10054
DATABUS_HDFS_PORT=10055
DATABUS_OFFLINE_PORT=10056

DATABUS_ES_HOST=databus.service.consul
DATABUS_ETL_HOST=databus.service.consul
DATABUS_HDFS_HOST=databus.service.consul
DATABUS_MYSQL_HOST=databus.service.consul
DATABUS_OFFLINE_HOST=databus.service.consul
DATABUS_REDIS_HOST=databus.service.consul
DATABUS_TSDB_HOST=databus.service.consul

DJANGO_SECRET_KEY=$(uuid -v4)
ESB_SUPER_USER=admin
ES_HOST=es.service.consul
ES_REST_PORT=10004
ES_TRANSPORT_PORT=9300
JAVA_HOME=/usr/lib/jvm/java
GSE_WIN_AGENT_HOME="C:\gse"
INFLUXDB_HOST=influxdb.service.consul
INFLUXDB_PORT=5260
KAFKA_HOST=kafka.service.consul
KAFKA_PORT=9092
MYSQL01_IP0=10.0.0.1
```

> 注: JAVA_HOME根据实际填写。IP地址相关的修改为本机的内网IP地址

重新校验：

```bash
source /data/blueking.env
~/render_tpl.sh -c -m bkdata -E APP_CODE=bk_bkdata \
    -E APP_TOKEN=$(awk '/bk_bkdata/ { print $NF}' /data/app.list) \
    -E MODULE_HOME=$INSTALL_PATH/bkdata -E MODULE_NAME=bkdata \
    -E LOGS_HOME=$INSTALL_PATH/logs/bkdata \
    /data/src/bkdata/support-files/templates/*
```

将bk_bkdata加入esb白名单：

```bash
app_code=bk_bkdata
app_token=$(awk '/bk_bkdata/ { print $NF }' /data/app.list )
app_desc=bkdata
tstr="$(date +%Y-%m-%d\ %H:%M:%S)"
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "insert into esb_app_account values ('', '$app_code', '$app_token', '$app_desc', '$tstr')"
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "update esb_function_controller set wlist=concat(wlist, ',$app_code')"
```

去掉 ~/render_tpl.sh 的 **-c** 参数将文件渲染。

#### 初始化 bkdata

接下来初始化数据库和表结构：

1. 创建数据库：

    ```bash
    source /data/blueking.env
    for sql in $PKG_SRC_PATH/bkdata/support-files/sql/*.sql
    do  
        mysql -u$MYSQL_USER -p$MYSQL_PASS <$sql
    done
    ```

2. 初始化dataapi：

    a. 切换到dataapi虚拟环境：

    ```bash
    set -a
    source /data/blueking.env
    set +a
    workon dataapi
    ```

    b. 初始化 zk 数据：

    ```bash
    python -m databus.script.zk
    ```

    b. 初始化 kafka 数据：

    ```bash
    python -m databus.script.kafka
    ```

    d. 初始化 mysql的数据表定义

    ```bash
    python manage.py migrate trt --database=trt
    ```

    e.  初始化预置的dataapi信息

    ```bash
    python manage.py test databus.tests.DatabusHealthTestCase.update_reserved_dataid  --settings='pizza.settings_no_db'
    python -m databus.script.dataid
    ```

启动bkdata之前有一个初始化快照数据（基础性能数据）的dataid和databus任务等流程。

它需要先让databus启动：

```bash
supervisord -c /data/bkce/etc/supervisor-bkdata-databus.conf
```

在/etc/hosts里添加域名解析，dataapi是通过databus.service.consul来访问databus接口：

```bash
10.0.0.1 databus.service.consul
```

dataapi需要使用celery，在rabbitmq里添加vhost和对应账号权限：

```bash
APP_CODE=bk_bkdata
APP_TOKEN=$(awk '/bk_bkdata/ { print $2 }' /data/app.list)
rabbitmqctl add_user $APP_CODE $APP_TOKEN
rabbitmqctl set_user_tags  $APP_CODE management
rabbitmqctl add_vhost $APP_CODE
rabbitmqctl set_permissions -p $APP_CODE $APP_CODE ".*" ".*" ".*"
```

启动dataapi：

```bash
supervisord -c /data/bkce/etc/supervisor-bkdata-dataapi.conf
```

初始化快照数据:

```bash
workon dataapi
python -u manage.py test databus.tests.DatabusHealthTestCase.init_snapshot_config  --settings='pizza.settings_no_db'
```

最后启动monitor后台进程：

```bash
workon monitor
supervisord -c /data/bkce/etc/supervisor-bkdata-monitor.conf
```

### 安装 FTA

fta是故障自愈SaaS的后台程序

将fta的目录从 PKG_SRC_PATH 拷贝到 INSTALL_PATH 下：

```bash
rsync -a --exclude=support-files $PKG_SRC_PATH/fta $INSTALL_PATH/
rsync -a $PKG_SRC_PATH/cert $INSTALL_PATH/
```

安装yum包依赖：

```bash
yum -y install mysql-devel gcc libevent-devel patch
```

安装虚拟环境(fta):

```bash
mkvirtualenv -a $INSTALL_PATH/fta/fta fta
workon fta
pip install -r requirements.txt \
    --no-cache --no-index \
    --find-links=/data/src/fta/support-files/pkgs
```

生成 appcode 和 apptoken

```bash
app_code=bk_fta
app_token=$(uuid -v4)
echo $app_code $app_token >> /data/app.list
```

在rabbitmq里创建vhost和账户

```bash
APP_CODE=bk_fta
APP_TOKEN=$(awk '/bk_fta/ { print $2 }' /data/app.list)
rabbitmqctl add_user $APP_CODE $APP_TOKEN
rabbitmqctl set_user_tags  $APP_CODE management
rabbitmqctl add_vhost $APP_CODE
rabbitmqctl set_permissions -p $APP_CODE $APP_CODE ".*" ".*" ".*"
```

在esb表里，添加后台调用白名单：

```bash
source /data/blueking.env
app_code=bk_fta
app_token=$(awk '/bk_fta/ { print $NF }' /data/app.list )
app_desc=fta
tstr="$(date +%Y-%m-%d\ %H:%M:%S)"
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "insert into esb_app_account values ('', '$app_code', '$app_token', '$app_desc', '$tstr')"
mysql -h$LAN_IP -u$MYSQL_USER -p$MYSQL_PASS open_paas -e "update esb_function_controller set wlist=concat(wlist, ',$app_code')"
```

检查模板变量：

```bash
~/render_tpl.sh -c -m fta -E APP_CODE=bk_fta \
     -E APP_TOKEN=$(awk '/bk_fta/ { print $NF }' /data/app.list ) \
     -E MODULE_HOME=$INSTALL_PATH/fta -E MODULE_NAME=fta \
     -E LOGS_HOME=$INSTALL_PATH/logs/fta  $PKG_SRC_PATH/fta/support-files/templates/*
EMPTY PLACE_HOLDER: __FTA_APISERVER_PORT__
EMPTY PLACE_HOLDER: __FTA_JOBSERVER_PORT__
EMPTY PLACE_HOLDER: __FTA_WEBSERVER_PORT__
EMPTY PLACE_HOLDER: __REDIS_CLUSTER_IP0__
EMPTY PLACE_HOLDER: __REDIS_CLUSTER_IP1__
EMPTY PLACE_HOLDER: __REDIS_CLUSTER_IP2__
```

增加FTA的几个port即可：

```bash
FTA_WEBSERVER_PORT=13021
FTA_APISERVER_PORT=13031
FTA_JOBSERVER_PORT=13041
```

去掉 **-c** 参数重新渲染生成配置

```bash
~/render_tpl.sh -m fta -E APP_CODE=bk_fta \
     -E APP_TOKEN=$(awk '/bk_fta/ { print $NF }' /data/app.list ) \
     -E MODULE_HOME=$INSTALL_PATH/fta -E MODULE_NAME=fta \
     -E LOGS_HOME=$INSTALL_PATH/logs/fta  $PKG_SRC_PATH/fta/support-files/templates/*
```

创建目录：

```bash
mkdir -p /data/bkce/logs/fta
```

启动fta：

```bash
supervisord -c /data/bkce/etc/supervisor-fta-fta.conf
```

### 安装蓝鲸官方 SaaS

部署好后台后，打开配置的PAAS_FQDN域名，使用PAAS_ADMIN_UESR和PAAS_ADMIN_PASS分别作为账户名和密码登陆后。进入开发者中心，上传部署官方SaaS。

官方SaaS在服务器上的 $PKG_SRC_PATH/official_saas/目录下可以获取，也可以通过S-mart市场下载其他的SaaS
