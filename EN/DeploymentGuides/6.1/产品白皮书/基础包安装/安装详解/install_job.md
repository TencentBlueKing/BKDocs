# 安装 Job 详解

Job 是蓝鲸作业平台后台，基于 Spring Cloud 微服务框架开发。依赖的第三方组件：

1. RabbitMQ：消息队列
2. Redis：会话/缓存
3. MongoDB：执行日志内容存储
4. MySQL：核心数据库

## 配置 Job

Job 的配置主要是由于微服务比较多，拆分比较细，不同的数据库可以使用不同的 MySQL 实例，社区版默认配置为了简化部署，均使用同一个 MySQL 实例。
具体来说，分为五个数据库：

1. job_manage
2. job_execute
3. job_backup
4. job_crontab
5. job_analysis

Job 的 Redis 模块配置逻辑和 bkiam 的类似，通过区分 standalone 和 sentinel，启用不同的 Redis 实例。社区版默认使用 standalone

Job 的 MongoDB 只有 job-logsvr 模块会使用，它的配置项（BK_JOB_LOGSVR_MONGODB_URI）是一个整串的 URI（mongodb://user:password@mongodb-job.service.consul:27017/joblog\?replicaSet=rs0），如果有特殊字符，请使用 urlencode 来编码。

Job 的 RabbitMQ 多个微服务从部署简化目的，可以使用同一个 vhost 和账户密码即可。

## 安装 Job

需要注意，Job 各模块的启动顺序，主要是 job-config 模块先启动，其他模块再启动。

```bash
./bkcli sync job
./bkcli install job backend
./bkcli install job frontend
./bkcli start job
```

1. Job 的前端静态资源可以分开不同机器部署，部署脚本默认放置在蓝鲸主 nginx 所在服务器上。
前端页面的 job/frontend/index.html 里有一个占位符 {{JOB_API_GATEWAY_URL}} 在部署脚本中，会替换为 job.env 配置中的 `BK_JOB_API_PUBLIC_URL` 变量的值，前后端通过这个 API 地址来交互。请保证浏览器可以访问到该变量配置的域名和端口。

2. 安装 job 后台：

    1. 首先安装 jdk 运行环境
    2. 执行实际安装后台的脚本：`/data/install/bin/install_job.sh -e /data/install/bin/04-final/job.env -s /data/src -p /data/bkce`
    3. 启动进程：`systemctl start bk-job.target`
    4. 向权限中心，注册作业平台的权限模型 `/data/install/bin/bkiam_migrate.sh -a "bk_job" -s "$BK_JOB_APP_SECRET" -e "/data/install/bin/04-final/job.env" /data/src/job/support-files/bkiam/*.json`
    