# 接入系统管理类 API v2
### 创建分级管理员

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/grade_managers/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)

#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|否|应用 ID|
|bk_app_secret|string|否|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|access_token|string|否|用户或应用 access_token|

| 字段      |  类型      | 必选   | 位置 |描述      |
|-----------|------------|--------|------------|------------|
| system_id | string | 是 | path | 接入系统唯一标识 |
| name  | string| 是 | body |分级管理员名称, 权限中心里全局唯一 |
| description | string | 是 | body |分级管理员描述，可为空字符串 |
| members | array[string] | 是 | body | 分级管理员成员列表 |
| authorization_scopes | array[object] | 是 |  body |分级管理员可授权范围 |
| subject_scopes | array[object] | 是 | body |分级管理员可授权的人员范围 |
| sync_perm | bool | 否 | body |是否创建同步权限用户组, 默认false |
| group_name | string | 否 | body |如果sync_perm为true, 可以自定义用户组名称, 默认为空 |

subject_scopes

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| type    |  string  | 是   | body | 授权对象类型, 当前只支持 user和department |
| id    |  string  | 是   | body | 授权对象ID，即用户名或部门ID |

说明: 如需设置`全员`授权范围, type = `*`, id = `*`

authorization_scopes

| 字段      |  类型      | 必选   |  位置 |描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 系统id |
| actions |  array[object]   | 是   | body | 操作 |
| resources |  array[object]   | 是   | body | 资源拓扑, 资源类型的顺序必须操作注册时的顺序一致|

actions

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| id    |  string  | 是   | body | 操作ID |

resources

| 字段      |  类型      | 必选   | 位置 | 描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 资源系统ID |
| type |  string  | 是   | body | 资源类型ID |
| paths | `array[array[object]]` | 是 | body | 批量资源拓扑，`最多1000个` |

paths

| 字段      |  类型      | 必选   | 位置 | 描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 拓扑节点类型的系统ID |
| type | string  | 是   | body | 拓扑节点类型ID |
| id | string | 是 | body | 拓扑节点实例ID |
| name | string | 是 | body | 拓扑节点实例名称 |

`resources.paths`是批量的资源实例拓扑


#### Request

```json
{
  "name": "分级管理员1",
  "description": "",
  "members": [
    "admin"
  ],
  "authorization_scopes": [
    {
      "system": "bk_cmdb",
      "actions": [
        {
          "id": "edit_host"
        }
      ],
      "resources": [
        {  # 操作关联的资源类型, 必须与所有的actions都匹配, 资源类型的顺序必须操作注册时的顺序一致
          "system": "bk_cmdb",
          "type": "host",
          "paths": [  # 批量资源拓扑
            [
              {
                "system": "bk_cmdb",
                "type": "biz",
                "id": "1",
                "name": "biz1"
              },
              {
                "system": "bk_cmdb",
                "type": "set",
                "id": "*",
                "name": ""
              }
            ]
          ]
        }
      ]
    }
  ],
  "subject_scopes": [
    {
      "type": "user",
      "id": "admin"
    }
  ]
}
```

#### Response

> Status: 200 OK

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id   | int     | 分级管理员id |


```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "id": 1
  }
}
```
