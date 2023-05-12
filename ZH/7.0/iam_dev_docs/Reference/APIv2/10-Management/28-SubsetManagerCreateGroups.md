# 接入系统管理类 API v2
### 二级管理员下批量创建用户组

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/subset_managers/{subset_manager_id}/groups/
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
| subset_manager_id | int | path | 是 | 二级管理员id  |
| groups | array | body | 是 | 需要创建的用户组列表 |

groups列表元素
| 字段 | 类型 | 位置 | 必须 | 描述 |
|---|---|---|---|---|
| name |string | body | 是 | 用户组名称，必须保证接入系统下全局唯一，最少5个字符，最大长度32个字符 |
| description | string | body | 是 | 用户组的简介 |

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
      "description": "test1test2"
    }
  ]
}
```

#### Response

| 字段 | 类型 | 描述 |
|---|---|---|
| data | array[int] | 用户组ID列表 | 

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": [1, 2]
}
```
