### 功能描述

操作作业任务，用于只有bk_host_id参数的主机下线、重启等操作，该接口不可用于安装/替换Proxy操作

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段                        | 类型           | <div style="width: 50pt">必选</div> | 描述                                                                                     |
| ------------------------- | ------------ | --------------------------------- | -------------------------------------------------------------------------------------- |
| job_type                  | string       | 是                                 | 任务类型，见job_type定义                                                                       |
| bk_biz_id                 | int array    | 是                                 | 业务ID                                                                                   |
| conditions                | array | 否                                 | 搜索条件，支持os_type, ip, status，version, bk_cloud_id, node_from 和 模糊搜索query，见conditions定义   |
| bk_host_id                | int array    | 否                                 | 主机ID                                                                                   |
| exclude_hosts             | int array    | 否                                 | 跨页全选排除主机，主机ID和跨页全选排除主机ID必选一个，注意, 云区域ID、业务ID等筛选条件，仅在跨页全选模式下有效，并且跨页全选模式下不允许传bk_host_id参数 |
| is_install_latest_plugins | bool         | 否                                 | 是否安装最新版本插件，默认安装最新插件                                                                    |

##### conditions

由指定关键词key和value组成的字典 示例：{"key": "inner_ip", "value": ["127.0.0.1"]}

| key                   | 类型     | value描述                                                     |
| --------------------- | ------ | ----------------------------------------------------------- |
| inner_ip              | string | 主机内网IPV4地址                                                  |
| node_from             | string | 节点来源，1: CMDB,  配置平台同步 2: EXCEL, saas页面表格导入 3: NODE_MAN，节点管理 |
| node_type             | string | 节点类型，1: AGENT, 2: PROXY, 3: PAGENT                          |
| bk_addressing         | string | 寻址方式，1: 0，静态 2: 1，动态                                        |
| bk_host_name          | string | 主机名称                                                        |
| os_type               | string | 操作系统，1：LINUX 2：WINDOWS 3：AIX 4：SOLARIS                      |
| status                | string | 进程状态，见status定义                                              |
| version               | string | Agent版本号                                                    |
| is_manual             | string | 手动安装                                                        |
| bk_cloud_id           | string | 云区域ID                                                       |
| install_channel_id    | string | 安装通道ID                                                      |
| topology              | string | 集群与模块的精准搜索                                                  |
| query                 | string | IP、操作系统、Agent状态、Agent版本、云区域模糊搜索,对应value为列表时为多模糊搜索           |
| source_id             | string | 来源ID                                                        |
| plugin_name           | string | 插件名，展开任务下所有的插件名称                                            |
| ${plugin_name}        | string | 插件版本的精确搜索，${plugin_name}为对应的目标插件名称                          |
| ${plugin_name}_status | string | 插件状态的精确搜索，${plugin_name}为对应的目标插件名称                          |

##### status

| 状态类型          | 类型     | 描述   |
| ------------- | ------ | ---- |
| RUNNING       | string | 运行中  |
| UNKNOWN       | string | 未知状态 |
| TERMINATED    | string | 已终止  |
| NOT_INSTALLED | string | 未安装  |
| UNREGISTER    | string | 未注册  |
| REMOVED       | string | 已移除  |
| MANUAL_STOP   | string | 手动停止 |

###### job_type

| 字段                          | 类型     | 描述         |
| --------------------------- | ------ | ---------- |
| RESTART_AGENT               | string | 重启 Agent   |
| RESTART_PROXY               | string | 重启 Proxy   |
| REINSTALL_PROXY             | string | 重装 Proxy   |
| REINSTALL_AGENT             | string | 重装 Agent   |
| UPGRADE_PROXY               | string | 升级 Proxy   |
| UPGRADE_AGENT               | string | 升级 Agent   |
| REMOVE_AGENT                | string | 移除 Agent   |
| UNINSTALL_AGENT             | string | 卸载 Agent   |
| UNINSTALL_PROXY             | string | 卸载 Proxy   |
| IMPORT_PROXY                | string | 导入Proxy机器  |
| IMPORT_AGENT                | string | 导入Agent机器  |
| MAIN_START_PLUGIN           | string | 启动插件       |
| MAIN_STOP_PLUGIN            | string | 停止插件       |
| MAIN_RESTART_PLUGIN         | string | 重启插件       |
| MAIN_RELOAD_PLUGIN          | string | 重载插件       |
| MAIN_DELEGATE_PLUGIN        | string | 托管插件       |
| MAIN_UNDELEGATE_PLUGIN      | string | 取消托管插件     |
| MAIN_INSTALL_PLUGIN         | string | 安装插件       |
| MAIN_STOP_AND_DELETE_PLUGIN | string | 停止插件并删除策略  |
| RELOAD_AGENT                | string | 重载配置       |
| RELOAD_PROXY                | string | 重载配置       |
| PACKING_PLUGIN              | string | 打包插件       |
| PUSH_CONFIG_PLUGIN          | string | 下发插件配置     |
| REMOVE_CONFIG_PLUGIN        | string | 移除插件配置     |
| MANUAL_INSTALL_AGENT        | string | 手动安装 Agent |
| MANUAL_INSTALL_PROXY        | string | 手动安装 Proxy |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "job_type": "RESTART_AGENT",
    "conditions": [
        {
            "key": "inner_ip",
            "value": ["127.0.0.1"]
        }
    ],
    "exclude_hosts": [
        1,
        2,
        3
    ]
}
```

### 返回结果示例

```json
{
  "result": true,
  "data": {
    "job_id": 1741,
    "job_url": "https://localhost.com/#/task-list/detail/1741"
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

| 字段      | 类型     | 描述          |
| ------- | ------ | ----------- |
| job_id  | int    | 任务ID        |
| job_url | string | 作业平台任务链接URL |
