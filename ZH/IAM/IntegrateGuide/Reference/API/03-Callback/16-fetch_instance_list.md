# fetch_instance_list 

## fetch_instance_list 根据过滤条件搜索实例
> 在审计中心里用于（1）`产品`上搜索资源实例（2）对审计事件关联实例快照数据

**`特别注意`**
- 系统需要接入审计中心时, 才需要实现这个回调接口
- 由于此接口主要通过`变更时间`搜索查询，接入系统需要做`频率控制`，并对资源实例的`变更时间`建立适当的`索引机制`或`缓存机制`，否则可能会引发接入系统负载过高而导致正常业务服务的故障
- 如果未实现此接口，将无法使用`审计中心`关联实例快照数据功能

### 需支持的过滤查询
- 按照资源实例`变更时间`搜索查询

简单例子：

【按照资源实例`变更时间`搜索查询】

```json
{
  "filter": {
    "start_time": 1654012800000,
    "end_time": 1654099199000
  }
}
```


### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：fetch_instance_list |
| filter | object | 否 | 根据 7.1 里需支持的过滤查询，传入不同的参数 |
| page | object | 是 | 返回数据需要支持分页，该参数必填，具体说明请查看 [需实现接口的基础协议里的 Request.Body.page 字段](./01-API.md), `limit 最大为1000` |

filter 字段

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| start_time | long | 是 | 资源实例变更时间的开始时间（毫秒，包含start_time） |
| end_time | long | 是 |  资源实例变更时间的结束时间（毫秒，包含end_time） | 


* 搜索查询

```json
{
    "type": "host",
    "method": "fetch_instance_list",
    "filter": {
        "start_time": 1654012800000,
        "end_time": 1654099199000
    },
    "page": {
        "offset": 0,
        "limit": 20
    }
}
```

### Response.Body

code 字段说明
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
| creator | string | 是 | 创建人 |
| created_at | long | 是 | 创建时间(ms) |
| updater | string | 是 | 变更人 |
| updated_at | long | 是 | 变更时间(ms) |
| operator | string | 否 | 责任人，多个以半角逗号或半角分号分隔 |
| bk_bak_operator | string | 否 | 备份责任人，多个以半角逗号或半角分号分隔 |
| is_deleted | bool | 是 | 软删除的标记 |
| \_bk_iam_path_ | array | 否 | [资源拓扑](../../../Explanation/04-BkIAMPath.md) |
| data | object | 是 | 资源实例详情，键值对需要与[实例schema定义](./17-fetch_resource_type_schema.md)保持一致；如果实例使用范围授权，`data`应该包含`attribute`内容 |

* 正常查询返回

```json
{
    "code": 0,
    "message": "",
    "data": {
        "count": 100,
        "results": [
            {
                "id": "h1",
                "display_name": "192.168.1.1",
                "creator": "admin",
                "created_at": 1654012800000,
                "updater": "admin",
                "updated_at": 1654012800000,
                "operator": "admin",
                "bk_bak_operator": "admin",
                "is_deleted": false,
                "_bk_iam_path_": [
                    "/bk_cmdb,set,1/bk_cmdb,host,2/"
                ],
                "data": {
                    "k1": "v1",
                    "k2": "v2"
                }
            },
            {
                "id": "h2",
                "display_name": "192.168.1.2",
                "creator": "admin",
                "created_at": 1654012800000,
                "updater": "admin",
                "updated_at": 1654012800000,
                "operator": "admin",
                "bk_bak_operator": "admin",
                "is_deleted": false,
                "_bk_iam_path_": [
                    "/bk_cmdb,set,1/bk_cmdb,host,2/"
                ],
                "data": {
                    "k1": "v1",
                    "k2": "v2"
                }
            },
            {
                "id": "h3",
                "display_name": "192.168.1.3",
                "creator": "admin",
                "created_at": 1654012800000,
                "updater": "admin",
                "updated_at": 1654012800000,
                "operator": "admin",
                "bk_bak_operator": "admin",
                "is_deleted": true,
                "_bk_iam_path_": [
                    "/bk_cmdb,set,1/bk_cmdb,host,2/"
                ],
                "data": {
                    "k1": "v1",
                    "k2": "v2"
                }
            }
        ]
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
