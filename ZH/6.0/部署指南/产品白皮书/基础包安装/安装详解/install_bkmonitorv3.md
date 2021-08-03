# 安装 蓝鲸监控 详解

蓝鲸监控平台可分为以下三部分：

1. 监控 SaaS （bk_monitorv3）
2. 监控后台（monitor, grafana）
3. 数据链路（transfer，influxdb-proxy）

首先分析下数据链路的部署依赖：

transfer 从 Kafka 中消费 GSE 的数据服务（gse-data）写入的指标和日志数据，进而通过 influxdb-proxy 写入 InfluxDB 集群（高可用方案启用时），或者 elasticsearch 集群。这里引入三个存储/队列组件：

- Kafka
- Elasticsearch
- InfluxDB

监控后台（monitor）组件，拉取事件和处理告警收敛过程中，会通过 Redis 队列来做缓存，所以也需要部署至少一套 独立的 Redis 服务。社区版为了简化部署，没有单独搭建监控用的 Redis。实际生产环境中，为了运行稳定，应该独立部署单独的 Redis。

## 配置监控

监控后台和数据链路都使用 `./bin/04-final/bkmonitorv3.env` 来做配置渲染。列举一些需要注意的配置如下：

蓝鲸监控后台使用的 MySQL 实例是：`BK_MONITOR_MYSQL_*` 变量定义的。
蓝鲸监控 SaaS 使用的 MySQL 实例是和 PaaS 数据库同一个实例：`BK_PAAS_MYSQL_*` 变量定义的。
在部署蓝鲸监控 SaaS 的时候同样，需要指定蓝鲸监控后台对应的 MySQL 实例，需要使用 SaaS 变量来满足。
在社区版中，由于后台和 SaaS 均使用同一个 MySQL 实例，故没有配置 SaaS 的变量。如果需要拆分，请在 SaaS 中定义以下变量来重新部署：

```bash
BKAPP_BACKEND_DB_HOST=
BKAPP_BACKEND_DB_PASSWORD=
BKAPP_BACKEND_DB_PORT=
BKAPP_BACKEND_DB_USERNAME=
```

对于 Elasticsearch 实例的配置，兼容历史版本的原因，有 `BK_MONITOR_ES_HOST` 和 `BK_MONITOR_ES_REST_PORT` 变量来使用 elasticsearch 5.x 的版本。
新版本中，只需要配置 `BK_MONITOR_ES7_*` 的变量即可，且需要带认证方式。

## 安装监控

安装监控的顺序很重要，需要强调一下：

```bash
migrate_sql monitorv3
./bkcli install saas-o bk_monitorv3
./bkcli sync bkmonitorv3
./bkcli install bkmonitorv3
./bkcli start bkmonitorv3
```

1. 先创建监控后台依赖的数据库表结构
2. 部署监控 SaaS（包含了初始化 SaaS 数据库表结构和权限中心模型注册）
3. 部署监控后台和数据链路组件
4. 启动蓝鲸监控



