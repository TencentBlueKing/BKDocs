# 蓝鲸自监控指引

本文描述蓝鲸平台自身的组件监控，应该配置哪些基础的采集，告警策略以便能主动识别和提早发现问题。
具体实施落地，可以使用蓝鲸监控自身配置，也可以使用第三方的监控告警工具。

本文主要以使用蓝鲸配置平台和监控平台来完成自监控的配置。

## 配置信息梳理


在搭建部署文档的最后，有提示需要使用 `./bkcli initdata topo` 命令来自动创建《蓝鲸》业务下的集群模块拓扑结构。
并将服务器 ip 自动转移到对应的集群模块下，并自动应用了服务模板里配置的服务实例，包含了进程端口的配置。

在日常运维中，对蓝鲸后台服务器分布如果做了变更，包括扩容、缩容，大版本升级等。相应的集群模块和主机关系发生变动
需要及时更新配置平台信息，保障基础信息的准确性。

主机的负责人、备份负责人，也应该梳理清楚，相应人员的 Email、 手机号等通知渠道信息尽量准确。在使用蓝鲸监控告警通知时才能成功发送。

## 主机类

服务器主机的基础性能和异常告警，是最基础的配置，“蓝鲸监控” 开箱即启用了基础性能的默认策略。现列出实践中对《蓝鲸》业务下主机开启的主机
告警策略如下：

- Ping 不可达告警
- 主机重启
- 单机性能告警（5 分钟平均负载 > 16，5 个周期内发生 3 次）
- Corefile 产生
- 磁盘只读
- Agent 心跳丢失
- CPU 总使用率(>95%，5 个周期内发生 3 次)
- 磁盘 I/O 使用率(>85%，5 个周期内发生 3 次)
- 应用内存使用率(>95%，5 个周期内发生 3 次)
- 磁盘空间使用率(>95%)
- 磁盘 inode 使用率告警(>98%)
- OOM 异常告警

## 进程类

进程需要维护好 CMDB 上的进程端口配置，然后开启默认的进程端口不存在告警即可（依赖 processbeat 插件的正常运行）

## 第三方组件应用指标

### Elasticsearch

使用官方自带采集器指标，配置监控

- elasticsearch_cluster_health_status（集群状态 yellow, red, green, 如果不是 green 则告警）
- elasticsearch_thread_pool_queue_count（线程队列堆积数 > 200）

### RabbitMQ

使用官方自带采集器指标，配置监控

- rabbitmq_queue_messages_ready_total （>20000，5 周期内发生 3 次）

## 蓝鲸组件应用指标

蓝鲸的关键服务均通过 consul 服务注册，平时可以配置好 Consul 的 WebUI 来查看服务的情况。如果需要使用监控，当有服务异常时发送告警
可以采取自定义事件上报的方式来做监控。对于自定义上报功能，详细介绍参考监控平台白皮书中[自定义上报工具](../../../../Monitor/3.3/产品白皮书/guide/custom-report-tools.md)

最新的部署脚本里写了四个示例的自定义上报脚本：

- ./monitor/cmdb_healthz.sh
- ./monitor/consul_healthz.sh
- ./monitor/job_healthz.sh
- ./monitor/saas_healthz.sh

其中 cmdb_healthz、job_healthz.sh 需要在每台部署了 cmdb 和 job 的服务器配置 crontab 运行。
consul_healthz.sh 只用在中控机部署 crontab 运行。
saas_healthz 只用在任意一台 appo 上部署 crontab 运行。配置的 crontab 项实例如下：

```bash
# 蓝鲸监控healthz脚本告警
* * * * * sleep 7; /data/install/monitor/consul_healthz.sh <自定义上报数据ID> <自定义上报token> <自定义上报的地址url> <环境标签>
```

PaaS 平台 esb 组件的接口调用日志错误条数，可以纳入监控。

1. 配置日志采集，将 nginx 模块下的 paas_api_error.log 日志采集入库
2. 监控上配置采集项的日志条数告警，大于 1，则告警。因为正常情况下，该 error 日志不应该出现任何日志。