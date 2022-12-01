# 接入系统管理类 API
### 用户组权限按操作回收
-------

#### URL

ESB API

> DELETE /api/c/compapi/v2/iam/management/groups/{group_id}/actions/policies/

APIGateway2.0 API

> DELETE /api/v1/open/management/groups/{group_id}/actions/policies/

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

| 字段      |  类型      | 必选   | 位置 |描述      |
|-----------|------------|--------|------------|------------|
| group_id | int | 是 | path | 用户组 ID |
| system |  string  | 是   | body | 系统 id |
| actions |  array[object]   | 是   | body | 操作 |

actions

| 字段      |  类型      | 必选   |  位置 | 描述      |
|-----------|------------|--------|------------|------------|
| id    |  string  | 是   | body | 操作 ID |


#### Request
```json
{
  "system": "bk_cmdb",
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
