# 接入系统管理类 API v2
### 查询用户组成员列表

-------

#### URL

> GET /api/v2/open/management/systems/{system_id}/groups/{group_id}/members/
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
| page_size |  int  | 是| query | 分页查询参数之一，page_size 表示查询数量，`最大值为100` |
| page  | int | 是| query | 分页查询参数之一，page 表示从第几页开始查询，page 从 0 开始计算 |

#### Request
```bash
Get /api/v2/open/management/systems/{system_id}/groups/1/members/?page=0&page_size=10
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
  "data": {
    "count": 2,
    "results": [
      {
        "type": "user",
        "id": "admin",
        "name": "管理员",
        "expired_at": 1619587562
      },
      {
        "type": "department",
        "id": "1",
        "name": "部门1",
        "expired_at": 4102444800
      }
    ]
  }
}
```
