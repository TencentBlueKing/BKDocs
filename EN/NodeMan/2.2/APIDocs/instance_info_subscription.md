### 功能描述

执行订阅

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段              | 类型     | <div style="width: 50pt">必选</div> | 描述                  |
| --------------- | ------ | --------------------------------- | ------------------- |
| subscription_id | int    | 是                                 | 订阅ID                |
| scope           | object | 是                                 | 事件订阅监听的范围, 见scope定义 |
| actions         | object | 否                                 | 动作范围，见actions定义, 如果没有传入actions，则以最近一次任务的action执行     |

#### actions

由订阅步骤ID 和作业类型组成字典，示例：{"agent": "INSTALL_AGENT"}

| 字段       | 类型     | <div style="width: 50pt">必选</div> | 描述                |
| -------- | ------ | --------------------------------- | ----------------- |
| step_id  | string | 是                                 | 订阅步骤ID            |
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
    "scope": {
        "bk_biz_id": 2,
        "object_type": "SERVICE",
        "node_type": "TOPO",
        "nodes": [
            {
                "bk_host_id": 12
            },
            {
                "bk_inst_id": 33,
                "bk_obj_id": "module"
            },
            {
                "ip": "127.0.0.1",
                "bk_cloud_id": 0,
                "bk_supplier_id": 0
            },
            {
                "ip": "127.0.0.1",
                "bk_cloud_id": 1,
                "instance_info": {
                    "key": "",
                    "port": 22,
                    "ap_id": 1,
                    "account": "root",
                    "os_type": "LINUX",
                    "login_ip": "127.0.0.1",
                    "password": "Qk=",
                    "username": "admin",
                    "auth_type": "PASSWORD",
                    "bk_biz_id": 337,
                    "data_path": "/var/lib/gse",
                    "is_manual": false,
                    "retention": -1,
                    "bk_os_type": "1",
                    "bk_biz_name": "xxxxxx",
                    "bk_cloud_id": 1,
                    "bk_cloud_name": "xxxx",
                    "bt_speed_limit": null,
                    "host_node_type": "PROXY",
                    "bk_host_innerip": "127.0.0.1",
                    "bk_host_outerip": "127.0.0.1",
                    "install_channel_id": null,
                    "bk_supplier_account": "0",
                    "peer_exchange_switch_for_agent": 1
                },
                "bk_supplier_account": "0"
            }
        ]
    },
    "actions": {
        "testscript": "UNINSTALL",
        "bkmonitorbeat": "UNINSTALL"
    }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "subscription_id": 1,
        "task_id": 1
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
| data    | object | 请求返回的数据，见data定义            |

#### data

| 字段              | 类型  | 描述   |
| --------------- | --- | ---- |
| subscription_id | int | 订阅ID |
| task_id         | int | 任务ID |
