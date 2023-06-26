### 功能描述

重试失败的任务

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段               | 类型     | <div style="width: 50pt">必选</div> | 描述                                              |
| ---------------- | ------ | --------------------------------- | ----------------------------------------------- |
| subscription_id  | int    | 是                                 | 订阅ID                                            |
| instance_id_list | array  | 否                                 | 实例ID列表，见instance_id_list定义                      |
| task_id_list     | array  | 否                                 | 任务ID列表                                          |
| actions          | object | 否                                 | 订阅动作，见actions定义，如果没有传入actions，则以最近一次任务的action执行 |

##### instance_id_list

由scope内的主机实例信息转换而来，由以下字段拼接，，可通过接口`task_result_subscription`查询，规则：{object_type}|{node_type}|{type}|{id}，示例：1: host|instance|host|1, 2: host|instance|host|127.0.0.1-1-0

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述                                                                                  |
| ----------- | ------ | --------------------------------- | ----------------------------------------------------------------------------------- |
| object_type | string | 是                                 | 对象类型，1：host，主机类型  2：service，服务类型                                                    |
| node_type   | string | 是                                 | 节点类别，1: topo，动态实例（拓扑）2: instance，静态实例 3: service_template，服务模板 4: set_template，集群模板 |
| type        | string | 是                                 | 服务类型，1: host 主机 2: bk_obj_id 模板ID                                                   |
| id          | string | 是                                 | 服务实例ID，1： 根据ip，bk_cloud_id，bk_supplier_id和分隔符”-“生成key 2: bk_host_id, 主机Host-ID      |

#### actions

由订阅步骤ID 和作业类型组成字典，示例：{"agent": "INSTALL_AGENT"}

| 字段       | 类型     | <div style="width: 50pt">必选</div> | 描述                |
| -------- | ------ | --------------------------------- | ----------------- |
| step_id  | string | 是                                 | 订阅步骤ID，创建订阅时指定    |
| job_type | string | 是                                 | 作业类型，见job_type 定义 |

###### job_type

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

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "subscription_id": 1, 
    "instance_id_list": ["host|instance|host|1"],
    "task_id_list": [1],
    "actions": {"agent": "INSTALL_AGENT"}
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
       "task_id": 415,
    },
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

##### data

| 字段      | 类型  | <div style="width: 50pt">必选</div> | 描述   |
| ------- | --- | --------------------------------- | ---- |
| task_id | int | 是                                 | 任务ID |
