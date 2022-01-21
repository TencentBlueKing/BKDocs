### 请求地址

/api/c/compapi/v2/nodeman/create_task/


### 请求方法

POST


### 功能描述

创建任务

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id   | int    | 是     | 业务 id |
| creator   | string    | 是     | 任务创建人 |
| hosts     | array    | 是     | 主机相关信息 |
| bk_cloud_id | int    | 是     | 云区域 ID |
| node_type   | string  | 是    | 主机的节点类型，可以是 AGENT, PROXY 或 PAGENT |
| op_type  | string | 是     | 操作类型，可以是 INSTALL, REINSTALL, UNINSTALL, REMOVE 或 UPGRADE |

#### hosts

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| conn_ips     |  string     | 是     | 主机通信 IP，当为多个时用逗号隔开 |
| login_ip     |  string     | 否     | 主机登录 IP，适配复杂网络时填写 |
| data_ip     |  string     | 否     | 主机数据 IP，适配复杂网络时填写 |
| cascade_ip      |  string     | 否     | 级联 IP, 安装 PROXY 时必填 |
| os_type |  string  | 否     | 操作系统类型，可以是 LINUX, WINDOWS,或 AIX |
| has_cygwin   |  bool  | 否     | 是否安装了 cygwin, windows 操作系统时选填 |
| port |  int     | 否     | 端口号 |
| account        |  string  | 否     | 登录帐号 |
| auth_type    |  string     | 否     | 认证方式，可以是 PASSWORD 或 KEY |
| password | string | 否     | 登录密码，auth_type 为 PASSWORD 时需要填写,RSA 方式加密 |
| key    |  string   | 否     | 登录密钥， auth_type 为 KEY 时需要填写，RSA 方式加密 |



### 请求参数示例

```json
{
"bk_biz_id":2,
"creator":"admin",
"hosts":[{"conn_ips":"xxx.xxx.xxx.xxx", 
          "os_type":"LINUX",
          "has_cygwin":false,
          "port":22,
          "account":"root",
          "auth_type":"PASSWORD",
          "password":"JPRidyg3iXUFN6BiRj8ncgzOgL2nuIl2DcTjTG2oTrClZar/MqZc=",
          "key":""}],
"bk_cloud_id":"xxx",
"node_type":"PAGENT",
"op_type":"INSTALL", 
}
```

### 返回结果示例

```json
{
    "message": "success",
    "code": "OK",
    "data": {
        "id": 187,
        "creator": "admin",
        "bk_biz_id": "2",
        "bk_supplier_account": "",
        "bk_supplier_id": "0",
        "bk_cloud_id": "218",
        "job_type": "INSTALL_PAGENT",
        "hosts": [
            {
                "job_id": "187",
                "status": "QUEUE",
                "err_code": "INIT",
                "step": "任务初始化(安装)",
                "err_code_desc": "初始化",
                "host": {
                    "id": 43,
                    "bk_biz_id": "2",
                    "bk_cloud_id": "218",
                    "conn_ips": "xxx.xxx.xxx.xxx",
                    "node_type": "PAGENT",
                    "os_type": "LINUX",
                    "has_cygwin": false
                }
            }
        ],
        "global_params": null,
        "start_time": "2018-12-05 21:20:20",
        "end_time": null,
        "status_count": {
            "running_count": 1,
            "failed_count": 0,
            "success_count": 0
        },
        "os_count": {
            "WINDOWS": 0,
            "AIX": 0,
            "LINUX": 1
        },
        "host_count": 1,
        "job_type_desc": "安装PAGENT",
        "op_target": {
            "config_file": "",
            "name": ""
        }
    },
    "result": true
}
```