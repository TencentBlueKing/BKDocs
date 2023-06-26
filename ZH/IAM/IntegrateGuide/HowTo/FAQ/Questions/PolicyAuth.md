# 鉴权及策略查询相关

## 1. `/api/v1/policy/query` 接口是否可以不传资源(resources)

可以
- 如果传了具体资源, 那么会返回 `用户+操作+这个资源`符合的所有策略(此时相当于拿传递的资源带入计算), 数据量小, 性能相对高一些;
- 如果不传资源, 那么会返回`用户+操作`的所有策略; 数量可能比较大, 接口传输数据量比较大, 性能相对会低一些; 拿到策略后, 接入系统需要自己把资源带入策略表达式计算. 可以用于一些批量的场景, 例如批量鉴权`用户-查看` 100 台主机的权限, 不传资源拉回来, 将 100 台主机资源带入遍历计算. (只需要一次策略查询)

## 2. 鉴权相关接口协议中 resources 字段代表一个资源

- resources 是一个列表
- resources 代表一个资源

详细说明: [接口协议中 resources 字段说明](../../../Reference/API/01-Overview/02-APIBasicInfo.md)


## 3. 为什么 admin 用户所有策略查询返回的都是 any

admin 是超级管理员, 默认有所有权限, 所以鉴权/策略查询得到的策略都是`{ op=any, field=, value=}`
进行接入验证/测试联调时, 避免使用 admin 用户.

用一个具体的用户, 申请权限, 测试

## 4. 一个无关联资源类型的权限, 如果一个用户有权限的话返回的表达式是 any

是的, `{ op=any, field=, value= }`

## 5. 使用实例视图展示拓扑配置了权限, 为什么返回的策略中有`_bk_iam_path_`

关于`_bk_iam_path_`, 可以查看 [说明: 资源拓扑`_bk_iam_path_`](../../../Explanation/04-BkIAMPath.md)

当接入系统支持以`拓扑`配置权限, 那么勾选中间节点的时候, 会产生一个拓扑链路, 这个链路表示是`怎么选`到的资源, 即, 有这个路径下的资源的相关权限.

表达式中, 使用`_bk_iam_path_`来存储拓扑链路, 例如 `/biz,bk/set,sz/module,paas/` 表示 `业务-蓝鲸 -> 集群-深圳 -> 模块-paas`


## 6. 使用一个用户测试, 在我的权限里面没有对应权限, 但是实际上页面却是有权限操作的

权限来源:
- 自定义申请
- 个人加入用户组权限 => 默认继承用户组权限
- 个人加入部门, 部门加入用户组 => 默认继承用户组权限
- 是超级管理员, 并勾选`拥有蓝鲸平台所有操作权限`
- 是系统管理员, 并勾选`拥有该系统的所有操作权限`

所以, `[我的权限]-[自定义权限]`中看不到, 并不一定没有权限, 需要检查 `[用户组权限]`

## 7. 删除了`我的权限`里面这个系统所有权限, 同时加入的组也都没有这个系统的权限, 但是去页面操作还是有权限?

见上一个问题中的`权限来源`

此时, 需要去找`超级管理员`确认, 自己是否是超级管理员或某个系统的系统管理员

## 8. 跨系统资源依赖鉴权报`request resources not match action `

```
POST /api/v1/policy/query_by_actions
{
    "code": 1901500,
    "message": "system error[request_id=6741e5d31fe24841b8b55b1fc807a34e]: [Handler:BatchQueryByActions] systemID=`bk-xxxx`, request.Action.ID=`app_create`, body=`{baseRequest:{System:bk-xxxx Subject:{Type:user ID:tom}} Resources:[] Actions:[{ID:app_create}]}` =\u003e [PDP:Query] queryAndPartialEvalConditions fail%!!(MISSING)(EXTRA types.Action={app_create 0xc003559f60}) =\u003e [PDP:queryAndPartialEvalConditions] ValidateActionResource systemID=`bk-bscp`, actionID=`%!!(MISSING)d(string=app_create)`, resources=`[]` fail, request resources not match action =\u003e [Raw:Error] validateActionResource fail",
    "data": {}
}
```

跨系统资源依赖的场景, 相当于接入系统不需要关心第三方系统的资源, 拿到的表达式都是本系统的

所以, 鉴权时, 自己系统资源的可以不传, 跨系统的资源必须传递. 

- 如果同时传递本系统资源+跨系统资源, 有权限会返回any表达式, 没权限就不返回任何策略
- 如果只传递跨系统资源, 会返回本系统表达式(需要代入本系统资源进一步计算), 或者不返回任何策略(没权限)
