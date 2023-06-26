# 系统间接口鉴权

## 接入系统 -> 权限中心

### 1. 场景

1. 模型注册 ([模型注册接口协议](../02-Model/00-API.md))
2. 拉取策略/鉴权 ([SDK 鉴权接口协议](../04-Auth/01-SDK.md))

### 2. 鉴权逻辑

使用蓝鲸 app_code/app_secret 进行鉴权 

Request Header:
```bash
X-Bk-App-Code 蓝鲸应用app_code
X-Bk-App-Secret 蓝鲸应用app_secret
```

没有权限将返回:

```bash
status: 200
response_body:
# 没有提供app_code/app_secret
{
    "code": 1901401,
    "message": "unauthorized: app code and app secret required",
    "data": {}
}
# app_code或app_secret错误
{
    "code": 1901401,
    "message": "unauthorized: app code or app secret wrong",
    "data": {}
}
```

---

## 权限中心 -> 接入系统

接入系统暴露的接口是可以查询资源实例/属性等信息的, 可能包含敏感信息, 所以需要对权限中心资源拉取接口做鉴权.

### 1. 场景

资源拉取 ([资源拉取接口协议](../03-Callback/01-API.md))

### 2. 鉴权逻辑

**注意**: 目前只支持`none`或`basic`, 相对复杂的`digest`/`signature`规划中

1. 注册系统时([新增系统接口协议](../02-Model/10-System.md)), 需要确定鉴权方式: `none`/`basic`/`digest`/`signature` 
2. 系统注册成功, 会生成一个`token`
3. 当权限中心调用`接入系统`的时候, 会根据接入系统注册的鉴权方式和上一步生成的 token, 生成对应的请求, 然后调用`接入系统`
4. 接入系统需要根据注册系统选择的鉴权方式, 对权限中心发过来的请求进行鉴权.


**鉴权方式:**
- `none`: 不鉴权, 意味着所有资源拉取接口没有权限控制([资源拉取接口协议](../03-Callback/01-API.md)). `不推荐, 可以在测试联调时使用`
- `basic`: http basic auth, 权限中心调用接入系统, 生成 header`Authorization: Basic base64(username:password)` (其中`username=bk_iam, password={token}`), `接入系统`解析请求后, 要使用 token 进行鉴权.  `推荐, 同蓝鲸体系部署在同一个内网的服务` - 已支持
- `digest`: http digest auth, 权限中心调用接入系统, 使用摘要算法生成 header`Authorization: Digest xxxx`, `接入系统`解析请求后, 需要使用 token 进行鉴权. `同蓝鲸体系部署在同一个内网的服务, 对安全性进一步需求的服务(实现方和调用方的逻辑较为复杂, 出问题不好调试)` - 暂不支持
- `signature`: 使用签名算法, 生成 header`X-Bk-IAM-Signature: xxx` (尚未确认协议). `接入系统`解析请求后, 需要使用 token 进行鉴权. `外网服务或对安全性有很高要求的服务`- 暂不支持


`接入系统`解析请求后, 需要使用 token 进行鉴权:

- 使用`app_code/app_secret`到权限中心查询`token` ([查询 token 协议](../02-Model/16-Token.md)) (建议, 查询回来后缓存起来)

