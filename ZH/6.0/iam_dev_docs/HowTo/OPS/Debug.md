# 运维问题

# 1. 权限中心服务是否可用

权限中心分为 SaaS 和 后台两部分；
- 通过桌面/控制台权限中心入口打开页面， 请求落到 SaaS， 主要处理权限申请/审批/管理等。 如果 SaaS 不可用， 需要从开发者中心查询相关日志(`开发者中心-Smart应用-权限中心V3-日志查询`)
- 接入系统鉴权等接口， 请求落到后台。如果后台不可用， 需要从 bkiam 后台日志排查对应问题(注意可能部署在多台机器)

如何确认权限中心 SaaS 服务可用
1. 确认 SaaS 服务健康 `curl -vv http://{PAAS_HOST}/o/bk_iam/healthz`, 正常应该返回`ok`
2. 查看 SaaS 服务的系统日志 `bk_iam.log`和 API 请求日志`uwsgi.log` 中 是否有异常堆栈信息(error)
3. 确认第三方服务是否正常, 查看`component.log`确认是否有异常信息(error)
4. 确认后台异步任务是否正常，查看`celery.log` 确认是否有异常信息(error)
5. 确认 SaaS 服务的依赖`MySQL`/`Redis`/`RabbitMQ` 可达/正常

如何确认权限中心后台服务可用?
1. 确认后台服务可达 `curl -vv http://{IAM_HOST}/ping`, 正常应该返回`{"message": "pong"}`(可以使用[IAM-Debug CLI](./SelfHelp/DebugCLI.md)确认)
2. 确认后台服务健康 `curl -vv http://{IAM_HOST}/healthz`, 正常应该返回`ok`(可以使用[IAM-Debug CLI](./SelfHelp/DebugCLI.md)确认)
3. 查看后台服务的系统日志 `iam.log` 是否有异常堆栈信息(error) / `iam_api.log` 中的请求处理响应时间是否超过 100ms
4. 确认后台服务所在机器的 `负载/网络/IO` 等正常
5. 确认后台服务依赖的 `Redis`/`MySQL` 可达/正常; 查看后台日志 `iam_sql.log`是否有大量 SQL 慢请求日志
6. 确认第三方服务是否正常, 查看`iam_component.log`确认是否有异常信息(error)

