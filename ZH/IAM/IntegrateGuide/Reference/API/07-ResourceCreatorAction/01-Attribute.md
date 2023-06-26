# 新建关联属性授权接口

### 接口基本说明
* 背景：
    - 接入系统上批量资源实例被创建时，对应的创建者应该需要赋予依赖这批实例的某个属性的相关权限
        - 比如批量作业创建时，创建者需要有属性为 creator=xxx 的作业的编辑、删除和查看权限

* 流程:
    - 1. **用户**在**接入系统**上产生资源实例
    - 2. **接入系统**请求 API,  **权限中心**根据 [新建关联](../02-Model/19-ResourceCreatorAction.md) 配置对应创建者进行授权

* 接口描述： 
    - 接入系统根据资源实例创建，对创建者进行相关属性授权

* `接口特别说明`
    - 新建关联的 Actions 对应的依赖资源类型必须 selection_mode 为 all 或 attribute（Action 无关联实例除外）且只能有一种依赖资源，否则新建关联授权时会被`自动忽略`

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/resource_creator_action_attribute/

APIGateway2.0 API

> POST /api/v1/open/authorization/resource_creator_action_attribute/

> `特别说明`: [ESB API 与 APIGateway2.0 API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)

#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|bk_app_code|string|是|应用 ID|
|bk_app_secret|string|是|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|bk_token|string|否|当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取|
|bk_username|string|否|当前用户用户名，仅仅在 ESB 里配置免登录态验证白名单中的应用，才可以用此字段指定当前用户|

* 接口参数

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system | string | 是 | 系统唯一标识 |
| type  | string | 是 | 资源类型的唯一标识 |
| creator | string | 是 | 资源实例的创建者 |
| attributes | array(object) | 是 | 资源属性列表，`多个属性之间的权限逻辑是AND` |

attributes 列表的元素说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源属性的唯一标识 |
| name | string | 是 | 资源属性的名称 |
| values | array(object) | 是 | 资源属性的值，支持多个值，`多个值之间的权限逻辑是OR` |

values 列表的元素说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 |  资源属性值的唯一标识 |
| name | string | 是 | 资源属性值的名称 |


#### Request

```json
{
    "system": "bk_sops",
    "type":"task",
    "creator":"admin",
    "attributes": [
        {
            "id":"owner",
            "name":"任务所属者",
            "values": [
                {
                    "id": "admin",
                    "name": "admin(管理员)"
                }
            ]
        }
    ]
}
```

#### Response

data 数组元素

| 字段      |  类型      |  描述      |
|:---|:---|:---|
|action|object| creator 被授权对应的 Action |
|policy_id|int| creator 被授权对应的策略 ID |

action

| 字段 |  类型 |  描述 |
|:---|:---|:---|
|id|string| 操作 ID |


> Status: 200 OK

```json
{
  "data": [  // 表示creator被授权对应的Action和策略ID列表
    {
        "action": {
            "id": "edit"
        },
        "policy_id": 1
    },
    {
        "action": {
            "id": "list"
        },
        "policy_id": 2
    },
    {
        "action": {
            "id": "delete"
        },
        "policy_id": 3
    },
    {
        "action": {
            "id": "view"
        },
        "policy_id": 4
    }
  ],
  "result": true,
  "code": 0,
  "message": "OK"
}
```


