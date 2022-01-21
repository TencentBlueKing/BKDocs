### 功能描述

根据 ip 列表批量查询作业执行日志

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id       |  long    | 是     | 业务 ID |
| job_instance_id | long | 是 | 作业实例 ID |
| step_instance_id |  long    | 是     | 步骤实例 ID |
| ip_list |  array    | 是     | 源/目标主机 IP 列表,定义见 ip |

##### ip

| 字段        | 类型   | 必选 | 描述     |
| ----------- | ------ | ---- | -------- |
| bk_cloud_id | int    | 是   | 云区域 ID |
| ip          | string | 是   | IP 地址   |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "job_instance_id": 100,
    "step_instance_id": 200,
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
}
```

### 返回结果示例

#### 脚本执行步骤
```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "log_type": 2,
        "task_instance_id": 100,
        "step_instance_id": 200,
        "file_task_logs": [
            {
                "ip": "10.0.0.1",
                "bk_cloud_id": 0,
                "file_logs": [
                    {
                        "mode": 1,
                        "src_ip": {
                            "bk_cloud_id": 0,
                            "ip": "10.0.0.2"
                        },
                        "src_path": "/data/1.log",
                        "dest_ip": {
                            "bk_cloud_id": 0,
                            "ip": "10.0.0.1"
                        },
                        "dest_path": "/tmp/1.log",
                        "status": 4,
                        "log_content": "[2021-06-28 11:32:16] FileName: /tmp/1.log FileSize: 9.0 Bytes State: dest agent success download file Speed: 1 KB/s Progress: 100% StatusDesc: dest agent success download file Detail: success"
                    }
                ]
            },
            {
                "ip": "10.0.0.2",
                "bk_cloud_id": 0,
                "file_logs": [
                    {
                        "mode": 0,
                        "src_ip": {
                            "bk_cloud_id": 0,
                            "ip": "10.0.0.2"
                        },
                        "src_path": "/data/1.log",
                        "status": 4,
                        "log_content": "[2021-06-28 11:32:16] FileName: /data/1.log FileSize: 9.0 Bytes State: source agent success upload file Speed: 1 KB/s Progress: 100% StatusDesc: source agent success upload file Detail: success upload"
                    }
                ]
            }
        ]
    }
}
```

**文件任务返回结果说明**

- 如果需要返回文件源的上传日志，需要在 ip_list 添加源文件服务器 IP

### 返回结果说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_cloud_id   | int         | 目标服务器云区域 ID |
| ip            | string      | 目标服务器 IP 地址 |
| log_type   | int         | 日志类型。1-脚本执行任务日志;2-文件分发任务日志 |
| script_task_logs   | array      | 脚本执行任务日志。定义见 script_task_log|
| file_task_logs   | array      | 文件分发任务日志。定义见 file_task_log|

#### script_task_log

| 字段      |  类型     |  描述      |
|-----------|------------|--------|
| bk_cloud_id |  long    | 云区域 ID |
| ip          |  string  | 目标 IP 地址 |
| log_content |  string  | 脚本执行日志内容   |

#### file_task_log

| 字段      |  类型     |  描述      |
|-----------|------------|--------|
| bk_cloud_id |  long    | 云区域 ID |
| ip          |  string  | 源/目标 IP 地址 |
| file_logs   |  array  | 文件分发日志内容。定义见 file_log |

#### file_log

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| mode | 分发模式 | 0:上传;1:下载|
| src_ip |  object |文件源主机 IP。定义见 ip |
| src_path | string | 源文件路径 |
| dest_ip | object | 分发目标主机 IP，mode=1 时有值。定义见 ip |
| dest_path | string | 目标路径，mode=1 时有值 |
| status | int | 任务状态。1-等待开始;2-上传中;3-下载中;4-成功;5-失败 |
| log_content | string | 文件分发日志内容 |

#### ip

| 字段      |  类型     |  描述      |
|-----------|------------|--------|
| bk_cloud_id |  long    | 云区域 ID |
| ip          |  string  | IP 地址   |
