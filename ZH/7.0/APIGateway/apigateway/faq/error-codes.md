# 网关 API 错误码

请求网关 API 失败，原因可能是网关错误，也可能是后端接口错误。
- 请求响应头 `X-Bkapi-Error-Code` 不为空，表示网关错误，错误码为一个 7 位整数字符串，响应头 `X-Bkapi-Error-Message` 表示详细错误消息
- 请求响应头 `X-Bkapi-Error-Code` 为空，表示由 API 网关透传的后端接口响应


| 错误码 | HTTP 状态码 | 错误消息 | 解决方案 |
| ------ | ----------- | -------- | -------- |
| 1640001 | 400 | Parameters error | 参数错误，请根据错误消息，更新对应的参数 |
| 1640101 | 401 | App authentication failed | 应用认证失败，需提供有效的应用认证数据 |
| 1640102 | 401 | User authentication failed | 用户认证失败，需提供有效的应用认证数据 |
| 1640301 | 403 | App has no permission to the resource | 应用无访问资源的权限，请到开发者中心申请资源的访问权限 |
| 1640302 | 403 | Request rejected, the request source IP has no permission, please apply for IP permission | 请求来源IP无访问资源的权限，请联系网关负责人添加IP白名单 |
| 1640401 | 404 | API not found | 网关资源不存在 |
| 1640501 | 405 | Request unsupported method | 网关资源不支持该请求方法 | 
| 1641301 | 413 | Request body size too large | 请求体过大，网关支持的最大请求体为 40M |
| 1642901 | 429 | API rate limit exceeded by stage global limit | 环境全局流量频率超限，请联系网关负责人，确认是否需要调整网关环境的全局流量控制 |
| 1642902 | 429 | API rate limit exceeded by stage strategy | 应用请求环境频率超限，请联系网关负责人，申请调整应用访问网关环境的频率 |
| 1642903 | 429 | API rate limit exceeded by resource strategy | 应用请求资源频率超限，请联系网关负责人，申请调整应用访问网关资源的频率 |
| 1642904 | 429 | Request concurrency exceeds | 并发请求数超限，每个应用支持 1000 个并发请求 |
| 1650002 | 500 | Resource configuration error | 网关配置错误，请联系网关负责人检查网关资源配置 |
| 1650003 | 500 | Request rejected, detected recursive request to API Gateway | 网关资源配置错误，资源后端地址配置了一个网关资源的地址，请联系网关负责人调整 |
| 1650201 | 502 | Request backend service failed | 网关请求后端接口服务失败，可能是网络抖动等原因，请稍后重试，或联系网关负责人检查 |
| 1650401 | 504 | Request backend service timeout | 网关请求后端接口超时（未在指定时间内响应），请联系网关负责人检查 |
