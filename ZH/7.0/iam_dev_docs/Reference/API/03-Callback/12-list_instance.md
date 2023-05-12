# list_instance

## list_instance 根据过滤条件查询实例
> 在权限中心里用于（1）`产品`上按照资源拓扑树选择资源实例

### 需支持的过滤查询
- 按照资源的上级过滤查询

简单例子：

【按照资源的上级过滤查询】

```json
"filter": {
    "parent": {
        "type": "module",
        "id": "m1"
    }
}
```

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：list_instance |
| filter | object | 否 | 根据 3.1 里需支持的过滤查询，传入不同的参数 |
| page | object | 是 | 返回数据需要支持分页，该参数必填，具体说明请查看 [需实现接口的基础协议里的 Request.Body.page 字段](./01-API.md), `limit 最大为1000` |

filter 字段

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| parent | object | 否 |  资源的直接上级，具体包含 type 和 id，type 为直接上级资源的类型，id 为直接上级资源实例 ID |

* 无条件查询

```json
{
    "type": "host",
    "method": "list_instance",
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```

* 上级过滤查询

```json
{
    "type": "host",
    "method": "list_instance",
    "filter": {
        "parent": {
            "type": "module",
            "id": "m1"
        }
    },
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```

### Response.Body

data 字段，类型为 Dict

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| count | int | 是 | 查询到的资源实例的总数量 |
| results | array(object) | 是 | 对应的资源实例列表 |

results 字段 ，类型 Array

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源实例的唯一标识 |
| display_name | string | 是 | 资源实例的展示名称 |
| child_type | string | 否 | 非必填，仅仅"用户管理"系统定制的字段，其他系统不需要返回，表示该资源实例的下一层资源类型，仅仅用于动态资源层级，且其下一层与本层类型一致的情况，空值表示已经无下一层级，该数据将用于在权限中心产品拉取同一资源动态层级拓扑 |


```json
{
    "code": 0,
    "message": "",
    "data": {
        "count": 100,
        "results": [
            {"id": "h1", "display_name": "192.168.1.1"},
            {"id": "h2", "display_name": "192.168.1.2"},
            {"id": "h3", "display_name": "192.168.1.3"}
        ]
    }
}
```
