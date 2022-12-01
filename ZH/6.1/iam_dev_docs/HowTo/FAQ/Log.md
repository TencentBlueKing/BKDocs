# 日志

# 权限中心 SaaS 日志说明

| 文件名 | 说明 | 日志级别 | 备注 |
|-----|----|------|----|
| bk_iam.log    | 后台日志   |  info    |  IAM SaaS 本身进程打印日志, 包含基本运行信息 (IAM SaaS 服务报错) |
|  uwsgi.log    | API 请求 Uwsgi 日志   |  info    |  默认是所有请求流水日志，特别是 500 等系统异常，可直接查看该日志  |
|  component.log   |  请求第三方接口日志  |  info    |  调用第三方系统接口流水日志，包括对 IAM 后台服务、用户管理、ITSM 以及`接入系统回调接口`  |
|  celery.log   | 异步任务日志   |  info    | 后台异步任务日志，包括`同步组织架构`、续期通知等  |

# 权限中心后台日志说明

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