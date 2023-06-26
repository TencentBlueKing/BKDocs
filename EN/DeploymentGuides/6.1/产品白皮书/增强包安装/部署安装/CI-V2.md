# 一、准备工作
## 资源需求
### 常规单点方案

蓝盾根据资源配置需求可以分为 3 类，一般每类 1 台即可。构建机应当随并行的任务量增加而扩容。
1. 网关（ gateway ） `1c/4GB/100GB` （也可放入微服务节点，或者和其他非 web 服务复用机器 。）
2. 微服务（除 agentless 及 dockerhost ） `8c/32GB/100GB`
3. 构建机（ agentless 及 dockerhost ） `8c/16GB/100GB+500GB` （ `500GB` 的数据盘用于流水线任务的 workspace 缓存）

注：
1. 微服务及构建机配置可以升降并分散到更多的机器上，主要需要保障 java 内存需求。
2. artifactory 服务存在多实例时，需要共享的数据存储，建议使用 nfs ，或者其他能直接 mount 的网络文件系统。

### 最小化单点方案

可以将网关、微服务及公共构建机部署到同一个节点上。推荐使用 `8c/32GB/100GB` 配置的服务器 1 台 ，最低配置可以为 `8c/16G/100G` 。

### 高可用方案

参考 “常规单点方案” 直接把微服务及网关机器数量 x2 即可。
构建机（ `dockerhost` 及 `agentless` ）无法高可用，无需对数量翻倍。

如果任务途中构建机故障，则可能导致故障机器上的正在执行的任务中止或挂起。新发起任务会调度到存活的其他构建机上。

Web 高可用 需要用户自行准备前端 HA load balancer 。如 `HA-Proxy` 。在我们注册了蓝盾内部域名后，Consul 会自动维护集群内部 `bk-ci.service.consul` 域名的可用性（故障切换时间约为 0-3s ）。
微服务在存在多个实例时会自动调度实现负载均衡及高可用，此能力依赖 Consul 服务发现。

## 依赖的服务

### Consul

蓝盾全部组件依赖 Consul 。版本 1 的稳定版即可。

### MySQL

大部分微服务依赖 MySQL。版本建议 5.7。

### RabbitMQ

蓝盾使用 RabbitMQ 进行任务分配。 版本 3.7 或 3.8 。

需要 `delayed_message_exchange` 插件。

在 **全部** RabbitMQ 服务端执行如下命令安装并启用插件，需要重启服务端。
```bash
cd /usr/lib/rabbitmq/lib/rabbitmq_server-3.8.3/plugins/
wget https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez
rabbitmq-plugins enable rabbitmq_delayed_message_exchange
sleep 3  # 等3秒
rabbitmq-plugins list | grep rabbitmq_delayed_message_exchange  # 显示 E* 即为 启用+运行 状态。否则可能需要重启服务端。
```

### Redis

缓存必不可少，网关及大部分微服务依赖 Redis 。 版本 >2.8 。

> 暂不支持 Sentinel 协议
> 
> 目前微服务框架支持 Redis Sentinel ，但是 `ci(gateway)` 使用的 OpenResty 暂不支持，而 `ci(gateway)` 需要和微服务使用相同的 Redis 实例 ，故不支持 Sentinel 协议。

### ElasticSearch

`ci(log)` 需要 ElasticSearch ，使用 REST API 连接，要求 ElasticSearch 服务端版本 >=7 。

### 可选：NFS

在部署了多个 `ci(artifactory)` 时，`ci(artifactory)` 数据目录需要使用共享存储，一般为 NFS 。

不然文件会分散到多个 `ci(artifactory)` 的本地存储，因为负载均衡后端的数据不一致，会导致同一个资源请求在 `404 Not Found` 和 `200 OK` 之间变动。

### 可选：InfluxDB

`ci(environtment)` 负责管理第三方构建机，如果在 env 文件中设置了`BK_CI_ENVIRONMENT_AGENT_COLLECTOR_ON=true`，则依赖 InfluxDB 。

## 依赖的软件或数据
### sysstat

`ci(agentless)` 服务使用自带的 libsigar.so 探测系统配置，后者需要 iostat 命令。

### Docker

`ci(dockerhost)`及 `ci(agentless)` 需要主机提供 `dockerd` 。如果在容器内部署，则需映射主机的 `/var/run/docker.sock` 到容器内，确保容器内可以读写。

## 蓝盾安装包
### 下载蓝盾安装包

