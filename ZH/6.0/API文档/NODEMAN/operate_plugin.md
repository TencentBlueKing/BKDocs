 ### 功能描述

插件操作类任务

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
| plugin_params | dict | 否 | 插件更新必填 |
| bk_host_id | list | 是 | 主机 ID 列表 |


#### plugin_params
| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| name | string | 是 | 插件名称 |
| version | string | 否 | 插件版本 |
| keep_config | int | 是 | 保留原有配置文件 |
| no_restart | int | 是 | 仅更新文件，不重启进程 |

#### job_type

| 值     |描述                  |
|----------|------------|
| MAIN_START_PLUGIN | 启动插件 |
| MAIN_STOP_PLUGIN | 停止插件 |
| MAIN_RESTART_PLUGIN | 重启插件 |
| MAIN_RELOAD_PLUGIN | 重载插件 |
| MAIN_DELEGATE_PLUGIN | 托管插件 |
| MAIN_UNDELEGATE_PLUGIN | 取消托管插件 |
| MAIN_INSTALL_PLUGIN | 更新插件 |

### 请求参数示例
```plain
{
    "job_type":"MAIN_START_PLUGIN",
    "plugin_params":{
        "name":"basereport"
    },
    "plugin_params":{
        "name":"basereport",
        "version":"10.8.40",
        "keep_config":0,
        "no_restart":0
    },
    "bk_host_id":[
        35
    ]
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": {
        "job_id": 306
    },
    "result": true,
    "request_id": "0e0543eadaa949cda0eb8f6213963476"
}
```
