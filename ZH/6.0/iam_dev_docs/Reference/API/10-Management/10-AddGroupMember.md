# 接入系统管理类 API
### 添加用户组成员

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/management/groups/{group_id}/members/

APIGateway2.0 API

> POST /api/v1/open/management/groups/{group_id}/members/

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

| 字段 |  类型 |是否必须  | 位置 |描述  |
|--------|--------|--------|--------|--------|
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

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count   | int     |  总数量 |
| results   |  array[object]   |  分页查询到结果 |

results
| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| type | string | 成员类型，user 表示用户，department 表示部门
| id   | string     | 用户或部门 ID |
| name | string | 用户或部门名称 |
| expired_at | int | 过期时间戳(单位秒)，即用户或部门在 expired_at 后将不具有该用户组的相关权限，其中值为 4102444800 表示永久 |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {}
}
```
