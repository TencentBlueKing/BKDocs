# 调用网关 API FAQ

### 后端接口依赖 Cookies 中的用户登录态认证用户，可否接入网关
浏览器 Cookies 中包含用户敏感信息，因此，网关将不会向后端接口传递 Cookies。
后端接口无法通过 Cookies 验证用户，可参考[网关认证方案](../reference/authorization.md)，解析`X-Bkapi-JWT`获取当前用户。
