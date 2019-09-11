## 蓝鲸日常维护

### 统一术语 {#glossary}

- **INSTALL_PATH：** 安装路径，默认为 `/data/bkce`

- **CTRL_PATH：** 安装维护脚本所在目录，默认为 `/data/install`

- **PKG_SRC_PATH：** 组件原始包解压目录，默认为 `/data/src`

- **中控机：** 安装蓝鲸后台服务器中，选一台作为中控机，安装蓝鲸和运维蓝鲸，一般均从这台机器开始

- **source utils.fc：** 一些操作需要加载蓝鲸环境变量和函数后才能调用，此为 `cd $CTRL_PATH/ && source utils.fc` 的简写

- **bkcec <command> <module>：** 若无特殊说明，含义是：`cd $CTRL_PATH && ./bkcec <command> <module>`

下面提到路径时，均以默认路径为例，请根据实际安装路径修改相关命令

### 登陆指定服务器 {#login_srv}

一般维护操作时，均从中控机出发，跳转到其他模块服务器进行操作

假设发现作业平台模块启动失败，想登陆到作业平台模块所在服务器查看相关日志：

```bash
source utils.fc

# 这个命令用来加载环境变量（/data/install/*.env）和蓝鲸安装维护的函数（/data/install/*.{rc,fc})。
# 在该文档中，凡是提到查看 xx 函数的地方，可以用以下方法找到：
# source utils.fc;  type 函数名，例如想看 initdata_rabbitmq 做了什么事情，请运行 type initdata_rabbitmq ，返回的内容里可能也有没见过的函数调用，那继续使用 `type 函数名` 来查看
# grep "函数名 *()" *.rc *.fc 通过过滤函数定义，来寻找位置
#  编辑器内的搜索跳转
```

```bash
ssh $JOB_IP
# 因为 /data/install/config.env 里通过解析 install.config ，生成了模块对应的 IP ，所以，我们可以直接用 $MODULE_IP 这样的方式来访问。MODULE，用 install.config 里模块名的大写形式进行替换。譬如 bkdata 所在的 IP 为 $BKDATA_IP ，配置平台所在IP为 $CMDB_IP ，依此类推。
# 也可以输入 $ 符号后，用 <tab> 补全试试。
```

### 查看日志 {#logs}

日志文件统一在 `/data/bkce/logs/` 下，按模块名，组件名分目录存放。

假设需要查看作业平台的日志：

```bash
cd /data/bkce/logs/job
```

组件日志均在对应部署主机 $INSTALL_PATH/logs/$MODULE/ 目录下。

SaaS 较为特殊，在部署了 paas_agent 的主机 `/data/bkce/paas_agent/apps/logs` 下，根据 AppCode 名分目录存放。

### 组件启停 {#start_stop}

一般情况，可以在中控机用 `bkcec start/stop <module> <project>` 方式来整体启停进程，但了解每个组件的手动启停方式也有助于运维好蓝鲸。另外需要特别注意的是，开源组件里分布式架构的 `Kafka` 、 `ZK` 、 `Consul` ，这些尽量逐个启停。

下面分三类来介绍不同组件的启停命令

### Supervisor 托管 {#supervisor}

supervisord 和 supervisorctl 都会使用 Python 虚拟环境 (virtualenv) 来单独安装隔离。每个模块对应的虚拟环境名称，可以在机器上输入 `workon` 命令查看。

特别注意的是：Consul 使用全局的 `/opt/py27/bin/supervisord` 和 `/opt/py27/bin/supervisorctl`

Supervisor 托管的分两级维度， `module` 和 `project` ， `project` 可以单独启停。

例如：

```bash
./bkcec stop paas esb
./bkcec start paas esb
```

使用 Supervisor 托管的模块如下：

* bkdata/{monior,databus,dataapi}

* paas_agent

* open_paas

* fta ( FTA 比较特殊，单独封装了/data/bkce/fta/fta/bin/fta.sh 启停脚本)

* cmdb-server （配置平台的后台进程）

* consul （使用全局 Supervisor ）

以 bkdata/dataapi 为例，单独启动 dataapi 的进程：

