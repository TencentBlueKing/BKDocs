# 功能开关配置 FeatureShieldRules API

### 参数说明
| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| effect |string | 是 | 支持黑白名单，值为 deny 或 allow  |
| feature | string | 是 | 开启或关闭的功能 |
| action | Object | 是 | 操作 |

feature 字段枚举值说明：

| 枚举值 | 说明 |
|:---|:---|:---|
| application.custom_permission.grant | 申请自定义权限 |
| application.custom_permission.renew | 申请自定义权限续期 |
| user_permission.custom_permission.delete | 自定义权限删除 |


action 字段说明：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | Action 的唯一标识，`特别说明:` 如果功能是针对整个接入系统，则 id 为 * |


`特别说明`：
1. 多条 allow/deny 规则判断最终 effect 的逻辑（类似 Nginx 的 IP 白名单判断），即判断某个功能开启或关闭逻辑：

```bash
在某个功能下的该系统的某个Action的开启与否：allow *[开启] > allow action_id[开启] > deny *[关闭] > deny action_id[关闭] > 默认开启
（1）如果存在allow * 或 allow action_id 的规则匹配，则开启
（3）如果不存在allow * 和 allow action_id 规则，但有deny * 或者deny action_id 规则匹配，则关闭
（4）如果没有任何规则匹配，则默认开启

一般来说，只需要配置屏蔽的功能即可
```

2. 对于依赖操作，如果被屏蔽了，则不会创建依赖操作，比如 edit 依赖 view，但是 view 被屏蔽了，则申请 edit 权限时，不会创建其依赖操作 view


### 1. 注册或更新 功能开关规则

#### URL

注册
> POST /api/v1/model/systems/{system_id}/configs/feature_shield_rules

更新 (整个列表完全覆盖更新)
> PUT /api/v1/model/systems/{system_id}/configs/feature_shield_rules

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request

```json
[
    // 对于自定义申请，屏蔽整个该接入系统所有Action，即该接入系统不支持自定义申请
    {
        "effect": "deny",
        "feature": "application.custom_permission.grant",
        "action": {
            "id": "*"
        }
    },
    // 对于个人权限，接入系统某个Aciton的自定义权限不允许被删除
    {
        "effect": "deny",
        "feature": "user_permission.custom_permission.delete",
        "action": {
            "id": "access_business"
        }
    }
]
```
#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```