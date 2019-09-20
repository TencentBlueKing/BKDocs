
### 请求地址

/api/c/compapi/v2/job/get_job_detail/



### 请求方法

GET


### 功能描述

根据作业模板ID查询作业模板详情

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id |  int       | 是     | 业务ID |
| bk_job_id |  int       | 是     | 作业模板ID |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "bk_job_id": 100
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "bk_biz_id": 1,
        "bk_job_id": 100,
        "name": "test",
        "creator": "admin",
        "create_time": "2018-03-15 12:46:24 +0800",
        "last_modify_user": "admin",
        "last_modify_time": "2018-03-16 09:58:47 +0800",
        "tag_id": "1",
        "step_num": 3,
        "global_vars": [
            {
                "type": 1,
                "id": 11,
                "category": 1,
                "name": "varName",
                "value": "value is Me",
                "description": "hello"
            },
            {
                "type": 2,
                "id": 12,
                "category": 3,
                "name": "id-201831512468155",
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
                    "3",
                    "5",
                    "7"
                ],
                "step_ids": [
                    1059,
                    1060
                ],
                "description": ""
            }
        ],
        "steps": [
            {
                "type": 1,
                "name": "xxx",
                "step_id": 1059,
                "script_type": 1,
                "script_id": 1078,
                "script_timeout": 1000,
                "script_content": "echo $1 $2 $3",
                "script_param": "a1 a2 a3",
                "is_param_sensitive": 0,
                "creator": "admin",
                "account": "root",
                "db_account_id": 0,
                "block_order": 1,
                "block_name": "step1",
                "create_time": "2018-03-15 12:46:24 +0800",
                "last_modify_time": "2018-03-16 09:58:47 +0800",
                "last_modify_user": "admin",
                "pause": 0,
                "order": 1,
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
                    "3",
                    "5",
                    "7"
                ]
            },
            {
                "type": 2,
                "step_id": 1060,
                "name": "xxx",
                "pause": 0,
                "creator": "admin",
                "account": "root",
                "db_account_id": 0,
                "block_order": 2,
                "block_name": "step2",
                "create_time": "2018-03-15 12:46:24 +0800",
                "last_modify_time": "2018-03-16 14:19:02 +0800",
                "last_modify_user": "admin",
                "order": 2,
                "file_target_path": "/tmp/[FILESRCIP]/",
                "file_source": [
                    {
                        "files": [
                            "/tmp/REGEX:[a-z]*.txt",
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
                            "3",
                            "5",
                            "7"
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
                    "3",
                    "5",
                    "7"
                ]
            },
            {
                "type": 4,
                "name": "SQL Runner",
                "step_id": 1061,
                "script_id": 1079,
                "script_content": "select 1;",
                "script_type": 6,
                "script_timeout": 1000,
                "account": "mysql",
                "db_account_id": 1010,
                "block_order": 3,
                "block_name": "SQL Execute Step",
                "creator": "admin",
                "create_time": "2018-03-15 12:47:26 +0800",
                "last_modify_time": "2018-03-16 14:19:02 +0800",
                "last_modify_user": "admin",
                "pause": 0,
                "order": 3,
                "ip_list": [
                    {
                        "ip": "10.0.0.1",
                        "bk_cloud_id": 0
                    }
                ]
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_biz_id       | int       | 业务ID |
| bk_job_id       | int       | 作业模板ID |
| name            | string    | 作业名称 |
| creator         | string    | 作业创建人帐号 |
| create_time     | string    | 创建时间，YYYY-MM-DD HH:mm:ss格式 |
| last_modify_user| string    | 作业修改人帐号 |
| last_modify_time| string    | 最后修改时间，YYYY-MM-DD HH:mm:ss格式 |
| tag_id          | string    | 作业标签ID，1.未分类、2.运营发布、3.故障处理、4.常用工具、5.产品自助、6.测试专用、7.持续集成 |
| step_num        | int       | 步骤数量 |
| steps           | array     | 步骤对象 |
| global_vars     | dict      | 全局变量信息 |

#### steps

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| step_id         | int       | 作业步骤ID |
| name            | string    | 作业步骤名称 |
| type            | int       | 步骤类型：1.脚本步骤; 2.文件步骤; 4.SQL步骤 |
| block_order     | int       | 步骤块在作业中的顺序 |
| block_name      | string    | 步骤块名称 |
| creator         | string    | 作业步骤创建人帐号 |
| create_time     | string    | 创建时间，YYYY-MM-DD HH:mm:ss格式 |
| last_modify_user| string    | 作业步骤修改人帐号 |
| last_modify_time| string    | 最后修改时间，YYYY-MM-DD HH:mm:ss |
| pause           | int       | 0.执行完成后不暂停(默认); 1.执行完成后暂停 |
| script_id       | int       | 脚本ID。当type=1或4时才有这个字段。 |
| script_param    | string    | 脚本参数。当type=1或4时并且有值时才有这个字段。 |
| script_content  | string    | 脚本内容。当type=1或4时才有这个字段。 |
| script_timeout  | int       | 脚本超时时间，秒。默认1000，取值范围60-86400 |
| account         | string    | 执行帐号名/别名 |
| is_param_sensitive| int     | 敏感参数将会在执行详情页面上隐藏, 0.不是（默认），1.是。当type=1时才有这个字段。 |
| db_account_id   | int       | SQL执行的db帐号ID，SQL步骤必填 |
| order           | int       | 当前步骤在作业中的顺序号 |
| script_type     | int       | 当type=1或4时并且有值时才有这个字段。脚本类型：1(shell脚本)、2(bat脚本)、3(perl脚本)、4(python脚本)、5(Powershell脚本) |
| file_target_path| string    | 文件传输目标路径，当type=2时并且有值时才有这个字段 |
| file_source     | array     | 源文件对象数组，当type=2时并且有值时才有这个字段，见下面file_source定义 |
| ip_list         | array     | IP对象数组，见下面ip_list结构定义 |
| custom_query_id | array     | 配置平台上的自定义查询id列表，有值时才有这个字段 |

#### global_vars

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id            | int       | 全局变量ID，唯一标识 |
| type          | int       | 全局变量数据类型：1:字符，2:IP，3:索引数组，4:关联数组 |
| category      | int       | 全局变量类型：1:云参，2:上下文参数，3:IP |
| name          | string    | 全局变量的名称 |
| value         | string    | 字符串类型的全局变量值，当type=1时有这个字段 |
| description   | string    | 变量描述 |
| custom_query_id| array    | 配置平台上的自定义查询ID列表，当type=2时并且有值时才有这个字段 |
| ip_list       | array     | IP对象数组，当type=2时并且有值时才有这个字段，见下面ip_list结构定义 |
| step_ids      | array     | 引用了这个IP全局变量的步骤ID列表，当type=2时并且有值时才有这个字段 |

#### file_source

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| files           | array        | 源文件的绝对路径数组，支持多个文件 |
| account         | string       | 执行帐号名/别名 |
| ip_list         | array        | IP对象数组，当有值时才有这个字段，见下面ip_list结构定义 |
| custom_query_id | array        | 配置平台上的自定义查询ID列表，当有值时才有这个字段 |

#### ip_list

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_cloud_id   | int       | 云区域ID |
| ip            | string    | IP地址 |