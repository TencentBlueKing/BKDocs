### 请求地址

/api/c/compapi/v2/job/execute_job/

### 请求方法

POST

### 功能描述

根据作业模板 ID 启动作业。支持全局变量，如果全局变量的类型为 IP，参数值必须包含 custom_query_id 或 ip_list。没有设置的参数将使用作业模版中的默认值。

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_biz_id | int | 是 | 业务 ID |
| bk_job_id | int | 是 | 作业模板 ID |
| steps | array | 否 | 指定要执行或自定义参数的步骤数组，要执行全部步骤可不传此参数，见下面 steps 结构定义 |
| global_vars | array | 否 | 全局变量信息，作业包含的全局变量和类型，可以通过接口“查询作业模板详情” (get_job_detail)获取。对于作业中的全局变量值，如果 global_vars 包含该变量信息，那么会使用 api 指定的值；否则使用全局变量默认值 |
| bk_callback_url | string | 否 | 回调 URL，当任务执行完成后，JOB 会调用该 URL 告知任务执行结果。回调协议参考 callback_protocol 组件文档 |

#### global_vars

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| id | int | 否 | 全局变量 id，唯一标识。如果 id 为空，那么使用 name 作为唯一标识 |
| name | string | 否 | 全局变量 name |
| value | string | 否 | 字符串全局变量值，此字段仅在字符串类型变量有效。 |
| custom_query_id | array | 否 | 配置平台上的自定义查询 id 列表。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并，此字段仅在 IP 类型变量有效。 |
| ip_list | array | 否 | IP 对象数组。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并，此字段仅在 IP 类型变量有效。 |

#### steps

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| step_id | int | 是 | 步骤 ID |
| script_id | int | 否 | 脚本 ID，如果不更改脚本，则不传 |
| script_type | int | 否 | 脚本类型：1(shell 脚本)、2(bat 脚本)、3(perl 脚本)、4(python 脚本)、5(powershell 脚本)，当 script_content 有内容时必填 |
| script_content | string | 否 | 脚本内容 Base64，如果同时传了 script_id 和 script_content，则 script_id 优先 |
| script_param | string | 否 | 脚本参数 Base64 |
| script_timeout | int | 否 | 脚本超时时间，秒。默认 1000，取值范围 60-86400 |
| account | string | 否 | 执行帐号名/别名 |
| db_account_id | int | 否 | SQL 执行的 db 帐号 ID，SQL 步骤必填 |
| file_target_path | string | 否 | 文件传输目标路径 |
| file_source | array | 否 | 源文件对象数组，见下面 file_source 定义 |
| custom_query_id | array | 否 | 配置平台上的自定义查询 id 列表。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |
| ip_list | array | 否 | IP 对象数组。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |

#### file_source

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| files | array | 是 | 源文件的绝对路径数组，支持多个文件 |
| account | string | 是 | 执行帐号名/别名 |
| custom_query_id | array | 否 | 配置平台上的自定义查询 id 列表。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |
| ip_list | array | 否 | IP 对象数组。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |

#### ip_list

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_cloud_id | int | 是 | 云区域 ID |
| ip | string | 是 | IP 地址 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "bk_job_id": 100,
    "global_vars": [
        {
            "id": 436,
            "custom_query_id": [
                "3",
                "5",
                "7"
            ],
            "ip_list": [
                {
                    "bk_cloud_id": 0,
                    "ip": "10.0.0.1"
                },
                {
                    "bk_cloud_id": 0,
                    "ip": "10.0.0.2"
                }
            ]
        },
        {
            "id": 437,
            "value": "new String value"
        }
    ],
    "steps": [{
        "script_timeout": 1000,
        "script_param": "aGVsbG8=",
        "ip_list": [
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.1"
            },
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.2"
            }
        ],
        "custom_query_id": [
            "3"
        ],
        "script_id": 1,
        "script_content": "ZWNobyAkMQ==",
        "step_id": 200,
        "account": "root",
        "script_type": 1
    },
    {
        "script_timeout": 1003,
        "ip_list": [
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.1"
            },
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.2"
            }
        ],
        "custom_query_id": [
            "3"
        ],
        "script_id": 1,
        "script_content": "ZWNobyAkMQ==",
        "step_id": 1,
        "db_account_id": 31
    },
    {
        "file_target_path": "/tmp/[FILESRCIP]/",
        "file_source": [
            {
                "files": [
                    "/tmp/REGEX:[a-z]*.txt"
                ],
                "account": "root",
                "ip_list": [
                    {
                        "bk_cloud_id": 0,
                        "ip": "10.0.0.1"
                    },
                    {
                        "bk_cloud_id": 0,
                        "ip": "10.0.0.2"
                    }
                ],
                "custom_query_id": [
                    "3"
                ]
            }
        ],
        "ip_list": [
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.1"
            },
            {
                "bk_cloud_id": 0,
                "ip": "10.0.0.2"
            }
        ],
        "custom_query_id": [
            "3"
        ],
        "step_id": 2,
        "account": "root"
    }]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "job_instance_name": "Test",
        "job_instance_id": 10000
    }
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| result | bool | 请求成功与否，true:请求成功，false:请求失败 |
| code | string | 组件返回错误编码，0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误消息 |
| data | object | 请求返回的数据 |

#### data
| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| job_instance_name | string | 作业实例名称 |
| job_instance_id | int | 作业实例 ID |
