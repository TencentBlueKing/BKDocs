# 网关错误响应说明

[toc]

## 前置说明

> 链路：调用方 -> APIGateway -> 后端服务

当前网关错误响应协议为

```json
{
  "code_name": "",
  "data": null,
  "code": 16xxxxx,
  "message": "",
  "result": false
}
```

如果响应体非该协议，那么该响应是`后端服务`返回的，对响应有疑问需要找对应**网关负责人**

以下为网关的错误响应具体的说明，可以根据状态码或者关键字查找

## status: 400

### app code cannot be empty

```json
{
  "code": 1640001,
  "data": null,
  "code_name": "INVALID_ARGS",
  "message": "Parameters error [reason=\"app code cannot be empty\"]",
  "result": false
}
```

- 原因：没有提供 `X-Bkapi-Authorization` 头或者 `X-Bkapi-Authorization`头中没有 `bk_app_code`
- 处理：提供 `X-Bkapi-Authorization` 头并且里面包含 `bk_app_code`

其他：
- `app code cannot be longer than 32 characters`:  传递的`bk_app_code`错误，正常签发的`bk_app_code`长度不会超过 32
- `app secret cannot be longer than 128 characters`: 传递的`bk_app_secret`错误，正常签发的`bk_app_secret`长度不会超过 128

### please provide bk_app_secret or bk_signature to verify app

```json
{
  "code": 1640001,
  "data": null,
  "code_name": "INVALID_ARGS",
  "message": "Parameters error [reason=\"please provide bk_app_secret or bk_signature to verify app\"]",
  "result": false
}
```

- 原因：`X-Bkapi-Authorization`头中没有 `bk_app_secret`
- 处理：`X-Bkapi-Authorization` 头里面包含 `bk_app_secret`

### bk_app_code or bk_app_secret is incorrect

```json
{
  "code": 1640001,
  "data": null,
  "code_name": "INVALID_ARGS",
  "message": "Parameters error [reason=\"bk_app_code or bk_app_secret is incorrect\"]",
  "result": false
}
```

- 原因：`bk_app_code + bk_app_secret` 校验失败，不合法
- 处理：确认发起请求头中 `bk_app_code / bk_app_secret` 合法，与蓝鲸 PaaS 平台或运维签发给到的一致

### user authentication failed, please provide a valid user identity, such as bk_username, bk_token, access_token

```json
{
  "code": 1640001,
  "data": null,
  "code_name": "INVALID_ARGS",
  "message": "Parameters error [reason=\"user authentication failed, please provide a valid user identity, such as bk_username, bk_token, access_token\"]",
  "result": false
}
```

- 原因：
    - 没有提供`X-Bkapi-Authorization` 头
    - 头里面没有包含 `bk_token` or `access_token`
    - `bk_token` 不合法 (会到蓝鲸统一登录校验，校验失败，可能是非法的`bk_token`或已过期)
    - `access_token`不合法 (会到蓝鲸 bkauth/ssm 校验，校验失败，可能是非法的`access_token`或已过期)
- 处理：确认 `bk_token/access_token` 存在并且合法

### user authentication failed, the user indicated by bk_username is not verified

```json
{
    "code":1640001,
    "data":null,
    "code_name":"INVALID_ARGS",
    "message":"Parameters error [reason=\"user authentication failed, the user indicated by bk_username is not verified\"]",
    "result":false
}
```

- 原因：
  - 提供的用户认证信息里面，只有 bk_username，没有 bk_token, access_token 等能表示用户真实身份的信息，而 bk_username 不能真实表示用户真实身份（非 verified)
- 处理：
  - 提供合法的 bk_token/access_token


其他：
网关"插件配置”中，查找插件“免用户认证应用白名单 (不推荐)”，在该插件配置中，将应用添加到免用户认证应用白名单中。该插件不推荐使用，非官方网关，暂可能无法添加此插件。

注意：`免用户认证应用白名单(不推荐)` 将会下线，不建议使用该插件; 接口需要根据需求开启`应用认证`或者`用户认证`, 不应该不开启`用户认证`之后又想要获取用户信息

### access_token is invalid

```json
{
    "code":1640001,
    "data":null,
    "code_name":"INVALID_ARGS",
    "message":"Parameters error [reason=\"access_token is invalid, url: ......., code: 403\"]",
    "result":false
}
```

- 原因：
  - access_token 错误，可能复制错了
  - access_token 已经过期
  - access_token 不是通过 [bkssm or bkauth](../Explanation/access-token.md) 生成的或者是其他环境的
- 处理：
  - 如果是已过期，可以续期或者重新生成一个 access_token  [access_token 接口文档](../Explanation/access-token.md)

### the access_token is the application type and cannot indicate the user

```json
{
    "code_name": "INVALID_ARGS",
    "code": 1640001,
    "data": null,
    "message": "Parameters error [reason=\"the access_token is the application type and cannot indicate the user\"]",
    "result": false
}
```

