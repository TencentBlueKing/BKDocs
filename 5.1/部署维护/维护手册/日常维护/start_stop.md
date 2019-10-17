# 蓝鲸日常维护

## 组件启停

一般情况，可以在中控机用 `bkcec start/stop <module> <project>` 方式来整体启停进程，但了解每个组件的手动启停方式也有助于运维好蓝鲸。另外需要特别注意的是，开源组件里分布式架构的 `Kafka` 、 `ZK` 、 `Consul` ，这些尽量逐个启停。

下面分三类来介绍不同组件的启停命令

## Supervisor 托管

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

## GSE 启停方法

GSE 组件分为 GSE 后台，GSE 客户端，GSE 插件，分别对应三个不同的启停进程：

- GSE 后台服务端： `/data/bkce/gse/server/bin/gsectl [start|stop|restart] <module>`

- GSE 客户端（Agent）:  `/usr/local/gse/agent/bin/gsectl [start|stop|restart]`

- GSE 插件进程（plugin）： `/usr/local/gse/plugins/bin/{stop,start,restart}.sh <module>`

## 开源组件

### Java

- Elasticsearch: 切换到 ES 用户执行 /data/bkce/service/es/bin/es.sh start

- ZooKeeper: /data/bkce/service/zk/bin/zk.sh start

- Kafka: /data/bkce/service/kafka/bin/kafka.sh start

### Golang/C/C++

- Nginx: nginx 或者 nginx -s reload

- Beanstalkd: `nohup beastalkd -l $LAN_IP -p $BEANSTALK_PORT &>/dev/null &`

- MySQL: /data/bkce/service/mysql/bin/mysql.sh start

- MongoDB: /data/bkce/service/mongodb/bin/mongodb.sh start

### Erlang

- RabbitMQ: `systemctl start rabbitmq-server`

## 蓝鲸组件

- License: `/data/bkce/license/license/bin/license.sh start`

- JOB: `/data/bkce/job/job/bin/job.sh start`

- APPO / APPT : 从 `/data/bkce/paas_agent/apps/Envs/*` 下遍历 workon home ，然后使用 `apps` 用户调用 supervisord 拉起进程。

## 第三方组件

- bk_network: `/data/bkce/bknetwork/bknetwork/bin/nms.sh start >/dev/null 2>&1`
