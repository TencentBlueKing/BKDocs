### 功能描述

查询主机列表

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段            | 类型           | <div style="width: 50pt">必选</div> | 描述                 |
| ------------- | ------------ | --------------------------------- | ------------------ |
| bk_biz_id     | int array    | 否                                 | 业务ID               |
| bk_host_id    | int array    | 否                                 | 主机ID               |
| bk_cloud_id   | int array    | 否                                 | 云区域ID              |
| version       | string array | 否                                 | Agent版本            |
| exclude_hosts | int array    | 否                                 | 跨页全选排除主机           |
| conditions    | array | 否                                 | 搜索条件，见conditions定义 |
| extra_data    | string array | 否                                 | 展示额外信息             |
| page          | int          | 否                                 | 当前页数，默认为1          |
| pagesize      | int          | 否                                 | 分页大小，默认为10         |
| only_ip       | bool         | 否                                 | 只返回IP，不返回其他字段      |
| running_count | bool         | 否                                 | 是否只返回运行状态统计        |

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

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "bk_host_id": [
        1,
        2,
        3
    ],
    "conditions": [
         {
             "key": "inner_ip",
             "value": ["127.0.0.1"]
         }
     ],
    "extra_data": [
        "job_result"
    ],
    "pagesize": 20,
    "page": 1,
    "only_ip": false,
    "running_count": false
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
        "status": "RUNNING",
        "version": "1.7.15",
        "bk_cloud_id": 0,
        "bk_biz_id": 2,
        "bk_host_id": 2,
        "bk_host_name": "",
        "bk_addressing": "0",
        "os_type": "LINUX",
        "inner_ip": "127.0.0.1",
        "inner_ipv6": "",
        "outer_ip": "",
        "outer_ipv6": "",
        "ap_id": 1,
        "install_channel_id": null,
        "login_ip": "",
        "data_ip": "",
        "created_at": "2022-07-12 18:58:36+0800",
        "updated_at": "2022-07-12 18:58:36+0800",
        "is_manual": true,
        "extra_data": {
          "bt_speed_limit": null,
          "peer_exchange_switch_for_agent": 1
        },
        "status_display": "正常",
        "bk_cloud_name": "直连区域",
        "install_channel_name": null,
        "bk_biz_name": "蓝鲸",
        "identity_info": {},
        "job_result": {
          "instance_id": "host|instance|host|2",
          "job_id": 1656,
          "status": "FAILED",
          "current_step": "正在重装"
        },
        "topology": [
          "蓝鲸 / 中控机 / controller_ip",
          "蓝鲸 / 公共组件 / consul",
          "蓝鲸 / 公共组件 / redis",
          "蓝鲸 / 公共组件 / rabbitmq",
          "蓝鲸 / 公共组件 / beanstalk",
          "蓝鲸 / 管控平台 / license",
          "蓝鲸 / 监控平台v3 / monitor"
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

| 字段                  | 类型           | <div style="width: 50pt">必选</div> | 描述                           |
| ------------------- | ------------ | --------------------------------- | ---------------------------- |
| total               | int          | 否                                 | 主机总数                         |
| list                | array | 否                                 | 汇总后的主机信息，见list定义             |
| running_count       | int          | 否                                 | 正在运行机器的数量                    |
| no_permission_count | int          | 否                                 | 没有操作权限的主机数量                  |
| manual_statistics   | array | 否                                 | 手动安装主机统计，true 为手动安装，false则不是 |

##### list

| 字段                   | 类型           | <div style="width: 50pt">必选</div> | 描述                                     |
| -------------------- | ------------ | --------------------------------- | -------------------------------------- |
| bk_cloud_id          | int          | 是                                 | 云区域ID                                  |
| bk_biz_id            | int          | 是                                 | 业务ID                                   |
| bk_host_id           | int          | 是                                 | 主机ID                                   |
| bk_host_name         | string       | 是                                 | 主机名                                    |
| bk_addressing        | int          | 是                                 | 寻址方式，1: 0，静态 2: 1，动态                   |
| os_type              | string       | 是                                 | 操作系统，1：LINUX 2：WINDOWS 3：AIX 4：SOLARIS |
| inner_ip             | string       | 是                                 | 内网IPv4地址                               |
| inner_ipv6           | string       | 否                                 | 内网IPv6地址                               |
| outer_ip             | string       | 否                                 | 外网IPv4地址                               |
| outer_ipv6           | string       | 否                                 | 外网IPv6地址                               |
| ap_id                | int          | 是                                 | 接入点ID                                  |
| install_channel_id   | int          | 否                                 | 安装通道ID                                 |
| login_ip             | string       | 是                                 | 登录IP                                   |
| data_ip              | string       | 是                                 | 数据IP                                   |
| status               | string       | 是                                 | 运行状态，见status定义                         |
| version              | string       | 是                                 | Agent版本                                |
| created_at           | string       | 是                                 | 创建时间                                   |
| updated_at           | string       | 是                                 | 更新时间                                   |
| is_manual            | bool         | 是                                 | 是否手动模式                                 |
| extra_data           | string array | 是                                 | 额外信息，见extra_data定义                     |
| status_display       | string       | 否                                 | 运行执行状态名称，见status定义                     |
| bk_cloud_name        | string       | 否                                 | 云区域名称                                  |
| install_channel_name | string       | 否                                 | 安装通道名称                                 |
| bk_biz_name          | string       | 否                                 | 业务名称                                   |
| identity_info        | object       | 否                                 | 鉴权信息                                   |
| job_result           | object       | 否                                 | 执行任务结果，见job_result定义                   |
| topology             | string array | 否                                 | 拓扑信息                                   |
| operate_permission   | bool         | 否                                 | 是否具有操作权限                               |

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

##### extra_data

| 字段                             | 类型  | <div style="width: 50pt">必选</div> | 描述                 |
| ------------------------------ | --- | --------------------------------- | ------------------ |
| bt_speed_limit                 | int | 否                                 | bt传输限制速度值，单位M/s    |
| peer_exchange_switch_for_agent | int | 否                                 | bt传输开关，1: 开启 0: 关闭 |

##### job_result

| 字段           | 类型     | <div style="width: 50pt">必选</div> | 描述                 |
| ------------ | ------ | --------------------------------- | ------------------ |
| instance_id  | string | 否                                 | 实例ID               |
| job_id       | int    | 否                                 | 作业ID               |
| status       | string | 否                                 | 执行状态，见job_status定义 |
| current_step | string | 否                                 | 当前步骤名称             |

##### job_status

| 状态类型    | 类型     | 描述   |
| ------- | ------ | ---- |
| RUNNING | string | 运行中  |
| QUEUE   | string | 队列中  |
| PENDING | string | 等待执行 |
| FAILED  | string | 失败   |
| SUCCESS | string | 成功   |
