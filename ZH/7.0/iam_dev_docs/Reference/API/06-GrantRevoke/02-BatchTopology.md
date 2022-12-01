# 批量资源拓扑授权/回收

对多个资源拓扑, 多个操作的授权与回收接口

`resources.paths`是批量的资源实例拓扑, 具体说明可以参考[资源拓扑授权/回收](../06-GrantRevoke/01-Topology.md)

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/batch_path/

APIGateway2.0 API

> POST /api/v1/open/authorization/batch_path/

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
| resources |  数组[对象]   | 是   | 资源拓扑, 资源类型的顺序必须操作注册时的顺序一致|
| expired_at |  int   | 否   | 过期时间戳(单位秒)，即用户或用户组在expired_at后将不具有该用户组的相关权限，其中值为4102444800表示永久 |

actions

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
| paths | 数组[[对象]] | 是 | 批量资源拓扑，`最多1000个` |

resources.paths

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type |  字符串  | 是   | 拓扑节点类型 ID |
| id | 字符串 | 是 | 拓扑节点实例 ID |
| name | 字符串 | 是 | 拓扑节点实例名称 |

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
      "paths": [  # 批量资源拓扑
        [
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
      ]
    }
  ]
}
```

如需授权实例为任意的权限, `resources.paths` 可以留空:

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
      "paths": [] # 留空表示任意实例权限, 即拥有所有实例的操作权限
    }
  ]
}
```

#### Response

| 字段      | 类型      | 描述      |
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


