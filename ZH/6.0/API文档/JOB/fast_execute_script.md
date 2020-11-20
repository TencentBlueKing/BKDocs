
### 请求地址

/api/c/compapi/v2/job/fast_execute_script/



### 请求方法

POST


### 功能描述

快速执行脚本

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段          |  类型      | 必选   |  描述      |
|---------------|------------|--------|------------|
| bk_biz_id      |  long       | 是     | 业务 ID |
| script_id      |  long       | 否     | 脚本 ID |
| task_name      |  string    | 否     | 自定义作业名称 |
| script_content |  string    | 否     | 脚本内容 Base64，如果同时传了 script_id 和 script_content，则 script_id 优先 |
| script_param   |  string    | 否     | 脚本参数 Base64。注意：如果有多个参数，比如&#34;param1 param2&#34;这种，需要对&#34;param1 param2&#34;整体进行 base64 编码，而不是对每个参数进行 base64 编码再拼接起来 |
| script_timeout |  long       | 否     | 脚本超时时间，秒。默认 1000，取值范围 60-86400 |
| account        |  string    | 是     | 执行帐号名/别名 |
| is_param_sensitive |  int   | 否     | 敏感参数将会在执行详情页面上隐藏, 0:不是（默认），1:是 |
| script_type    |  int       | 否     | 脚本类型：1(shell 脚本)、2(bat 脚本)、3(perl 脚本)、4(python 脚本)、5(Powershell 脚本) |
| custom_query_id  |  array    | 否     | *deprecated*，请使用 target_server.dynamic_group_id_list 替代。配置平台上的自定义分组 ID |
| ip_list          |  array    | 否     | *deprecated*，请使用 target_server.iplist 替代。静态 IP 列表 |
| target_server    |  dict     | 否     | 目标服务器 |
| bk_callback_url |  string   | 否     | 回调 URL，当任务执行完成后，JOB 会调用该 URL 告知任务执行结果。回调协议参考 callback_protocol 组件文档 |

#### target_server
| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| ip_list               | array | 否     | 静态 IP 列表 |
| dynamic_group_id_list | array | 否     | 动态分组 ID 列表 |
| topo_node_list        | array | 否     | 动态 topo 节点列表 |

#### ip_list

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_cloud_id |  long    | 是     | 云区域 ID |
| ip          |  string | 是     | IP 地址 |

#### topo_node_list
| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id               | long   | 是     | 动态 topo 节点 ID，对应 CMDB API 中的 bk_inst_id |
| node_type        | string | 是     | 动态 topo 节点类型，对应 CMDB API 中的 bk_obj_id,比如"module","set"|

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "script_id": 1,
    "script_content": "ZWNobyAkMQ==",
    "script_param": "aGVsbG8=",
    "script_timeout": 1000,
    "account": "root",
    "is_param_sensitive": 0,
    "script_type": 1,
    "target_server": {
        "dynamic_group_id_list": ["blo8gojho0skft7pr5q0", "blo8gojho0sabc7priuy"],
        "ip_list": [{
                "bk_cloud_id": 0,
                "ip": "10.0.0.1"
            }, {
                "bk_cloud_id": 0,
                "ip": "10.0.0.2"
            }
        ],
        "topo_node_list": [{
                "id": 1000,
                "node_type": "module"
            }
        ]
    }
}

```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "job_instance_name": "API Quick execution script1521100521303",
        "job_instance_id": 10000
    }
}
```