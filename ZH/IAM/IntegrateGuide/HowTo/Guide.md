# 接入指引

## 基本接入

1. 阅读 产品介绍及接入流程 (10 分钟)
    - [产品说明](../../1.12/UserGuide/Introduce/README.md)
    - [接入流程](GuideFlow.md)
2. 阅读 快速开始(30 分钟)
    - [简介](../QuickStart/01-Begin.md)
    - [准备工作](../QuickStart/02-Prepare.md)
    - [模型注册](../QuickStart/03-Model.md)
    - [鉴权](../QuickStart/04-Auth.md)
    - [无权限申请](../QuickStart/05-Application.md)
    - [了解更多](../QuickStart/06-More.md)
3. 梳理 系统的权限模型
4. 阅读 接入样例(30 分钟)
    通过接入样例, 可以快速理解各种业务场景对应的权限模型

    - [样例 1: 无关联实例权限](Examples/01-ActionWithoutResource.md)
    - [样例 2: 关联简单实例权限](Examples/02-ActionWithResource.md)
    - [样例 3: 使用拓扑层级管理权限](Examples/03-Topology.md)
    - [样例 4: 使用属性管理权限](Examples/04-Attribute.md)
    - [样例 5: 配置操作组优化权限申请](Examples/05-ActionGroup.md)
    - [样例 6: 配置常用操作优化权限申请](Examples/06-CommonActions.md)
    - [样例 7: 配置依赖操作优化权限申请](Examples/07-RelatedActions.md)
    - [样例 8: 系统间调用无权限申请](Examples/08-NoPermissionApply.md)
    - [开源项目: 接入权限中心的实现](Examples/10-OpenSource.md)
5. 阅读 权限中心接口协议相关说明 (10 分钟)
    - [后台 API 和 ESB API 说明](../Reference/API/01-Overview/01-BackendAPIvsESBAPI.md)
    - [接口协议前置说明](../Reference/API/01-Overview/02-APIBasicInfo.md)
    - [系统间接口鉴权](../Reference/API/01-Overview/03-APIAuth.md)
6. 注册权限模型到权限中心
    - [系统注册名词规范](../Reference/NamingRules.md)
    - [说明: 实例视图](../Explanation/01-instanceSelection.md)
    - [AppCode 和 SystemID 说明](../Explanation/05-AppcodeAndSystemID.md)
    - [模型注册 API](../Reference/API/02-Model/00-API.md)
    - [权限模型自动初始化及更新 migration](Solutions/Migration.md)

    建议使用 json 通过 migration 进行模型注册, 方便后续维护及升级; 如果使用了 python sdk, 可以利用 sdk 的封装将模型注册 migration 整合到 django migration 中
7. 接入系统实现相关资源反向拉取接口
    - [系统间接口鉴权](../Reference/API/01-Overview/03-APIAuth.md)
    - [资源拉取 API](../Reference/API/03-Callback/01-API.md)
    
    如果使用了 python sdk, 可以通过封装的 dispatcher 实现相应 API
8. 接入系统实现鉴权逻辑
    使用 SDK 进行鉴权(推荐, 常规 SaaS/中大型系统)
    - [Python SDK](../Reference/SDK/01-PythonSDK.md)
    - [Go SDK](../Reference/SDK/02-GoSDK.md)
    - [Java SDK](../Reference/SDK/03-JavaSDK.md)
    - [PHP SDK](../Reference/SDK/05-PHPSDK.md)
    - [SDK 鉴权](../Reference/API/04-Auth/01-SDK.md)
    
    非 SDK 鉴权(直接鉴权, 小型系统/脚本/定时任务等无法使用 SDK 的情况)
    - [直接鉴权](../Reference/API/04-Auth/02-DirectAPI.md)
9. 实现无权限交互逻辑

    - [无权限交互方案](Solutions/NoPermissionApply.md)
    - [生成无权限申请 URL](../Reference/API/05-Application/01-GenerateURL.md)
    - [第三方鉴权失败返回权限申请数据协议](../Reference/API/05-Application/02-NoPermissionData.md)

## 增强功能

1. 新建关联
    当新建一个资源时, 需要给某些人自动授予某些权限, 例如新建一个业务, 自动授予创建者 A 用户业务查看, 业务编辑, 业务删除的权限
    - [新建关联权限方案](Solutions/ResourceCreatorAction.md)
    - [新建关联属性授权接口](../Reference/API/07-ResourceCreatorAction/01-Attribute.md)
