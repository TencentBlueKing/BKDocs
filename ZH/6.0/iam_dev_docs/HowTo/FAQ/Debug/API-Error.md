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

可以使用[权限模型: 通用查询 Common Query API](../../../Reference/API/02-Model/15-CommonQuery.md) 查询确认

### 3. GetSystemClients fail

> bad request:get system(xxxx) valid clients fail, err=[Cache:GetSystemClients] LocalSystemClientsCache.Get key=`xxx` fail => [SystemSVC:Get] saasManager.Get id=`xxx` fail => [Raw:Error] sql: no rows in result set

找不到这个注册的系统

确认系统是否注册

### 4. SubjectSVC:GetPK

> [SubjectSVC:GetPK] GetPK _type=user, id=xxx fail => [Raw:Error] sql: no rows in result set

原因: 用户在权限中心不存在, 新增用户未同步到权限中心, 或者用户被删除.

处理: 在用户管理新增用户后, 需要到权限中心做一次同步(同步所有组织架构需要 10 分钟左右)

默认权限中心从用户管理一天同步一次组织架构.

### 5. 错误码 

- 1901400
- 1901401
- 1901404
- 1901409
- 1902412
- 1902417

见 [错误码](../ErrorCode.md)


### 6. SaaS接口调用

> app_code(bk_xxxx) do not be allowed to call api(group_list)

需要添加白名单

> creator authorization instance api don't support the (xxxxx] of system[yyyyy]

没有权限调用, 需要评估后, 添加白名单

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

## 无权限申请

### 1. Parameter error

> Parameter error: The resource(system_id:bk_xxxx, type:page, id:244) display_name cannot be queried through the API - fetch_instance_info

回调接口, 查询 244 资源实例时报错; 需要到被调用系统确认

无权限申请, 对于传入的数据，我们需要严格校验，这时候会回调 接入系统资源 fetch_instance_info接口查询资源名称


