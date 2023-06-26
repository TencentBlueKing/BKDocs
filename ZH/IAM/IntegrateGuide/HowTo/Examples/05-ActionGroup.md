# 样例 5: 配置操作组优化权限申请

## 1. 场景描述

一般情况下, 单个系统的权限可能有多个操作, 甚至几十个操作;

如果没有分类, 用户在申请时, 难以找到目标的操作;

权限中心提供了`操作组`, 支持接入系统将操作进行分类, 划分到不同组中, 这样在申请页面, 操作将以接入系统配置的分类进行展示, 体验更好.

## 2. 权限模型

通过 [操作组(ActionGroup) API](../../Reference/API/02-Model/14-ActionGroup.md) 进行注册;

例如 bk_paas 存在 5 个操作, 可以划分成三类.

```json
[
  {
    "name": "访问权限",
    "name_en": "Access Permissions",
    "actions": [
      {
        "id": "access_developer_center"
      }
    ]
  },
  {
    "name": "开发者权限",
    "name_en": "Developer Permissions",
    "actions": [
      {
        "id": "develop_app"
      }
    ]
  },
  {
    "name": "管理权限",
    "name_en": "Admin Permissions",
    "actions": [
      {
        "id": "manage_smart"
      },
      {
        "id": "ops_system"
      },
      {
        "id": "manage_apigateway"
      }
    ]
  }
]
```


## 3. 产品交互

在权限申请页面, 自动根据注册的配置, 将权限分成了`访问权限`/`开发者权限`/`管理权限`三组;

![-w2021](../../assets/HowTo/Examples/05_01.jpg)
