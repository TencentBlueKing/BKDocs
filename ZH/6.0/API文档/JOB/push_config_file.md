
### 请求地址

/api/c/compapi/v2/job/push_config_file/



### 请求方法

POST


### 功能描述

分发配置文件，此接口用于分发配置文件等小的纯文本文件

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段        |  类型      | 必选   |  描述      |
|-------------|------------|--------|------------|
| bk_biz_id        |  long       | 是     | 业务 ID |
| account          |  string    | 是     | 执行帐号名/别名 |
| file_target_path |  string    | 是     | 文件传输目标路径 |
| file_list        |  array     | 是     | 源文件对象数组，见下面 file_list 定义 |
| ip_list          |  array     | 是     | IP 对象数组，见下面 ip_list 结构定义 |

#### file_list

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| file_name |  string    | 是     | 文件名称 |
| content   |  string    | 是     | 文件内容 Base64 |

#### ip_list

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_cloud_id |  long    | 是     | 云区域 ID |
| ip          |  string | 是     | IP 地址 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "account": "root",
    "file_target_path": "/tmp/",
    "file_list": [
        {
            "file_name": "a.txt",
            "content": "aGVsbG8gd29ybGQh"
        }
    ],
    "ip_list": [
        {
            "bk_cloud_id": 0,
            "ip": "10.0.0.1"
        }
    ]
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "job_instance_name": "API GSE PUSH FILE1521107826893",
        "job_instance_id": 10000
    }
}
```