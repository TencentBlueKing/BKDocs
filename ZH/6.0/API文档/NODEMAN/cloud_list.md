### 功能描述

查询云区域列表

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

### 返回结果示例
```plain
{
	"result": true,
	"code": 0,
    "message": "success",
    "data": [
		{
            "is_visible": true,
            "exception": "",
            "permissions": {
                "edit": true,
                "delete": true,
                "view": true
            },
            "isp": "PrivateCloud",
            "bk_cloud_name": "TEST",
            "ap_id": 1,
            "ap_name": "测试云区域",
            "bk_cloud_id": 1,
            "isp_icon": "xcxvcxvcxv",
            "node_count": 0,
            "proxies": [
                {
                    "inner_ip": "127.0.0.1",
                    "outer_ip": "0.0.0.0"
                }
			],
            "isp_name": "测试ISP",
            "proxy_count": 0
        },
	]
}
```
