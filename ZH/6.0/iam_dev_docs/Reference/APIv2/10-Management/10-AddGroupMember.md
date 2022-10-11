# 接入系统管理类 API v2
### 添加用户组成员

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/groups/{group_id}/members/
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
| members |  array[object]  | 是 | body | 成员列表 |
| expired_at | int | 是 | body |过期时间戳(单位秒)，即用户或部门在 expired_at 后将不具有该用户组的相关权限，其中值为 4102444800 表示永久 |

members
| 字段 |  类型 |是否必须  | 位置 |描述  |
|--------|--------|--------|--------|--------|
| type |  string  | 是 | body | 成员类型，user 表示用户，department 表示部门 |
| id | string | 是 | body | 用户或部门 ID |

#### Request
```json
{
  "members": [
    {
      "type": "user",
      "id": "admin"
    },
    {
      "type": "department",
      "id": "1"
    }
  ],
  "expired_at": 1619587562
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
