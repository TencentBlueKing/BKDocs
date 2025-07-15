# 安装 PaaS 平台 详解

PaaS 平台是蓝鲸产品的门户入口，所以安装蓝鲸先安装 PaaS 平台。

PaaS 平台正常运行在 6.0 版本中，新增了权限中心后台(iam)和用户管理后台(usermgr)的依赖。

完整的 PaaS 能正常运行，需要依次部署好以下蓝鲸组件： license,iam,ssm,usermgr,paas,appt,appo

这些蓝鲸组件，依赖以下第三方组件：consul,mysql,redis,nginx,consul-template,rabbitmq

本文档重点介绍 PaaS 自身的部署和对第三方组件的账号权限以及初始化需求。第三方组件的部署和维护，有各自单独的文档介绍。

## 安装 license 服务

证书服务 license 也是所有蓝鲸产品的全局依赖。license 的环境变量文件（/data/install/bin/04-final/license.env），无须自定义，直接使用默认生成的即可。

```bash
./bkcli sync cert
./bkcli sync license
./bkcli install license
./bkcli start license
```

说明：
1. 拷贝 cert 目录和 license 代码目录
2. 渲染配置文件，并生成 `bk-license.service` 的服务
3. 启动 bk-license.service 并设为开机启动

## 安装 bkiam（权限中心后台）

bkiam 依赖 Redis 和 MySQL，需要提前部署并准备好，并在环境变量（./bin/04-final/bkiam.env）中确认以下变量：

1. Redis 相关配置。先确认使用的 Redis 是单实例还是 sentinel 模式。BK_IAM_REDIS_MODE 的取值为单实例（standalone）和哨兵模式（sentinel）。分别对应不同的变量。需要指出的是，如果使用哨兵模式，`BK_IAM_REDIS_SENTINEL_PASSWORD`的值是 sentinel 本身的密码，而不是 redis 实例的密码。redis 实例的密码，两种模式下，均使用 `BK_IAM_REDIS_PASSWORD` 来配置。

2. MySQL 相关配置。BK_PAAS_MYSQL_HOST 指向的是 paas 的数据库实例。BK_IAM_MYSQL_HOST 指向的是自身的数据库实例，它们可以是不同的 mysql 实例，正式生产环境建议隔离。

```bash
./bkcli sync bkiam
./bkcli install bkiam
./bkcli start bkiam
```

安装步骤和 license 一样，安装成功的关键是，Redis 和 MySQL 的配置正确，账户权限正常。

bkssm 的安装和 bkiam 的完全一样，不再赘述。

## 安装 PaaS 后台

PaaS 后台由五个 Python 工程组成（paas、appengine、esb、login、apigw）按次顺序，依次部署启动。

PaaS 的环境变量配置中（./bin/04-final/paas.env），需要格外注意的是域名和 URL 相关的，请仔细确认是否符合预期。
BK_DOMAIN 变量的设置也影响到 PaaS 用户登录后 cookies 生效的域。

```bash
./bkcli sync paas
./bkcli install paas
./bkcli start paas
./bkcli initdata paas
```

说明：

1. 安装 PaaS 用的脚本为 `./bin/install_paas.sh` 调用它的命令行参数为：`/data/install/bin/install_paas.sh -e /data/install/bin/04-final/paas.env -m paas -s /data/src -p /data/bkce -b $LAN_IP --python-path /opt/py27_e/bin/python` 其中 `-m` 参数是子工程名，需要依次按顺序安装。`-b` 是服务启动后绑定的本机内网 ip 地址。`--python-path` 是加密 python 解释器的绝对路径。
2. 安装成功后，虚拟环境路径是 `/data/bkce/.envs`，用户家目录下的 `~/.bashrc` 会配置上相关命令，可以直接使用 `workon open_paas-子工程名` 切换
3. 子工程的服务名是 `bk-paas-<子工程名>` 例如登录服务是 `bk-paas-login` 
4. 启动成功后，利用 consul 的服务定义，注册 `paas-<子工程名>.service.consul` 的域名，进而使用 consul-template 来渲染到 Nginx 的配置中，实现接入层的转发。详见 nginx 的维护文档。
5. 初始化 PaaS 

    - 注册 RabbitMQ 服务到 PaaS 后台
    - 添加 APP 的鉴权白名单，供免登录态的应用调用 ESB。
    - 添加 SaaS 部署时强依赖的环境变量到 PaaS 数据库。
6. paas 的五个工程可以分布在不同的机器上，默认安装在一起是为了简化部署。

## 安装 PaaS Agent (appo appt)

PaaS Agent，根据正式环境和测试环境区分，分别称为 appo 和 appt 服务器。蓝鲸 S-mart 应用，通过 PaaS 部署后，在 appo 和 appt 服务器上运行。安装完 PaaS 后台后，即可安装 appo 和 appt 了。

它们的环境变量配置文件（./bin/04-final/paasagent.env）中，需要注意的配置有：

- BK_BLUEKING_UID、BK_BLUEKING_GID 定义的 blueking 账户的用户 ID 和组 ID，默认是 10000，和初始化系统的脚本保持一致，否则会有权限问题。
- BK_PAASAGENT_PYTHON2_IMAGE_NAME、BK_PAASAGENT_PYTHON3_IMAGE_NAME：定义 Python2 和 Python3 的基础镜像的名字，默认不需要调整，如果有自定义基础镜像并改名，则需要调整。

```bash
./bkcli sync appo
./bkcli install appo
./bkcli start appo
```

说明：

1. 同步 paas_agent/ 和 image/ 目录到 appo 服务器
2. 安装 docker 且导入镜像 （./bin/install_docker_for_paasagent.sh）
3. 安装 paasagent （./bin/install_paasagent.sh -e ./bin/04-final/paasagent.env -b $LAN_IP -m prod -s /data/src -p /data/bkce）
4. 安装 openresty 
5. 安装 consul-template 