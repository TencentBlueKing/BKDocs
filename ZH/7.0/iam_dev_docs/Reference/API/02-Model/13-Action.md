# 操作 Action API

### 参数说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 操作 id, 系统下唯一, 只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-). 最长 32 个字符. |
| name |string | 是 | 操作名称，系统下唯一，参考[命名规范](../../NamingRules.md) |
| name_en | string | 是 | 操作英文名，国际化时切换到英文版本显示，参考[命名规范](../../NamingRules.md) |
| description  |string | 否 | 操作描述 |
| description_en | string | 否 | 操作描述英文，国际化时切换到英文版本显示 |
| auth_type | string | 否 | 操作授权类型，枚举值包括`abac\rbac` 不填默认为`abac`, [更多概念说明](./00-Concepts.md)  |
| type | string | 否 | 操作的类型，枚举值包括`create\delete\view\edit\list\manage\execute\use` 比如创建类操作需要标识为"create"，无法分类可为空字符串  |
| related_resource_types | Array(Object) | 否 | 操作的对象，资源类型列表，列表顺序与`产品展示`、`鉴权校验` 顺序 必须保持一致。`如果操作无需关联资源实例，这里为空即可。`  **注意这是一个有序的列表!**:  |
| related_actions | Array(string) | 否 | 操作的依赖操作, 由操作 ID 组成的字符串列表, 用于在申请权限时同时创建依赖权限  [更多概念说明](./00-Concepts.md)  |
| version | int | 否 |  版本号，允许为空，仅仅作为在权限中心上进行 New 的更新提醒 [更多概念说明](./00-Concepts.md)  |
| related_environments | Array(Object) | 否 |  操作可配置的环境属性列表，允许为空 [更多概念说明](./00-Concepts.md)  |

related_resource_types 里的元素

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system_id | string | 是 | 资源类型的来源系统，可以是自身系统或其他系统 |
| id | string | 是 | 资源类型 ID，操作关联多个资源类型时，`同一个related_resource_types里 id 不能重复` |
| name_alias | string | 否 | 资源类型名称的别名，同一个资源类型对于不同 Action 可以有各自的显示名称
| name_alias_en | string | 否 | 资源类型名称的别名英文名 |
| selection_mode | string | 否 | 选择类型, 即资源在权限中心产品上配置权限时的作用范围, 可选: `instance`/`attribute`/`all`, 如果不设置, 默认为`instance`, [更多概念说明](./00-Concepts.md)  |
| related_instance_selections | Array(Object) | 否 |  关联的实例视图，即资源在权限中心产品上配置权限时的选择方式; 可以配置本系统的实例视图, 也可以配置其他系统的实例视图(如果`selection_mode=attribute`则该字段不用配置; 如果没有设置`selection_mode`或`selection_mode=instance/all`, 此时这个字段不能为空)  |

related_instance_selections 里的元素 

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system_id | string | 是 | 实例视图的来源系统 ID |
| id |string | 是 | 实例视图 ID |
|  ignore_iam_path | bool | 否 | 是否配置的权限忽略路径，`默认为false`，[更多概念说明](./00-Concepts.md)  |

注册后，IAM 配置权限时拉取资源的逻辑，请查看[资源拉取接口协议](../03-Callback/01-API.md)