```bash
# 进入虚拟环境
workon dataapi

# 启动
supervisord -c /data/bkce/etc/supervisor-bkdata-dataapi.conf

#临时停止，但不退出 supervisord
supervisorctl -c /data/bkce/etc/supervisor-bkdata-dataapi.conf stop all

# 完全退出，包括 supervisord
supervisorctl -c /data/bkce/etc/supervisor-bkdata-dataapi.conf shutdown
```
其他模块依此类推

### GSE 启停方法{#Gse_stop_start}

GSE 组件分为 GSE 后台，GSE 客户端，GSE 插件，分别对应三个不同的启停进程：

- GSE 后台服务端： `/data/bkce/gse/server/bin/gsectl [start|stop|restart] <module>`

- GSE 客户端（Agent）:  `/usr/local/gse/agent/bin/gsectl [start|stop|restart]`

- GSE 插件进程（plugin）： `/usr/local/gse/plugins/bin/{stop,start,restart}.sh <module>`

### 开源组件{#openplugins}

#### Java

- Elasticsearch: 切换到 ES 用户执行 /data/bkce/service/es/bin/es.sh start

- ZooKeeper: /data/bkce/service/zk/bin/zk.sh start

- Kafka: /data/bkce/service/kafka/bin/kafka.sh start

#### Golang/C/C++

- Nginx: nginx 或者 nginx -s reload

- Beanstalkd: `nohup beastalkd -l $LAN_IP -p $BEANSTALK_PORT &>/dev/null &`

- MySQL: /data/bkce/service/mysql/bin/mysql.sh start

- MongoDB: /data/bkce/service/mongodb/bin/mongodb.sh start

#### Erlang

- RabbitMQ: `systemctl start rabbitmq-server`

### 蓝鲸组件{#bk_plugins}

- License: `/data/bkce/license/license/bin/license.sh start`

- JOB: `/data/bkce/job/job/bin/job.sh start`

- APPO / APPT : 从 `/data/bkce/paas_agent/apps/Envs/*` 下遍历 workon home ，然后使用 `apps` 用户调用 supervisord 拉起进程。

### 第三方组件{#thirdplugins}

- bk_network: `/data/bkce/bknetwork/bknetwork/bin/nms.sh start >/dev/null 2>&1`

### 磁盘清理 {#disk_clean}

可能产生比较大数据量的目录有：

- /data/bkce/logs

- /data/bkce/public

- /data/bkce/service

logs 目录可以按需设置自动清理 N 天前的日志。

public 目录一般不能手动删除，一般比较大的组件可能有

- MySQL 数据库太大

- Kafka 数据

- Elasticsearch 数据


### 变更域名 {#change_domain}

- 修改 globale.env 中的域名配置信息。

- 修改 每台机器上的 `/etc/hosts` 匹配上新的域名。

- 修改完成后按如下命令顺序执行：

```bash
./bkcec sync common
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec stop
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec render
echo nginx paas cmdb job bkdata fta | xargs -n 1 ./bkcec start

 ```

如果有安装 SaaS ，到 **开发者中心-Smart 应用-已上线** 的 SaaS 操作栏里的【部署 】按钮，重新【一键部署】 SaaS。

### 全站 HTTP 切换 HTTPS {#convert_https}

- 修改 globale.env 中的 HTTP_SCHEMA='https'。

- 修改完成后按如下命令顺序执行。

- 全站 https 切换 http ，只需要修改 globale.env 中的 HTTP_SCHEMA='http' 即可，然后执行相同步骤即可

```bash
./bkcec sync common
./bkcec install nginx
./bkcec stop nginx
./bkcec start nginx
echo  job cmdb paas  | xargs -n 1 ./bkcec stop
echo  job cmdb paas  | xargs -n 1 ./bkcec render
echo  job cmdb paas  | xargs -n 1 ./bkcec start
echo  job cmdb paas  | xargs -n 1 ./bkcec status
  ```

### 变更 DEFAULT_HTTP_PORT 端口 {#change_http_port}

安装好后的蓝鲸访问端口默认是 80 ，如果安装成功后想修改它，需要按以下步骤：

