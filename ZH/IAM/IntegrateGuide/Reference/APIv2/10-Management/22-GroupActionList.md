# 接入系统管理类 API v2
### 创建用户组申请单据

-------

#### URL

> GET /api/v2/open/management/systems/demo/groups/1/policies/-/actions/
> > `特别说明:该 API 为APIGateway API` [APIGateway API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)


#### Parameters

* 通用参数

| 字段 | 类型 | 位置 | 必须 | 描述 |
|---|---|---|---|---|
| system_id | string | path | 是 | 接入系统唯一标识 |
| group_id | int | path | 是 | 用户组ID |

actions

| 字段 | 类型 | 位置| 必选 | 描述 |
|---|---|---|---|---|
| id | string | body | 是 | 操作 ID |

#### Request
```json
GET /api/v2/open/management/systems/demo/groups/1/policies/-/actions/
```

#### Response

data字段
| 字段 | 类型 | 描述 |
|---|---|---|
| data | array[object] | 操作列表 |

data列表元素
| 字段 | 类型 | 位置| 必选 | 描述 |
|---|---|---|---|---|
| id | string | body | 是 | 操作 ID |

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": [
    {
        "id": "edit_host"
    }
  ]
}
```
