# 批量资源实例授权/回收

### 批量资源实例授权/回收

对多个资源实例, 多个操作的授权与回收接口

**`特别注意`** : 
- 涉及到资源实例授权，权限中心有限制规则：`1个人拥有1个操作 + 1个资源类型`的实例权限最大数量：`10000`个 。(`触发后, 授权接口报错/用户无法继续增加实例权限`)
- [大规模实例级权限限制具体说明和对应处理方案](../../../Explanation/06-LargeScaleInstances.md)

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/batch_instance/

APIGateway2.0 API

> POST /api/v1/open/authorization/batch_instance/

> `特别说明`: [ESB API 与 APIGateway2.0 API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)

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
| asynchronous |  布尔  | 是   | 是否异步调用, 默认 否, 当前只支持同步 |
| operate |  字符串   | 是   | grant 或 revoke |
| system |  字符串  | 是   | 系统 id |
| actions |  数组[对象]   | 是   | 操作 |
| subject |  字符串   | 是   | 授权对象 |
| resources |  数组[对象]   | 是   | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |

actions

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resources

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| instances | 数组[对象] | 是 | 批量实例信息，`最多20个`  |

resources.instances

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | 字符串 | 是 | 资源实例 ID |
| name | 字符串 | 是 | 资源实例名称 |

```json
{
  "asynchronous": false,
  "operate": "grant",
  "system": "bk_cmdb",
  "actions": [  # 批量的操作
    {
      "id": "edit_host"
    }
  ],
  "subject": {
    "type": "user",
    "id": "admin"
  },
  "resources": [
    {  # 操作关联的资源类型, 必须与所有的actions都匹配, 资源类型的顺序必须操作注册时的顺序一致
      "system": "bk_cmdb",
      "type": "host",
      "instances": [  # 批量资源实例
        {
          "id": "1",
          "name": "host1"
        }
    }
  ]
}
```

#### Response

| 字段 | 类型 | 描述 |
|:---|:---|:---|
| policy_id   | 数值     | 权限策略 id |
| action   | 对象     | 操作 |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": [
    {
      "action": {
        "id": "edit_host"
      },
      "policy_id": 1
    }
  ]
}
```

#### Response when async (未实现)

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "task_id": 1  // 任务id
  }
}
```
