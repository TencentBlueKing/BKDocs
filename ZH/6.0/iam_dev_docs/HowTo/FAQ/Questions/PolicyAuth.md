# 鉴权及策略查询相关

## 1. `/api/v1/policy/query` 接口是否可以不传资源(resources)

可以
- 如果传了具体资源, 那么会返回 `用户+操作+这个资源`符合的所有策略(此时相当于拿传递的资源带入计算), 数据量小, 性能相对高一些;
- 如果不传资源, 那么会返回`用户+操作`的所有策略; 数量可能比较大, 接口传输数据量比较大, 性能相对会低一些; 拿到策略后, 接入系统需要自己把资源带入策略表达式计算. 可以用于一些批量的场景, 例如批量鉴权`用户-查看` 100 台主机的权限, 不传资源拉回来, 将 100 台主机资源带入遍历计算. (只需要一次策略查询)

## 2. `/api/v1/policy/query` 接口报错

### request resources not match action => [Raw:Error] validateActionResource fail

用户请求查询时传入的资源(resources) 同接入系统注册操作的关联资源类型(related_resource_types)不匹配.

例如注册`查看主机`关联的资源类型是主机, 但是查询策略的时候传入的`action=查看主机`, `resources=[集群]` 此时校验操作的资源类型失败

### [Cache:GetActionPK] ActionPKCache.Get key=`{system_x}:{action_y}` fail => [Raw:Error] sql: no rows in result set

用户请求传入的 action 在权限中心不存在(即 action 不在系统注册的操作列表中)

可能原因: 1. 接入系统变更了模型, 例如删除 action 2.请求传入的 action 错误

## 3. 鉴权相关接口协议中 resources 字段代表一个资源

- resources 是一个列表
- resources 代表一个资源

详细说明: [接口协议中 resources 字段说明](../../../Reference/API/01-Overview/02-APIBasicInfo.md)

## 4. 在用户管理新建一个用户后鉴权失败(SubjectSVC -> [Raw:Error] sql: no rows in result set)

报错信息中包含`[SubjectSVC:GetPK] GetPK _type=user, id=xxx fail => [Raw:Error] sql: no rows in result set`

默认权限中心从用户管理一天同步一次组织架构.

所以在用户管理新增用户进行鉴权会失败, 原因是: 用户在权限中心不存在.

在用户管理新增用户后, 需要到权限中心做一次同步(同步所有组织架构需要 10 分钟左右)

## 5. 为什么 admin 用户所有策略查询返回的都是 any

admin 是超级管理员, 默认有所有权限, 所以鉴权/策略查询得到的策略都是`{ op=any, field=, value=}`
进行接入验证/测试联调时, 避免使用 admin 用户.

用一个具体的用户, 申请权限, 测试

## 6. 一个无关联资源类型的权限, 如果一个用户有权限的话返回的表达式是 any

是的, `{ op=any, field=, value= }`

## 7. 使用实例视图展示拓扑配置了权限, 为什么返回的策略中有`_bk_iam_path_`

关于`_bk_iam_path_`, 可以查看 [说明: 资源拓扑`_bk_iam_path_`](../../../Explanation/04-BkIAMPath.md)

当接入系统支持以`拓扑`配置权限, 那么勾选中间节点的时候, 会产生一个拓扑链路, 这个链路表示是`怎么选`到的资源, 即, 有这个路径下的资源的相关权限.

表达式中, 使用`_bk_iam_path_`来存储拓扑链路, 例如 `/biz,bk/set,sz/module,paas/` 表示 `业务-蓝鲸 -> 集群-深圳 -> 模块-paas`


## 8. 使用一个用户测试, 在我的权限里面没有对应权限, 但是实际上页面却是有权限操作的

权限来源:
- 自定义申请
- 个人加入用户组权限 => 默认继承用户组权限
- 个人加入部门, 部门加入用户组 => 默认继承用户组权限

所以, [我的权限]-[自定义权限]中看不到, 并不一定没有权限, 需要检查 [用户组权限]
