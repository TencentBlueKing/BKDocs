# 生成无权限申请 URL

> 此文档向接入系统说明接入系统在用户无权限需要提醒用户申请时使用的 api

### 接入系统权限申请

用户在接入系统进行操作时, 如果没有某些权限, 此时需要跳转到权限中心申请对应权限.
权限中心申请页面, 需要自动填充相关的申请信息.
所以, 需要接入系统, 将相关信息预先提交到权限中心, 权限中心返回`权限申请URL`

流程:
1. 组装权限申请信息
2. 请求 API, 获取权限申请 url
3. url 渲染到前端表单, 用户点击后, 跳转到权限中心的权限申请页面

具体无权限交互可以查看 [文档](../../../HowTo/NoPermissionApply.md)

#### URL

> POST /api/c/compapi/v2/iam/application/
> `特别说明:该 API 为ESB API` [ESB API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|bk_app_code|string|是|应用 ID|
|bk_app_secret|string|是|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取|
|bk_token|string|否|当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取|
|bk_username|string|否|当前用户用户名，仅仅在 ESB 里配置免登录态验证白名单中的应用，才可以用此字段指定当前用户|

#### Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|system|字符串|是|系统 id|
|actions|数组|是|申请权限的操作|

actions

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|id|字符串|是|操作 id|
|related_resource_types|数组|是|操作关联的资源类型, `资源类型的顺序必须操作注册时的顺序一致` ([操作注册 API](../../../Reference/API/02-Model/13-Action.md))|

related_resource_types

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|system|字符串|是|资源类型的系统 id|
|type|字符串|是|资源类型|
|instances|数组[数组]|否|资源实例,可选|
|attributes|数组|否|实例属性,可选|

related_resource_types.instances

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|type|字符串|是|资源类型|
|id|字符串|是|资源实例 id|

related_resource_types.attributes

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|id|字符串|是|属性 key|
|name|字符串|是|属性 key 名称|
|values|数组|是|属性的可选值|

related_resource_types.attributes.values

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|id|字符串|是|属性 value|
|name|字符串|是|属性 value 名称|


```json
{
  "system": "bk_job",  # 权限的系统
  "actions": [
    {
      "id": "execute_job",  # 操作id
      "related_resource_types": [  # 关联的资源类型, 无关联资源类型的操作, 必须为空, 资源类型的顺序必须操作注册时的顺序一致
        {
          "system": "bk_job",  # 资源类型所属的系统id
          "type": "job",  # 资源类型
          "instances": [  # 申请权限的资源实例
            [  # 带层级的实例表示
              {
                "type": "job",  # 层级节点的资源类型
                "id": "job1",  # 层级节点的资源实例id
              }
            ]
          ]
        },
        {
          "system": "bk_cmdb",  # 资源类型所属的系统id
          "type": "host",  # 操作依赖的另外一个资源类型
          "instances": [
            [
              {
                "type": "biz",
                "id": "biz1",
              }, {
                "type": "set",
                "id": "set1",
              }, {
                "type": "module",
                "id": "module1",
              }, {
                "type": "host",
                "id": "host1",
              }
            ]
          ],
          "attributes": [  # 支持配置实例的属性值
            {
              "id": "os",  # 属性的key
              "name": "操作系统",
              "values": [
                {
                  "id": "linux",  # 属性的value, 可以有多个
                  "name": "linux"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

#### Response


```json
{
  "data": {
    "url": "https://{PAAS_DOMAIN}/o/bk_iam_app/perm-apply?system_id=bk_job&amp;tid=09d432dccac74ec4aa17629f5f83715f"  # 链接有效期10分钟
  },
  "result": true,
  "code": 0,
  "message": "OK"
}
```

data

| 字段      |  类型      |  描述      |
|:---|:---|:---|
|url|字符串|权限申请重定向 URL|


### 返回结果错误说明

由于跳转申请后，产品上需要显示的时资源实例名称，而不是 ID，所以权限中心会回调查询接入系统
1. 如果未提供查询相关接口,则错误码 code=1902204
2. 如果查询不到资源实例的名称或接入系统不存在对应的资源实例，则错误码 code=1902416
3. 会校验 `related_resource_types`操作关联的资源类型, `资源类型的顺序必须操作注册时的顺序一致` ([操作注册 API](../../../Reference/API/02-Model/13-Action.md)), 如果不一致, 错误码 `1902417`, 具体见文档 [错误码](../../../HowTo/FAQ/ErrorCode.md)