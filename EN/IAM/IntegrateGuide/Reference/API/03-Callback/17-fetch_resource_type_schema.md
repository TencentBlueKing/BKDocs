# fetch_resource_type_schema

## fetch_resource_type_schema 获取资源类型 schema 定义
> 在审计中心里用于（1）`产品`上对某种资源类型的实例信息展示

**`特别注意`**
- 系统需要接入审计中心时, 才需要实现这个回调接口
- 如果未实现此接口，将影响`审计中心`关联实例快照数据功能
- 资源类型`schema`定义仅用于`审计中心`资源实例展示使用，不用于资源实例上报校验
- 如果实例本身的`schema`发生变化, 例如增删字段, 变更字段属性(required/类型)等, 这个接口需要同步更新

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：fetch_resource_type_schema |

* 搜索查询

```json
{
    "type": "host",
    "method": "fetch_resource_type_schema"
}
```

### Response.Body

code 字段说明
- `code = 429` 代表接口超过接入系统的频率控制 

data 字段，类型为 Dict

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type| string | 否 | 固定值, 资源类型 schema 最外层必须为`object`类型|
| properties | object | 是 | 资源类型 schema 定义 | 

properties 字段，类型 Dict。key 为资源实例的字段名, value 为字段描述，按 [json-schema](https://json-schema.org/) 协议定义，\
当前仅支持以下定义：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 字段类型 |
| description | string | 是 | 描述 |

* 正常查询返回

```json
{
    "code": 0,
    "message": "",
    "data": {
        "type":  "object",
        "properties": {
            "id": {
                "type": "string",
                "description": "user key1"
            },
            "k2": {
                "type": "number",
                "description": "user key2"
            },
            "tags": {
                "type": "array",
                "description": "Tags for the product",
            }
        }
    }
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