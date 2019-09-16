## 蓝鲸组件配置文件

### 开源组件

开源组件的实际配置均在 `/data/bkce/etc` 目录下，而这些配置文件其实是通过变量替换
`/data/src/service/support-files/templates/` (模板目录路径随用户解压至的目录而不同) 下的预设模板文件生成的，所以要从源头修改配置应该修改 `/data/src` 下的，然后通过以下命令同步，并渲染模板文件：

- ./bkcec sync 模块
- ./bkcec render 模块

渲染模板时，bkcec 脚本通过调用 templates_render.rc 里定义的函数 `render_cfg_templates` 来实现
举例说明，假设 `/data/src/service/support-files/templates/` 目录下有如下文件：

- \#etc#nginx#job.conf  
那么当模板渲染时，它里面的占位符诸如 `__BK_HOME__` 会被对应的 `$BK_HOME` 变量的值替换掉
然后生成 `/data/bkce/etc/nginx/job.conf` 这个文件。可以发现，脚本将文件名中的 `#` 替换成 `/` ，然后放到 `$INSTALL_PATH` 目录下，也就是默认的 `/data/bkce`

- kafka#config#server.properties  
这个形式的模板文件和上述的不同之处时没有以 `#` 开头，那么它表示一个相对模块安装路径的配置，也就是
对于 `/data/src/service/` 来说，它会被安装到 `/data/bkce/service` ，那么 `kafka#config#server.properties` 就会生成到 `/data/bkce/service/kafka/config/server.properties`

- \#etc#my.cnf.tpl  
这类文件名和第一个不同之处在于多了 `.tpl` 的后缀名，生成时 tpl 后缀会被去掉。

其他模块文件，以此类推。

以下列举当前所有的开源组件配置文件路径：

#### Nginx

- \#etc#nginx.conf  
Nginx 主配置文件，安装时会 `ln -s /data/bkce/etc/nginx.conf /etc/nginx/nginx.conf`

- \#etc#nginx#paas.conf  
PaaS 平台的 Nginx server 配置

- \#etc#nginx#cmdb.conf  
配置平台的 Nginx server 配置，主配置会 include `/data/bkce/etc/nginx/` 下的配置文件

- \#etc#nginx#job.conf
作业平台的 Nginx server 配置

- \#etc#nginx#miniweb.conf  
存放 Agent 安装时所需要下载的脚本和依赖软件包

#### RabbitMQ

- \#etc#rabbitmq#rabbitmq-env.conf
- \#etc#rabbitmq#rabbitmq.config
- \#etc#rabbitmq#enabled_plugins

####  MongoDB

- \#etc#mongodb.yaml

#### MySQL

- \#etc#my.cnf.tpl

#### Redis

- \#etc#redis.conf

#### Consul

Consul 的配置文件比较特殊，因为它是全局依赖， Consul 的配置文件会存放在 `/data/bkce/etc/consul.conf` ，它没有对应的模板文件，是由 `/data/install/parse_config` 这个脚本来生成。不过 Consul 启动的 supervisor 配置文件模板在：

- \#etc#supervisor-consul.conf

#### ZooKeeper

- \#etc#zoo.cfg

#### Elasticsearch

- es#config#elasticsearch.yml.tpl

#### Kafka

- kafka#config#server.properties

#### InfluxDB

-  \#etc#influxdb.conf

#### Beanstalk

- \#etc#beanstalkd

### 蓝鲸组件

蓝鲸组件除了作业平台和管控平台，其他均用 supervisor 来做进程启停，所以都会存在一个对应的 supervisor 进程配置文件
它的标准规范是：\#etc#supervisor-模块名-工程名.conf，如果没有子工程，则工程名等于模块名。例如 bkdata 存在三个子工程，所以各自的 supervisor 配置为：

- \#etc#supervisor-bkdata-dataapi.conf
- \#etc#supervisor-bkdata-databus.conf
- \#etc#supervisor-bkdata-dataapi.conf

故障自愈模块，因为没有子工程，所以它的 supervisor 配置文件为：

- \#etc#supervisor-fta-fta.conf

因为 supervisor 配置具有一致性，下面不再具体列举 supervisor 相关配置文件。

#### 配置平台 CMDB

CMDB 的后台是微服务化架构，每个进程对应一个配置文件，所以配置文件模板也有很多，

- server#conf#模块名.conf

模块名对应进程名，比如进程名叫 `cmdb_webserver` 那它对应的配置文件名叫 webserver.conf

- \#etc#nginx#cmdb.conf

CMDB 进程对应的 Nginx 配置，里面会通过 url rewrite 兼容 v2 的接口。cmdb_webserver 提供的 Web 页面
也是经过这层 Nginx 反向代理。

#### 作业平台 JOB

作业平台的配置文件比较简单。一个配置文件，一个启动脚本：

-  \#etc#job.conf

主配置文件，里面的中文注释非常详尽，这里不再赘述。

- job#bin#job.sh  

Job 进程的启停脚本，里面可以设置一些调试参数，Java 虚拟机内存分配大小等

#### PaaS

PaaS 平台 在 src 目录下叫 open_paas 它实际上由 appengine login esb paas 四个子工程组成。

- \#etc#uwsgi-open_paas-工程名.ini  

