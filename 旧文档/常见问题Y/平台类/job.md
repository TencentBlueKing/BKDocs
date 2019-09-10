# 作业平台FAQ

## JOB启动失败

job启动失败常见原因：

- 若有日志，根据日志定位
	- 证书是否匹配
	- RabbitMQ连接是否失败
	- Redis连接是否失败
	- Mysql连接是否失败
	- 确定IP/密码/用户名是否存在及正确
- consul是否路由正确
- 端口问题`/data/bkce/etc/job.conf`配置项内的端口是否有冲突
- 环境问题导致没有日志，打开`/data/bkce/job/job/bin/jo.sh`的`NOHUPLOG=job_jvm_console.log`配置，再重启确认job的日志目录下的日志文件job_jvm_console.log进行确认
- 确认License合法及可以连接

## JOB作业一直等待执行

在执行作业时，步骤状态一直为等待执行，解决方法如下：

- RabbitMQ连接异常，作业启动信息收不到，请检查RabbitMQ，并重启Job进程尝试恢复
- 检查项：ijobs.amqp.addresses，ijobs.amqp.username，ijobs.amqp.password。其中ijobs.amqp.username，ijobs.amqp.password与app.code和app.secret配置项相同，并且RabbitMQ会在创建帐号后并授权vhost名为bk_job的使用权限

## JOB一直跳转登陆页面

此问题一般为PaaS登陆接口通信失败，解决方法如下：

- 检查`/data/bkce/etc/job.conf`中bk.paas.host配置项，确认地址是否可以连通，并确认PaaS是否正常
- 检查`/data/bkce/etc/job.conf`中bk.paas.host配置项app.code和app.secret配置是否正确，否则访问PaaS接口会鉴权试下而无法登录

## JOB无执行日志

在排除用户的脚本本身就不输出日志的正常情况，JOB出现无日志的情况有很多种，第一种是Job本身问题，与GSE无关，当error.log出现 Table has no partition for value xxxx  这种错，就是Job本身的问题，原因：

JOB对日志数据库表进行表分区， 并且要求MYSQL中启动事件调度功能，JOB默认会在版本升级时自动启用这个功能，在JOB的版本1.2.49之前，蓝鲸出厂默认的MySQL配置中没有开启这个功能，所以在MySQL被重启后，这个事件功能被关闭，随着时间流转，分区不够用了，会出现这个错误 。

解决办法可根据情况选择：

1.不想升级蓝鲸版本

•在Mysql配置文件my.cnf中的[mysqld]部分添加以下内容event_scheduler=ON   并重启MySQL

•请联系蓝鲸人员提供一个Job的临时启用event的SQL

2.升级蓝鲸到最新版本。

## JOB耗时时间长并无执行日志：Execution result log always

此问题出现在job.log文件内，并一直打印`redis reply is not string`这种情况，原因如下：

- 此情况属于GSE的任务管道或者Agent的原因导致的无日志，这种情况需要排查GSE服务是否正常，以及执行机器Agent进程是否正常，有可能在执行中被杀掉，导致长时间无上报执行日志给服务器
- 最终结果为JOB的作业执行日志出现`Execution result log always`，这个是在脚本作业的超时时间范围内如果连接10分钟内一直没有收到任何日志信息，JOB会触发保护，强制终止作业并返回上述信息给用户

## JOB脚本耗时长并失败：Script log timed out

出现此问题可能两种原因：

- 用户业务脚本问题：执行过于耗时的脚本，并且超过了设置的脚本超时时间，一般默认是1000秒，在此时间基础上多1-10%以内是正常的。若因为此原因，解决方法：修改耗时脚本或者修改脚本超时时间
- GSE Agent的问题：作业最终超时时间是在用户设置的超时时间再+20%，若用户设置了1000秒超时，但脚本最终在1200秒以上出现超时，则表示这个任务是因为Agent原因导致长时间无响应，最终JOB容错了20%的时间（1000+200秒）而强行触发终止。解决方法：重启GSE Agent再重试

## JOB连接GSE失败

这种报错，说明job连接gse_task异常 可能的原因如下：

- gse_task进程异常，48669端口（task提供给job通信的端口）未监听
- job配置文件`etc/job.conf`里配置的gse.taskserver.ip的值无法连通
- 证书问题，会爆出ssl字样的错误信息

## JOB无法发现Agent

这类报错说明job连接task是正常，但是agent状态异常

- agent 安装问题，失败，进程未正常启动
- agent到gse_task的48533端口未建立tcp连接
- agent证书和gse_task的不匹配，会爆ssl字样错误信息
- 云区域ID不匹配

## JOB平台错误代码

| 错误码  | 源   | 目标  | 描述                                                         |
| ------- | ---- | ----- | ------------------------------------------------------------ |
| 1210001 | JOB  | GSE   | GSE TaskServer 不可用                                        |
| 1210101 | JOB  | GSE   | 当前证书服务不可用，请检查license_server！                   |
| 1250001 | JOB  | Redis | Redis服务不可：IP不对或者配置错误                            |
| 1250002 | JOB  | Redis | Redis服务内存满或者其他问题：内存不足                        |
| 1259001 | JOB  | NFS   | NFS存储不可用                                                |
| 1252001 | JOB  | MYSQL | 数据库异常                                                   |
| 1255001 | JOB  | MQ    | Rabbit MQ不可用或者连接不上                                  |
| 1211001 | JOB  | CMDB  | CMDB服务状态不可达：地址配置错误                             |
| 1211002 | JOB  | CMDB  | CMDB接口返回数据结构异常。一般是被网关防火墙重定向返回非JSON协议内容 |
| 1211121 | JOB  | CMDB  | 蓝鲸业务下的Git模块没有IP（包管理）                          |
| 1213001 | JOB  | PAAS  | PAAS服务不可达 - 地址配置错误或者地址无法正确解析            |
| 1213002 | JOB  | PAAS  | PaaS接口返回数据结构异常。一般是被网关防火墙重定向返回非JSON协议内容 |