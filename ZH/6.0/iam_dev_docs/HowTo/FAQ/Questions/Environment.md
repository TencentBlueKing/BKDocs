# 环境相关

## 1. SaaS 如何获取和访问权限中心?  应该用哪个环境变量读取权限中心访问地址

SaaS 在部署时, 已注入权限中心相关的环境变量. 
- `BK_IAM_V3_APP_CODE`  (权限中心 SaaS 的 app_code, 用于跳转到权限中心的 URL 拼接) 
- `BK_IAM_V3_INNER_HOST` (权限中心后台的访问地址)

具体可以阅读 [后台 API 和 ESB API 说明](../../../Reference/API/01-Overview/01-BackendAPIvsESBAPI.md)

## 2. 调用接口 404

文档中出现的接口都是存在的接口, 如果调用接口出现 404

一般是如下原因:
1. 访问地址配置错误, 接口分为后台 API 和 ESB API, 二者的访问地址是不一样的. 具体见 [后台 API 和 ESB API 说明](../../../Reference/API/01-Overview/01-BackendAPIvsESBAPI.md)
2. URL 复制或拼接错误(需要再次核对)