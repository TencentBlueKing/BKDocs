
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/jobv3/get_job_instance_global_var_value/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

获取作业实例全局变量的值

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id       |  long       | 是     | 业务 ID |
| job_instance_id |  long    | 是     | 作业实例 ID |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "job_instance_id": 100
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "job_instance_id": 100,
        "step_instance_var_list": [
            {
                "step_instance_id": 292778,
                "global_var_list": [
                    {
                        "name": "aa",
                        "value": "AA",
                        "type": 1
                    },
                    {
                        "name": "password",
                        "value": "mypassword",
                        "type": 4
                    }
                ]
            },
            {
                "step_instance_id": 292779,
                "global_var_list": [
                    {
                        "name": "aa",
                        "value": "AAAA",
                        "type": 1
                    },
                    {
                        "name": "password",
                        "value": "mypassword",
                        "type": 4
                    }
                ]
            }
        ]
    }
}
```

### 返回结果参数说明

#### response
| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| result       | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code         | int    | 错误编码。 0 表示 success，>0 表示失败错误 |
| message      | string | 请求失败返回的错误信息|
| data         | object | 请求返回的数据|
| permission   | object | 权限信息|
| request_id   | string | 请求链 id|

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| job_instance_id  | long       | 作业实例 ID |
| job_instance_var_list | array   | 作业实例全局变量值。定义见 step_instance_var |

**step_instance_var**

| 字段             | 类型  | 描述                             |
| ---------------- | ----- | -------------------------------- |
| step_instance_id | long  | 步骤实例 ID                       |
| global_var_list  | array | 全局变量值列表，定义见 global_var |

#### global_var

| 字段   | 类型   | 必选 | 描述                                                       |
| ------ | ------ | ---- | ---------------------------------------------------------- |
| id     | long   | 否   | 全局变量 id，唯一标识。如果 id 为空，那么使用 name 作为唯一标识 |
| name   | string | 否   | 全局变量 name                                               |
| value  | string | 否   | 字符、密码、数组类型的全局变量的值                         |
| server | object   | 否   | 主机类型全局变量的值，见 server 定义                         |

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