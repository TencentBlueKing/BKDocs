# 资源拓扑授权/回收
### 参数说明

`resources.path`的说明

示例 1: 拓扑层级授权到资源实例, *业务 1-集群 2-主机 1*

```json
{
  "system": "bk_cmdb",
  "type": "host",
  "path": [
    {
      "type": "biz",
      "id": "1",
      "name": "biz1"
    },
    {
      "type": "set",
      "id": "2",
      "name": "set2"
    },
    {
      "type": "host",
      "id": "1",
      "name": "host1"
    }
  ]
}
```

示例 2: 拓扑层级前缀, *业务 1-任意集群*, 此时只有业务 1 的集群下的主机会有权限

`注意`: 

- 业务 1 下的主机与业务 1 下任意集群的主机的定义是不一样的
  1. `业务1下的主机`包含业务 1 下可能的`所有拓扑`下的所有主机
  2. `业务1下集群的所有主机`, 只包含特定拓扑 `业务-集群` 下的所有主机
- 为避免权限放大, 在拓扑层级授权时需要把选择到的拓扑节点的下一级的任意带上, 比如选择的是 `业务1`, 授权时传 `业务1-任意集群`

```json
{
  "system": "bk_cmdb",
  "type": "host",
  "path": [
    {
      "type": "biz",
      "id": "1",
      "name": "biz1"
    },
    {
      "type": "set",
      "id": "*",
      "name": ""
    }
  ]
}
```

`subject.type`的说明

当`subject.type` == "group"时对用户组授权, 授权的操作以及资源topology需要满足用户组所在的分级管理员的可授权操作实例范围

### 资源拓扑授权/回收

对单个资源拓扑, 单个操作的授权与回收接口

`注意`: 

- `resources.type`的是操作关联的资源类型, `resources.path`是资源类型能选择的拓扑层级
- `resources.path`的路径必须与接入系统注册的资源实例选择视图的拓扑层级一致, 否则授权的拓扑层级在权限中心会出现在视图中选择不中(打不上勾)的情况

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/path/

APIGateway2.0 API

> POST /api/v1/open/authorization/path/

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
| resources |  数组[对象]   | 是   | 资源拓扑, 资源类型的顺序必须操作注册时的顺序一致 |
| expired_at |  int   | 否   | 过期时间戳(单位秒)，即用户或用户组在expired_at后将不具有该用户组的相关权限，其中值为4102444800表示永久 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, user或group |
| id    |  字符串  | 是   | 授权对象 ID |

resources

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| path | 数组[对象] | 是 | 资源的拓扑 |

resources.path

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type |  字符串  | 是   | 拓扑节点类型 ID |
| id | 字符串 | 是 | 拓扑节点实例 ID |
| name | 字符串 | 是 | 拓扑节点实例名称 |


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
  "resources": [  # 操作依赖多个资源类型的情况下, 表示一个组合资源, 资源类型的顺序必须操作注册时的顺序一致
    {
      "system": "bk_cmdb",
      "type": "host",
      "path": [
        {
          "type": "biz",
          "id": "1",
          "name": "biz1"
        },{
          "type": "set",
          "id": "*",
          "name": ""
        }
      ]
    }
  ],
  "expired_at": 1671227398 # 可以不填, 默认1年, 单位时间戳秒
}
```


#### Response

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| policy_id   | 数值     | 权限策略 id |


> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "policy_id": 1
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
