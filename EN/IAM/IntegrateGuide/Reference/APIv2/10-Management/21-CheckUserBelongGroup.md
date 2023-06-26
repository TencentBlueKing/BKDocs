# 接入系统管理类 API v2
### 校验用户是否某个用户组的有效成员

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/users/{user_id}/groups/belong/
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
| user_id | string | 用户 ID |
| group_ids | string | body | 是 | 用户组ID 列表，多个以英文逗号分隔 |
| inherit | bool | body | 否 | 对于用户，是否会包括其继承来着部门的，默认为false，即默认只查询直接关联的，不会包括继承的 |


#### Request

```json
GET /api/v2/open/management/systems/demo/users/test_user1/groups/belong/?groups=1,2,3,4&inherit=false
```

#### Response

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    1: true,
    2: false,
    3: false,
    4: true
  }
}
```