related_environments 里的元素

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 环境属性类型, 单前只支持`period_daily |

**重要说明：** 
- Action 关联的资源类型必须在权限中心已经注册的，否则 Action 将注册失败
- 若关联的资源类型的自身系统的，则需要先注册该资源类型
- 若关联的资源类型是依赖其他系统的，则需要等依赖系统注册该资源类型后才可以进行该 Action 注册

### 1. 添加 action

限制:
- 一个系统只能创建最多 100 个 action, 所以如果操作会超过 100 个, 需要思考模型的正确性/合理性(例如把实例抽象到了 action 导致 action 随实例增多而增多)

#### URL

> POST  /api/v1/model/systems/{system_id}/actions

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request

```json
[
    {
        "id": "biz_create",
        "name": "业务创建",
        "name_en": "biz_create",
        "description": "业务创建是...",
        "description_en": "biz_create is...",
        "auth_type": "abac",
        "type": "create",
        "related_resource_types": [],
        "version": 1
    },
    {
        "id": "host_edit",
        "name": "主机编辑",
        "name_en": "host_edit",
        "auth_type": "",
        "type": "",
        "related_resource_types": [
            {
                "system_id": "bk_cmdb",
                "id": "host",
                "name_alias":  "",
                "name_alias_en": "",
                "selection_mode": "instance",
                "related_instance_selections": [
                    {
                        "system_id": "bk_cmdb",
                        "id": "free_host",
                        "ignore_iam_path": false,
                    }, 
                    {
                        "system_id": "bk_cmdb",
                        "id": "biz_topology",
                        "ignore_iam_path": false,
                    }, 
                    {
                        "system_id": "bk_cmdb",
                        "id": "biz_set_topology",
                        "ignore_iam_path": false,
                    }
                ]
            }
        ],
        "related_actions": ["view", "delete"],
        "version": 1
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

### 2. 修改 action

**重点：**
- 可更新 name\name_en\type\version\related_resource_types 这 5 个 key 的值， 如果传了对应`key`并给了`空值`, 那么执行的是`置空操作`; 如果没有传`key`, 表示不更新该字段；
- `特别：对于related_resource_types是一个完全覆盖操作，不能单独更新related_resource_types里的某个key的值`

#### URL

> PUT /api/v1/model/systems/{system_id}/actions/{action_id}

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |
| action_id | string | 是 | path | 操作 ID |

#### Request
```json
{
   "name":"主机编辑New",
   "name_en":"host_edit",
   "description":"主机编辑New是...",
   "description_en":"host_edit is...",
   "related_resource_types":[
      {
         "system_id":"bk_cmdb",
         "id":"host",
         "name_alias":"",
         "name_alias_en":"",
         "selection_mode": "instance",
         "related_instance_selections":[
                    {
                        "system_id": "bk_cmdb",
                        "id": "free_host",
                        "ignore_iam_path": false,
                    }, 
                    {
                        "system_id": "bk_cmdb",
                        "id": "biz_topology",
                        "ignore_iam_path": false,
                    }
         ]
      }
   ],
   "related_actions": ["view", "delete"],
   "version":2
}
```
#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```
### 3. 删除 action

说明：
- 如果action没有配置相关的操作分组/常用操作/新建关联, 并且没有配置过权限, 可以直接删除;
- 如果配置过, 需要先删除操作分组/常用操作/新建关联的引用及用户配置的权限, 之后完全删除action;

删除action步骤：
1. [调用更新操作分组API](./14-ActionGroup.md) - 将要删除的Action从操作分组里删除
2. [调用更新常用操作配置API](./17-CommonActions.md) - 将要删除的Action从常用操作配置里移除
3. [调用更新新建关联配置API](./19-ResourceCreatorAction.md) - 将要删除的Action从新建关联配置里移除
4. [调用异步删除Action配置的权限策略API](./20-ActionPolicy.md) - 将所有涉及要删除的Action的权限都删除
5. 调用以下接口完成Action的删除

#### URL

批量删除 (需要 Request.Body)

> DELETE  /api/v1/model/systems/{system_id}/actions

单个删除 (不需要 Request.Body)

> DELETE /api/v1/model/systems/{system_id}/actions/{action_id}

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--|:--|:--|:--|:--|
|system_id |string |是 |path |系统 ID |
|action_id |string |是 |path |操作 ID |
|check_existence |boolean |否 |query |默认会检查 id 存在, 不存在将导致删除失败, 设置 false 不检查 id 是否存在, 直接走删除( `delete from table where id in []` ) |

#### Request

```json
[
    {
        "id": "host_edit"
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