- 原因：
  - 调用 API 使用的 access_token 是应用态的，只代表`bk_app_code+bk_app_secret`，不能代表用户
- 处理：
  - 申请并使用用户态 access_token 来调用接口 165040



## status: 401

## status: 403

### App has no permission to the resource

```
{
  "code": 1640301,
  "data": null,
  "code_name": "APP_NO_PERMISSION",
  "message": "App has no permission to the resource",
  "result": false
}
```

- 原因：网关 API 开启了 `校验访问权限`, 调用方 bk_app_code 无权限调用 (没有申请权限或者权限过期)
- 处理：到 开发者中心  找对应的应用，点进去，`云 API 管理 - 云 API 权限`申请对应接口权限或者进行权限续期

### Request rejected by ip restriction

```json
{
  "code_name": "IP_NOT_ALLOWED",
  "message": "Request rejected by ip restriction",
  "result": false,
  "data": null,
  "code": 1640302
}
```

- 原因：触发了网关或资源配置的 IP 访问保护
- 处理：将调用方的 IP 加到 IP 访问保护的白名单中

## status: 404

### API not found

```json
{
  "code_name": "API_NOT_FOUND",
  "message": "API not found [method=\"POST\" path=\"/api/xxxxx\"]",
  "result": false,
  "data": null,
  "code": 1640401
}
```

- 原因：在 APIGateway 找不到对应的 API(method+path)
- 处理：
  - 调用方确认调用的 method / path 是正确的，没有拼接错误
  - 找网关负责人确认对应的 method / path 资源已经发布，接口存在

## status: 413

### Request body size too large

```json
{
  "code_name": "BODY_SIZE_LIMIT_EXCEED",
  "message": "Request body size too large.",
  "result": false,
  "data": null,
  "code": 1641301
}
```

- 原因：请求体超过网关限制，目前网关限制最大是 40M
- 处理：
   - 不经过网关，直接请求后台服务

## status: 414

### Request uri size too large

```json
{
  "code_name": "URI_SIZE_LIMIT_EXCEED",
  "message": "Request uri size too large.",
  "result": false,
  "data": null,
  "code": 1641401
}
```

- 原因：请求 uri 超过网关限制
- 处理：
   - 不要将过长的参数放在 uri 中

## status: 415

网关不会返回 `status code = 415`，具体参考 [ 如何确认错误的 response 是网关还是后端服务返回的？- 后端返回 status code 415](./gateway-error-or-backend-error.md)

## status: 429

### API rate limit exceeded by stage strategy

```json
{
  "code_name": "RATE_LIMIT_RESTRICTION",
  "message": "API rate limit exceeded by stage strategy",
  "result": false,
  "data": null,
  "code": 1642902
}
```

- 原因：应用触发了  网关对应`环境`的访问频率控制策略
- 处理：降低调用频率，或者联系网关负责人调整对应频率限制

可以从请求头中获取访问频率控制相关的信息

```
"X-Bkapi-RateLimit-Limit": 频率控制总计数
"X-Bkapi-RateLimit-Remaining": 剩余数
"X-Bkapi-RateLimit-Reset": 多久之后重置
"X-Bkapi-RateLimit-Plugin": 插件名
```

### API rate limit exceeded by resource strategy

```json
{
  "code_name": "RATE_LIMIT_RESTRICTION",
  "message": "API rate limit exceeded by resource strategy",
  "result": false,
  "data": null,
  "code": 1642903
}
```

- 原因：应用调用触发了 网关对应`API资源`的访问频率控制策略
- 处理：降低调用频率，或者联系网关负责人调整对应频率限制

可以从请求头中获取访问频率控制相关的信息

```
"X-Bkapi-RateLimit-Limit": 频率控制总计数
"X-Bkapi-RateLimit-Remaining": 剩余数
"X-Bkapi-RateLimit-Reset": 多久之后重置
"X-Bkapi-RateLimit-Plugin": 插件名
```

### API rate limit exceeded by stage global limit (deprecated)

```json
{
  "code_name": "RATE_LIMIT_RESTRICTION",
  "message": "API rate limit exceeded by stage global limit",
  "result": false,
  "data": null,
  "code": 1642901
}
```

- 原因：应用触发了  网关对应`环境` 全局的访问频率控制策略 (deprecated)
- 处理：降低调用频率，或者联系网关负责人调整对应频率限制

(已废弃，大部分环境应该都不存在这个插件策略)

### Request concurrency exceeds

```json
{
  "code_name": "CONCURRENCY_LIMIT_RESTRICTION",
  "message": "Request concurrency exceeds",
  "result": false,
  "data": null,
  "code": 1642904
}
```

- 原因：请求并发过高，超过了网关限制
- 处理：降低并发 (注意，禁止使用网关接口用于压测)INTERNAL_SERVER_ERROR


## status: 499 Client Closed Request

### 无 response body

> 499 client has closed connection 表示**客户端**断开了连接，即客户端发起请求后，没有等到服务端响应，就将连接关闭了。

