# list_attr_value

## list_attr_value 获取一个资源类型某个属性的值列表

> 可用于配置权限的属性 的值列表

> 在权限中心产品里用于（1）`产品`上按照属性配置权限（2）`产品`上回显权限

比如: 在配置平台中，主机(host)资源的操作系统属性(os)可用于配置权限，对应的操作系统属性的值列表：linux(Linux)、windows(Windows)、mac(Mac)

### 需支持的过滤查询
* keyword 搜索
    - 接入系统获取到 keyword 后，可选择 id 或 display_name 进行模糊搜索过滤，模糊搜索规则可以是前缀匹配或包含子串等其他匹配规则
* 批量 id 过滤


简单例子：
【keyword 搜索】

```json
"filter": {
    "attr": "os",
    "keyword": "Li" 
}
```

【批量 id 过滤】

```json
"filter": {
    "attr": "os",
    "ids": ["linux", "windows"]
}
```

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：list_attr_value |
| filter | object | 是 | 根据 2.1 里需支持的过滤查询，传入不同的参数 |
| page | object | 是 | 返回数据需要支持分页，该参数必填，具体说明请查看 [需实现接口的基础协议里的 Request.Body.page 字段](./01-API.md), `limit 最大为1000`|

filter 字段

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| attr | string | 是 | 需要查询的资源属性 id |
| keyword | string | 否 |  资源属性值的搜索关键字 |
| ids | Array(string/int/bool) | 否 | 资源属性值 ID 列表, [值的数据类型详细说明](./00-Concepts.md) |

* 无过滤条件

```json
{
    "type": "host",
    "method": "list_attr_value",
    "filter": {
        "attr": "os"
    },
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```

* 有过滤条件

```json
{
    "type": "host",
    "method": "list_attr_value",
    "filter": {
        "attr": "os",
        "keyword": "Li"
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
| count | int | 是 | 查询到的总数量 |
| results | array(object) | 是 | 对应的属性值列表 |

results 字段，类型 Array

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string/int/bool | 是 | 资源属性值的唯一标识, [值的数据类型详细说明](./00-Concepts.md) |
| display_name | string | 是 | 资源属性值的展示名称 |

```json
{
    "code": 0,
    "message": "",
    "data": {
        "count": 100,
        "results": [
            {"id": "linux", "display_name": "Linux"},
            {"id": "windows", "display_name": "Windows"},
            {"id": "mac", "display_name": "Mac"}
        ]
    }
}
```