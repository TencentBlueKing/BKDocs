# 资源反向拉取相关

## 1. 权限中心`资源反向拉取`调用接入系统接口拉取资源时的 token 如何获取 

调用接口获取, 详细文档见  [系统间接口鉴权](../../../Reference/API/01-Overview/03-APIAuth.md) / [系统 token 查询 API](../../../Reference/API/02-Model/16-Token.md)

建议缓存在内存中(确保升级/重启时重新拉取), 不建议放 redis 中(安全问题/更新未重新拉取)

## 2. 资源反向拉取接口各自对应页面上哪些展示? 什么时候会被调用?

- fetch_instance_info **无权限申请**/新建关联/跨系统资源依赖等场景, 会到接入系统拉取资源信息;
    - 无权限申请流程，生成无权限url，跳转权限中心**提交申请单**时会触发回调
- list_instance_by_policy 权限预览[前端暂未实现, 可以暂时不实现, 直接返回空]

## 3. fetch_instance_info的作用是什么?

无权限申请及其他权限申请场景, 接入系统生成提交的数据, 可能经过前端跳转或者被工具劫持, 可以将表单中资源 ID/名称等进行修改.

这样会带来安全风险, 申请资源 ID 是`核心业务 1`, 名称却是`非核心业务a`, 审批人无法识别id与名称是否匹配, 审批通过后有越权风险.

所以, 在数据进入申请审批流程, 或者授权流程, 权限中心会回调接入系统`fetch_instance_info`, 获取id及名称, 与提交的数据校验是否一致

## 4. fetch_instance_info 能给到父节点的parentID吗?

不能! 
fetch_instance的时候只有id列表，入口有无权限申请/页面申请/授权api等，这时候id是离散的，权限中心并不知道这批id的上级是什么

## 5. fetch_instance_info 的id列表为什么会有已经被删除的资源id?

用户组的配置权限的时候, 会通过`list_instance`拉取到接入系统的资源列表, 配置权限, 此时保存了`资源 id`

但是接入系统删除资源时并不会通知权限中心, 此时用户在修改已有策略的时候, 会触发回调.

接入系统应该过滤掉已经被删除的id, 只返回存在的. 例如
批量查 100 个, 如果其中有 3 个被删除, 返回另外 97 个.(不要500/404, 这是个批量接口, 需要确保其他数据正常返回)

(未来权限中心会增强这个协议, 支持识别被删除的资源, 做主动策略清理)

## 6. list_instance 的作用是什么?

在配置权限页面, 资源是以列表的方式展示给用户的, 并且, 如果存在上下级关系, 例如点击业务, 展开展示业务下的主机列表.

`list_instance`, 参数是上一级的`parent`的`type/id`, 拉取当前层级的资源列表

## 7. 提示回调接入系统接口错误, 怎么调试?

优先到被调用系统找到对应的回调请求记录, 从日志确认问题. 找不到再考虑构造请求复现.

使用文档中提示的回调接口协议, 构建请求验证即可; 以curl为例

- THE_TOKEN 为注册系统到权限中心时权限中心生成的 token, 可以通过 `get_token` 接口获取
- THE_CALLBACK_HOST 为注册系统到权限中心时的 `provider_config.host`的值, 一般是回调目标系统的地址
- request body中参数替换成对应的method, 资源类型以及filter过滤参数

```
curl -X POST -H 'Content-Type:application/json' -u bk_iam:{THE_TOKEN} http://{THE_CALLBACK_HOST}/auth/v3/find/resource -d '{
    "type": "biz_custom_query",
    "method": "fetch_instance_info",
    "filter": {
        "ids": ["bubdvkg64nb78c378ob0"],
        "attrs": ["display_name"]
    }
}'
```

注意, 如果 `THE_CALLBACK_HOST` 注册错误, 可能回调到其他地方去了(例如本地开发不小心刷掉了线上的系统配置)

