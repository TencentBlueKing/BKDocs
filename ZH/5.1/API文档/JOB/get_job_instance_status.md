
### 请求地址

/api/c/compapi/v2/job/get_job_instance_status/



### 请求方法

GET


### 功能描述

根据作业实例 ID 查询作业执行状态

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段             |  类型      | 必选   |  描述      |
|------------------|------------|--------|------------|
| bk_biz_id        |  int       | 是     | 业务ID |
| job_instance_id  |  int       | 是     | 作业实例ID |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "job_instance_id": 100
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "is_finished": true,
        "job_instance": {
            "job_instance_id": 65,
            "bk_biz_id": 1,
            "name": "API Quick execution script1521089795887",
            "start_way": 2,
            "operator": "admin",
            "bk_job_id": -1,
            "create_time": "2018-03-15 12:56:35 +0800",
            "status": 4,
            "start_time": "2018-03-15 12:56:35 +0800",
            "end_time": "2018-03-15 12:56:39 +0800",
            "total_time": 3.169,
            "current_step_instance_id": 75
        },
        "blocks": [
            {
                "type": 1,
                "block_order": 1,
                "block_name": "API Quick execution script xxx",
                "step_instances": [
                    {
                        "status": 4,
                        "total_time": 3.169,
                        "pause": 0,
                        "operation_list": [
                            {
                                "operation_code": 3,
                                "operation_name": "xxx"
                            },
                            {
                                "operation_code": 2,
                                "operation_name": "yyy"
                            }
                        ],
                        "name": "API Quick execution scriptxxx",
                        "step_instance_id": 75,
                        "operator": "admin",
                        "order": 1,
                        "retry_count": 0,
                        "create_time": "2018-03-15 12:56:35 +0800",
                        "end_time": "2018-03-15 12:56:39 +0800",
                        "step_id": -1,
                        "type": 1,
                        "start_time": "2018-03-15 12:56:35 +0800",
                        "step_ip_status": [
                            {
                                "ip": "10.0.0.1",
                                "bk_cloud_id": 0,
                                "status": 9
                            }
                        ]
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
| is_finished    | bool       | 作业是否结束 |
| job_instance   | dict       | 作业实例基本信息 |
| blocks         | array      | 作业步骤块数组 |

#### job_instance

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| name         | string       | 作业实例名称 |
| status       | int          | 作业状态码: 1.未执行; 2.正在执行; 3.执行成功; 4.执行失败; 5.跳过; 6.忽略错误; 7.等待用户; 8.手动结束; 9.状态异常; 10.步骤强制终止中; 11.步骤强制终止成功; 12.步骤强制终止失败 |
| operator     | string       | 作业执行人帐号 |
| create_time  | string       | 创建时间，YYYY-MM-DD HH:mm:ss格式 |
| start_time   | string       | 开始执行时间，YYYY-MM-DD HH:mm:ss格式 |
| end_time     | string       | 执行结束时间，YYYY-MM-DD HH:mm:ss格式 |
| total_time   | float        | 总耗时，秒 |
| start_way    | int          | 作业启动方式: 1.页面启动; 2.API调用; 3.定时任务 |
| bk_biz_id    | int          | 业务ID |
| bk_job_id    | int          | 作业模板ID，如果不是从作业模板启动的则为-1 |
| job_instance_id    | int    | 作业实例ID |
| current_step_instance_id  | int    | 当前执行的步骤实例ID |

#### blocks

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| type           | int       | 步骤块类型：1.脚本步骤; 2.文件步骤; 4.SQL步骤 |
| block_order    | int       | 步骤块顺序 |
| block_name     | string    | 步骤块名称 |
| step_instances | array     | 步骤块中包含的各个步骤对象 |

#### step_instances

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| step_id          | int       | 作业模板步骤ID，如果不是从作业模板启动的则为-1 |
| step_instance_id | int       | 作业步骤实例ID |
| type             | int       | 步骤类型：1.脚本步骤; 2.文件步骤; 4.SQL步骤 |
| name             | string    | 作业实例名称 |
| status           | int       | 作业步骤状态码: 1.未执行; 2.正在执行; 3.执行成功; 4.执行失败; 5.跳过; 6.忽略错误; 7.等待用户; 8.手动结束; 9.状态异常; 10.步骤强制终止中; 11.步骤强制终止成功; 12.步骤强制终止失败 |
| operator         | string    | 作业执行人帐号 |
| pause            | int       | 0.执行完成后不暂停(默认); 1.执行完成后暂停 |
| create_time      | string    | 创建时间，YYYY-MM-DD HH:mm:ss格式 |
| start_time       | string    | 开始执行时间，YYYY-MM-DD HH:mm:ss格式 |
| end_time         | string    | 执行结束时间，YYYY-MM-DD HH:mm:ss格式 |
| total_time       | float     | 总耗时，秒 |
| order            | int       | 当前步骤在步骤块中的顺序 |
| retry_count      | int       | 步骤重试次数 |
| operation_list   | array     | 当前步骤可操作的指令 |
| step_ip_status   | array     | 每个服务器的作业执行状态 |

#### operation_list Description

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| operation_code        | int       | 操作命令编码，命令标识 |
| operation_name        | string    | 操作命令名称, 比如&#39;强制终止&#39; |

#### step_ip_status Description

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| ip          | string    | IP |
| bk_cloud_id | int       | 云区域ID |
| status      | int       | 作业执行状态:1.Agent异常; 5.等待执行; 7.正在执行; 9.执行成功; 11.执行失败; 12.任务下发失败; 403.任务强制终止成功; 404.任务强制终止失败 |