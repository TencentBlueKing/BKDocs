# fetch_instance_info

## fetch_instance_info 批量获取资源实例详情

> 在权限中心里用于（1）`产品`上回显权限（2）`鉴权`上依赖资源的查询

### 需支持的查询
- 批量属性 attr 列表

简单例子：

【批量属性 attr 列表】

比如查询主机 h1 和主机 h2 的 路径(path)、名称(name)、操作系统(os)和所属国家(country)

```json
"filter": {
    "ids": ["h1", "h2"],  // 资源实例ID
    "attrs": ["_bk_iam_path_", "display_name", "os", "country"] // 属性列表
}
```

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 值为：fetch_instance_info |
| filter | object | 是 | 根据需支持的查询，传入不同的参数 |

filter 字段:

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| ids | array(string) | 是 | 需要查询的资源实例的唯一标识列表, `最多1000个` |
| attrs | array(string) | 否 |  需要查询的资源属性列表，比如["_bk_iam_path_", "os"]，空列表或无该参数则表示查询所有属性 |

**重要**: 权限中心为了校验用户提交的资源实例名称是否正确, 会调用`fetch_instance_info`查询实例的`display_name`属性, 该接口必须实现`display_name`属性的查询

* 无查询条件，表示查询资源的所有属性

```json
{
    "type": "host",
    "method": "fetch_instance_info",
    "filter": {
        "ids": ["h1", "h2"]
    }
}
```

* 有过滤条件

```json
{
    "type": "host",
    "method": "fetch_instance_info",
    "filter": {
        "ids": ["h1", "h2"],
        "attrs": ["_bk_iam_path_", "os", "country"]
    }
}
```

### Response.Body

data 字段，类型为 Array

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源实例的唯一标识 |
| `<attr>` | string/int/bool 或 array(string/int/bool) | 是 | 根据查询条件中的 attrs 返回，无 attrs 参数则返回所有属性 |

`特殊属性`:

- [说明: 资源拓扑`_bk_iam_path_`](../../../Explanation/04-BkIAMPath.md)
- [说明: 资源审批人`_bk_iam_approver_`](../../../Explanation/09-BkIAMApprover.md)

```json
{
    "code": 0,
    "message": "ok",
    "data": [
        {
            "id": "h1",
            "os": "Linux",
            "country": "China",
            "isp": 1,
            "is_public": true,
            "_bk_iam_path_": [
                "/biz,1/set,1/module,1/",
                "/biz,1/set,1/module,2/"
            ]
        },
        {
            "id": "h2",
            "os": "Windows",
            "country": "China",
            "isp": 3,
            "is_public": false,
            "_bk_iam_path_": [
                "/biz,1/set,1/module,1/",
                "/biz_set,1/set,2/module,2/"
            ]
        }
    ]
}
```
