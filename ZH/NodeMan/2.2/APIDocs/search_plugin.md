### 功能描述

查询主机列表

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段                        | 类型           | <div style="width: 50pt">必选</div> | 描述                                  |
| ------------------------- | ------------ | --------------------------------- | ----------------------------------- |
| bk_biz_id                 | int array    | 否                                 | 业务ID                                |
| bk_host_id                | int array    | 否                                 | 主机ID                                |
| bk_cloud_id               | int array    | 否                                 | 云区域ID                               |
| conditions                | array | 否                                 | 搜索条件，见conditions定义                  |
| exclude_hosts             | int arrray   | 否                                 | 跨页全选排除主机ID列表                        |
| page                      | int          | 否                                 | 当前页数，默认为1                           |
| pagesize                  | int          | 否                                 | 分页大小，默认为10                          |
| only_ip                   | bool         | 否                                 | 只返回IP，不返回其他字段，默认为否                  |
| simple                    | bool         | 否                                 | 仅返回概要信息(bk_host_id, bk_biz_id)，默认为否 |
| detail                    | bool         | 否                                 | 是否返回节点详情，默认为否                       |
| with_agent_status_counter | bool         | 否                                 | 是否返回Agent状态统计信息，默认为否，为True时显示主进程信息  |

##### conditions

由指定关键词key和value组成的字典 示例：{"key": "inner_ip", "value": ["127.0.0.1"]}

