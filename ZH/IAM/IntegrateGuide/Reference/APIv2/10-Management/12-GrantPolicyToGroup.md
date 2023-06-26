# 接入系统管理类 API v2
### 用户组授权
-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/groups/{group_id}/policies/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|否|应用 ID|
|bk_app_secret|string|否|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|access_token|string|否|用户或应用 access_token|

* 接口参数

| 字段 | 类型 | 位置 | 必须 | 描述 |
|---|---|---|---|---|
| system_id | string | path | 是 | 接入系统唯一标识 |
| group_id | int | path | 是 | 用户组ID |
| actions |  array[object]   | 是   | body | 操作 |
| resources |  array[object]   | 是   | body | 资源拓扑, 资源类型的顺序必须操作注册时的顺序一致 |

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
            "system": "bk_cmdb"
            "type": "biz",
            "id": "1",
            "name": "biz1"
          },
          {
            "system": "bk_cmdb"
            "type": "set",
            "id": "*",
            "name": ""
          }
        ]
      ]
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
