## 应用的代码存放到哪里
答：应用的代码仓库和数据库都是由开发者自己维护的，目前支持代码仓库有: SVN 和 Git

## 开发框架的代码在哪里获取
答：开发框架的代码在开发者中心-资源下载，开发者需要自己将框架代码放到自己的代码仓库中，并按照 **开发者中心-\> 新手指南 -\> 配置修改** 修改框架代码。

## 应用输入正确的用户名、密码后，无法登录一直停留在登录页面
答：请按照 **开发者中心 -\> 新手指南 -\>配置修改** 修改框架代码 `conf/default.py` 文件中的 `APP_ID` ， `APP_TOKEN` ， `BK_PAAS_HOST`

本地开发时，请配置 host 访问，确保应用 和 **开发者中心** 的根域名要一致，
否者登录授权的 cookie 写失败，将导致一直停留在登录页。

## 如何查看日志
答：
- 开发者中心日志: `${PAAS_ROOT}/open_paas/logs/` 目录下，其中应用日志 `(*.log)`，
  uwsgi 日志 `(*_uwsgi.log)，mysql日志(\*_mysql.log)`，supervisord 日志 `(supervisord/\*)`

- paas_agent 日志：`${PAAS_ROOT}/paas_agent/var/log/agent.log`

- 应用日志: `${PAAS_ROOT}/apps/logs/{app_code}/`

## 如何配置配置平台 CC 和作业平台 Job

如果安装 PaaS 前这两个服务已经搭建，则在 `bin/config.sh` 中配置即可

```bash
CC_DOMAIN="cmdb.jobqcloud.com"
CC_HTTP_PORT=80
CC_SSL_PORT=8443
IS_CC_USE_SSL=0
# e.g. ijob.biking.com，注意不带端口，
# 默认需要开启 SSL，80端口为 web 入口地址，8443 端口接口访问地址
JOB_DOMAIN="job.jobqcloud.com"
JOB_HTTP_PORT=80
JOB_SSL_PORT=8443
IS_JOB_USE_SSL=1
```

如果 PaaS 安装后，要将这两个服务加入，
修改 `${PAAS_ROOT}/open_paas/src/esb/configs/default.py` 文件

```bash
# host for cc
HOST_CC = 'cmdb.jobqcloud.com'
# host for job
HOST_JOB = 'job.jobqcloud.com'
```
然后重启 esb

```bash
$ cd ${PAAS_ROOT}/open_paas
$ ./bin/dashboard.sh restart esb
```

## 开发的应用能否自行更换 logo
答：可以，应用列表中，点击应用图表，重新上传即可


## [paas_agent 使用问题] 环境安装完成后，paas_agent 服务启动不了
查看 `${PAAS_ROOT}/paas_agent/var/log/agent.log`，可能的原因有

- 端口已被占用

- 服务器 id 或者 token 无效(sid or token is not valid，please check)

- yaml 文件中 CONTROLLER_SERVER_URL 对应的服务没有启动或本机无法访问该服务

- 证书文件不存在(paas_agent.license does not exit or be destroyed)

- 证书过期(license expired)

- 证书解析有误(paas_agent.license parse error/licenseInfo loads error)

- 证书 mac 地址不匹配(mac address error)

## [paas_agent 使用问题] app 提测或上线时，开发者中心看不到部署日志的输出
查看 `${PAAS_ROOT}/paas_agent/var/log/agent.log` 中是否有部署内容输出.

- 如果有，需要验证 `${PAAS_ROOT}/paas_agent/etc/paas_agent_config.yaml`中配置的 CONTROLLER_SERVER_URL 对应的服务是否启动，并且本机可以访问该服务。

- 如果没有，请确保 `${PAAS_ROOT}/paas_agent/etc/build/build`脚本可执行。

## [paas_agent 使用问题] app 提测或上线时，svn/git 拉取代码失败
查看具体失败信息，并确认

1.svn/git 配置的地址正确/密码正确。

2.在对应 agent 服务器上，可以访问到 svn/git (拉取代码操作是在 agent 服务器上处理的)。

## [paas_agent 使用问题] 部署 app 的时候，pip install 失败
paas_agent 通过 `${PAAS_ROOT}/paas_agent/etc/build/buid` 脚本，执行 `pip insall`安装 app 需要的软件包，默认源是 http://pypi.douban.com/simple 。如果失败，需要确认具体原因，选择解决方案，下面列出两个常见原因：

