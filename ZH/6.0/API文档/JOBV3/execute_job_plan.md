### 功能描述

启动作业执行方案

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
| bk_biz_id   |  long       | 是     | 业务 ID |
| job_plan_id |  long       | 是     | 作业执行方案 ID |
| global_var_list |  array     | 否     | 全局变量。对于作业执行方案中的全局变量值，如果请求参数中包含该变量，则使用传入的变量值；否则使用执行方案当前已配置的默认值。定义见 global_var |
| callback_url |  string  | 否     | 回调 URL，当任务执行完成后，JOB 会调用该 URL 告知任务执行结果。回调协议参考 callback_protocol 组件文档 |

#### global_var

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id               |  long     | 否     | 全局变量 id，唯一标识。如果 id 为空，那么使用 name 作为唯一标识 |
| name             |  string   | 否     | 全局变量 name |
| value     |  string   | 否     | 字符、密码、数组、命名空间类型的全局变量的值                      |
| server |  object   | 否     | 主机类型全局变量的值，见 server 定义 |

#### server

| 字段               | 类型  | 必选 | 描述                                |
| ------------------ | ----- | ---- | ----------------------------------- |
| ip_list            | array | 否   | 静态 IP 列表，定义见 ip              |
| dynamic_group_list | array | 否   | 动态分组列表，定义见 dynamic_group   |
| topo_node_list     | array | 否   | 动态 topo 节点列表，定义见 topo_node |

#### ip

| 字段        | 类型   | 必选 | 描述     |
| ----------- | ------ | ---- | -------- |
| bk_cloud_id | int    | 是   | 云区域 ID |
| ip          | string | 是   | IP 地址   |

#### dynamic_group

| 字段 | 类型   | 必选 | 描述           |
| ---- | ------ | ---- | -------------- |
| id   | string | 是   | CMDB 动态分组 ID |

#### topo_node

| 字段      | 类型   | 必选 | 描述                                                         |
| --------- | ------ | ---- | ------------------------------------------------------------ |
| id        | long   | 是   | 动态 topo 节点 ID，对应 CMDB API 中的 bk_inst_id                 |
| node_type | string | 是   | 动态 topo 节点类型，对应 CMDB API 中的 bk_obj_id,比如"module","set" |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "job_plan_id": 100,
    "global_var_list": [
        {
            "id": 436,
            "server": {
                "dynamic_group_list": [
                    {
                        "id": "blo8gojho0skft7pr5q0"
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
            }
        },
        {
            "name": "param_name",
            "value": "param_value"
        }
    ]
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

