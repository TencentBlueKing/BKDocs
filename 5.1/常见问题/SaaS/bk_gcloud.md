# 标准运维常见问题

## 标准运维原子能否支持用户接入企业内 IT 系统

支持，接入方式请参考 [附录 3：原子开发](5.1/标准运维/附录/Django.md)。

## 标准运维点击开始执行任务后报错

`taskflow[id=1] get status error: node(nodee37e20…c7fb131) does not exist, may have not by executed`，并且在任务列表中查看任务状态是“未知”，可能是什么原因？

标准运维执行引擎依赖于蓝鲸的 RabbitMQ 服务和 App 启动的 celery 进程，请登录服务器确认服务已启动并正常运行，可以查看 App 的 celery.log 日志文件帮助定位问题原因。

## 标准运维能执行任务，但是原子节点报错

`Trackback…TypeError:int() argument must be a string or a number,not ‘NoneType’`，可能是什么原因？

标准运维任务流程的执行状态和原子输入、输出等信息缓存依赖 Redis 服务，所以首次部署请务必按照“标准运维部署文档”，配置 Redis 环境变量后重新部署。
