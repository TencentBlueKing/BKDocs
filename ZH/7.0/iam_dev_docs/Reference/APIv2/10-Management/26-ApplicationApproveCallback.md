# 接入系统管理类 API v2
### 申请单审批状态通知回调

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/applications/{callback_id}/approve/
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
| system_id | string | 是 | path | 接入系统唯一标识 |
| callback_id | string | 是 | path | 申请回调id |
| sn  | string| 是 | body |申请单itsm返回的sn |
| current_status | string | 是 | body |itsm返回的回调状态 |
| approve_result | bool | 是 | body | itsm返回的审批结果 |

`注意:`

- `sn`, `current_status`, `approve_result` 三个参数来源于ITSM的回调数据, 具体的参数定义请参考ITSM相关文档
- 如果审批通过, 回调后, 会创建或更新分级管理员

#### Request

```json
{
  "sn": "",
  "current_status": "finished",
  "approve_result": true
}
```

#### Response

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id   | int     | 权限中心申请单id |
| role_id   | int     | 申请单创建的分级管理员id |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "id": 1,
    "role_id": 1
  }
}
```
