# 接入系统管理类 API
### 更新分级管理员
-------

#### URL

ESB API

> PUT /api/c/compapi/v2/iam/management/grade_managers/{grade_manager_id}/

APIGateway2.0 API

> PUT /api/v1/open/management/grade_managers/{grade_manager_id}/

> `特别说明`: [ESB API 与 APIGateway2.0 API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|是|应用 ID|
|bk_app_secret|string|是|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|bk_token|string|否|当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取|
|bk_username|string|否|当前用户用户名，仅仅在 ESB 里配置免登录态验证白名单中的应用，才可以用此字段指定当前用户|

* 接口参数

| 字段      |  类型      | 必选   | 位置 |描述      |
|-----------|------------|--------|------------|------------|
| name  | string| 是 | body |分级管理员名称, 权限中心里全局唯一 |
| description | string | 是 | body |分级管理员描述，可为空字符串 | 
| authorization_scopes | array[object] | 是 |  body |分级管理员可授权范围 |
| subject_scopes | array[object] | 是 | body |分级管理员可授权的人员范围 |

subject_scopes

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| type    |  string  | 是   | body | 授权对象类型, 当前只支持 user 和 department |
| id    |  string  | 是   | body | 授权对象 ID，即用户名或部门 ID |

authorization_scopes

| 字段      |  类型      | 必选   |  位置 |描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 系统 id |
| actions |  array[object]   | 是   | body | 操作 |
| resources |  array[object]   | 是   | body | 资源拓扑, 资源类型的顺序必须操作注册时的顺序一致|

actions

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| id    |  string  | 是   | body | 操作 ID |

resources

| 字段      |  类型      | 必选   | 位置 | 描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 资源系统 ID |
| type |  string  | 是   | body | 资源类型 ID |
| paths | `array[array[object]]` | 是 | body | 批量资源拓扑，`最多1000个` |

paths

| 字段      |  类型      | 必选   | 位置 | 描述      |
|-----------|------------|--------|------------|------------|
| system |  string  | 是   | body | 拓扑节点类型的系统 ID |
| type | string  | 是   | body | 拓扑节点类型 ID |
| id | string | 是 | body | 拓扑节点实例 ID |
| name | string | 是 | body | 拓扑节点实例名称 |

`resources.paths`是批量的资源实例拓扑, 具体说明可以参考[资源拓扑授权/回收](../06-GrantRevoke/01-Topology.md)


#### Request
```json
{
  "name": "分级管理员1",
  "description": "",
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

```json
{
  "code": 0,
  "message": "ok",
  "data": {}
}
```
