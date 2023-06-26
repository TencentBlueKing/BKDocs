### 功能描述

查询订阅运行状态

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段               | 类型   | <div style="width: 50pt">必选</div> | 描述         |
| ---------------- | ---- | --------------------------------- | ---------- |
| subscription_id  | int  | 是                                 | 订阅ID       |
| show_task_detail | bool | 否                                 | 展示任务详细信息   |
| need_detail      | bool | 否                                 | 展示实例主机详细信息 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "subscription_id_list": [
        1
      ],
      "show_task_detail": false,
      "need_detail": false
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": [
        {
            "subscription_id":1,
            "instances": [
                {
                    "instance_id": "host|instance|host|35",
                    "status": "SUCCESS",
                    "create_time": "2020-12-28 16:48:11+0800",
                    "host_statuses": [

                    ],
                    "instance_info": {
                        "host": {
                            "bk_biz_id": 5,
                            "bk_host_id": 35,
                            "bk_biz_name": "test",
                            "bk_cloud_id": 0,
                            "bk_host_name": "",
                            "bk_cloud_name": "直连区域",
                            "bk_host_innerip": "127.0.0.1",
                            "bk_supplier_account": "0"
                        },
                        "service": {

                        }
                    },
                    "running_task": null,
                    "last_task": {
                        "id": 150,
                        "record_id": 214,
                        "create_time": "2020-12-28 16:48:11",
                        "pipeline_id": "6de50ec13864470d9a9418613ed10da8",
                        "start_time": "2020-12-28 08:48:13",
                        "finish_time": "2020-12-28 08:50:09",
                        "steps": [
                            {
                                "id": "exceptionbeat",
                                "type": "PLUGIN",
                                "action": "MAIN_INSTALL_PLUGIN",
                                "node_name": "[exceptionbeat] 部署插件程序",
                                "pipeline_id": "5b702f51a5944d519f4abcc2678f0ed3",
                                "status": "SUCCESS",
                                "start_time": "2020-12-28 08:48:13",
                                "finish_time": "2020-12-28 08:50:09",
                                "target_hosts": [
                                    {
                                        "node_name": "[exceptionbeat] 部署插件程序 0:127.0.0.1",
                                        "pipeline_id": "5b702f51a5944d519f4abcc2678f0ed3",
                                        "status": "SUCCESS",
                                        "start_time": "2020-12-28 08:48:13",
                                        "finish_time": "2020-12-28 08:50:09",
                                        "sub_steps": [
                                            {
                                                "index": 0,
                                                "node_name": "查询Agent状态",
                                                "step_code": null,
                                                "pipeline_id": "5b702f51a5944d519f4abcc2678f0ed3",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:48:13",
                                                "finish_time": "2020-12-28 08:48:13"
                                            },
                                            {
                                                "index": 1,
                                                "node_name": "更新插件部署状态",
                                                "step_code": null,
                                                "pipeline_id": "6c8ff413abb04cb492265466337e9ba0",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:48:13",
                                                "finish_time": "2020-12-28 08:48:13"
                                            },
                                            {
                                                "index": 2,
                                                "node_name": "批量下发插件包",
                                                "step_code": null,
                                                "pipeline_id": "52bb6f6fb0cc4e7a9d6a6cf476921e6c",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:48:13",
                                                "finish_time": "2020-12-28 08:49:23",
                                                "inputs": {
                                                    "instance_info": {
                                                        "host": {
                                                            "operator": "admin",
                                                            "bk_biz_id": 5,
                                                            "bk_os_bit": "",
                                                            "bk_host_id": 35,
                                                            "bk_os_name": "",
                                                            "bk_os_type": "1",
                                                            "bk_biz_name": "test",
                                                            "bk_cloud_id": 0,
                                                            "bk_host_name": "",
                                                            "bk_cloud_name": "直连区域",
                                                            "bk_cpu_module": "",
                                                            "bk_bak_operator": "admin",
                                                            "bk_host_innerip": "127.0.0.1",
                                                            "bk_host_outerip": "",
                                                            "bk_supplier_account": "0"
                                                        },
                                                        "scope": [
                                                            {
                                                                "ip": "127.0.0.1",
                                                                "bk_cloud_id": 0,
                                                                "bk_supplier_id": 0
                                                            }
                                                        ],
                                                        "process": {

                                                        },
                                                        "service": null
                                                    }
                                                }
                                            },
                                            {
                                                "index": 3,
                                                "node_name": "安装插件包",
                                                "step_code": null,
                                                "pipeline_id": "0d0d62d071d44456bccdf7bbf9b18489",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:49:23",
                                                "finish_time": "2020-12-28 08:49:54"
                                            },
                                            {
                                                "index": 4,
                                                "node_name": "渲染并下发配置",
                                                "step_code": null,
                                                "pipeline_id": "85f252a390b14f1aa9c9538f5d6faf6e",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:49:54",
                                                "finish_time": "2020-12-28 08:49:59"
                                            },
                                            {
                                                "index": 5,
                                                "node_name": "重启 exceptionbeat 插件进程",
                                                "step_code": null,
                                                "pipeline_id": "e2534a4f17f545b2b341cc278b173a74",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:49:59",
                                                "finish_time": "2020-12-28 08:50:09"
                                            },
                                            {
                                                "index": 6,
                                                "node_name": "更新插件部署状态",
                                                "step_code": null,
                                                "pipeline_id": "9767216b9e734736ac70d7a8a429cb71",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:50:09",
                                                "finish_time": "2020-12-28 08:50:09"
                                            },
                                            {
                                                "index": 7,
                                                "node_name": "重置重试次数",
                                                "step_code": null,
                                                "pipeline_id": "95959096c4904e0c97d8b72a78cae308",
                                                "log": "",
                                                "ex_data": null,
                                                "status": "SUCCESS",
                                                "start_time": "2020-12-28 08:50:09",
                                                "finish_time": "2020-12-28 08:50:09"
                                            }
                                        ]
                                    }
                                ]
                            }
                        ],
                        "status": "SUCCESS"
                    }
                }
            ]
        }
    ]
}
```

### 返回结果参数说明

#### response

| 字段      | 类型     | 描述                         |
| ------- | ------ | -------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
| code    | int    | 错误编码。 0表示success，>0表示失败错误  |
| message | string | 请求失败返回的错误信息                |
| data    | object | 请求返回的数据，见data定义            |

#### data

| 字段              | 类型     | 描述                    |
| --------------- | ------ | --------------------- |
| subscription_id | int    | 订阅ID                  |
| instances       | object | 主机实例信息列表，见instances定义 |

##### instances

| 字段            | 类型     | <div style="width: 50pt">必选</div> | 描述                             |
| ------------- | ------ | --------------------------------- | ------------------------------ |
| instance_id   | string | 是                                 | 实例ID                           |
| status        | string | 是                                 | 执行状态，见status 定义                |
| create_time   | string | 否                                 | 创建时间                           |
| host_statuses | object | 是                                 | 主机状态，见host_status定义            |
| instance_info | object | 是                                 |                                |
| running_task  | object | 是                                 | 正在运行中的订阅执行任务信息，见running_task定义 |
| last_task     | object | 是                                 | 最后一个订阅执行任务，见last_task定义        |

##### status

| 状态类型        | 类型     | 描述   |
| ----------- | ------ | ---- |
| PENDING     | string | 等待执行 |
| RUNNING     | string | 正在执行 |
| FAILED      | string | 执行失败 |
| SUCCESS     | string | 执行成功 |
| PART_FAILED | string | 部分失败 |
| TERMINATED  | string | 已终止  |
| REMOVED     | string | 已移除  |
| FILTERED    | string | 被过滤的 |
| IGNORED     | string | 已忽略  |

##### host_statuses

| 字段       | 类型     | <div style="width: 50pt">必选</div> | 描述                  |
| -------- | ------ | --------------------------------- | ------------------- |
| name     | string | 否                                 | 进程名称                |
| status   | string | 否                                 | 进程状态，见proc_status定义 |
| version  | string | 否                                 | 版本号                 |
| group_id | int    | 否                                 | 插件组ID               |

##### instance_info

当need_detail参数为True时，展示信息将包括但不限于以下字段

| 字段      | 类型     | <div style="width: 50pt">必选</div> | 描述                |
| ------- | ------ | --------------------------------- | ----------------- |
| host    | object | 否                                 | 主机信息，见host定义      |
| service | object | 否                                 | 服务实例信息，见service定义 |

##### host

| 字段                  | 类型     | <div style="width: 50pt">必选</div> | 描述         |
| ------------------- | ------ | --------------------------------- | ---------- |
| bk_biz_id           | int    | 否                                 | 蓝鲸业务ID     |
| bk_host_innerip_v6  | string | 否                                 | 主机IPV6内网地址 |
| bk_host_innerip     | string | 否                                 | 主机IPV4内网地址 |
| bk_cloud_id         | int    | 否                                 | 云区域ID      |
| bk_supplier_account | int    | 否                                 | 服务商ID      |
| bk_host_name        | string | 否                                 | 主机名        |
| bk_host_id          | int    | 否                                 | 主机ID       |
| bk_biz_name         | string | 否                                 | 业务名称       |
| bk_cloud_name       | string | 否                                 | 云区域名称      |

##### service

| 字段           | 类型     | <div style="width: 50pt">必选</div> | 描述     |
| ------------ | ------ | --------------------------------- | ------ |
| id           | int    | 否                                 | 服务实例ID |
| name         | string | 否                                 | 服务实例名称 |
| bk_module_id | int    | 否                                 | 模块ID   |
| bk_host_id   | int    | 否                                 | 主机ID   |

##### proc_status

| 状态类型          | 类型     | 描述   |
| ------------- | ------ | ---- |
| RUNNING       | string | 运行中  |
| UNKNOWN       | string | 未知状态 |
| TERMINATED    | string | 已终止  |
| NOT_INSTALLED | string | 未安装  |
| UNREGISTER    | string | 未注册  |
| REMOVED       | string | 已移除  |
| MANUAL_STOP   | string | 手动停止 |

##### running_task

| 字段              | 类型   | <div style="width: 50pt">必选</div> | 描述       |
| --------------- | ---- | --------------------------------- | -------- |
| id              | int  | 是                                 | 订阅执行任务ID |
| is_auto_trigger | bool | 是                                 | 是否为自动触发  |

##### last_task

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述        |
| ----------- | ------ | --------------------------------- | --------- |
| id          | int    | 是                                 | 订阅执行任务ID  |
| record_id   | int    | 否                                 | 记录ID      |
| create_time |        | 否                                 | 创建时间      |
| pipeline_id | int    | 否                                 | 订阅执行流水线ID |
| finish_time | int    | 否                                 | 结束时间      |
| steps       | array  | 否                                 | 订阅执行步骤    |
| status      | string | 否                                 | 执行状态      |
