# 接入系统管理类 API v2
### 创建用户组申请单据

-------

#### URL

> POST /api/v2/open/management/systems/{system_id}/groups/-/applications/
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
| group_ids |  array[int] | body | 是 | 用户组 ID 列表 |
| expired_at | int |body | 是 |  过期时间戳(单位秒)，即用户在 expired_at 后将不具有申请的用户组的相关权限 |
| applicant | string | body | 是 |  申请人，即 username |
| reason | string | body | 是 |申请理由 |

#### Request
```json
{
  "group_ids": [
    1,
    2,
    3
  ],
  "expired_at": 1653481167,
  "reason": "开发需要",
  "applicant": "blueking"
}
```

#### Response

| 字段 | 类型 | 描述 |
|---|---|---|
| ids | array[int]  | 申请单据 ID 列表，由于不同用户组审批流程不一样，所以会拆分出不同申请单据 |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "ids": [1, 2, 3]
  }
}
```
