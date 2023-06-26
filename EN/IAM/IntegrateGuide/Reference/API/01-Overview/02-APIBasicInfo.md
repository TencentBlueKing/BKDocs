## 接口协议前置说明

Request Header:

-  `X-Bk-App-Code`   蓝鲸应用 app_code
-  `X-Bk-App-Secret`  蓝鲸应用 app_secret
-  `X-Bk-IAM-Version` IAM Policy 协议版本号, 不传默认为 1. (只有鉴权/策略相关的接口涉及, 暂时不需要关注)

Response Header:
-  `X-Request-Id`  请求 request_id, 请记录, 用于错误排查

Response Body: 遵循蓝鲸官方 API 协议进行返回, `code != 0` 表示出错, `message`包含具体信息

```bash
{
    "code": 0,
    "message": "",
    "data": {
    }
}
```

**重要**: 调用权限中心 API 都会返回一个`request_id`, 请在日志中记录, 以便后续联调及正式环境中进行问题排查; 


------

## 接口协议中`resources`字段说明

Request 的 json body 中`resources`

> `resources`是一个列表
> `resources`代表`一个资源`

如果是独立系统, 那么`resources`只有一个 item

```json
    "resources": [
    {
        "system": "bk_paas",
        "type": "app",
        "id": "bk_framework"
    }]
```

如果是跨系统资源依赖, 那么`resources`有多个 item, 包含跨系统依赖资源, 例如 job 脚本是否有在 cmdb 某个主机上的执行权限

```json
    "resources": [
    {
        "system": "bk_job",
        "type": "script",
        "id": "run"
    },
    {
        "system": "bk_cmdb",
        "type": "host",
        "id": "192.168.1.1"
    }]
```

所以, 写批量接口批量确认一批资源权限
- `resources`表示一个资源, 类型是 `[resource,]`
- `resources_list`表示一批资源, 类型是 `[resources, resources]` 即, `[ [resource,],  [resource,], ]`