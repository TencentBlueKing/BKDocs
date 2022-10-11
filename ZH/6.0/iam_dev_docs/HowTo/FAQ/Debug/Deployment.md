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
1. 确认后台服务可达 `curl -vv http://{IAM_HOST}/ping`, 正常应该返回`{"message": "pong"}`(可以使用[IAM-Debug CLI](./DebugCLI.md)确认)
2. 确认后台服务健康 `curl -vv http://{IAM_HOST}/healthz`, 正常应该返回`ok`(可以使用[IAM-Debug CLI](./DebugCLI.md)确认)
3. 查看后台服务的系统日志 `iam.log` 是否有异常堆栈信息(error) / `iam_api.log` 中的请求处理响应时间是否超过 100ms
4. 确认后台服务所在机器的 `负载/网络/IO` 等正常
5. 确认后台服务依赖的 `Redis`/`MySQL` 可达/正常; 查看后台日志 `iam_sql.log`是否有大量 SQL 慢请求日志
6. 确认第三方服务是否正常, 查看`iam_component.log`确认是否有异常信息(error)

# 2. 权限中心 SaaS 日志说明
| 文件名 | 说明 | 日志级别 | 备注 |
|-----|----|------|----|
| bk_iam.log    | 后台日志   |  info    |  IAM SaaS 本身进程打印日志, 包含基本运行信息 (IAM SaaS 服务报错) |
|  uwsgi.log    | API 请求 Uwsgi 日志   |  info    |  默认是所有请求流水日志，特别是 500 等系统异常，可直接查看该日志  |
|  component.log   |  请求第三方接口日志  |  info    |  调用第三方系统接口流水日志，包括对 IAM 后台服务、用户管理、ITSM 以及`接入系统回调接口`  |
|  celery.log   | 异步任务日志   |  info    | 后台异步任务日志，包括`同步组织架构`、续期通知等  |

# 3. 权限中心后台日志说明

如果请求 `url = /api/c/compapi/v2/iam/[application | authorization]`, 那么需要从开发者中心 S-mart 应用查询相关的日志(`开发者中心-Smart应用-权限中心V3-日志查询`)

如果请求 `url = /api/v1/[model | policy | systems]`, 那么需要从后台日志查对应的`request_id`(注意可能部署在多台机器)

| 文件名 | 说明 | 日志级别 | 备注 |
|-----|----|------|----|
| iam.log    | 后台日志   |  info    |  IAM 系统本身进程打印日志, 包含基本运行信息 (IAM 后台服务报错) |
|  iam_api.log    | 鉴权 API 流水日志   |  info    |  接入系统使用`/api/v1/query`进行鉴权的流水日志; 默认记录所有鉴权请求日志 (接入系统鉴权报错)  |
|  iam_sql.log   |  SQL 日志  |  info    |  SQL 执行语句日志;  如果日志级别是 debug, 记录所有日志, 否则, 只记录执行时间大于 20ms 的 SQL 语句 **注意: 如果使用 debug 将导致服务性能大幅下降**  |
|  iam_audit.log   | 模型注册流水日志   |  info    | 接入系统使用`/api/v1/model`进行模型注册的流水日志 (接入系统注册模型报错)   |
|  iam_web.log   |  SaaS 访问流水日志  |  info    | IAM 前端 SaaS 调用后台接口`/api/v1/web/`的流水日志; 默认打印所有 SaaS 请求日志 (IAM SaaS App 访问后台报错)   |
|  iam_component.log   | 请求第三方接口日志   |  error    | 调用第三方系统接口流水日志;   如果日志级别是 debug, 打印所有日志, 否则, 只记录非 200 及发生报错的请求日志 **注意: 如果使用 debug 将导致跨系统资源依赖相关的鉴权性能下降** |