1. 修改 ports.env 文件里的 `DEFAULT_HTTP_PORT` 值为新的端口

2. 同步配置到其他机器：`./bkcec sync common`

3. 渲染涉及到的进程的模块文件

    ```bashplainplainplainplainplain
    ./bkcec render $module
    ```
知道如何操作以及为什么需要这样操作：

修改 DEFAULT_HTTP_PORT 后，PAAS_HTTP_PORT CMDB_HTTP_PORT JOB_HTTP_PORT，这些端口都发生了变化。我们需要了解哪些配置文件模板引用了他们。所以，执行命令：

```bash
grep -lrE "(JOB|CMDB|PAAS|DEFAULT)_HTTP_PORT" /data/src/*/support-files/
```

发现，涉及的文件所在模块为：`bkdata,cmdb,fta,gse,job,miniweb,open_paas,paas_agent,nginx`。所以这些文件均需要重新 `render` 配置，然后重启模块生效。

以下模块需要 `render` 操作：

```bash
echo cmdb job gse paas appo bkdata fta | xargs -n 1 ./bkcec render
```

APPO(paas_agent) 的配置需要一个特殊操作：

```bash
./bkcec initdata appo
```

Nginx 和 miniweb 较为特殊，需要以下命令：

```bash
./bkcec install nginx
./bkcec stop nginx
./bkcec start nginx
```

重启其余进程:

```bash
for module in cmdb job gse paas appo bkdata fta; do ./bkcec stop $module ; sleep 2; ./bkcec start $module ;done
```

### 更新证书 {#update_cert}

有时候 GSE 和 License 所在服务器的 MAC 地址发生了变化，此时证书需要重新从官网生成下载，然后操作更新证书的步骤

中控机上解压新的证书

```bash
cd /data/src/cert && rm -f *
tar -xvf /data/ssl_certificates.tar.gz -C /data/src/cert/
```

操作更新相关组件

```bash
source /data/install/utils.fc
for ip in ${ALL_IP[@]}; do
    _rsync -a $PKG_SRC_PATH/cert/ root@$ip:$PKG_SRC_PATH/cert/
    _rsync -a $PKG_SRC_PATH/cert/ root@$ip:$INSTALL_PATH/cert/
done

 for ip in ${JOB_IP[@]}; do
     rcmd root@$ip "gen_job_cert"
 done

./bkcec stop license
./bkcec start license
./bkcec stop job
./bkcec start job
./bkcec install gse 1
./bkcec stop gse
./bkcec start gse
./bkcec stop bkdata
./bkcec start bkdata
./bkcec stop fta
./bkcec start fta
```

Proxy 和 Agent 的更新，需要把新的 cert 目录传到对应机器的路径：

- agent: `/usr/local/gse/agent/cert/`
- proxy: `/usr/local/gse/proxy/cert/`

然后重启进程：

- Proxy 和 Agent 均为：`/usr/local/gse/agent/bin/gsectl restart`

### 迁移服务 {#migrate_module}

假设想将 BKDATA 模块从目前混搭的服务器上，迁移到一台新机器，可以按如下步骤操作：

- 停掉原来服务器上的 BKDATA 进程 `./bkcec stop bkdata`
- 修改 install.config 文件，新增一行 `$ip bkdata` IP 为待迁移的机器 IP ，删除原 ip 所在行的 `bkdata`
- 新机器配置好中控机的 SSH 免密登陆

除非特别指出，在中控机上依次执行以下命令，每一个命令成功后，再继续下一个：

```bash
# 同步 install.config 更改
./bkcec sync common

#  同步基础依赖 Consul
./bkcec sync consul

# 同步 BKDATA 模块
./bkcec sync bkdata

# 安装 Consul
./bkcec install consul

# 重启 Consul
./bkcec stop consul
./bkcec start consul

# 安装 BKDATA
./bkcec install bkdata

# 给新机器授予 MySQL 权限
./bkcec initdata mysql

#  给新的 BKDATA 补上初始化标记文件
ssh $BKDATA_IP 'touch /data/bkce/.dataapi_snaphost'

# 启动新的 BKDATA
./bkcec start bkdata
```