原因：client 调用网关等待时间超过设置的 timeout 时间，主动关闭连接，此时可能是 client 设置的超时时间过短，或者 后端服务响应非常慢;

处理：
  - 确认 client 设置的 timeout 是否合理
  - 联系网关负责人，确认后端服务的性能是否满足要求 (可以通过接口性能优化，扩容等方式降低后端服务的响应耗时)


其他现象及原因：
- 用户的应用请求网关或 ESB 的接口，请求失败，查询网关日志，发现记录的状态码是 499
  - 如果是 SaaS，并且失败的请求基本都是 30s 左右，请排查是否是使用 gunicorn 启动的，没有配置超时时间的话默认是 `30s`  [gunicorn settings timeout](https://docs.gunicorn.org/en/stable/settings.html#timeout) ;
  - 如果是非 SaaS，那么需要检查请求发起的上下文，是否在某个 woker 或者处理程序中，这样由于所属的 woker 或处理程序中止，会导致请求中止;

## status: 500

## status: 502

### cannot read header from upstream

```json
{
  "data": null,
  "code_name": "BAD_GATEWAY",
  "code": 1650200,
  "message": "Bad Gateway [upstream_error=\"cannot read header from upstream\"]",
  "result": false
}
```

- 对应 nginx 错误日志为：`upstream prematurely closed connection while reading response header from upstream`, 可以 [google 这个字符串](https://www.google.com.hk/search?q=upstream+prematurely+closed+connection+while+reading+response+header+from+upstream&oq=upstream+prematurely+closed+connection+while+reading+response+header+from+upstream&sourceid=chrome&ie=UTF-8) 进一步了解

- 原因：网关请求到了后端服务，在等待后端服务响应，此时由于网络原因 (例如抖动) 或者后端服务原因 (例如 reload, 重启) 等，导致连接中断
    - 后端有发布/重启
    - 后端开启了 keep-alive 但是配置的 keep-alive timeout 小于 60s

- 处理：
  - 提供调用的信息 (时间/request 信息/request-id 等) 找网关负责人排查原因。是否是发布/重启导致的，不是的话，需要网关负责人进一步排查

### DNS 解析失败

```json
{
  "data": null,
  "code_name": "BAD_GATEWAY",
  "code": 1650200,
  "message": "Bad Gateway",
  "result": false
}
```

当网关代理到的后端服务的域名地址 DNS 无法解析时，也会表现为 502，此时由于底层解析失败的错误只打在了 nginx error.log 中，上层插件无法获取具体报错

常见：
1. 后端服务地址配置错误

解决：需要检查后端服务地址域名在 IDC 是否能 ping 通

### Request backend service failed

```json
{
  "data": null,
  "code_name": "ERROR_REQUESTING_RESOURCE",
  "code": 1650201,
  "message": "Request backend service failed [detail=\"Bad Gateway\" err=\"EOF\" status=\"502\"]",
  "result": false
}
```

- 原因：网关请求后端服务失败，具体报错信息见`message`
- 处理：直接拼接后端服务的地址，在 IDC 机器上`curl`访问确认问题，一般是后端服务或后端服务的接入层有问题导致的

## status: 503

## status : 504

### cannot read header from upstream

```json
{
  "code_name": "REQUEST_BACKEND_TIMEOUT",
  "data": null,
  "code": 1650401,
  "message": "Request backend service timeout [upstream_error=\"cannot read header from upstream\"]",
  "result": false
}
```
- 对应 nginx 错误日志为：`upstream timed out (110: Connection timed out) while reading response header from upstream`, 可以 google 这个字符串  进一步了解

- 原因：网关资源会配置后端接口的 timeout 时间，如果后端接口调用超时，此时网关返回 504
- 处理：后端服务需要提升接口性能 (可以通过接口性能优化，扩容等方式降低后端服务的响应耗时), 或者调大网关的超时时间 (不建议过大)

补充：
- 另一种可能原因：后端服务只配置支持 https, 不支持 http 协议，在网关环境配置中配置的后端地址使用了`http://{host}:{port}`
- 处理：将协议改成 https  `https://{host}:{port}`


## status: 508

### Recursive request detected, please contact the api manager to check the resource configuration

```json
{
  "code_name": "RECURSIVE_REQUEST_DETECTED",
  "data": null,
  "code": 1650801,
  "message": "Recursive request detected, please contact the api manager to check the resource configuration",
  "result": false
}
```

- 原因：网关是禁止拿另一个网关作为 backend 的，会导致可能得无限递归调用，最终导致网关服务本身挂掉，所以做了检测
- 处理：
  - 不要使用另一个网关地址作为 backend
  - 如果请求来自于网关，到达后端服务后，需要再次调用另一个网关接口，请不要复用该请求的 header 头，而是应该新建一个请求拼装相关信息后发起调用（复用上游请求头会带来安全问题，下游可以拿到本不属于他的各种信息，包括用户信息/本系统约定的一些敏感信息等等）