### 功能描述

查询任务执行结果

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段               | 类型           | <div style="width: 50pt">必选</div> | 描述              |
| ---------------- | ------------ | --------------------------------- | --------------- |
| subscription_id  | int          | 是                                 | 订阅ID            |
| page             | int          | 否                                 | 当前页面            |
| pagesize         | int          | 否                                 | 页面大小            |
| statuses         | string array | 否                                 | 过滤的状态列表         |
| return_all       | bool         | 否                                 | 是否返回全量          |
| instance_id_list | string array | 否                                 | 需过滤的实例ID列表      |
| task_id_list     | int array    | 否                                 | 任务ID列表          |
| need_detail      | bool         | 否                                 | 是否需要详情，默认为false |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "subscription_id": 1,
    "return_all": true
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": 
    "total": 1,
    "list": [
        {
            "task_id": 1,
            "record_id": 1,
            "instance_id": "host|instance|host|127.0.0.1-0-0",
            "create_time": "2020-12-23 16:46:01",
            "pipeline_id": "149cb17976da4040b75523d495886b3d",
            "start_time": "2020-12-23 16:46:01",
            "finish_time": "2020-12-23 16:47:08",
            "instance_info": {
                "host": {
                    "bk_biz_id": 4,
                    "bk_host_id": 1,
                    "bk_biz_name": "测试业务",
                    "bk_cloud_id": 0,
                    "bk_cloud_name": "直连区域",
                    "bk_host_innerip": "127.0.0.1",
                    "bk_supplier_account": "0"
                },
                "service": {

                }
            },
            "status": "SUCCESS",
            "steps": [
                {
                    "id": "agent",
                    "type": "AGENT",
                    "action": "INSTALL_AGENT",
                    "extra_info": {

                    },
                    "pipeline_id": "ac9db1d43b5d438886f08ad8c771005e",
                    "finish_time": "2020-12-23 16:47:08",
                    "start_time": "2020-12-23 16:46:01",
                    "create_time": "2020-12-23 16:46:01",
                    "status": "SUCCESS",
                    "node_name": "[agent] 安装",
                    "step_code": null,
                    "target_hosts": [
                        {
                            "pipeline_id": "d7e4d0e1235941609b4367114dcfe029",
                            "node_name": "[INSTALL_AGENT] 安装 0:127.0.0.1",
                            "sub_steps": [
                                {
                                    "pipeline_id": "913dc70fd5844639b8d72c9d3d7717fc",
                                    "index": 0,
                                    "node_name": "注册主机到配置平台",
                                    "finish_time": "2020-12-23 16:46:01",
                                    "start_time": "2020-12-23 16:46:01",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "e8a16636b1f94640aa3928f19ef87eb9",
                                    "index": 1,
                                    "node_name": "选择接入点",
                                    "finish_time": "2020-12-23 16:46:01",
                                    "start_time": "2020-12-23 16:46:01",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "b99c6872c3eb4c479423514f2d3b00ec",
                                    "index": 2,
                                    "node_name": "安装",
                                    "finish_time": "2020-12-23 16:46:32",
                                    "start_time": "2020-12-23 16:46:01",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "d7f55570fe714c28b7cca56064833be9",
                                    "index": 3,
                                    "node_name": "查询Agent状态",
                                    "finish_time": "2020-12-23 16:46:52",
                                    "start_time": "2020-12-23 16:46:32",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "d17003f106a64d88b8038e77ea9db29b",
                                    "index": 4,
                                    "node_name": "托管 processbeat 插件进程",
                                    "finish_time": "2020-12-23 16:46:58",
                                    "start_time": "2020-12-23 16:46:52",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "81aeb52bb37945788b3d254979854651",
                                    "index": 5,
                                    "node_name": "托管 exceptionbeat 插件进程",
                                    "finish_time": "2020-12-23 16:47:03",
                                    "start_time": "2020-12-23 16:46:58",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "53a5644de57c4c818fef2e38227aebc2",
                                    "index": 6,
                                    "node_name": "托管 basereport 插件进程",
                                    "finish_time": "2020-12-23 16:47:08",
                                    "start_time": "2020-12-23 16:47:03",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                },
                                {
                                    "pipeline_id": "54a91fb0720f47c59fea2dfbf64f4d77",
                                    "index": 7,
                                    "node_name": "更新任务状态",
                                    "finish_time": "2020-12-23 16:47:08",
                                    "start_time": "2020-12-23 16:47:08",
                                    "create_time": "2020-12-23 16:46:01",
                                    "status": "SUCCESS"
                                }
                            ],
                            "finish_time": "2020-12-23 16:47:08",
                            "start_time": "2020-12-23 16:46:01",
                            "create_time": "2020-12-23 16:46:01",
                            "status": "SUCCESS"
                        }
                    ]
                }
            ]
        }
    ],
    "status_counter": {
      "SUCCESS": 1,
      "total": 1
    }
}
```

### 返回结果参数说明

#### response

| 字段      | 类型     | 描述                         |
| ------- | ------ | -------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
| code    | int    | 错误编码。 0表示success，>0表示失败错误  |
| message | string | 请求失败返回的错误信息                |
| data    | object | 请求返回的数据                    |

#### data

| 字段             | 类型           | <div style="width: 50pt">必选</div> | 描述                       |
| -------------- | ------------ | --------------------------------- | ------------------------ |
| total          | int          | 否                                 | 实例记录数量总和                 |
| list           | array | 否                                 | 实例状态列表，见list定义           |
| status_counter | object       | 否                                 | 订阅全局状态统计，见status_counter |

##### status_counter

| 字段    | 类型  | <div style="width: 50pt">必选</div> | 描述                              |
| ----- | --- | --------------------------------- | ------------------------------- |
| 执行状态  | int | 否                                 | 不同执行状态下的数量统计，具体执行状态标识符见status定义 |
| total | int | 是                                 | 全局状态总和数量                        |

##### list

| 字段            | 类型           | <div style="width: 50pt">必选</div> | 描述                      |
| ------------- | ------------ | --------------------------------- | ----------------------- |
| task_id       | int          | 否                                 | 任务ID                    |
| record_id     | int          | 否                                 | 记录ID                    |
| instance_id   | string       | 否                                 | 实例ID，见instan_id定义       |
| create_time   | string       | 否                                 | 创建时间                    |
| pipeline_id   | string       | 否                                 | Pipeline节点ID            |
| start_time    | string       | 否                                 | 启动时间                    |
| finish_time   | string       | 否                                 | 完成时间                    |
| instance_info | object       | 否                                 | 主机实例信息，见instance_info定义 |
| status        | string       | 否                                 | 执行状态，见status 定义         |
| steps         | array | 否                                 | 订阅步骤信息，见steps 定义        |

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

##### steps

| 字段           | 类型            | <div style="width: 50pt">必选</div> | 描述                              |
| ------------ | ------------- | --------------------------------- | ------------------------------- |
| type         | string        | 是                                 | 步骤类型，1: AGENT，2：PLUGIN，3: PROXY |
| actions      | string        | 是                                 | 订阅动作，见actions定义                 |
| extra_info   | object        | 是                                 | 额外信息                            |
| create_time  | string        | 否                                 | 创建时间                            |
| pipeline_id  | string        | 否                                 | Pipeline节点ID                    |
| start_time   | string        | 否                                 | 启动时间                            |
| finish_time  | string        | 否                                 | 完成时间                            |
| status       | string        | 是                                 | 执行状态，见status定义                  |
| node_name    | string        | 是                                 | 节点名称                            |
| step_code    | string        | 是                                 | Pipeline节点执行码                   |
| target_hosts | object  array | 是                                 | 目标主机执行信息，见target_hosts定义        |

###### target_hosts

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述                                                            |
| ----------- | ------ | --------------------------------- | ------------------------------------------------------------- |
| create_time | string | 是                                 | 创建时间                                                          |
| pipeline_id | string | 是                                 | Pipeline节点ID                                                  |
| start_time  | string | 是                                 | 启动时间                                                          |
| finish_time | string | 是                                 | 完成时间                                                          |
| node_name   | string | 是                                 | Pipeline节点名称                                                  |
| sub_steps   | object | 否                                 | 子步骤执行信息，一个完整的订阅步骤可以由很多子步骤组装完成，改步骤展示每一个字步骤的相关信息, 见sub_steps 定义 |

###### sub_steps

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述              |
| ----------- | ------ | --------------------------------- | --------------- |
| create_time | string | 否                                 | 子步骤创建时间         |
| pipeline_id | string | 否                                 | 子步骤Pipeline节点ID |
| start_time  | string | 否                                 | 子步骤启动时间         |
| finish_time | string | 否                                 | 子步骤完成时间         |
| status      | string | 是                                 | 执行状态，见status定义  |
| index       | int    | 是                                 | 步骤顺序            |
| node_name   | string | 是                                 | 子步骤节点名称         |

###### actions

Agent

| 字段              | 类型     | 描述        |
| --------------- | ------ | --------- |
| INSTALL_AGENT   | string | 安装Agent   |
| RESTART_AGENT   | string | 重启Agent   |
| REINSTALL_AGENT | string | 重装Agent   |
| UNINSTALL_AGENT | string | 卸载Agent   |
| REMOVE_AGENT    | string | 移除Agent   |
| UPGRADE_AGENT   | string | 升级Agent   |
| RELOAD_AGENT    | string | 重载Agent配置 |
| INSTALL_PROXY   | string | 安装Proxy   |
| RESTART_PROXY   | string | 重启Proxy   |
| REINSTALL_PROXY | string | 重装Proxy   |
| UNINSTALL_PROXY | string | 卸载Proxy   |
| UPGRADE_PROXY   | string | 升级Proxy   |
| RELOAD_PROXY    | string | 重载Proxy配置 |

Plugin

| 字段                          | 类型     | 描述             |
| --------------------------- | ------ | -------------- |
| MAIN_START_PLUGIN           | string | 启动插件进程         |
| MAIN_STOP_PLUGIN            | string | 停止插件进程         |
| MAIN_RESTART_PLUGIN         | string | 重启插件进程         |
| MAIN_RELOAD_PLUGIN          | string | 重载插件配置         |
| MAIN_DELEGATE_PLUGIN        | string | 托管插件           |
| MAIN_UNDELEGATE_PLUGIN      | string | 取消插件托管         |
| MAIN_INSTALL_PLUGIN         | string | 安装插件           |
| DEBUG_PLUGIN                | string | 调试插件           |
| STOP_DEBUG_PLUGIN           | string | 停止调试插件         |
| MAIN_INSTALL_PLUGIN         | string | 部署插件程序，下发并安装插件 |
| MAIN_STOP_AND_DELETE_PLUGIN | string | 停用插件并删除订阅      |

官方插件，是基于多配置的管理模式，安装、卸载、启用、停用等操作仅涉及到配置的增删 

| 字段          | 类型     | 描述     |
| ----------- | ------ | ------ |
| INSTALL     | string | 下发插件配置 |
| UNINSTALL   | string | 移除插件配置 |
| PUSH_CONFIG | string | 下发插件配置 |
| START       | string | 下发插件配置 |
| STOP        | string | 移除插件配置 |

非官方插件

| 字段          | 类型     | 描述     |
| ----------- | ------ | ------ |
| INSTALL     | string | 部署插件   |
| UNINSTALL   | string | 卸载插件   |
| PUSH_CONFIG | string | 下发插件配置 |
| START       | string | 启动插件进程 |
| STOP        | string | 停止插件进程 |
