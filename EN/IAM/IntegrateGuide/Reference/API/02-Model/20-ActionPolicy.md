# 操作策略 Action Policy API

### 1. 删除 action对应的所有权限策略
**重要说明：** 
- 删除成功后，将会删除 Action 相关权限，该删除操作不可逆，请谨慎调用
- 该接口只是发起删除的异步任务，并标记Action相关策略已删除，然后定期进行实际硬删除，接口调用成功后, 则认为其策略已被删除, 可以继续调用删除 Action 接口对Action进行删除

**版本依赖说明：**
- SaaS 版本 >= 1.4.15
- 后台 版本 >= 1.7.7

#### URL

> DELETE /api/v1/model/systems/{system_id}/actions/{action_id}/policies

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--|:--|:--|:--|:--|
|system_id |string |是 |path |系统 ID |
|action_id |string |是 |path |操作 ID |

#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```


