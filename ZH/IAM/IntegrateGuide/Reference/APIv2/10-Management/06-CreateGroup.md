# 接入系统管理类 API v2
### 创建用户组

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/grade_managers/{grade_manager_id}/groups/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|否|应用 ID|
|bk_app_secret|string|否|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|access_token|string|否|用户或应用 access_token|

* 接口参数

| 字段 |  类型 |是否必须  | 位置 |描述  |
|--------|--------|--------|--------|--------|
| system_id | string | path | 是 | 接入系统唯一标识 |
| grade_manager_id | int | 是 | path | 分级管理员 ID |
| groups |  array[object]  | 是 | body | 用户组列表 |

groups
| 字段 |  类型 |是否必须  | 位置 |描述  |
|--------|--------|--------|--------|--------|
| name |  string  | 是   | body |用户组名称，至少 5 个字符，同一个分级管理员下唯一 |
| description | string | 是 | body | 用户组描述，至少 10 个字符 |
| readonly | bool | 否 | body |可选参数，默认为 false, 用户组仅仅可读，true 时，则无法用户组在权限中心产品上将无法删除 |

#### Request
```json
{
  "groups": [
    {
      "name": "test1",
      "description": "test1test1"
    },
    {
      "name": "test2",
      "description": "test1test2",
      "readonly": true
    },
  ]
}
```

#### Response

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| data |  array[int]  | 用户组 ID 列表 |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": [1, 2]
}
```
