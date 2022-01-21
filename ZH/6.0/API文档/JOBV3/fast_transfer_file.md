### 功能描述

快速分发文件

### 请求参数
| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |
#### 接口参数
| 字段             |  类型      | 必选   |  描述      |
|------------------|------------|--------|------------|
| bk_biz_id        |  long       | 是     | 业务 ID |
| account_alias    |  string    | 否    | 目标执行帐号别名，可从账号页面获取，推荐使用。与 account_id 必须存在一个。当同时存在 account_alias 和 account_id 时，account_id 优先。 |
| account_id | long | 否 | 目标执行帐号 ID，可从 get_account_list 接口获取。与 account_alias 必须存在一个。当同时存在 account_alias 和 account_id 时，account_id 优先。 |
| file_target_path |  string    | 是     | 文件传输目标路径 |
| file_source_list |  array     | 是     | 源文件对象数组，见下面 file_source 定义 |
| timeout          |  int    | 否     | 任务超时时间，秒，默认值为 7200。取值范围 1-86400。|
| download_speed_limit|  int    | 否     | 下载限速，单位 MB。如果未传入该参数，表示不限速|
| upload_speed_limit|  int    | 否     | 上传限速，单位 MB。如果未传入该参数，表示不限速|
| transfer_mode | int | 否 | 传输模式。1-严谨模式，2-强制模式。默认使用强制模式 |
| target_server    |  object     | 否     | 目标服务器，见 server 定义 |
| callback_url  |  string    | 否     | 回调 URL，当任务执行完成后，JOB 会调用该 URL 告知任务执行结果。回调协议参考 callback_protocol 组件文档 |

#### file_source
| 字段          |  类型      | 必选   |  描述      |
|---------------|------------|--------|------------|
| file_list     |  array     | 是     | 支持多个文件，若文件源类型为服务器文件，填写源文件的绝对路径数组；若文件源类型为第三方文件源，COS 文件源填写的路径为"bucket 名称/文件路径"，例如：testbucket/test.txt |
| account       |  object    | 是     | 文件源账号，见 account 定义，文件源类型为服务器文件源时必填，文件源类型为第三方文件源时无需填写 |
| server        |  object    | 否     | 源文件服务器，见 server 定义 |
| file_type     |  int       | 否     | 文件源类型，1：服务器文件，3：第三方文件源文件，不传默认为 1 |
| file_source_id |  int      | 否     | file_type 为 3 时，file_source_id 与 file_source_code 选择一个填写，若都填写，优先使用 file_source_id，第三方文件源 Id，可从 get_job_detail 接口返回结果中的步骤详情获取 |
| file_source_code|  string  | 否     | file_type 为 3 时，file_source_id 与 file_source_code 选择一个填写，若都填写，优先使用 file_source_id，第三方文件源标识，可从作业平台的文件分发页面->选择文件源文件弹框中获取 |

#### account

| 字段  | 类型   | 必选 | 描述                                                         |
| ----- | ------ | ---- | ------------------------------------------------------------ |
| id    | long   | 否   | 源执行帐号 ID，可从 get_account_list 接口获取。与 alias 必须存在一个。当同时存在 alias 和 id 时，id 优先。 |
| alias | string | 否   | 源执行帐号别名，可从账号页面获取，推荐使用。与 alias 必须存在一个。当同时存在 alias 和 id 时，id 优先。 |

#### server

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| ip_list               | array | 否     | 静态 IP 列表 |
| dynamic_group_list | array | 否     | 动态分组 ID 列表 |
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
```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "file_target_path": "/tmp/",
    "transfer_mode": 1,
    "file_source_list": [
        {
            "file_list": [
                "/tmp/REGEX:[a-z]*.txt"
            ],
            "account": {
                "id": 100
            },
            "server": {
                "dynamic_group_list": [
                    {
                        "id": "blo8gojho0skft7pr5q0"
                    },
                    {
                        "id": "blo8gojho0sabc7priuy"
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
                "topo_node_list": [
                    {
                        "id": 1000,
                        "node_type": "module"
                    }
                ]
            },
            "file_type": 1
        },
        {
            "file_list": [
                "testbucket/test.txt"
            ],
            "file_type": 3,
            "file_source_id": 1
        },
        {
            "file_list": [
                "testbucket/test2.txt"
            ],
            "file_type": 3,
            "file_source_code": "testInnerCOS"
        }
    ],
    "target_server": {
        "dynamic_group_list": [
            {
                "id": "blo8gojho0skft7pr5q0"
            },
            {
                "id": "blo8gojho0sabc7priuy"
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
        "topo_node_list": [
            {
                "id": 1000,
                "node_type": "module"
            }
        ]
    },
    "account_id": 101
}
```
### 返回结果示例
```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "job_instance_name": "API Quick Distribution File1521101427176",
        "job_instance_id": 10000,
        "step_instance_id": 10001
    }
}
```