登陆到老的 BKDATA 机器，将标记文件 /data/bkce/.installed_module 文件中的 BKDATA 行删除：

```bash
sed -i '/bkdata/d' /data/bkce/.installed_module
```

其余模块的迁移流程大致和 BKDATA 类似。只是部分模块有一些特殊注意事项需要额外做一些操作。列举如下：

- PaaS 迁移。因为 PaaS IP 地址发生了改变，而作业平台的配置文件 job.conf 中，有一项 api.ip.whitelist 配置，需要随之修改。可以在迁移完 PaaS 后运行如下命令自动修改生效
  ```bash
  ./bkcec render job
  ./bkcec stop job
  ./bkcec start job
  ```
  PaaS 迁移后，Nginx 上对 PaaS 的反向代理配置也需要跟随改变，Nginx 需要重新渲染配置，重新加载配置。

### 单机部署增加一台 APPT{#add_appt}

使用单机部署方案，虽然 install.config 里自动配置了 APPT 和 APPO 两个模块，但实际生效的只有 APPO 。部署蓝鲸官方的 SaaS，只需要 APPO 即可。

用户如果有自己开发 SaaS 应用，提测时，平台会提示没有可用的测试环境。这时需要扩充一个 APPT 环境。运维操作如下, 以下命令均在中控机上执行：

1. 新增一台服务器 (假设 IP 为 10.0.0.2) 作为 APPT ，机器配置 1 核 1G 以上即可，跑的测试 SaaS 越多，配置需求越高。

2. 登陆中控机，编辑 install.config , 新增一行
    ```bash
    10.0.0.2 appt
    ```
    并将原来 install.config 第一行中的 `APPO,APPT` 换成 `APPO`
3. 对 10.0.0.2 配置好 SSH 免密登陆。

4. 依次运行以下命令开始安装 APPT

    ```bash
    ./bkcec sync common
    ./bkcec sync consul
    ./bkcec sync appt
    ./bkcec install consul
    ./bkcec stop consul
    ./bkcec start consul
    ./bkcec install appt
    ./bkcec initdata appt
    ./bkcec start appt
    ./bkcec activate appt
    ```
5. 查看开发者中心->服务器信息中，类别为《测试服务器》的信息是否正确，状态是否激活。


### 健康检查{#health_check}

蓝鲸产品后台提供了健康检查的接口，用 HTTP GET 请求访问，接口地址和端口用变量表达：

```bash
cd /data/install && source utils.fc

# PAAS 注意 URL 末尾带上/
curl http://$PAAS_FQDN:$PAAS_HTTP_PORT/healthz/

# 配置平台 (beta)，目前版本不够准确
curl http://$CMDB_IP:$CMDB_API_PORT/healthz

# 作业平台
curl http://$JOB_FQDN:$PAAS_HTTP_PORT/healthz
```

蓝鲸监控 SaaS 的监控检查接口，可以用浏览器直接访问:

```bash
http://$PAAS_FQDN:$PAAS_HTTP_PORT/o/bk_monitor/healthz/
```

### 机器重启后 {#host_reboot}

- 确认 /etc/resolv.conf 里第一个 nameserver 是 `127.0.0.1`， `option` 选项不能有 `rotate`
- 检查重启机器的 crontab ，是否有自动拉起进程的配置 `crontab -l | grep process_watch` ，重启后的自动拉起主要靠 crontab
- 中控机上确认所有进程状态： `./bkcec status all` , 正常情况下应该都是正常拉起 `RUNNING` 状态，如果有 `EXIT` 的，则尝试手动拉起。手动拉起的具体方法参考 [组件的启动停止](./maintain.md#start_stop)
- 如果社区版所有机器同时重启，很大概率会有很多进程启动失败，因为不同机器上组件恢复的时间没法控制，导致依赖的组件还没启动起来，导致失败，连锁反应。所以这种情况，遵循和安装时的启动原则:
    1. 先启动 DB

    2. 启动依赖的其他开源组件及服务

    3. 启动蓝鲸产品

- 如果已经部署过 SaaS ，那么手动拉起。
    ```bash
    ./bkcec start saas-o # 正式环境
    ./bkcec start saas-t # 测试环境
    ```
