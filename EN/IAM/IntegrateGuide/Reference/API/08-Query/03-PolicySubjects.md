# policy subjects 根据策略 ID 拉群策略对应的用户信息


基于 LBAC 方案, 最终每个资源会打上一批 label, 这批 label 对应一批 Policy IDs
查询这个资源的有某个权限的用户列表时, 可以将这批 Policy IDs 作为这个接口参数, 查询`用户列表`

注意: 
- 只能查询自己系统的策略列表对应的`用户列表`
- 如果 policyID 是其他系统的, 将会被`过滤掉`, 接口正常, 但对应的 policyId 不会出现在结果列表中

#### URL

> GET /api/v1/systems/{system_id}/policies/-/subjects

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--|:--|:--|:--|:--|
| system_id | string | 是 | path | 系统 ID |
| ids |string |是 |query |策略 id, 多个以英文逗号分隔 |
| type | string | 否 |query | 授权类型，枚举值包括`abac\rbac` 不填默认为`abac` |

示例: `ids=2,3,4,7,9`

#### Response

```json
{
    "code": 0,
    "message": "ok",
    "data": [
        {
            "id": 2,
            "subject": {
                "type": "user",
                "id": "admin",
                "name": "管理员"
            }
        },
        {
            "id": 3,
            "subject": {
                "type": "user",
                "id": "test2",
                "name": "test2"
            }
        },
        {
            "id": 4,
            "subject": {
                "type": "user",
                "id": "test1",
                "name": "test1"
            }
        },
        {
            "id": 7,
            "subject": {
                "type": "user",
                "id": "admin",
                "name": "管理员"
            }
        }
    ]
}
```
