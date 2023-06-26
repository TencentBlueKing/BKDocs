### 功能描述

查询任务详情

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段         | 类型           | <div style="width: 50pt">必选</div> | 描述                 |
| ---------- | ------------ | --------------------------------- | ------------------ |
| job_id     | int          | 是                                 | 任务ID               |
| page       | int          | 否                                 | 当前页数，默认为1          |
| pagesize   | int          | 否                                 | 分页大小，默认为10         |
| conditions | array | 否                                 | 搜索条件，见conditions定义 |

##### 见conditions定义

| 字段    | 类型     | <div style="width: 50pt">必选</div> | 描述                                                                                             |
| ----- | ------ | --------------------------------- | ---------------------------------------------------------------------------------------------- |
| key   | string | 否                                 | 查询类型，1: ip，IP地址 2:instance_id，主机实例ID 3: status，执行状态                                            |
| value | string | 否                                 | 查询关键词，1：当key为ip时，可以指定查询IP地址 2：当key 为instance_id时，可以指定对应的实例ID 3：当key为status时，可以指定查询状态，见status定义 |

###### status

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

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "job_id": 1,
    "conditions": [
        {
            "key": "status",
            "value": "SUCCESS"
        }
    ],
    "page": 1,
    "pagesize": 10
}
```

### 返回结果示例

```json
{
  "result": true,
  "data": {
    "job_id": 1,
    "created_by": "admin",
    "job_type": "UPGRADE_AGENT",
    "job_type_display": "升级 Agent",
    "ip_filter_list": [],
    "total": 0,
    "list": [],
    "statistics": {
      "total_count": 1,
      "failed_count": 0,
      "ignored_count": 0,
      "pending_count": 0,
      "running_count": 0,
      "success_count": 1
    },
    "status": "SUCCESS",
    "end_time": "2021-09-16 15:07:20+0800",
    "start_time": "2021-09-16 15:06:03+0800",
    "cost_time": "77",
    "meta": {
      "type": "AGENT",
      "step_type": "AGENT",
      "op_type": "UPGRADE",
      "op_type_display": "升级",
      "step_type_display": "Agent"
    }
  },
  "code": 0,
  "message": ""
}
```

### 返回结果参数说明

#### response

| 字段      | 类型           | 描述                         |
| ------- | ------------ | -------------------------- |
| result  | bool         | 请求成功与否。true:请求成功；false请求失败 |
| code    | int          | 错误编码。 0表示success，>0表示失败错误  |
| message | string       | 请求失败返回的错误信息                |
| data    | array | 请求返回的数据，见data定义            |

#### data

| 字段               | 类型           | <div style="width: 50pt">必选</div> | 描述                   |
| ---------------- | ------------ | --------------------------------- | -------------------- |
| job_id           | int          | 是                                 | 作业任务ID               |
| created_by       | string       | 是                                 | 创建者                  |
| job_type         | string       | 是                                 | 作业类型，见job_type定义     |
| job_type_display | string       | 是                                 | 作业类型名称               |
| ip_filter_list   | string arary | 是                                 | 过滤的IP列表，不在指定的筛选范围内   |
| total            | int          | 否                                 | 实例记录数量总和             |
| list             | object       | 否                                 | 过滤的主机详细信息列表，见list定义  |
| statistics       | object       | 是                                 | 任务统计信息，见statistics定义 |
| status           | string       | 是                                 | 执行状态，见status定义       |
| end_time         | string       | 是                                 | 完成时间                 |
| start_time       | string       | 是                                 | 启动时间时间               |
| cost_time        | string       | 是                                 | 执行耗时，单位为秒            |
| meta             | object       | 是                                 | 执行任务元数据信息，见meta定义    |

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

##### list

| 字段             | 类型     | <div style="width: 50pt">必选</div> | 描述                 |
| -------------- | ------ | --------------------------------- | ------------------ |
| filter_host    | bool   | 否                                 | 是否存在过滤的主机          |
| bk_host_id     | int    | 否                                 | 主机ID               |
| ip             | string | 否                                 | 主机IP地址             |
| inner_ip       | string | 否                                 | 主机内网IPV4地址         |
| inner_ipv6     | string | 否                                 | 主机内网IPV6地址         |
| bk_cloud_id    | int    | 否                                 | 云区域ID              |
| bk_cloud_name  | string | 否                                 | 云区域名称              |
| bk_biz_id      | int    | 否                                 | 业务ID               |
| bk_biz_name    | string | 否                                 | 业务名称               |
| job_id         | int    | 否                                 | 任务ID               |
| status         | string | 否                                 | 任务执行状态，见status定义   |
| status_display | string | 否                                 | 任务执行状态名称，见status定义 |

##### statistics

| 字段            | 类型  | 描述       |
| ------------- | --- | -------- |
| total_count   | int | 任务实例总数   |
| failed_count  | int | 失败实例数量   |
| ignored_count | int | 忽略实例数量   |
| pending_count | int | 等待执行实例数量 |
| running_count | int | 正在执行实例数量 |
| success_count | int | 执行成功实例数量 |

##### meta

| 字段                | 类型     | <div style="width: 50pt">必选</div> | 描述                                |
| ----------------- | ------ | --------------------------------- | --------------------------------- |
| type              | string | 是                                 | 任务对象类型，1: AGENT  2：PLUGIN 3：PROXY |
| step_type         | string | 是                                 | 步骤类型                              |
| op_type           | string | 是                                 | 操作类型，见op_type定义                   |
| op_type_display   | string | 是                                 | 操作类型名称，见op_type定义                 |
| step_type_display | string | 是                                 | 订阅步骤类型，1: Agent 2: 插件 3: Proxy    |
| name              | string | 否                                 | 订阅名称                              |
| category          | string | 否                                 | 订阅类别，1: None，普通插件任务，2: POLIC， 策略  |
| plugin_name       | string | 否                                 | 插件名                               |

###### op_type

| 字段              | 类型     | 描述    |
| --------------- | ------ | ----- |
| INSTALL         | string | 安装    |
| REINSTALL       | string | 重装    |
| UNINSTALL       | string | 替换    |
| REMOVE          | string | 移除    |
| REPLACE         | string | 替换    |
| UPGRADE         | string | 升级    |
| IMPORT          | string | 导入    |
| UPDATE          | string | 更新    |
| START           | string | 启动    |
| STOP            | string | 停止    |
| RELOAD          | string | 重载    |
| RESTART         | string | 重启    |
| DELEGATE        | string | 托管    |
| UNDELEGATE      | string | 取消托管  |
| DEBUG           | string | 调试    |
| MANUAL_INSTALL  | string | 手动安装  |
| PACKING         | string | 打包    |
| STOP_AND_DELETE | string | 卸载并删除 |
| PUSH            | string | 下发    |
| IGNORED         | string | 忽略    |
| POLICY_CONTROL  | string | 策略管控  |
| REMOVE_CONFIG   | string | 移除配置  |
| PUSH_CONFIG     | string | 下发配置  |
