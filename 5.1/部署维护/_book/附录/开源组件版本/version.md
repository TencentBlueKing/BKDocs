## 产品和组件版本

该文档列出当前最新对外社区版的各蓝鲸产品版本号和安装包自带的开源组件版本。

### 一. 蓝鲸产品版本

1. 软件包后台版本号，可在部署环境中用命令来查询：

```bash
# 登录到中控机，切换到软件包目录
cd /data/src

# 过滤出所有软件的后台版本号
grep . */VERSION */*/VERSION
```

  - 版本输出示例：

  ```bash
  bknetwork/VERSION:3.6.0
  cmdb/VERSION:0.0.38
  fta/VERSION:4.1.2
  gse/VERSION:3.2.2
  job/VERSION:4.2.3
  license/VERSION:3.1.4
  open_paas/VERSION:3.0.48
  paas_agent/VERSION:3.0.8
  bkdata/dataapi/VERSION:1.2.92
  bkdata/databus/VERSION:1.2.23
  bkdata/monitor/VERSION:0.1.7
  ```

2. 部署维护脚本包版本号：

```bash
# 登录到中控机，获取部署脚本包的版本号
cat /data/install/VERSION
```

3. SaaS 包版本号，在 **蓝鲸工作台 - 开发者中心 - S-mart 应用** 可以看到。

### 二. 蓝鲸自带的开源组件版本

以下开源组件是包含在蓝鲸提供的 src 包中，按照时拷贝到指定路径安装的。

* Consul：`consul version` v0.8.3。

* Java：`java -version` 1.8.0_131。

* Python:
  * `/opt/py27/bin/python --version` 非 PaaS 用的版本：2.7.10。

  * `/usr/local/bin/python --version` PaaS 专用版本：2.7.9。

* MySQL：`./mysqld --version` 5.5.24-patch-1.0。

* MongoDB：`./mongod --version`  v3.6.3。

* Redis：`./redis-server --version` v3.2.9。

* InfluxDB：`influxd version` 1.3.6。

* ZooKeeper：登陆到 ZK 运行机器执行 `source /data/install/utils.fc; echo envi | nc $LAN_IP 2181 | grep version` v3.4.10。

* Kafka：`cd /data/src/service/kafka/ && find libs/ -name "*kafka_*.jar" | head -1 |  cut -d- -f2` v0.10.2.0。

* Elasticsearch：登陆到 ES 运行机器执行 `source /data/install/utils.fc; curl $LAN_IP:$ES_REST_PORT` v5.4.0。

还有一部分开源组件，是安装脚本使用 `yum` 来安装的，这些组件版本号取决于安装蓝鲸的
操作系统上配置的 Yum 源中软件仓库的版本。请使用 `yum info 包名` 来确认。

* Nginx

* RabbitMQ-Server

* Beanstalk
