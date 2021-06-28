# list_instance_by_policy 

## list_instance_by_policy 根据策略表达式查询资源实例

> 在权限中心里用于（1）`产品`上动态查询资源实例进行预览

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：list_instance_by_policy |
| filter | object | 是 | 查询条件 |
| page | object | 是 | 返回数据需要支持分页，该参数必填，具体说明请查看 [需实现接口的基础协议里的 Request.Body.page 字段](./01-API.md)|

filter 字段

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| expression | object | 是 |  资源的表达式，[协议请查看](../../Expression/01-Schema.md) |


```json
{
    "type": "host",
    "method": "list_instance_by_policy",
    "filter": {
        "expression": {
            "op": "OR",
            "content": [
            {
                "op": "in",
                "field": "host.id",
                "value": [1, 2, 3]
            },
            {
                "op": "eq",
                "field": "host.os",
                "value": "linux"
            },
            {
                "op": "eq",
                "field": "host.owner",
                "value": "admin"
            },
            {
                "op": "OR",
                "content": [
                {
                    "op": "starts_with",
                    "field": "host._bk_iam_path_",
                    "value": "/biz,1/"
                },
                {
                    "op": "starts_with",
                    "field": "host._bk_iam_path_",
                    "value": "/biz,2/"
                }]
            },
            {
                "op": "AND",
                "content": [
                {
                    "op": "eq",
                    "field": "host.biz",
                    "value": "bk"
                },
                {
                    "op": "eq",
                    "field": "host.status",
                    "value": "online"
                }]
            }]
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
| results | array(object) | 是 | 对应到的资源实例列表 |

results 字段 ，类型 Array

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源实例的唯一标识 |
| display_name | string | 是 | 资源实例的展示名称 |

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