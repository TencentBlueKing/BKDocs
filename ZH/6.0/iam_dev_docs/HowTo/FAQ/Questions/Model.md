# 模型注册相关

## 1. system.provider_config 的 healthz 字段说明

注册系统的时候, 除了 host/auth, 还需要提供 healthz

背景: 权限中心 SaaS 上用户配置权限时会依赖于接入系统的 `资源拉取接口`; 如果接入系统异常导致对应接口不可用, 那么在 SaaS 上, 用户将无法申请权限. 此时, 需要定期检查接入系统是否健康, 用于展示/监控/告警/提示用户等

注意: 
- 非必填, 不填的话, 会使用 `system.provider_config.host + ""` (注意不设置是空的)
- 注意这个接口不能带鉴权, 报错信息不能带敏感信息
- 这个 healthz 接口不一定是系统层面全局的 healthz, 范围不一样. 例如全局系统依赖 redis 不可用, healthz 报错, 但是不影响提供给 IAM 的 api, 此时 IAM 调用的 healthz 应该是正常的;

示例:

```json
{
    "id": "bk_cmdb",
    "name": "配置平台",
    "name_en": "CMDB",
    "description": "配置平台是一个...",
    "description_en": "CMDB is a...",
    "clients": "bk_cmdb,cmdb",
    "provider_config": {
        "host": "http://cmdb.service.consul",
        "healthz": "/api/v1/healthz"
        "auth": "basic"
    }
}
```

## 2. 注册操作的实例视图时, ignore_iam_path	有什么作用 

是否配置的权限忽略路径,   [名词及概念](../../../Reference/API/02-Model/00-Concepts.md) 中的 ignore_iam_path 说明;

## 3. 问题 操作 ID 32位限制是否会考虑放开?

不会!

action_id 是唯一标识, 对于一个系统来说是枚举的, 32 位理论上可以支持超过所有系统的场景.

如果操作是`用户侧`配置的, 不可控, 建议给用户输入的信息做处理, 例如用户输入一串hash入库后生成一个唯一主键,  操作id为 `xxxx_{primary_key}` , 这个值只用于鉴权, 不需要可读性;

## 4. 一个系统内最多能注册多少个action? 

具体见 [说明: 权限中心限制](../../../Explanation/07-Limit.md)


## 5. 注册一套系统, 能否针对不同的 resource 配置不同的回调域名?

一套系统的, 只能有一个回调域名

背后如果是多个应用提供者的话, 需要自行转发过去, 例如使用网关或Nginx.

如果用多个系统, 由某个系统A管公共的权限, 
另一个系统 B 想要在页面上用到 A 管的公共权限, 将 B 的app_code注册为 A 的clients即可, 鉴权的时候可以调用 A 的鉴权接口;

## 6. 模型注册: action name是否允许重复? 

不允许

## 7. 新建关联配置/常用操作/操作组等, 能否增量更新?

不支持增量, 本质上是一个json, 每个元素没有id的, 后台无法识别增删了哪些东西, 只能全覆盖