# 错误码
## 错误码总览

| 错误码 | 描述  |
| :--- | :--- |
| 1901002  | 参数错误  |
| 1901400  | 用户传入的参数非法 (bad request)  |
| 1901401  | 没有权限调用接口 (unauthorized)  |
| 1901403  | 无访问权限  |
| 1901404  | 资源不存在 (not found)  |
| 1901409  | 资源冲突 (conflict)  |
| 1901500  | 500 系统错误 (system error)  |
| 1902000  | 依赖系统 api 不可达  |
| 1902001  | ESB api 调用错误  |
| 1902101  | IAM 后台请求返回码非 0  |
| 1902102  | 请求 ENGINE 错误  |
| 1902301  | 用户管理 api 调用错误  |
| 1902400  | 请求通用错误  |
| 1902409  | 请求数据与已存在数据有冲突  |
| 1902412  | 请求参数校验错误  |
| 1902413  | 请求第三方接口失败  |
| 1902414  | 请求参数 JSON 格式错误  |
| 1902415  | 请求方法不支持  |
| 1902416  | 请求参数错误  |
| 1902417  | 操作数据检查错误  |
| 1902418  | 用户组转出错误  |
| 1902419  | 请求数值错误  |
| 1902401  | 用户未登录  |
| 1902403  | 用户无权限访问  |
| 1902404  | 数据不存在  |
| 1902200  | 接入系统资源接口请求失败  |
| 1902201  | 接入系统资源接口请求 API 认证失败  |
| 1902204  | 接入系统不存在请求的资源类型或未实现该资源的查询方法  |
| 1902206  | 搜索 Keyword 参数校验失败  |
| 1902222  | 接入系统需返回的资源内容过多，拒绝返回数据  |
| 1902229  | 请求频率超出接入系统 API 频率限制  |
| 1902250  | 接入系统自身接口异常  |
| 1902250  | 接入系统自身接口返回数据不符合要求  |
| 1902501  | ITSM 请求返回码非 0  |
| 1902502  | ITSM 流程里存在 IAM 不支持的流程处理者  |


## 后台错误码

### 1901400

用户传入的参数非法, 不符合规范. 详细信息在 message 中, `bad request: {message}`

需要仔细接口协议, 确保调用的 URL/参数等符合要求

### 1901401

- `message: unauthorized: app code and app secret required` 请求 header 中没有传递 `X-Bk-App-Code`/`X-Bk-App-Secret`

- `message: unauthorized: app code or app secret wrong` 请求 header 中传递的`X-Bk-App-Code`/`X-Bk-App-Secret`错误, 无法在该环境找到匹配的.需要确认 
    - a.是否传递了`X-Bk-App-Code`/`X-Bk-App-Secret`且非空 
    - b.对应的`app_code`和`app_secret`是在同一个环境生成的 
    - c.再次确认`app_code`/`app_secret`是否同应用详情页信息匹配(经常出现的是复制错/复制漏)`
    - d.由于认证存在缓存，第一次错误后，相同 AppCode 和 AppSecret `必须等待5秒以上`才能再请求
    - e.如果无法确认, 请提供请求详情.
  
- `message: unauthorized: app(xxx) is not allowed to call system (yyy) api" xxx这个app_code不允许调用系统yyy的资源, 需要将xxx加入到yyy的`clients`中. 具体见  [系统(System) API](../../Reference/API/02-Model/10-System.md)

### 1901404

- `message: not found: system(xxx) not exists` 系统 xxx 不存在, 请确认系统已注册(注意, system 是接入系统注册到权限中心的, `clients`中配置的是可以调用这个系统 API 的合法`app_code`, 不要混淆二者概念)


### 1901409

- `message: conflict:action has releated policies, you can't delete it or update the related_resource_types unless delete all the related policies. please contact administrator.` 操作已经被使用配置了相关的权限, 不能删除 action 或者改变这个 action 的 related_resource_types. 联系管理员, 通过权限中心 SaaS 的 Django Command 进行`权限升级`或者`权限清理`;

