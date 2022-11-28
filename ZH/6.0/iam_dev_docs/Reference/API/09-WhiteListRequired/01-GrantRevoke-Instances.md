# 资源实例授权/回收

### 资源实例授权/回收

对单个资源实例, 单个操作的授权与回收接口

`注意`: 

- 对资源实例的授权只会产生`id in ["host1"]`的策略表达式, 如果需要对资源实例的拓扑授权, 请使用 [资源拓扑授权/回收](../06-GrantRevoke/01-Topology.md)
- 在权限中心如果没有注册相应的资源选择视图(比如只有`host`实例选择的视图), 可能会导致授权的资源在权限中心会出现在视图中选择不中(打不上勾)的情况

**`特别注意`** : 
- 涉及到资源实例授权，权限中心有限制规则：`1个人拥有1个操作 + 1个资源类型`的实例权限最大数量：`10000`个 。(`触发后, 授权接口报错/用户无法继续增加实例权限`)
- [大规模实例级权限限制具体说明和对应处理方案](../../../Explanation/06-LargeScaleInstances.md)

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/instance/

APIGateway2.0 API

> POST /api/v1/open/authorization/instance/

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
| action |  字符串   | 是   | 操作 |
| subject |  字符串   | 是   | 授权对象 |
| resources |  数组[对象]   | 是   | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |

action

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
| id | 字符串 | 是 | 资源实例 ID |
| name | 字符串 | 是 | 资源实例名称 |


```json
{
  "asynchronous": false,  # 默认false, 当前只支持同步
  "operate": "grant",   # grant 授权 revoke 回收
  "system": "bk_cmdb",
  "action": {
    "id": "edit_host"
  },
  "subject": {  # 当前只能对user授权
    "type": "user",
    "id": "admin"
  },
  "resources": [{  # 操作依赖多个资源类型的情况下, 表示一个组合资源, 资源类型的顺序必须操作注册时的顺序一致
    "system": "bk_cmdb",
    "type": "host",
    "id": "host1",
    "name": "host1"
  }]
}
```


#### Response

| 字段 | 类型 | 描述 |
|:---|:---|:---|
| policy_id   | 数值     | 权限策略 id |
| expression   | 对象     | 权限表达式 |


> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "policy_id": 1,
    "expression": {
      "field": "host.id",
      "op": "in",
      "value": ["host1", "host2"]
    }
  }
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
