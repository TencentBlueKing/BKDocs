
### 请求地址

/api/c/compapi/v2/job/fast_push_file/

### 请求方法

POST

### 功能描述

快速分发文件

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段             |  类型      | 必选   |  描述      |
|------------------|------------|--------|------------|
| bk_biz_id        |  int       | 是     | 业务 ID |
| account          |  string    | 是     | 执行帐号名/别名 |
| file_target_path |  string    | 是     | 文件传输目标路径 |
| file_source      |  array     | 是     | 源文件对象数组，见下面 file_source 定义 |
| custom_query_id  |  array     | 否     | 配置平台上的自定义查询 id 列表。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |
| ip_list          |  array     | 否     | IP 对象数组。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |
| bk_callback_url  |  string    | 否     | 回调 URL，当任务执行完成后，JOB 会调用该 URL 告知任务执行结果。回调协议参考 callback_protocol 组件文档 |

#### file_source

| 字段          |  类型      | 必选   |  描述      |
|---------------|------------|--------|------------|
| files         |  array     | 是     | 源文件的绝对路径数组，支持多个文件 |
| account       |  string    | 是     | 执行帐号名/别名 |
| custom_query_id| array     | 否     | 配置平台上的自定义查询 id 列表。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |
| ip_list       |  array     | 否     | IP对象数组。ip_list 与 custom_query_id 之间任意选一或并存，ip 数据会去重合并 |

#### ip_list

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_cloud_id |  int    | 是     | 云区域ID |
| ip          |  string | 是     | IP地址 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
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
    "account": "root"
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "job_instance_name": "API Quick Distribution File1521101427176",
        "job_instance_id": 10000
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| result    | bool      | 请求成功与否，true:请求成功，false:请求失败 |
| code      | string    | 组件返回错误编码，0表示success，>0表示失败错误 |
| message   | string    | 请求失败返回的错误消息 |
| data      | object    | 请求返回的数据 |

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| job_instance_name | string  | 作业实例名称 |
| job_instance_id   | int     | 作业实例ID  |