- 服务器无法访问外网：在无外网的情况下，可以参考[install pip package without
    internet](http://stackoverflow.com/questions/36725843/installing-python-packages-without-internet-and-using-source-code-as-tar-gz-and)解决问题。

    1.在有外网的机器上，下载需要的软件包  `mkdir python_pkgs pip install 软件包 --download="/root/python_pkgs" tar cvfz python_pkgs.tar.gz python_pkgs`

    2.解压软件包到 app 服务器上  `tar zxvf python_pkgs.tar.gz -C ${PAAS_ROOT}/paas_agent/pkg/`

    3.替换 pip 源
      修改 `${PAAS_ROOT}/paas_agent/etc/build/buid` 脚本中源的指定方法，将  `pip install -r requirements.txt -i http://pypi.douban.com/simple --trusted-host pypi.douban.com`  
      替换成  `pip install -r requirements.txt --no-index --find-links=${PAAS_ROOT}/paas_agent/pkg/python_pkgs`

- 缺少底层编译依赖：有些 Python 安装的时候，依赖一些底层库，例如 paramiko 需要 libffi-devel/openssl-devel 等。出现这种问题，需要手动预先安装依赖包，再执行部署 app 的操作。

## [paas_agent 使用问题] 服务器重启后，再次部署 app 失败
当服务器异常宕机或者重启后，app 的 supervisor 程序没有正常关闭，目录下会残留 supervisord.sock 文件，最终导致 app 的进程拉起失败。

解决方法：清空 `${PAAS_ROOT}/apps/projects/***/run` 目录下的所有文件，再次执行部署 app 的操作。

## [ESB 使用问题] 访问组件出现错误消息："Not found，component class not found，generic.xxx.xxx_xxx_xxx"
错误表示组件加载失败，原因主要有两部分：

- 组件代码存在问题，加载时出现异常，可查看 logs/esb.log 是否有异常信息。

- 组件源码需是 py 文件，可在 components/generic/apis/ 下检查组件 py 文件是否存在。

## [ESB 使用问题] 访问组件出现错误消息："xxx SSL 配置文件不存在" 或者 "xxx SSL 请求异常"
背景: esb 与其他平台交互时，需要用到 ssl，

这些 ssl 文件需要到 [http://bk.tencent.com/download/](http://bk.tencent.com/download/) 下载，并放入固定目录中。

(集成平台安装时，其配置文件 config.sh 中的 SSL_ROOT_DIR 变量对应目录)

原因：SSL 文件配置错误或者 SSL 签名已经过期。

解决方法：到 [http://bk.tencent.com/download/](http://bk.tencent.com/download/) 下载证书，根据错误信息，放入指定目录即可。

## [ESB 使用问题] 组件参数 bk_token 如何获取
bk_token 是用户登录态，用户登录后存储在 COOKIES 中，开发者可从 COOKIES 中获取，或使用框架的 get_client_by_request 方法，该方法会主动从 COOKIES 中获取此参数。

## No such file or directory: 'requirements.txt'
原因: 填写项目的 svn/git 地址，其根目录不是 framework 代码的根目录。

## [Errno 111] Connection refused
错误信息
```bash
django.db.utils.OperationalError: (2003，"Can't connect to MySQL server on
'localhost' ([Errno 111] Connection refused)")
```
原因: mysql 没有授权给 agent 服务器/本地开发环境等，导致连接 mysql 的时候报错，需要到 mysql 中对机器/用户进行授权。

## django.db.utils.OperationalError: (1018，"Can't read dir of './chengpeal/' (errno: 23)")
错误信息

```bash
django.db.utils.OperationalError: (1018，"Can't read dir of './chengpeal/'
(errno: 23)")
```
解决:

```bash
# http://stackoverflow.com/questions/11066411/mysql-error-error-1018-hy000-cant-read-dir-of-errno-13
chown -R mysql:mysql /var/lib/mysql/ # your mysql user may have different name
chmod -R 755 /var/lib/mysql/
```

## [ESB 使用问题] 自定义组件依赖了第三方包
增加了自定义组件，发现报错

```json
{
  "message": "Not found，component class not found，generic.xxxxx...."，
  "code":"20004"，
  "data": null
}
```

可能原因:

1.没有按照组件文档处理，即新增组件放的目录不对(新增的所有层级目录须带 `__init__.py` )，组件放置路径正确

2.组件文件名/文件内对应的 class name 正确

3.组件加载异常，查看 `${PAAS_ROOT}/open_paas/logs/esb.log` 日志

一般是由于语法错误导致的，也可能是缺少第三方包

查看日志确认缺少哪些包，按照下面的步骤，安装对应的包

```bash
$ cd ${PAAS_ROOT}/open_paas
$ source Envs/esb/bin/activate
```

有外网的情况下

```bash
$ pip install {包名}
$ bin/dashboard.sh restart esb
```

无外网的情况下，请参考: [install pip package without
internet](http://stackoverflow.com/questions/36725843/installing-python-packages-without-internet-and-using-source-code-as-tar-gz-and)

## 变更域名
如果域名变更，需要修改对应配置文件，可以不手工进行，直接修改原先安装路径下 `bin/config.sh` 中所有域名相关配置，整体重装即可

1.手工处理. 修改 open_paa 的几个 web 项目的配置，安装路径默认为/data/paas/open_paas

paas 的 web 配置，src/paas/conf/settings_production.py

修改对应域名/主域名

```bash
# domain
PAAS_DOMAIN = 'paas.bk.com'
# cookie 访问域
BK_COOKIE_DOMAIN = '.bk.com'
# host for cc
HOST_CC = 'cmdb.jobqcloud.com'
# host for job
HOST_JOB = 'job.jobqcloud.com'
login 的 web 配置，src/login/conf/settings_production.py
# cookie 访问域
BK_COOKIE_DOMAIN = '.bk.com'
esb 的 web 配置，src/esb/configs/default.py
# Third party system host
# host for bk login
HOST_BK_LOGIN = 'paas.bk.com'
# host for cc
HOST_CC = 'cmdb.jobqcloud.com'
# host for job
HOST_JOB = 'job.jobqcloud.com'
# host for gse
HOST_GSE = '10.129.143.213:48667'
```

然后重启

```bash
bin/dashboard.sh restart all
```

2.修改 paas 对应 nginx 配置中域名 `paas.conf`

3.server_name: xxx.com 对 nginx 进行 reload: `sbin/nginx -s reload`

4.修改 paasagent 两台机器上，对应安装路径下的 agent 配置 `etc/paas_agent_config.yaml`

5.CONTROLLER_SERVER_URL: 'http://paas.bking.com'然后重启 `bin/dashboard.sh restart all`
