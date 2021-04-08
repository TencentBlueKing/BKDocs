# 系统 token 查询 API

### 查询系统 token

用于`权限中心` 调用 `接入系统` 拉取资源信息相关接口的鉴权

#### URL

> GET /api/v1/model/systems/{system_id}/token

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :---| :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Response

```bash
{
    "code": 0,
    "data": {
        "token": "dk9httsqmq4bbdu7aqq6cqp1az6i8org"
    },
    "message": "ok"
}
```