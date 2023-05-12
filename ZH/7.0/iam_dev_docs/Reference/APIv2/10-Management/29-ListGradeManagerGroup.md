# 接入系统管理类 API v2
### 查询分级管理员下用户组列表

-------

#### URL

> GET /api/v2/open/management/systems/{system_id}/grade_managers/{grade_manager_id}/groups/
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
| grade_manager_id或subset_manager_id| int | 是 | path  | 分级管理员或二级管理员id |
| inherit | bool | query | 否 | 分级管理员是否继承查询子集管理员的用户组, 默认否 |
| name | string | query | 否 | 用户组名称筛选 |
| id | int | query | 否 | 用户组id筛选 |
| description | string | query | 否 | 用户组描述筛选 |
| page_size | int | query | 是 | 分页大小, 最大500 |
| page | int | query | 是 | 分页 |

#### Request
```json
GET /api/v2/open/management/systems/demo/grade_managers/1/groups/?page_size=100&page=1
```

#### Response

| 字段 | 类型 | 描述 |
|---|---|---|
| id| int | 用户组ID | 
| name| string | 用户组名称 |
| description| string | 用户组描述 |
| readonly| bool| 是否是只读用户组|
| user_count| int| 用户组成员user数量|
| department_count| int| 用户组成员department数量|

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "count": 1,
    "results": [
      {
        "id": 1,
        "name": "用户组",
        "description": "用户组",
        "readonly": false,
        "user_count": 1,
        "department_count": 1
      }
    ]
  }
}
```
