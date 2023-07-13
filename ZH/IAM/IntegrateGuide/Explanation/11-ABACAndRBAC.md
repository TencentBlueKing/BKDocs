# ABAC 与 RBAC 的区别

## 0. 前置说明

权限规则由一下几个部分组成:

```json
{
    "subject": { # 被授权对象, 可以是用户, 可以是用户组
        "type": "user",
        "id": "admin"
    },
    "action": { # 对资源的操作
        "id": "view_host"
    },
    "resource": { # 资源实例
        "type": "host",
        "id": "host1"
    }
}
```

概念请参考: [术语解释](../../1.8/UserGuide/Term/Term.md)

## 1. ABAC 功能与限制

### 1.1 ABAC 可以做到

1. 通过 `subject` + `action` + `resource` 查询鉴权结果
2. 通过 `subject` + `action` 查询实例范围
    - *注意* 这里查询的实例的范围, 有可能不能精准到实例的`id`列表, 例如表达式是`starts_with`, 需要接入系统自行解析

### 1.2 ABAC 做不到

1. 通过 `action` + `resource` 查询有权限的 `subject`
2. 通过 `subject` + `resource` 查询有权限的 `action`

ABAC有以上限制的原因是:

ABAC的策略中资源部分保存的是资源选择的范围, 而不是单个资源实例id的集合, 这就导致如果要通过`resource`来反查`subject`或者`action`需要全表遍历计算

## 2. RBAC 功能与限制

*注意* RBAC的`subject`只能是用户组

### 2.1 RBAC 可以做到

1. 通过 `subject` + `action` + `resource` 查询鉴权结果
2. 通过 `subject` + `action` 查询有权限的 `resource`
3. 通过 `subject` + `resource` 查询有权限的 `action`
4. 通过 `action` + `resource` 查询有权限的 `subject`

### 2.2 RBAC 的限制

1. 对`subject`为`user`的用户直接授权
2. 不支持资源的属性授权
3. 资源的层级选择必须配置忽略路径

如何配置操作为ABAC或RBAC请参考:

- [操作 Action API](../Reference/API/02-Model/13-Action.md)
- [操作授权类型](./10-ActionAuthType.md)
