
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
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段          |  类型      | 必选   |  描述      |
|---------------|------------|--------|------------|
| bk_biz_id      |  int       | 是     | 业务ID |
| script_id      |  int       | 否     | 脚本ID |
| task_name      |  string    | 否     | 自定义作业名称 |
| script_content |  string    | 否     | 脚本内容Base64，如果同时传了script_id和script_content，则script_id优先 |
| script_param   |  string    | 否     | 脚本参数Base64。注意：如果有多个参数，比如&#34;param1 param2&#34;这种，需要对&#34;param1 param2&#34;整体进行base64编码，而不是对每个参数进行base64编码再拼接起来 |
| script_timeout |  int       | 否     | 脚本超时时间，秒。默认1000，取值范围60-86400 |
| account        |  string    | 否     | 执行帐号名/别名 |
| is_param_sensitive |  int   | 否     | 敏感参数将会在执行详情页面上隐藏, 0:不是（默认），1:是 |
| script_type    |  int       | 否     | 脚本类型：1(shell脚本)、2(bat脚本)、3(perl脚本)、4(python脚本)、5(Powershell脚本) |
| custom_query_id|  array     | 否     | 配置平台上的自定义查询id列表。ip_list与custom_query_id之间任意选一或并存，ip数据会去重合并 |
| ip_list        |  array     | 否     | IP对象数组。ip_list与custom_query_id之间任意选一或并存，ip数据会去重合并 |
| bk_callback_url |  string   | 否     | 回调URL，当任务执行完成后，JOB会调用该URL告知任务执行结果。回调协议参考callback_protocol组件文档 |

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
    "script_id": 1,
    "script_content": "ZWNobyAkMQ==",
    "script_param": "aGVsbG8=",
    "script_timeout": 1000,
    "account": "root",
    "is_param_sensitive": 0,
    "script_type": 1,
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
    },
}
```