## 组件调用错误 1902XXX - 190230X

日志查询方法:

找到权限中心 SaaS 的 component.log 日志, 搜索对应的请求 request_id, 查询相关 api 调用的上下文

![-w2021](../../assets/HowTo/FAQ/ErrorCodes_1.png)

### 1902000

描述: 依赖系统(esb, 权限中心后台, 用户管理) api 调用不可达

错误信息:

- `request esb api error`  排查权限中心 SaaS 的主机是否能正常访问 ESB api
- `request usermanger api error`  排查权限中心 SaaS 的主机是否能正常访问用户管理的 ESB api
- `request iam api error` 排查权限中心 SaaS 的主机是否能正常访问权限中心后台 api

### 1902001

描述: 调用 ESB api 失败

提供错误信息与日志到 ESB 负责人排查

### 1902200

描述: 接入系统回调接口调用错误

错误信息:

- `unreachable interface call`  接入系统接口不可达
- `interface status code:`xxx`error`  接入系统接口返回状态码`xxx`错误

### 1902201

`接入系统资源接口请求API认证失败`; 

逻辑:
- 接入系统注册系统信息及回调接口, 权限中心会生成一个 token
- 权限中心回调接入系统, 会使用 basic auth, `username=bk_iam, password={token}`, 具体文档见 [接口间调用鉴权](../../Reference/API/01-Overview/03-APIAuth.md)
- 接入系统接口, 会查询自己系统的 token,  [系统 token 查询 API](../../Reference/API/02-Model/16-Token.md), 进行比对
    - 如果使用的是 `iam-python-sdk`, 那么调用的是`IAM.get_token(system)`, 注意参数是`system`, 不是`app_code`
    - 如果使用了 `iam-python-sdk` 的 `DjangoBasicResourceApiDispatcher(iam, system)`, 注意参数是`system`, 不是`app_code`
- 比对失败, 返回 401, 权限中心报错误码 `1902201`

某些场景下, 例如上云环境, app_code 和 system 是不一致的, 如果出现这个错误码, 大概率是使用`DjangoBasicResourceApiDispatcher`传递`system`参数错误



### 1902301

描述: 调用用户管理 api 失败

提供错误信息与日志到用户管理负责人排查

----

## 用户请求错误 19024XX

日志查询方法:

找到权限中心 SaaS 的 bk_iam-app.log 日志, 搜索对应的请求 request_id, 查询相关 api 调用的上下文

![-w2021](../../assets/HowTo/FAQ/ErrorCodes_2.png)

### 1902400 1902412 1902414 1902415 1902416

描述: 用户的请求数据错误

提供请求数据, 结果返回数据, 日志信息提单到权限中心负责人排查

### 1902417

描述: 权限提交的数据与接入系统注册操作依赖的资源类型数据校验错误

错误信息:
- `action xxx has no related resource type yyy` 操作`xxx`不关联申请的资源类型`yyy`
- `action xxx related resource types yyy are in the wrong order` 操作`xxx`关联多个资源类型, 其中类型`yyy`与接入系统注册的操作关联资源类型顺序不一致
- `action xxx lacks related resource type yyy` 操作`xxx`缺少资源类型`yyy`

----

## 附录: SaaS 错误码说明

### 1. 前端 api 调用错误时的提示

![-w2021](../../assets/HowTo/FAQ/ErrorCodes_3.png)

当权限中心 SaaS 页面出现如上红框弹出提示时, 表示权限中心 SaaS api 调用报错需要查询 api 返回的结果, 找到结果中的 code, 根据以下排查方法排查问题

### 2. api 请求的 request_id

![-w2021](../../assets/HowTo/FAQ/ErrorCodes_4.png)

权限中心 SaaS 的每个 api 请求都有 request_id, 在排查前记录 request_id, 在排查日志过程中可以更方便定位到错误信息

### 3. api 返回结构说明

```json
{
  "code": 0,  // 返回code, 0表示成功, 其它为错误码
  "data": [],
  "message": "OK",  // 返回的错误信息
  "result": true  // 调用结果
}
```