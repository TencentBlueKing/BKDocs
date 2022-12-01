# 接入系统管理类 API v2
### 删除用户组成员

-------

#### URL

> DELETE /api/v2/open/management/systems/{system_id}/groups/{id}/members/
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
| type | string | query | 是 | 成员类型，user 表示用户，department 表示部门 |
| ids | string | query | 是  | 成员 ID 列表，多个以英文逗号分隔, 对于 type=user，则 ID 为用户名，对于 type=department，则为部门 ID |


#### Request
```bash
Delete /api/v2/open/management/systems/demo/groups/1/members/?type=user&ids=admin,test1,test2
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
