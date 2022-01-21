### 功能描述

移除主机

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
| bk_host_id | list | 是 | 主机 ID 列表 |
| is_proxy | bool | 是 | 是否为 proxy |

### 请示参数示例
```plain
{
		"is_proxy":false,
    "bk_host_id":[
        111
    ]
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": {},
    "result": true,
    "request_id": "5f3dea25022a444bb8a11f1db9cdc07d"
}
```
