# 蓝鲸后台模块简介

部署、配置、维护蓝鲸，管理员需要理解蓝鲸的后台模块。

正如在蓝鲸的[产品功能架构图](https://bk.tencent.com/static/images/product/framework_ce_zh.png)所示。整套蓝鲸由 PaaS 平台、多个原子平台和上层 SaaS 应用组成。

本文简要介绍这些平台和 SaaS 的架构。

## PaaS 平台

首先需要了解 PaaS 平台及配套的用户管理和认证平台。

PaaS 平台包含：

- paas 后台模块，它包含五个子工程，社区版部署为了简化，均部署在同一台机器上，简称 paas 模块。
  - appengine
  - paas
  - esb
  - login
  - apigw
- paas_agent 模块，根据环境分为测试环境(appt)和正式环境(appo)，它的功能是和 paas 后台交互，处理 SaaS 部署相关逻辑。

PaaS 平台依赖 MySQL 存储应用数据、Redis 做缓存、Nginx 做接入层。

用户管理和认证平台包含：

后台模块：

- iam: 权限中心后台
- ssm: 凭证管理后台，蓝盾和容器管理平台部署依赖。
- usermgr: 用户管理后台

前台 SaaS：

- bk_user_manage: 用户管理 SaaS
- bk_iam: 权限中心 SaaS

## 配置平台

配置平台（以下简称 cmdb）包含十几个微服务进程，具体的架构参考：[蓝鲸配置平台的架构设计](https://github.com/Tencent/bk-cmdb/blob/master/docs/overview/architecture.md)

配置平台对外通过 `cmdb_apiserver` 提供 HTTP 协议接口接入到 PaaS 平台的 esb 总线对外提供访问。

内部微服务之间，通过 `zookeeper` 服务进行服务发现。数据库依赖 `MongoDB` 4.2 及以上版本。

## 管控平台

管控平台（以下简称 gse）包含 8 个后台服务进程和远端管控机器上部署的 agent 进程，提供蓝鲸平台的文件传输能力、实时任务执行能力、数据采集与传输的能力

gse 的具体架构参考：[GSE 产品架构图](../../../GSE/3.6/产品白皮书/产品架构图/Architecture.md)

从运维关注的进程脚本，每个后台进程的功能描述如下：

- gse_api: 对外提供 api 的服务程序，查询 agent 状态信息等。
- gse_task(TaskServer): 任务及控制服务端程序。该程序提供对集群内 Agent 的管理能力，并支持对 Agent 批量下和执行发命令或脚本
- gse_data(DataServer): 数据传输服务端程序。该程序主要提供对 Agent 采集的数据进行汇聚、分类、流转能力
- gse_btsvr(FileServer): 文件传输控制服务端程序。该程序对指定范围内 Agent 节点提供 BT 种子服务
- gse_dba: Redis 集群管理模块。通过代理对 Redis 的操作，完成 Redis 分布式集群的同一管控，支持 hash 写入，多备份写入等
- gse_procmgr: 进程管理服务程序。提供进程注册、操作、查询等原子操作，是节点管理的插件管理功能的后台程序之一
- gse_syncdata: 数据同步服务程序。该服务支持订阅并同步配置平台的主机身份信息到远端 Agent
- gse_alarm: Agent 状态监控程序。该程序会将心跳超时的 Agent 列表发给 gse_data

gse 后台在部署上，需要注意的是，gse_dba 必须和 Redis 同机部署。

gse 的客户端称为 gse_agent，gse_agent 的安装部署，通过节点管理实施。

## 作业平台

作业平台（以下简称 job），包含 6 个由 Sprint Cloud 框架开发的微服务。提供脚本执行，文件分发，和流程编排的能力。

作业平台依赖 GSE 提供的任务接口(gse_task)以及 cmdb 提供的拓扑和主机查询接口。

job 后台的 6 个进程，均为 java 进程，为了区分，使用定义的 systemd service 服务名如下：

- bk-job-config.service:    配置中心
- bk-job-gateway.service:   业务网关
- bk-job-manage.service:    作业管理
- bk-job-execute.service:   作业执行，作业历史
- bk-job-crontab.service:   定时任务管理和调度
- bk-job-logsvr.service:    作业执行日志存取

Job 后台进程之间通过 Consul 服务发现。通过 RabbitMQ 收发消息。Redis 做数据缓存。Mysql 存储作业相关信息。MongoDB 存储执行日志。

## 节点管理

节点管理分为 SaaS(bk_nodeman) 和后台(bknodeman)。它主要功能是对 gse_agent 及其插件的安装升级卸载整个生命周期进行管理。

## 监控平台

监控平台分为 SaaS(bk_monitorv3)和后台(bkmonitorv3)。

后台(bkmonitorv3)分为四个子工程：

- monitor: 监控后台，提供 api 接入 esb，供前端 SaaS 查询
- transfer: 原始数据清洗入库进程
- influxdb-proxy: InfluxDB 的读写代理，高可用部署方案依赖
- grafana: 监控仪表盘的后台

## 日志平台

日志平台分为 SaaS(bk_log_search)和后台(bklog)
