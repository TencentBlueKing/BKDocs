### 功能描述

查询云区域的 proxy 列表

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
| bk_cloud_id | int | 是 | 云区域 ID |

### 请求参数示例
```plain
{
		"bk_cloud_id": 3
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": [
        {
            "bk_biz_id": 5,
            "status": "TERMINATED",
            "account": "root",
            "status_display": "异常",
            "version": "",
            "pagent_count": 0,
            "re_certification": false,
            "bk_host_id": 1,
            "bk_cloud_id": 3,
            "outer_ip": "127.0.0.1",
            "ap_id": 1,
            "data_ip": "",
            "inner_ip": "127.0.0.1",
            "login_ip": "0.0.0.0",
            "is_manual": false,
            "ap_name": "默认接入点",
            "auth_type": "PASSWORD",
            "extra_data": {
                "bt_speed_limit": null,
                "peer_exchange_switch_for_agent": 1
            },
            "bk_biz_name": "测试用",
            "port": 22,
            "job_result": {
                "instance_id": "host|instance|host|127.0.0.1-3-0",
                "status": "FAILED",
                "job_id": 22,
                "current_step": "正在安装"
            }
        }
    ],
    "result": true,
    "request_id": "1c031f7eb50c46d1b775d428aed35c5a"
}
```