蓝盾的安装包请优先使用蓝鲸官方发布的安装包。此安装包会经过多轮部署及测试评估。

也可在 GitHub 下载 `v1.2` 版本的最新安装包。如果下载其他版本，则无法保证本文档的兼容性。
GitHub 下载地址： [https://github.com/Tencent/bk-ci/releases](https://github.com/Tencent/bk-ci/releases)

### 预处理蓝盾安装包

自动解压并更新 env 模板。

用法：在预处理脚本后面添加下载的 蓝盾 tar.gz 包作为参数：
```bash
./bin/prepare-bk-ci.sh 蓝盾tar.gz包路径  # 在/data/install目录执行. 
```

# 二、配置 install.config

此文件决定着决定哪些机器安装什么服务。

参考模板：

最小化单点方案
```bash
# 内存建议 32G ，至少 16G。CPU 建议8核。
10.0.1.1 ci(gateway),ci(dockerhost),ci(artifactory),ci(auth),ci(dispatch),ci(environment),ci(image),ci(log),ci(misc),ci(notify),ci(openapi),ci(plugin),ci(process),ci(project),ci(quality),ci(repository),ci(store),ci(ticket),ci(websocket)
```
> **注意**
> 
> `ci(dockerhost)` 与 `ci(agentless)` 使用相同的端口，因此不能部署在同一节点上。
> 
> 故单节点最小化部署时，放弃 `ci(agentless)` （无编译环境）。
> 
> 当然，您也可以选择保留 `ci(agentless)` ，放弃 `ci(dockerhost)` （公共构建机）。使用 **项目专属** 的 “私有构建机” 提供任务执行环境，详情请参考 “私有构建机方案“ 章节。

常规单点方案
```bash
# gateway选择4G内存即可.
10.0.1.1 ci(gateway)
# 微服务总内存32G, 如果为多台机器组成, 请随意组合, 但是需要确保在同一个子网内. 其中, agentless为无编译环境, 一般和微服务放在一起.
10.0.1.2 ci(agentless),ci(artifactory),ci(auth),ci(dispatch),ci(environment),ci(image),ci(log),ci(misc),ci(notify),ci(openapi),ci(plugin),ci(process),ci(project),ci(quality),ci(repository),ci(store),ci(ticket),ci(websocket)
# 公共构建机也尽量放在同一子网. 建议内存8G起步. 数量视任务量而定, 如果任务量较多且耗时较长, 建议增加dockerhost节点的数量, 并升级磁盘性能.
10.0.1.2 ci(dockerhost)
```

# 三、手动安装

为了让用户更全面地了解整个软件的模块与服务，提供手动安装的详解过程，遇到问题可以快速定位。

> **注意**
> 
> 所有的命令都预期在 `$CTRL_DIR` （默认为 `/data/install` ） 目录下执行。

## 初始化新节点

请参考蓝鲸新节点初始化文档完成如下的步骤。

### 配置免密

配置免密，即可从中控机登录到对应的节点执行命令。
```bash
./configure_ssh_without_pass
```

### 配置 bk-custom 仓库

请参考蓝鲸部署文档完成仓库配置。

用于安装 `java` 、 `docker-ce` 、 `openresty` 等软件包。

### 安装 Consul agent

```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/install_consul.sh -e $BK_CONSUL_KEYSTR_32BYTES -j $BK_CONSUL_IP_COMMA -r client --dns-port 53 -b $LAN_IP'
```

### 环境初始设置

在 `install.config` 中定义了新的节点 IP 后，我们应该尽快完成新节点的初始化。

使用如下的命令完成基础软件包安装，蓝鲸用户组创建，一些初始目录的创建等。
```bash
./bkcli update bkenv
```

## 编写 env 文件
### env 路径说明

env 模板位置： `./bin/default/ci.env`，在 “预处理蓝盾安装包” 章节里提过， `./bin/prepare-bk-ci.sh` 脚本会从蓝盾安装包中同步模板到此路径。

需要创建并修改 `./bin/03-userdef/ci.env`，具体操作请查看下面的 “ env 修改建议”。

在完成了 merge-env 后，会生成 `./bin/04-final/ci.env`，我们的安装脚本会读取此文件。

注：可以在 GitHub 查看社区版 6.0 的 env 模板文件： [https://github.com/Tencent/bk-ci/blob/release-1.2/scripts/bkenv.properties](https://github.com/Tencent/bk-ci/blob/release-1.2/scripts/bkenv.properties)

### env 修改建议

依赖服务选择蓝鲸部署或云服务。

一般情况下，我们需要修改如下的变量：
1. 基础依赖变量，需要从已经安装的蓝鲸环境中获取赋值。
2. `BK_CI_APP_TOKEN`：取值为 uuid 。使用 `uuidgen` 或者 `uuid -v4` 命令可以生成一个 uuid 。
3. `BK_CI_AUTH_PROVIDER=bk_login_v3` 为蓝鲸社区版 6.0 部署时所需。 `bk_login` 已经不再支持。
4. 按需修改 `BK_CI_FQDN` 及 `BK_CI_PUBLIC_URL`，在安装成功后使用此地址访问蓝盾。
5. 按需填写 MySQL ， RabbitMQ ， es ， Redis 等配置信息。

> **注意**：目前文档中描述为“蓝鲸环境下自动填充”的变量均需手动赋值修改。待后续改进 merge-env.sh 或提供其他解决办法。

社区版 6.0 `./bin/03-userdef/ci.env` 最小化配置模板供参考：
```bash
BK_DOMAIN=填写主域名. 如果在腾讯云测试, 可以填写 个人的ID.bktencent.com
BK_HOME=/data/bkce
BK_HTTP_SCHEMA=http
BK_PAAS_PUBLIC_URL=填写PaaS的完整url. 一般为 http://paas.$BK_DOMAIN
BK_CI_AUTH_PROVIDER=bk_login_v3
BK_CI_FQDN=一般可以配置为 devops.$BK_DOMAIN
BK_CI_PUBLIC_URL=http://$BK_CI_FQDN  # 此处保持不变即可
BK_CI_MYSQL_ADDR=填写IP:3306
BK_CI_MYSQL_PASSWORD=填写密码
BK_CI_MYSQL_USER=bk_ci
BK_CI_RABBITMQ_ADDR=填写IP:5672
BK_CI_RABBITMQ_PASSWORD=填写密码
BK_CI_RABBITMQ_USER=bk_ci
BK_CI_RABBITMQ_VHOST=bk_ci
BK_CI_REDIS_DB=0
BK_CI_REDIS_HOST=填写IP
BK_CI_REDIS_PASSWORD=填写密码
BK_CI_REDIS_PORT=6379
BK_CI_ES_REST_ADDR=填写IP
BK_CI_ES_REST_PORT=9200
BK_CI_ES_USER=elastic  # 一般为此用户.
BK_CI_ES_PASSWORD=填写密码
BK_CI_APP_TOKEN=自己生成一个UUID-v4填在这里
BK_SSM_HOST=bkssm.service.consul  # 保持不变即可.
BK_CI_PAAS_LOGIN_URL=$BK_PAAS_PUBLIC_URL/login/\?c_url=  # 保持不变即可.
BK_CI_REPOSITORY_GITLAB_URL=http://$BK_CI_FQDN  # gitlab服务端如果有https, 且http端口会强制30x调整, 参考"FAQ -- gitlab https适配问题"章节.
```

## 合并 env

```bash
cd ${CTRL_DIR:-/data/install}
./bin/merge_env.sh ci
```

## 校验最终 env 文件

人工观察 env 文件是否存在渲染异常。

## 同步 env 及 install.config

在安装前，需要确保所有节点的 env 文件是最新的。 merge_env 只会修改当前机器的。

这里直接同步整个 install 目录：
```bash
./bkcli sync common
```

## 创建账户及权限

> **注意**
> 
> 本章节随附代码适用于蓝鲸社区版部署脚本部署的依赖服务。
> 
> 如使用非蓝鲸部署的服务（如自建服务或采购的云服务），则无法直接使用下述代码，请自行查阅等价操作进行。

### MySQL 账户授权

本语句在 MySQL 节点执行：原则上仅对全部蓝盾节点授权，其他系统尽量通过 API 与蓝盾交互。严格情况下应该仅对微服务所在的节点授权。

`-n login-path名称` 用于免密登录 MySQL 。如果提示名称不对，请使用 `mysql_config_editor print --all` 查看，或者参考蓝鲸部署文档完成 MySQL 的默认 login-path 设置。
```bash
source ${CTRL_DIR:-/data/install}/bin/04-final/ci.env  # 注意merge_env后操作.
echo "$BK_CI_MYSQL_USER" -p "$BK_CI_MYSQL_PASSWORD" -H "$BK_CI_IP_COMMA"  # 人工确认输出.
# 使用pcmd前往MySQL节点(这里假设复用了默认的MySQL, 故选择`$BK_CI_MYSQL_USER`)执行ci的授权操作. 注意不要使用 `-m mysql` 选择全部MySQL节点, 这样可能会执行多次.
pcmd -H "$BK_MYSQL_IP" '${CTRL_DIR:-/data/install}/bin/grant_mysql_priv.sh -n default-root -u "$BK_CI_MYSQL_USER" -p "$BK_CI_MYSQL_PASSWORD" -H "$BK_CI_IP_COMMA"'
```

因为中控机上将会执行 `./bin/sql_migrate.sh` （见 “导入数据库 SQL” 章节），所以需要授权中控机访问蓝盾数据库：
```bash
pcmd -H "$BK_MYSQL_IP" '${CTRL_DIR:-/data/install}/bin/grant_mysql_priv.sh -n default-root -u "$BK_CI_MYSQL_USER" -p "$BK_CI_MYSQL_PASSWORD" -H "$(<$CTRL_DIR/.controller_ip)"'
```

在成功添加了中控机的访问授权后，我们可以配置 `mysql` 命令的 login-path ，以便命令行调用：
> **注意**
> 
> 如果使用自备的 MySQL 服务，请先完成账户创建并授权中控机 IP 访问，然后配置 env 文件，运行下述命令。

```bash
source ${CTRL_DIR:-/data/install}/bin/04-final/ci.env  # 注意merge_env后操作.
${CTRL_DIR:-/data/install}/bin/setup_mysql_loginpath.sh -n mysql-ci -h "${BK_CI_MYSQL_ADDR%:*}" -u "$BK_CI_MYSQL_USER" -p "$BK_CI_MYSQL_PASSWORD"
```

### RabbitMQ 账户授权

> **注意**
> `所有的` RabbitMQ 服务端需要启用 `delayed_message_exchange` 插件。

在中控机执行：
```bash
pcmd -H "$BK_RABBITMQ_IP" '${CTRL_DIR:-/data/install}/bin/add_rabbitmq_user.sh -u "$BK_CI_RABBITMQ_USER" -p "$BK_CI_RABBITMQ_PASSWORD" -h "$BK_CI_RABBITMQ_VHOST"'
```
说明：此处不使用 `-m rabbitmq`，是因为只需要在 1 台服务端执行即可。

### Redis 加密

Redis 暂不支持 Sentinel 协议。

一般复用 db 及 password 即可，部署及配置密码细节可参考蓝鲸部署文档。

### elasticsearch 密码

一般复用蓝鲸集群的 es7 即可，部署及配置用户认证细节可参考蓝鲸部署文档。

### 可选：InfluxDB

在启用了第三方构建机实时状态后，才需要创建 InfluxDB 账户信息并设置蓝盾服务端的访问授权，请参考网络公开文档配置即可。

## 导入数据库 SQL

仅在中控机执行。
```bash
cd ${CTRL_DIR:-/data/install}
./bin/sql_migrate.sh -n mysql-ci /data/src/ci/support-files/sql/*.sql
```
如果出现报错，请检查是否完成了 “ MySQl 账户授权” 章节里对中控机的全部操作。

## 注册到 ESB

注册 APP ：
```bash
cd ${CTRL_DIR:-/data/install}
source ./load_env.sh  # 加载变量, 方便下面的命令行使用.
# 一般使用PaaS的loginpath (mysql-paas)连接数据库：
./bin/add_or_update_appcode.sh "$BK_CI_APP_CODE" "$BK_CI_APP_TOKEN" "蓝盾" "mysql-paas"  # 注册app。第4个参数即是login-path。
```

## 导入 IAM 权限模板

> **注意**
> 需要完成 “注册到 ESB ” 章节后，本操作方可进行。

需要导入 IAM 权限模板 。仅在中控机执行。
```bash
cd ${CTRL_DIR:-/data/install}
source ./load_env.sh  # 加载变量, 方便下面的命令行使用.
./bin/bkiam_migrate.sh -t "$BK_IAM_PRIVATE_URL" -a "$BK_CI_APP_CODE" -s "$BK_CI_APP_TOKEN" /data/src/ci/support-files/bkiam/*.json
```

## 安装
### 同步部署脚本

同步公共文件（其中包含 env 文件）到其他节点

```bash
./bkcli sync common
```

### 同步蓝盾安装包

最初的安装包是放在中控机的，但是安装时会读取本机的，所以需要将蓝盾的安装包从中控机同步到蓝盾节点：
```bash
./bkcli sync ci
```

### 安装 java

在中控机使用 `pcmd` 在所有的蓝盾节点执行安装脚本。
> **提示**
> `pcmd` 是蓝鲸部署工具包提供的别名。在安装蓝鲸后可用。其来源一般如下：
```bash
alias pcmd='/data/install/pcmd.sh'
```

安装蓝盾依赖的 JDK 。如果此时不安装，则安装脚本会在发现没有 `java` 命令时尝试自动安装 OpenJDK ：
```bash
cd ${CTRL_DIR:-/data/install}
source ./load_env.sh  # 加载变量, 方便下面的命令行使用.
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/install_java.sh -p "$BK_HOME" -f /data/src/java8.tgz'
```

### 安装蓝盾

`./bin/install_ci.sh` 会根据蓝鲸部署脚本提供的环境变量判断本机应该安装及启用何种服务。也可以 `-m` 强制指定。

`-e` 参数后面为 env 文件路径，这里选择 merge 后的`./bin/04-final/ci.env`。

> **注意**
1. 在执行安装前，请确保 env 文件是最新的。
2. 推荐使用 `-p "$BK_HOME"` 引用安装目录。
3. 安装程序会检查内存并适配。如果内存不满足，安装程序会在 “ **PRECHECK** ” 步骤主动退出。

使用 pcmd 时，会在命令执行后才输出 stdout 和 stderr 到屏幕。因此如果部分节点配置的微服务较多，会等待 1-10 分钟不等。请耐心等待。
```bash
pcmd -m ci 'cd ${CTRL_DIR:-/data/install}; export LAN_IP ${!BK_CI_*}; ./bin/install_ci.sh -e ./bin/04-final/ci.env -p "$BK_HOME" 2>&1;'
```

> **重复安装蓝盾**
> 如果安装出现问题，可以重复执行安装脚本。请提前在中控机完成 /data/src/ci 及 env 文件的更新及同步。
```bash
./bin/merge_env.sh ci   # 汇总新的env
./bkcli sync common     # 同步公共文件(其中包含env)到其他节点
# 下述操作按需执行. 仅当修改了ci的安装包时才需要分发安装包到ci节点.
./bkcli sync ci
# 如下操作按需执行. 仅当修改了CI的数据库信息时才需要重新导入初始数据:
ls  ~/.migrate/*_ci_*  # 看mysql及bkiam的flag文件, 蓝鲸使用了flag文件避免重复导入mysql.sql及iam.json
chattr -i ~/.migrate/*_ci_*   # 关掉删除保护
rm ~/.migrate/*_ci_*    # 删除, 删除完成后，即可重新执行 sql_migrate.sh 和 bkiam_migrate.sh 了.
```

## 启动服务

启动全部的蓝盾服务。

```bash
cd ${CTRL_DIR:-/data/install}
pcmd -m ci 'systemctl start bk-ci.target'
```
> **提示**：当单节点部署时，因为服务同时启动，可能因 CPU 及磁盘资源问题导致整体启动时间更久，大约 1-5 分钟。期间 pcmd 可能无输出，请耐心等待。

## 检查服务状态

检查服务是否成功启动。
```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/bks.sh'
```
> **注意**
> `agentless` 会等待 `dispatch` 服务启动完毕后才开始启动。因耗时略久，可以临时忽略此服务的状态，继续下述步骤。


## 注册到 PaaS 工作台

可以将蓝盾注册到蓝鲸的 PaaS 工作台。注册完成后，蓝盾图标会出现在 PaaS 首页的“工作台”中。

部署脚本中提供了 `./bin/bk-ci-reg-paas-app.sh`，在中控机执行。
```bash
./bin/bk-ci-reg-paas-app.sh
```

## 注册蓝鲸集群内部域名

在对应蓝盾组件节点上注册 Consul 服务。
```bash
# 在全部 ci(gateway) 节点上注册主入口域名: bk-ci.service.consul, 用于在集群内提供web服务.
pcmd -m ci_gateway '${CTRL_DIR:-/data/install}/bin/reg_consul_svc -n bk-ci -p "${BK_CI_HTTP_PORT:-80}" -a "$LAN_IP" -D > /etc/consul.d/service/bk-ci.json; consul reload'
# 在全部 ci(auth) 节点注册 ci-auth.service.consul, 供iam回调使用. 请勿更改此名称.
pcmd -m ci_auth '${CTRL_DIR:-/data/install}/bin/reg_consul_svc -n ci-auth -p "${BK_CI_AUTH_API_PORT:-21936}" -a "$LAN_IP" -D > /etc/consul.d/service/ci-auth.json; consul reload'
```
命令说明： `-n` 指定名称。 `-p` 为服务的端口， `-a` 为服务的 IP ，一般为本机内网 IP 。 Consul 会检查 IP 及端口是否可用，据此决定是否在解析结果中启用此 IP 。 `-D` 生成配置文件，然后重定向写入与服务名称相应的路径。

检查注册结果：

如果下述命令出现 IP ，则说明解析成功。

```bash
dig +short bk-ci.service.consul
dig +short ci-auth.service.consul
```

排查：

如果上述解析失败。请先检查本机：
1. 本机 `/etc/resolv.conf`里第一个 nameserver 是否为 `127.0.0.1`。
2. 本机是否存在 Consul agent ，是否监听了 127.0.0.1:53 端口提供 DNS 服务。
3. Consul 加入的集群是否正确。

如果本机正常，则需要前往对应的节点（ ci_gateway 或 ci_auth ）检查：
1. 服务（ `ci(auth)` ， `ci(gateway)` ）是否正常（ `pcmd -m ci '/data/install/bin/bks.sh'` 脚本检查蓝鲸服务状态），服务端口是否正常监听（ `netstat -ntple` 或 `ss -ntl` 检查端口监听 ）。对应端口是否可建立连接（可以用 `curl` 进行连接测试）。
2. Consul 配置文件存在，路径 `/etc/Consul.d/service/xx.json` 。
3. Consul 的启动参数有 `/etc/Consul.d/service/` 目录，我们 systemd 启动的 Consul 存在 `-configdir /etc/consul.d/service/` 参数。

## 配置 DNS 解析或配置 hosts

为了从外界访问蓝盾。您需要配置可用的 DNS 服务。在测试场景下，可以直接配置 hosts 。

可以考虑使用如下代码生成 hosts ：
```bash
source ${CTRL_DIR:-/data/install}/load_env.sh
for ip in ${BK_CI_GATEWAY_IP[@]-}; do
  printf "%-15s %42s\n" "$ip" "$BK_CI_FQDN"
done
```

## 访问蓝盾的集群内地址

蓝盾安装完成后，可以在集群内访问蓝盾的内部域名。

我们可以在中控机访问如下地址，预期会 302 到 http://bk-ci.service.consul/console/
```bash
curl -v http://bk-ci.service.consul
```

## 访问蓝盾的公开地址

> **注意**
> 
> 访问蓝盾的公开域名时，请先完成 “配置 DNS 解析或配置 hosts ” 章节。确保客户端上能解析到 `$BK_CI_FQDN`，或者配置 hosts 文件。
> 以及网络是否互通，有些场景下需要配置代理或者网络策略方可。
> 
> 当蓝盾在云上部署时，请留意配置 `云主机` 或 `负载均衡器` 的安全组，需放行您所在网络的公网 IP 。

```bash
source ${CTRL_DIR:-/data/install}/load_env.sh
curl -v "$BK_CI_PUBLIC_URL"
```

## 注册构建机

公共构建机需要注册到 dispatch 方可使用。

> **提示**
> 后续会推出一个运营系统，目前需要在 `ci(dispatch)` 节点调用脚本完成注册。

使用蓝盾安装包里的 `scripts/bkci-op.sh` 脚本在 `ci(dispatch)` 任一节点注册构建机，每个构建机 IP 仅需注册一次。

> **注意**
> 执行 `bkci-op.sh` 请登录到 `$BK_CI_DISPATCH_IP` 节点。

查看构建机

```bash
/data/src/ci/scripts/bkci-op.sh list  # list可以使用-v参数. 显示更多列.
```

添加构建机，默认状态为 false ， dispatch 会在 dockerhost 心跳后自动设置为 true ：

```bash
ip=构建机IP
/data/src/ci/scripts/bkci-op.sh add "$ip" enable=false
```

根据（蓝鲸部署根据解析 install.config 自动生成的）环境变量批量注册构建机：

```bash
source ${CTRL_DIR:-/data/install}/load_env.sh
for ip in ${BK_CI_DOCKERHOST_IP[@]-}; do
  echo "$ip";
  /data/src/ci/scripts/bkci-op.sh add "$ip" enable=false; 
done
```
