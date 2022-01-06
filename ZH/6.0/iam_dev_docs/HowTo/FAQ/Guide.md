# 问题排查指引

如果有`错误码`, 优先看错误码

- [错误码](ErrorCode.md)

如果是下面这几类问题, 直接跳转到对应文档

- [常见: SaaS 回调接入系统失败](Debug/SaaS-Callback.md)
- [常见: SaaS 组织架构同步异常](Debug/SaaS-DeptSync.md)
- [常见: 为什么有权限/无权限](Debug/PolicyAPIDebug.md)

---

## 1. 开发接入

当遇到调用权限中心接口报错, 首先

1. 确认请求响应的 [错误码](ErrorCode.md) 确认问题, 并根据指引解决
2. 查找 FAQ
3. 如果无法自助解决, 需要提单由权限中心开发协助排查, 请 [提单模板](Debug/Issue.md) 提供环境/请求/响应等信息. 请务必按照要求填写, 便于更快速定位解决问题

## 2. 使用权限中心 SaaS 过程中发现`未知错误`

客户在发现 SaaS 使用过程中出现 `未知错误` , 可以通过 `request_id` 查询到相关的调试信息, 提单时附加到单据中; 

- 如果配置权限回调接入系统报错, 根据 [回调接入系统失败](Debug/SaaS-Callback.md)
- 如果是组织架构同步异常/失败, 根据 [组织架构同步异常](Debug/SaaS-DeptSync.md) 自助排查
- 可以根据 [自助排查: SaaS 报错 Debug](Debug/SelfHelp/SaaS-DebugTraceAPI.md) 自助通过`request_id`获取报错详情;

## 3. 对权限有疑问

鉴权接口正常返回, 但是不符合预期(为什么有权限/为什么无权限)

1. 到权限中心 SaaS 页面, 查看个人权限, 确认个人权限 / 组织架构权限 / 组权限 (大概率是继承了上级部门或所属组的权限)
2. 想进一步从请求中确认权限计算细节; 可以根据 SDK 文档, 开启 debug 模式; 或者阅读 [鉴权接口 debug](Debug/PolicyAPIDebug.md) 文档, 通过在请求参数中加`?debug=true`, 开启接口`debug`, 可以看到详细的策略计算流程; 如果怀疑是缓存问题, 可以加上`?force=true`参数, 强制走实时数据查询, 不走缓存;

## 4. 运维问题

1. [确认权限中心服务是否可用？](../OPS/Debug.md) 

## 5. 进阶

权限中心提供了 debug-cli, 用于深入定位一些复杂问题

用户可以

1. 根据文档指引中的问题排查步骤, 使用 debug-cli 获取信息
2. 同权限中心开发协作, 共同排查生产问题
3. 自行阅读文档, 自助排查问题

[自助排查: IAM-Debug CLI](Debug/SelfHelp/DebugCLI.md) 使用文档
