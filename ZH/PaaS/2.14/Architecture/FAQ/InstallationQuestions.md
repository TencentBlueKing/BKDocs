## 能否使用 32 位系统
答：不能，依赖都是基于 64 位系统编译的。

## 能否使用 centos7
答：实际测试中可以，但是会遇到问题，需要根据提示错误，根据 FAQ/Google 等查找解决方案，处理解决即可。

## 开发者中心能否使用 IP 访问
答：访问开发者中心一定要通过域名. 不能通过 IP. 因为登录状态写在有效域名的 cookie 中。

## PaaS & paas_agent 可以全部搭建到一台服务器上吗
答：PaaS 和 paas_agent 可以在一台服务器上，但一台服务器上只能部署一个 paas_agent。

## paas_agent 服务器上无外网有什么影响
答：如果用户开发应用，在开发框架中加入了自定义的安装包 requirements.txt，如果 paas_agent 无外网，则部署时无法安装自定义的软件包(pip install 无法安装外部 python 软件包)

## 进行数据库连接测试 mysql client is required
2016-09-23 02:20:43 [ERROR] mysql client is required

解决
```bash
$ yum install mysql \# or yum install mysql-server
# or 自行下载 rpm 安装，或者通过源码编译 mysql
# 确认安装成功
$ which mysql
/usr/bin/mysql
```

## 集成平台安装脚本最后，某些服务启动 FAIL

这里以 paas 服务为例

```bash
./bin/dashboard.sh
appengine RUNNING pid 5340，uptime 0:00:29
esb RUNNING pid 5339，uptime 0:00:29
login RUNNING pid 5338，uptime 0:00:29
paas FATAL Exited too quickly (process log may have details)
supervisor>
```

查看对应的启动日志 `${PAAS_ROOT}/open_paas/logs/*_uwsgi.log`，
一般启动失败的原因是， `bin/config.sh` 中，对应的端口被占用导致的

```bash
Mon Sep 19 05:29:44 2016 - probably another instance of uWSGI is running on the
same address (127.0.0.1:8001).

Mon Sep 19 05:29:44 2016 - bind(): Address already in use [core/socket.c line
769]
```

处理:

变更 `config.sh` 中配置的端口号，重新执行 `bin/setup.sh` 即可

如果是其他的原因导致的启动失败，根据日志信息解决。

## 502

访问集成平台(open_paas)出现 502，原因比较多

-   确认 open_paas 四个 web 服务启动正常，且可访问(最可能的原因)，
    注意如果端口被占用，web 服务将启动失败

-   确认防火墙策略，即， nginx 所在机器能请求到 open_paas 所在机器的对应服务 `curl http://{open_paas_ip}:8000`

-   确认 nginx 中 `paas.conf - server { listen 80;}`，如果此时 502，
    可能是 nginx 部署机器有多块网卡，
    而 listen 使用的网卡和访问域名配置的网卡不同导致的，变更 server { listen
    {网卡 IP}:80;}

## centos7 问题汇总

如果是 centos 7，安装完成后四个 web 服务启动失败

```bash
bin/uwsgi: error while loading shared libraries: libpcre.so.0
./bin/dashboard.sh status
appengine FATAL Exited too quickly (process log may have details)
esb FATAL Exited too quickly (process log may have details)
login FATAL Exited too quickly (process log may have details)
paas FATAL Exited too quickly (process log may have details)
```

且查看 `${PAAS_ROOT}/open_paas/logs/supervisord/*_err.log`

```bash
${PAAS_ROOT}/open_paas/Envs/paas/bin/uwsgi: error while loading shared
libraries: libpcre.so.0: cannot open shared object file: No such file or
directory
```

这是 uwsgi 缺乏依赖导致的. 常见于 centos7 版本

```bash
$ yum install pcre pcre-devel
$ ln -s /usr/lib64/libpcre.so /usr/lib64/libpcre.so.0
$ link /usr/lib64/libpcre.so.1 /lib64/libpcre.so.0
```
