# search_instance 

## search_instance 根据过滤条件和搜索关键字查询实例
> 在权限中心里用于（1）`产品`上搜索资源实例（1）`产品`上支持拓扑树的资源搜索

### 需支持的过滤查询
- 按照资源实例进行 Keyword 搜索查询
    - 接入系统获取到 keyword 后，可支持对应资源实例的唯一标识 id、名称 name、展示名称 display_name 等字段进行模糊搜索过滤，`默认必须支持display_name搜索`，搜索结果为`包含关键词`。
- 按照资源的上级 + 资源实例 Keyword 搜索 查询

**重要**：
`搜索不要区分大小写！！！`
`搜索不要区分大小写！！！`
`搜索不要区分大小写！！！`

简单例子：

【按照资源实例进行 Keyword 搜索查询】

```json
"filter": {
    "keyword": "192.168."
}
```

【按照资源的上级 + 资源实例 Keyword 搜索 查询】
```json
"filter": {
    "parent": {
        "type": "module",
        "id": "m1"
    },
    "keyword": "192.168."
}
```

**`特别注意`**
由于 keyword 搜索可能性能很低，接入系统需要做`频率控制`和实现适当的`缓存机制`，否则可能会引发接入系统负载过高而导致正常业务服务的故障


### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：search_instance |
| filter | object | 否 | 根据 6.1 里需支持的过滤查询，传入不同的参数 |
| page | object | 是 | 返回数据需要支持分页，该参数必填，具体说明请查看 [需实现接口的基础协议里的 Request.Body.page 字段](./01-API.md), `limit 最大为1000` |

filter 字段

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| keyword | object | 是 | 资源实例的搜索关键字 |
| parent | object | 否 |  资源的直接上级，具体包含 type 和 id，type 为直接上级资源的类型，id 为直接上级资源实例 ID  `两种情况下可为空，(1) 本身资源类型无上级 (2) 权限中心产品上只需要根据Keyword全局搜索该资源类型，可能场景如某种资源类型的下拉框过滤选择` |


* Keyword 搜索查询

```json
{
    "type": "host",
    "method": "search_instance",
    "filter": {
        "keyword": "192.168."
    },
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```

* 上级+Keyword 搜索查询

```bash
{
    "type": "host",
    "method": "search_instance",
    "filter": {
       "parent": {
            "type": "module",
            "id": "m1"
        }
        "keyword": "192.168."
    },
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```


### Response.Body

code 字段说明
- `code = 422` 代表 Keyword 搜索时，扫描的资源内容过多，无法支持，拒绝返回数据，对于 IAM 产品上将提示用户完善搜索条件再搜索
- `code = 429` 代表接口超过接入系统的频率控制 

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

* 正常查询返回

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

* 搜到的 Keyword 不满足要求，即 keyword 的参数校验规则，比如，可能对于某些资源类型，keyword 至少 2 个字符才进行搜索
    - `对于message字段，必须清楚提示keyword的校验规则`

```json
{
    "code": 406,
    "message": "the length of keyword should be greater than or equals to 2",
    "data": {}
}
```

* 搜索结果分页返回，如果个别资源类型因为搜索结果过多而导致性能问题，无法返回时，
   - `对于这种情况，权限中心产品上将会提示用户完善Keyword，尽量精确`

```json
{
    "code": 422,
    "message": "not support, too much data found",
    "data": {}
}
```

* 接口超过调用频率控制

```json
{
    "code": 429,
    "message": "exceed api rate limiting",
    "data": {}
}
```