这里工程名用上面四个工程分别替换可得到，是这四个 Python 工程 uwsgi 的配置文件

以下四个分别是对应工程的 配置文件

- paas#conf#settings_production.py.tpl
- login#conf#settings_production.py.tpl
- esb#configs#default.py.tpl
- appengine#controller#settings.py.tpl

其中 ESB 的配置中，配置了访问其他周边模块的接口域名和端口。

#### GSE

GSE 目录下的模板文件分为 agent、plugins、proxy、后台。

GSE 后台的配置模板，需要留意的是生成后的配置中监听的 IP 地址是否符合预期：

- \#etc#gse#api.conf
- \#etc#gse#btsvr.conf
- \#etc#gse#data.conf
- \#etc#gse#dba.conf
- \#etc#gse#task.conf

GSE Proxy 后台的配置模板:

- proxy\#etc#btsvr.conf
- proxy\#etc#proxy.conf
- proxy\#etc#transit.conf

GSE Agent 的配置模板，`*` 表示匹配所有的，这里 Agent 按系统和 CPU 架构区分了不同的目录

- agent_*\#etc#agent.conf
- agent_*\#etc#iagent.conf
- agent_*\#etc#procinfo.conf

GSE agent plugins 的配置模板

- plugins_*\#etc#basereport.conf
- plugins_*\#etc#alarm.json

#### paas_agent

paas_agent 是 appo、和 appt 模块对应的后台代码目录，它的配置文件由两部分构成：

- \#etc#nginx.conf  #etc#nginx#paasagent.conf  

paas_agent 依赖一个 Nginx 做路由转发，这里是它的 Nginx 配置

- \#etc#paas_agent_config.yaml.tpl  

paas_agent 的主配置，需要特别注意的是，这里的 `sid` 和 `token` 是激活 paas_agent 成功后，获取返回的字符串自动填充的，里面的配置应该和开发者中心，服务器信息页面看到的一致

#### BKDATA

BKDATA 分为`dataapi` 、 `databus` 、 `monitor` 三个工程，dataapi 是 Python 工程，databus 是 Java 工程，monitor 是 Python 工程。

dataapi 的配置：

- dataapi#conf#dataapi_settings.py
- dataapi#pizza#settings_default.py
- dataapi#tool#settings.py

databus 的配置：

- databus#conf#es.cluster.properties
- databus#conf#jdbc.cluster.properties
- databus#conf#tsdb.cluster.properties
- databus#conf#etl.cluster.properties
- databus#conf#redis.cluster.properties

monitor 的配置：

- monitor#bin#environ.sh
- monitor#conf#worker#production#community.py

#### 故障自愈 FTA

故障自愈后台的配置

- `fta#project#settings_env.py`

### 常用配置调整

调整后的配置模板文件请自行备份好，如果遇到升级，需要手工对比后再覆盖，如果升级后的文件没有新增配置，可以直接覆盖，但如果升级后的配置文件有新增，需要自行处理合并。

#### 调整 Redis 使用的最大内存大小

编辑 `/data/src/service/support-files/templates/#etc#redis.conf`

插入一行，比如限制最大使用 4GB 内存：

```plain
maxmemory 4G
```

再执行以下命令生效：

```bash
./bkcec sync redis
./bkcec render redis
./bkcec stop redis
./bkcec start redis
```

#### 调整 BKDATA 的 databus 内存使用大小

databus 目前有五个进程，对应的配置文件分别是：

```plain
/data/src/bkdata/support-files/templates/databus#conf#es.cluster.properties
/data/src/bkdata/support-files/templates/databus#conf#etl.cluster.properties
/data/src/bkdata/support-files/templates/databus#conf#jdbc.cluster.properties
/data/src/bkdata/support-files/templates/databus#conf#redis.cluster.properties
/data/src/bkdata/support-files/templates/databus#conf#tsdb.cluster.properties
```

分别修改这五个文件里的 "deploy.cluster.memory.max" 的值，根据实际情况调大小。原则：如果内存够用，但 CPU 占用很高，适当调大；如果内存不够用，CPU 占用正常，可以适当调小。

#### 调整 ES 的内存使用大小

修改 `/data/bkce/service/es/config/jvm.options` 里的

```plain
-Xms1G
-Xmx1G
```

为合适的数值，如果不需要用日志检索，那可以尽量调低。

#### 调整 Kafka 的内存使用大小

修改 `/data/bkce/service/kafka/bin/kafka-server-start.sh` 里的

KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"

#### 调整 FTA 进程数

`/data/bkce/etc/supervisor-fta-fta.conf` 里 numprocs 和 gunicorn 的进程数

#### 调整 Bkdata-dataapi 的 worker 数

`/data/bkce/etc/supervisor-bkdata-dataapi.conf` 里的 gunicorn 的 -w 参数

#### 调整 Bkdata-monitor 的进程数

`/data/bkce/etc/supervisor-bkdata-monitor.conf` 里的 numprocs 配置项

#### 调整 PaaS 的 worker 数量

`/data/bkce/etc/uwsgi-open_paas*.ini` 里的 workers 配置

#### 调整 JOB 的内存使用大小

`/data/bkce/job/job/bin/job.sh里startup()` 函数下的 JOB_JAVA_OPTS="-Xms256M -Xmx256M"
