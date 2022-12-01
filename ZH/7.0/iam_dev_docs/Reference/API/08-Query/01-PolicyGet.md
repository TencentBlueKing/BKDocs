# policy get 获取某条策略详情

根据策略 ID, 获取策略详情

注意:
- 如果`policy_id`对应记录不存在(错误的 ID 或者已经被删除), 将会返回`code=1901404(NotFoundError)` 
- 只能查询自己系统的策略详情, 如果是其他系统的 policy ID, 将会返回`code=1901403(ForbiddenError)` 
- 返回结果中`expired_at`为过期时间, 需二次判定是否过期(查回来一刻可能还没过期, 但是传递使用时可能已过期)

#### URL

> GET /api/v1/systems/{system_id}/policies/{policy_id}

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |
| policy_id | integer | 是 | path | 策略 ID |
| type | string | 否 |query | 授权类型，枚举值包括`abac\rbac` 不填默认为`abac` |

#### Response

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "version": "1",
        "id": 2,
        "system": "bk_cmdb",
        "subject": {
            "type": "user",
            "id": "admin",
            "name": "管理员"
        },
        "action": {
            "id": "view_host"
        },
        "expression": {
            "content": [
                {
                    "field": "host.id",
                    "op": "any",
                    "value": []
                }
            ],
            "op": "OR"
        },
        "expired_at": 4102444800
    }
}
```
