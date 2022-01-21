### 功能描述

安装类任务

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
| hosts | list | 是 | 主机信息 |
| retention | Number | 是 | 密码保留天数 |
| replace_host_id | Number | 否 | 要替换的 ProxyID，替换 proxy 时使用 |

#### job_type

| 字段     |描述            |
|----------|----------------|
| INSTALL_AGENT | 安装 agent |
| REINSTALL_AGENT |重装 agent |
| INSTALL_PROXY | 安装 proxy |
| REINSTALL_PROXY | 重装 proxy |

#### hosts

| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| bk_cloud_id | Number | 否 | 云区域 ID |
| ap_id | Number | 是 | 接入点 ID |
| bk_host_id | Number | 是 | 主机 ID, 创建时可选, 更改时必选 |
| os_type | String | 否 | 操作系统类型 Windows,Linux,AIX |
| bk_biz_id | Number | 否 | 业务 ID |
| inner_ip | String | 否 | 内网 IP |
| outer_ip | String | 是 | 外网 IP |
| login_ip | String | 是 | 登录 IP |
| data_ip | String | 是 | 数据 IP |
| account | String | 否 | 账户名 |
| port | Number | 否 | 端口 |
| auth_type | String | 否 | 认证类型 |
| password | String | 是 | 密码 |
| key | String | 是 | 密钥 |

### 请求参数示例
```plain
{
    "job_type": "INSTALL_AGENT",
    "hosts": [
        {
            "bk_cloud_id": 1,
            "ap_id": 1,
            "bk_biz_id": 2,
            "os_type": "Linux",
            "inner_ip": "127.0.0.1",
            "outer_ip": "127.0.0.2",
            "login_ip": "127.0.0.3",
            "data_ip": "127.0.0.4",
            "account": "root",
            "port": 22,
            "auth_type": "PASSWORD",
            "password": "password",
            "key": "key"
        }
    ],
    "retention": 1,
    "replace_host_id": 1
}
```

### 返回结果示例
```plain
{
	"result": true,
	"code": 0,
    "message": "success",
    "data": {
		"job_id": 35,
		"ip_filter": []
	}
}
```