# 接口错误汇总

请根据接口错误`message`中关键字进行检索

注意, 如果想确认目前环境中注册的权限模型, 
可以用接口 [权限模型: 通用查询 Common Query API](../../../Reference/API/02-Model/15-CommonQuery.md) 查询.

## 通用报错

## 1. client(xxx) can not request system(yyy)

> bad request:client(xxx) can not request system(yyy)

不是该系统合法 clients

需要找系统权限模型的维护者, 在模型注册阶段, 将`app_code`加入到其系统合法`clients`列表中

### 2. action.id invalid

> {"code":1901400,"message":"bad request:action.id invalid","data":{}}

`action.id`非法, 确认下这个环境注册的权限模型中是否有这个操作

### 3. GetSystemClients fail

> bad request:get system(xxxx) valid clients fail, err=[Cache:GetSystemClients] LocalSystemClientsCache.Gt key=`xxx` fail => [SystemSVC:Get] saasManager.Get id=`xxx` fail => [Raw:Error] sql: no rows in result set

找不到这个注册的系统

确认系统是否注册

### 4. SubjectSVC:GetPK

> [SubjectSVC:GetPK] GetPK _type=user, id=xxx fail => [Raw:Error] sql: no rows in result set

原因: 用户在权限中心不存在, 新增用户未同步到权限中心, 或者用户被删除.

处理: 在用户管理新增用户后, 需要到权限中心做一次同步(同步所有组织架构需要 10 分钟左右)

默认权限中心从用户管理一天同步一次组织架构.

### 5. 1901401

> unauthorized: app code and app secret required

请求 header 中没有传递 X-Bk-App-Code/X-Bk-App-Secret

> unauthorized: app code or app secret wrong

请求 header 中传递的 X-Bk-App-Code/X-Bk-App-Secret 错误, 无法在该环境找到匹配的.
需要确认:
- 是否传递了 X-Bk-App-Code/X-Bk-App-Secret 且非空
- 对应的 app_code 和 app_secret 是在同一个环境生成的
- 再次确认 app_code/app_secret 是否同应用详情页信息匹配(经常出现的是复制错/复制漏)`
- 由于认证存在缓存，第一次错误后，相同 AppCode 和 AppSecret 必须等待 5 秒以上才能再请求
- 如果无法确认, 请提供请求详情.

> unauthorized: app(xxx) is not allowed to call system (yyy) api" 

xxx 这个 app_code 不允许调用系统 yyy 的资源, 需要将 xxx 加入到 yyy 的 clients`中.

### 6. 1901404

> not found: system(xxx) not exists 

系统 xxx 不存在, 请确认系统已注册(注意, system 是接入系统注册到权限中心的, clients 中配置的是可以调用这个系统 API 的合法 app_code, 不要混淆二者概念)

### 7. 1901400

> bad request: {message}

用户传入的参数非法, 不符合规范. 详细信息在 message 中

需要仔细接口协议, 确保调用的 URL/参数等符合要求

## 鉴权相关

### 1. validateActionResource

> request resources not match action =\u003e [Raw:Error] validateActionResource fail

用户请求查询时传入的资源(resources) 同接入系统注册操作的关联资源类型(related_resource_types)不匹配

例如注册查看主机关联的资源类型是`主机`, 但是查询策略的时候传入的`action=查看主机, resources=[集群]` 此时校验操作的资源类型失败

确认是否是以下场景:

- 操作关联了两个资源类型, 鉴权只传一个
- 操作关联资源类型 A, 鉴权时传递资源类型 B

### 2. GetActionPK

> [Cache:GetActionPK] ActionPKCache.Get key={system_x}:{action_y} fail => [Raw:Error] sql: no rows in result set

用户请求传入的 action 在权限中心不存在(即 action 不在系统注册的操作列表中)

可能原因: 
1. 接入系统没有注册对应的`action`
2. 鉴权请求传入了错误的`action.id`
3. 接入系统变更了模型, 例如删除 action 