2. 依赖操作
    用户在申请操作 A 权限时, 操作 A 依赖于操作 B, IAM 在创建申请单时会同时帮用户申请操作 B 的权限 例如申请`开发应用`的权限时, 会自动申请`访问开发者中心`权限, 这样存在依赖关系的权限就不需要额外单独申请
    - [依赖操作权限方案](Solutions/RelatedActions.md)
    - [样例 7: 配置依赖操作优化权限申请](Examples/07-RelatedActions.md)
    - [操作(Action)](../Reference/API/02-Model/13-Action.md)
3. 操作组
    如果系统注册的操作非常多, 在权限中心申请权限时默认是没有分类展示的, 可以额外进行分组
    - [操作组(ActionGroup)](../Reference/API/02-Model/14-ActionGroup.md)
    - [样例 5: 配置操作组优化权限申请](Examples/05-ActionGroup.md)
4. 常用操作
    接入系统可以根据使用场景, 将操作进行`组合`, 作为常用操作方便用户申请
    - [常用操作配置(CommonActions)](../Reference/API/02-Model/17-CommonActions.md)
    - [样例 6: 配置常用操作优化权限申请](Examples/06-CommonActions.md)
5. 依赖环境属性
    接入系统对于权限的生效条件的需求，除了权限本身的过期时间外，可能还需要关注权限生效的环境属性条件，比如可以控制权限只在 `星期一`的`00:00:00-06:00:00` 这个时间段生效，在这个时间段的鉴权请求都是`pass`, 时间段外的鉴权都是`not allowed`，这就需要接入系统在注册操作的时候同时提供是否能配置相关环境属性的信息
    - [依赖环境属性方案](./Solutions/RelatedEnvironments.md)
    - [操作(Action)](../Reference/API/02-Model/13-Action.md)

# 高级接入

1. 授权及回收
    - [大规模实例级权限限制](../Explanation/06-LargeScaleInstances.md)
    - [资源拓扑授权/回收](../Reference/API/06-GrantRevoke/01-Topology.md)
    - [批量资源拓扑授权/回收](../Reference/API/06-GrantRevoke/02-BatchTopology.md)
2. 查询类 API
    - [policy get 获取某条策略详情](../Reference/API/08-Query/01-PolicyGet.md)
    - [policy list 拉取系统下某个操作的策略列表(翻页)](../Reference/API/08-Query/02-PolicyList.md)
    - [policy subjects 根据策略 ID 拉群策略对应的用户信息](../Reference/API/08-Query/03-PolicySubjects.md)
3. RBAC
    - [操作 Action API](../Reference/API/02-Model/13-Action.md)
    - [说明: 操作授权类型](../Explanation/10-ActionAuthType.md)
    - [说明: ABAC与RBAC区别](../Explanation/11-ABACAndRBAC.md)

4. LBAC

    注意, 这个方案是为了满足一些特殊场景而设计的, 本身的实现成本非常高, 如无相应的需求, 不需要关注

    - 基于 LBAC+RBAC 的接入方案


# 其他链接
1. 常见问题
    - [问题排查指引](FAQ/Guide.md)
    - [错误码](FAQ/ErrorCode.md)
    - [常见: SaaS 回调接入系统失败](FAQ/Debug/SaaS-Callback.md)
    - [常见: SaaS 组织架构同步异常](FAQ/Debug/SaaS-DeptSync.md)
    - [常见: 为什么有权限/无权限](FAQ/Debug/PolicyAPIDebug.md)
    - [产品相关](../../1.12/UserGuide/FAQ/Diffv2v3.md)
2. API
    - [后台 API 和 ESB API 说明](../Reference/API/01-Overview/01-BackendAPIvsESBAPI.md)
    - [接口协议前置说明](../Reference/API/01-Overview/02-APIBasicInfo.md)
    - [系统间接口鉴权](../Reference/API/01-Overview/03-APIAuth.md)
3. 附加阅读
    - [表达式定义](../Reference/Expression/01-Schema.md)
    - [大规模实例级权限限制](../Explanation/06-LargeScaleInstances.md)
4. 部署及运维
    - [部署及运维说明](OPS/Deploy.md)
    - [升级部署说明](OPS/Upgrade.md)
    - [开发测试环境搭建](OPS/Develop.md)
    - [性能测试说明](../Reference/Benchmark.md)
