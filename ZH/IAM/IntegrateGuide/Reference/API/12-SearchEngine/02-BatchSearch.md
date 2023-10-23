# 批量检索有权限的subject列表

注意, `IAM_SEARCH_ENGINE_HOST`是一个独立服务, 不是原先权限中心后台地址

#### URL

> GET http://{IAM_SEARCH_ENGINE_HOST}/api/v1/engine/batch-search

#### Parameters

请求json是一个列表, 列表内的结构说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject_type | string | 是 | user/group/all |
| action | object | 是 | 操作 |
| resource | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |
| limit | int | 是 | 最大返回subject数量 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |


#### Request


```json
[  // 单个请求对象与search接口相同, 批量使用数组传多个请求对象
    {
        "system": "bk_job",
        "subject_type": "all",  // all同时查询user与group
        "action": {
            "id": "execute"
        },
        "resource": [{   // 资源类型的顺序必须操作注册时的顺序一致, 否则会导致鉴权失败!
            "system": "bk_job",
            "type": "job",
            "id": "ping",
            "attribute": {  // 资源的属性值可能有多个, 目前支持string/int/boolean, 以及路径stringList
                "os": "linux",
                "_bk_iam_path_": ["/biz,1/set,2/"],
                "is_ready": true,
                "area_id": 200
            }
        }, {
            "system": "bk_cmdb",
            "type": "host",
            "id": "192.168.1.1",
            "attribute": {} // 外部资源的属性由iam负责查询属性, 接入方不需要传入
        }],
        "limit": 1000  // 最多返回的subject数量
    }
]
```

#### Response


```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "results": [  // 批量返回的数据, 每个请求对象一个数组, 顺序与请求对象的顺序一致
            [  // 返回subject的数组
                {
                    "type": "user",
                    "id": "admin",
                    "name": "admin"
                },
                    {
                    "type": "group",
                    "id": "1001",
                    "name": "测试用户组"
                }
            ]
        ]
    }
}
```
