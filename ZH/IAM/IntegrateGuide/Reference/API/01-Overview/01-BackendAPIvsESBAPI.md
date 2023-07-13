# 后台 API 和 ESB API 以及 APIGateway 2.0 API 说明

## 背景

由于高性能的 APIGateway2.0 只在蓝鲸7.0以上版本发布, 尚未发布企业版, 所以为了性能考虑, 模型/策略/鉴权等接口目前没有接入 ESB, 直接后台 API 调用; 而 SaaS 上无权限申请/授权接口等, 接入了 ESB

> 已升级到蓝鲸7.0以上版本, 或者蓝鲸内部使用请直接使用`APIGateway2.0 API`

目前权限中心提供的接口分为3类:
1. 后台 API, URL 前缀: `/api/v1/[model | policy | systems]`
    1.1 model [模型注册及更新 API](../02-Model/00-API.md)
    1.2 policy [策略查询 API](../04-Auth/01-SDK.md) / [直接鉴权 API](../04-Auth/02-DirectAPI.md)
    1.3 systems 系统相关  [查询策略 API](../08-Query/01-PolicyGet.md)
2. 组件 API, URL 前缀: `/api/c/compapi/v2/iam/[application | authorization]`
    1.1  application [5. 生成无权限申请 URL](../05-Application/01-GenerateURL.md)
    1.2  authorization [新建关联属性授权接口](../07-ResourceCreatorAction/01-Attribute.md)
    1.3 authorization [资源拓扑授权/回收](../06-GrantRevoke/01-Topology.md)
3. APIGateway2.0 API, URL 前缀: `/api/[v1 | v2]`
    1.1 model [模型注册及更新 API](../02-Model/00-API.md)
    1.2 policy [策略查询 API](../04-Auth/01-SDK.md) / [直接鉴权 API](../04-Auth/02-DirectAPI.md)
    1.3 systems 系统相关  [查询策略 API](../08-Query/01-PolicyGet.md)
    1.4  application [5. 生成无权限申请 URL](../05-Application/01-GenerateURL.md)
    1.5  authorization [新建关联属性授权接口](../07-ResourceCreatorAction/01-Attribute.md)
    1.6 authorization [资源拓扑授权/回收](../06-GrantRevoke/01-Topology.md)
   
## 后台 API

直接调用 IAM 后台 API, 请仔细阅读 [接口协议前置说明](./02-APIBasicInfo.md) 中对 request header/body 以及 response 的说明

调用地址:
- 如果是企业版 SaaS, 直接通过环境变量获取: `BK_IAM_V3_APP_CODE` (权限中心 SaaS 的 app_code, 用于跳转到权限中心的 URL 拼接) / `BK_IAM_V3_INNER_HOST`(权限中心后台的访问地址)
- 如果是非 SaaS 的其他平台, 需要部署时渲染 `__BKIAM_HOST__:__BKIAM_PORT__`

相关链接:
- [后台接口错误码说明](../../../HowTo/FAQ/ErrorCode.md)

## ESB API

需要遵守企业版 ESB 的接口协议. eedev 联调环境, 可以通过 `https://{PAAS_DOMAIN}/esb/api_docs/system/IAM/` 查看权限中心接入 ESB 的具体文档

ESB 调用地址:
- 如果是企业版 SaaS, 使用 ESB SDK 调用,   API 调用说明 `https://{PAAS_DOMAIN}/esb/guide/page/use_component`
- 如果是企业版 SaaS, 直接通过 http 访问, 可以通过环境变量获取: `BK_PAAS_INNER_HOST`即 PaaS 的内网域名, 拼接`{BK_PAAS_INNER_HOST}/api/c/compapi/v2/iam/`
- 如果是非企业版 SaaS 的其他平台, 请使用 PaaS 内网地址或域名访问组件 `{PAAS_DOMAIN}/api/c/compapi/v2/iam/`. 

## APIGateway2.0 API

APIGateway 文档

- [调用网关 API](../../../../../APIGateway/1.10/UserGuide/component/use-api/use-component-api.md)
