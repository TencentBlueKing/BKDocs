# 接入系统管理类 API v2
### 更新用户组名称和描述

-------

#### URL

> PUT /api/v2/open/management/systems/{system_id}/groups/{group_id}/
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
| group_id | int | 是 | path | 用户组 ID |
| name |  string  | 是   | body | 用户组名称，至少 5 个字符，也可为空，空则不更新 |
| description | string | 是 | body| 用户组描述，至少 10 个字符，也可为空，空则不更新 |

#### Request
```json
{
    "name": "test2",
    "description": "test1test2"
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
