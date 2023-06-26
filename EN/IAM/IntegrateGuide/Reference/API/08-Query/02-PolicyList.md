# policy list 拉取系统下某个操作的策略列表


用于接入系统批量拉取某个 action 的所有策略; 全量带翻页; 
接入系统可以利用这个接口, 定期拉取策略进行全量校验及`补偿`


关于 timestamp 的说明:
- 由于策略是带过期时间的, 翻页查询的过程是一个时间跨度比较长的操作, 如果每一页实时查询`当前未过期`的策略列表, 那么整体结果集及固定页码里面的策略内容将会动态变化; 接入系统无法真正拉取某个操作`全量`策略
- 这个接口拉取第一页, 默认设置`timestamp`为当天`00:00:00`的时间戳, 例如`1593273600`
- 当翻第二页到最后一页的过程中, 接入系统建议将`timestamp`作为参数传入; 以定位一个`锚点`; 防止翻页过程中跨天导致的策略列表动态变化; (如果不担心这个, 可以一直不传)
- `timestamp` 最小为`当前时间-24小时`

注意:
- 查询回去的每条策略中`expired_at`为过期时间, 接入系统在使用前需要再次判定是否过期
- 只能查询自己系统的`action_id`, 如果是在本系统找不到这个`action_id`不存在, 将会返回`code=1901404(NotFoundError)` 

-----

#### URL

> GET  /api/v1/systems/{system_id}/policies

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:---|:--- |
| system_id | string | 是 | path | 系统 ID |
| action_id | string | 是 | query | 操作 ID(action id), 必须是这个系统注册到权限中心的合法 Action |
| page | integer |  否| query |页码, 不传默认为`1` |
| page_size | integer |  否| query |单页大小,不传默认`100`, 限制单页最大`500`|
| timestamp | integer |  否| query |查询时间戳, 锚点 |
| type | string | 否 |query | 授权类型，枚举值包括`abac\rbac` 不填默认为`abac` |

示例: `action_id=edit_host&page=1&page_size=100&timestamp=1592899208`

#### Response

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "metadata": {
            "system": "bk_cmdb",
            "action": {
                "id": "edit_host"
            },
            "timestamp": 1593273600
        },
        "count": 3,
        "results": [
            {
                "version": "1",
                "id": 3,
                "subject": {
                    "type": "user",
                    "id": "test2",
                    "name": "test2"
                },
                "expression": {
                    "content": [
                        {
                            "field": "host.id",
                            "op": "eq",
                            "value": "192.168.1.1"
                        }
                    ],
                    "op": "OR"
                },
                "expired_at": 4102444800
            },
            {
                "version": "1",
                "id": 4,
                "subject": {
                    "type": "user",
                    "id": "test1",
                    "name": "test1"
                },
                "expression": {
                    "content": [
                        {
                            "field": "host.system",
                            "op": "eq",
                            "value": "linux"
                        }
                    ],
                    "op": "OR"
                },
                "expired_at": 4102444800
            },
            {
                "version": "1",
                "id": 7,
                "subject": {
                    "type": "user",
                    "id": "admin",
                    "name": "管理员"
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
        ]
    }
}
```
