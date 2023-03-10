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