| key                   | 类型     | value描述                                                    |
|-----------------------|--------|------------------------------------------------------------|
| ip                    | list   | 主机内网 IP，支持 v4 / v6 混合输入                                    |
| inner_ip              | list   | 主机内网IPv4地址                                                 |
| inner_ipv6            | list   | 主机内网IPv6地址                                                 |
| node_from             | list   | 节点来源，1: CMDB, 配置平台同步 2: EXCEL, saas页面表格导入 3: NODE_MAN，节点管理 |
| node_type             | list   | 节点类型，1: AGENT, 2: PROXY, 3: PAGENT                         |
| bk_addressing         | list   | 寻址方式，1: 0，静态 2: 1，动态                                       |
| bk_host_name          | list   | 主机名称                                                       |
| os_type               | list   | 操作系统，1：LINUX 2：WINDOWS 3：AIX 4：SOLARIS                     |
| status                | list   | 进程状态，见status定义                                             |
| version               | list   | Agent版本号                                                   |
| is_manual             | list   | 手动安装                                                       |
| bk_cloud_id           | list   | 云区域ID                                                      |
| install_channel_id    | list   | 安装通道ID                                                     |
| topology              | string | 集群与模块的精准搜索                                                 |
| query                 | string | IP、操作系统、Agent状态、Agent版本、云区域模糊搜索,对应value为列表时为多模糊搜索          |
| source_id             | string | 来源ID                                                       |
| plugin_name           | string | 插件名，展开任务下所有的插件名称                                           |
| ${plugin_name}        | string | 插件版本的精确搜索，${plugin_name}为对应的目标插件名称                         |
| ${plugin_name}_status | string | 插件状态的精确搜索，${plugin_name}为对应的目标插件名称                         |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "bk_host_id": [
        1
    ],
    "detail": true
}
```

### 返回结果示例

```json
{
    "result": true,
    "data": {
        "total": 1,
        "list": [
            {
                "bk_biz_id": 2,
                "bk_host_id": 1,
                "bk_cloud_id": 0,
                "bk_host_name": "",
                "bk_addressing": "0",
                "inner_ip": "127.0.0.1",
                "inner_ipv6": "",
                "os_type": "LINUX",
                "cpu_arch": "x86_64",
                "node_type": "Agent",
                "node_from": "NODE_MAN",
                "status": "RUNNING",
                "version": "1.7.19",
                "status_display": "正常",
                "bk_cloud_name": "直连区域",
                "bk_biz_name": "蓝鲸",
                "job_result": {
                    "instance_id": "host|instance|host|1",
                    "job_id": 1434,
                    "status": "SUCCESS",
                    "current_step": "正在重装"
                },
                "plugin_status": [
                    {
                        "name": "basereport",
                        "status": "RUNNING",
                        "version": "10.12.76",
                        "host_id": 1
                    }
                ],
                "operate_permission": true
            }
        ]
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

| 字段    | 类型           | <div style="width: 50pt">必选</div> | 描述               |
| ----- | ------------ | --------------------------------- | ---------------- |
| total | int          | 否                                 | 主机总数             |
| list  | array | 否                                 | 汇总后的主机信息，见list定义 |

##### list

| 字段                 | 类型           | <div style="width: 50pt">必选</div> | 描述                                               |
| ------------------ | ------------ | --------------------------------- | ------------------------------------------------ |
| bk_cloud_id        | int          | 是                                 | 云区域ID                                            |
| bk_biz_id          | int          | 是                                 | 业务ID                                             |
| bk_host_id         | int          | 是                                 | 主机ID                                             |
| bk_host_name       | string       | 是                                 | 主机名                                              |
| bk_addressing      | int          | 是                                 | 寻址方式，1: 0，静态 2: 1，动态                             |
| node_type          | string       | 是                                 | 节点类型，1: Agent, 2: Proxy, 3: Pagent               |
| os_type            | string       | 是                                 | 操作系统，1：LINUX 2：WINDOWS 3：AIX 4：SOLARIS           |
| inner_ip           | string       | 是                                 | 内网IPv4地址                                         |
| inner_ipv6         | string       | 否                                 | 内网IPv6地址                                         |
| cpu_arch           | string       | 否                                 | CPU类型，1：x86 2：x86_64 3：powerpc 4：aarch64 5：sparc |
| status             | string       | 是                                 | 主机Agent状态，见status定义                              |
| status_display     | string       | 否                                 | 运行执行状态名称，见status定义                               |
| bk_cloud_name      | string       | 否                                 | 云区域名称                                            |
| bk_biz_name        | string       | 否                                 | 业务名称                                             |
| job_result         | object       | 否                                 | 执行任务结果，见job_result定义                             |
| plugin_status      | array | 否                                 | 插件状态，见plugin_status定义                            |
| operate_permission | bool         | 否                                 | 是否具有操作权限                                         |

##### plugin_status

| 字段      | 类型     | <div style="width: 50pt">必选</div> | 描述             |
| ------- | ------ | --------------------------------- | -------------- |
| name    | string | 是                                 | 插件名称           |
| status  | int    | 是                                 | 插件状态，见status定义 |
| version | string | 是                                 | 插件版本           |
| host_id | int    | 是                                 | 主机ID           |

##### job_result

| 字段           | 类型     | <div style="width: 50pt">必选</div> | 描述                  |
| ------------ | ------ | --------------------------------- | ------------------- |
| instance_id  | string | 否                                 | 实例ID，见instance_id定义 |
| job_id       | int    | 否                                 | 作业ID                |
| status       | string | 否                                 | 执行状态，见job_status定义  |
| current_step | string | 否                                 | 当前步骤名称              |

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

###### job_status

| 状态类型    | 类型     | 描述   |
| ------- | ------ | ---- |
| RUNNING | string | 运行中  |
| QUEUE   | string | 队列中  |
| PENDING | string | 等待执行 |
| FAILED  | string | 失败   |
| SUCCESS | string | 成功   |

###### instance_id

 由scope内的主机实例信息转换而来，由以下字段拼接，规则：{object_type}|{node_type}|{type}|{id}，示例：1: host|instance|host|1, 2: host|instance|host|127.0.0.1-1-0

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述                                                                                  |
| ----------- | ------ | --------------------------------- | ----------------------------------------------------------------------------------- |
| object_type | string | 是                                 | 对象类型，1：host，主机类型  2：service，服务类型                                                    |
| node_type   | string | 是                                 | 节点类别，1: topo，动态实例（拓扑）2: instance，静态实例 3: service_template，服务模板 4: set_template，集群模板 |
| type        | string | 是                                 | 服务类型，1: host 主机 2: bk_obj_id 模板ID                                                   |
| id          | string | 是                                 | 服务实例ID，1： 根据ip，bk_cloud_id，bk_supplier_id和分隔符”-“生成key  2: bk_host_id, 主机Host-ID     |
