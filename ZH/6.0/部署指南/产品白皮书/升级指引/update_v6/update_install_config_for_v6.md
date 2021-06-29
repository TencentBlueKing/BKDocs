# 社区版 5.1-6.0 install.config 配置

## 原机器配置进行升级

**原则上：建议在是不改变原 5.1 模块的分布，而是将新增的模块进行的合理分布、修改变化的模块名以及去掉不需要的模块即可。**

以蓝鲸默认分布的模块为例。
如原来部署时，调整过模块的位置，请自行合理的将相关模块分布到机器上。避免因分布不合理，导致个别主机资源不足产生问题。

**原 5.1 install.config 模板分布文件**

```bash
[bkce-basic]
10.0.0.1 nginx,rabbitmq,kafka(config),zk(config),es,appt,fta,consul,bkdata(databus)
10.0.0.2 mongodb,appo,kafka(config),zk(config),es,mysql,consul,bkdata(dataapi),beanstalk
10.0.0.3 paas,cmdb,job,gse,license,kafka(config),zk(config),es,redis,influxdb,consul,bkdata(monitor)
```

**现 6.0 install.config 模块分布**

```bash
10.0.0.1 iam,ssm,usermgr,gse,license,redis,consul,es7,monitorv3(influxdb-proxy),monitorv3(monitor),monitorv3(grafana)
10.0.0.2 nginx,consul,mongodb,rabbitmq,appo,influxdb(bkmonitorv3),monitorv3(transfer),fta,beanstalk
10.0.0.3 paas,cmdb,job,mysql,zk(config),kafka(config),appt,consul,log(api),nodeman(nodeman),log(grafana)
```

### 详细操作

1. 去掉 `bkdata(databus),bkdata(dataapi),bkdata(monitor)` 模块。

2. 将 `influxdb`、`es` 模块更名为 `influxdb(bkmonitorv3)`、`es7`。

3. 然后将新增的`iam、ssm、usermgr、monitorv3(influxdb-proxy)、monitorv3(monitor)、monitorv3(grafana)、monitorv3(transfer)、nodeman(nodeman)、log(api)、log(grafana)`模块合理的分布到机器上。分布可参考 6.0 install.config 模块分布。

## 新增主机进行升级

新增主机进行升级，是将增强套餐的监控平台、日志平台、故障自愈进行剥离升级。而基础套餐则保持在原环境机器上进行升级。

**原则上：建议在是不改变原 5.1 模块分布的原则上，将新增的模块进行的合理分布、修改变化的模块名以及去掉不需要的模块即可。**

### 详细操作

1. 去掉 `bkdata(databus)`、`bkdata(dataapi)`、`bkdata(monitor)` `influxdb`、`es`、`kafka(config)`、`fta`、`beanstalk`模块。去掉两个 zk(config)模块，在任意一台机器上保留一个即可（建议先进行资源评估，再决定在哪台机器上保留）。

**去掉后效果如下：**

```bash
[bkce-basic]
10.0.0.1 nginx,rabbitmq,zk(config),appt,consul
10.0.0.2 mongodb,appo,mysql,consul
10.0.0.3 paas,cmdb,job,gse,license,redis,consul
```

2. 将 `iam`、`ssm`、`usermgr`、`nodeman(nodeman)`模块合理的分布在原机器环境上。

3. 将 `kafka(config)`、`influxdb(bkmonitorv3)`、`es7`、`monitorv3(influxdb-proxy)`、`monitorv3(monitor)`、`monitorv3(grafana)`、`monitorv3(transfer)`、`log(api)`、`log(grafana)`、`fta`、`beanstalk`、`consul` 模块分布在新增的机器上。

**变更后效果如下：**

**注意：** 该效果不包含详细操作的第 2 点。需要自行合理的分布在原环境的机器上。

```bash
[bkce-basic]
10.0.0.1 nginx,rabbitmq,zk(config),appt,consul
10.0.0.2 mongodb,appo,mysql,consul
10.0.0.3 paas,cmdb,job,gse,license,redis,consul

10.0.0.4 consul,kafka(config),influxdb(bkmonitorv3),es7,monitorv3(influxdb-proxy),monitorv3(monitor),monitorv3(grafana),monitorv3(transfer)
10.0.0.5 consul,log(api),log(grafana),fta,beanstalk
```

分配模块后，可以返回升级指引继续后续升级操作。
