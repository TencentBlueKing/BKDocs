# 接入系统管理类 API v2
### 取消申请单

-------

#### URL

> PUT /api/v2/open/management/systems/{system_id}/applications/{callback_id}/cancel/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)

#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|--------|--------|--------|--------|
|bk_app_code|string|否|应用 ID|
|bk_app_secret|string|否|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|access_token|string|否|用户或应用 access_token|


#### Response

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {}
}
```
