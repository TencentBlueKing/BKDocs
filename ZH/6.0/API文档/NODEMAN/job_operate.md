### 功能描述

操作类任务

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| job_type | string | 是 | 任务类型 |
| bk_biz_id | int | 是 | 业务 ID 列表 |
| bk_host_id | list | 是 | 主机 ID 列表 |


#### job_type
| 值     |描述            |
|----------|----------------|
| RESTART_PROXY | 重启 proxy |
| RESTART_AGENT | 重启 agent |
| UPGRADE_PROXY | 升级 proxy |
| UPGRADE_AGENT | 升级 agent |

### 请求参数示例
```plain
{
    "job_type":"RESTART_AGENT",
    "bk_host_id":[
        35
    ],
    "bk_biz_id":[
        5
    ]
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": {
        "job_id": 309
    },
    "result": true,
    "request_id": "03c35997c40948e9954ab93ed8f50355"
}
```
