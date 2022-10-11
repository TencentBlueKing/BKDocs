# FAQ

## 产品相关

- [产品相关](../../../权限中心/产品白皮书/常见问题/Diffv2v3.md)

## 模型注册

- [1. system.provider_config 的 healthz 字段说明](./Questions/Model.md)
- [2. 注册操作的实例视图时, ignore_iam_path 有什么作用?](./Questions/Model.md)

## 资源反向拉取

- [1. 权限中心资源反向拉取调用接入系统接口拉取资源时的 token 如何获取?](./Questions/Callback.md)
- [2. 资源反向拉取接口各自对应页面上哪些展示?](./Questions/Callback.md)


## 鉴权及策略查询

- [1. /api/v1/policy/query 接口是否可以不传资源(resources)?](./Questions/PolicyAuth.md)
- [2. /api/v1/policy/query 接口报错](./Questions/PolicyAuth.md)
- [3. 鉴权相关接口协议中 resources 字段代表一个资源?](./Questions/PolicyAuth.md)
- [4. 在用户管理新建一个用户后鉴权失败(SubjectSVC -> [Raw:Error] sql: no rows in result set)](./Questions/PolicyAuth.md)
- [5. 为什么 admin 用户所有策略查询返回的都是 any?](./Questions/PolicyAuth.md)
- [6. 一个无关联资源类型的权限, 如果一个用户有权限的话返回的表达式是 any?](./Questions/PolicyAuth.md)
- [7. 使用实例视图展示拓扑配置了权限, 为什么返回的策略中有_bk_iam_path_?](./Questions/PolicyAuth.md)
- [8. 使用一个用户测试, 在我的权限里面没有对应权限, 但是实际上页面却是有权限操作的](./Questions/PolicyAuth.md)

## 环境

- [1. SaaS 如何获取和访问权限中心? 应该用哪个环境变量读取权限中心访问地址](./Questions/Environment.md)
- [2. 调用接口 404](./Questions/Environment.md)

## SDK

- [1. 怎么把 iam-python-sdk 的日志落地项目?](./Questions/SDK.md)
- [2. 怎么开启 python-sdk 的 debug?](./Questions/SDK.md)

## do_migrate

- [1. do_migrate 执行 upsert_action_groups 为什么只有最后一个生效?](./Questions/Migration.md)
- [2. do_migrate 执行结果 conflict: xxxx already exists](./Questions/Migration.md)
- [3. do_migrate 如果我使用 django 框架怎么进行 iam migration?](./Questions/Migration.md)
- [4. do_migrate 是否可以重复执行同一个文件?](./Questions/Migration.md)

## 使用场景

- [1. 怎么实现批量鉴权, 一个用户是否有查看 1000 台主机的权限?](./Questions/Usage.md)
- [2. 配置权限的时候, 怎么控制只能选择实例, 不需要配置属性](./Questions/Usage.md)

## 申请与审批

- [1. 权限中心创建申请单报错中存在ITSM相关的关键词?](./Questions/itsm.md)
- [2. 权限中心配置用户组加入,自定义权限申请的审批流程报错中存在ITSM关键词?](./Questions/itsm.md)
- [3. 权限中心申请单中详情调整ITSM审批页面地址有误?](./Questions/itsm.md)

## 分级管理员与用户组

- [1. 分级管理员是什么?](./Questions/GradeManager.md)
- [2. 分级管理员与用户组的关系?](./Questions/GradeManager.md)
- [3. 用户组与RBAC?](./Questions/GradeManager.md)
- [4. 通过Open API创建分级管理员?](./Questions/GradeManager.md)
