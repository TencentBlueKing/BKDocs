# list_attr

## list_attr 查询某个资源类型可用于配置权限的属性列表

> 在权限中心里用于（1）`产品`上按照属性配置权限（2）`产品`上回显权限

比如: 在配置平台中，主机的可用于配置权限的属性列表：os(操作系统)/country(国家)/province(省份)/isp(运营商) 等

### Request.Body

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型(ResourceType) |
| method |string | 是 | 值为：list_attr |

```json
{
    "type": "host",
    "method": "list_attr"
}
```



### Response.Body

data 字段，类型为 Array

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源属性的唯一标识 |
| display_name | string | 是 | 资源属性的展示名称 |

```json
{
    "code": 0,
    "message": "",
    "data": [
        {"id": "os", "display_name": "操作系统"},
        {"id": "country", "display_name": "国家"},
        {"id": "province", "display_name": "省份"},
        {"id": "isp", "display_name": "运营商"}
    ]
}
```