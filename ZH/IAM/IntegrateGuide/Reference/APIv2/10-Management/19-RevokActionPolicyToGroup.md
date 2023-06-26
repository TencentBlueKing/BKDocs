# 接入系统管理类 API v2
### 用户组权限按操作回收
-------

#### URL

> DELETE /api/v2/open/management/systems/{system_id}/groups/{group_id}/actions/-/policies/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|否|应用 ID|
|bk_app_secret|string|否|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|access_token|string|否|用户或应用 access_token|

* 接口参数

| 字段      |  类型      | 必选   | 位置 |描述      |
|-----------|------------|--------|------------|------------|
| system_id | string | path | 是 | 接入系统唯一标识 |
| group_id | int | path | 是 | 用户组ID |
| actions |  array[object]   | 是   | body | 操作 |

actions

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| id    |  string  | 是   | body | 操作 ID |


#### Request
```json
{
  "actions": [
    {
      "id": "edit_host"
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
