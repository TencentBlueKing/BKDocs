### 功能描述

安装作业任务, 新安装Agent、新安装Proxy、重装、替换等操作

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段                        | 类型     | <div style="width: 50pt">必选</div> | 描述                  |
| ------------------------- | ------ | --------------------------------- | ------------------- |
| job_type                  | string | 是                                 | 任务类型，见job_type定义    |
| hosts                     | array  | 是                                 | 主机列表，见hosts定义       |
| replace_host_id           | int    | 否                                 | 被替换的Proxy主机ID       |
| is_install_latest_plugins | bool   | 否                                 | 是否安装最新版本插件，默认安装最新插件 |

##### hosts

| 字段                             | 类型     | <div style="width: 50pt">必选</div> | 描述                                                      |
| ------------------------------ | ------ | --------------------------------- | ------------------------------------------------------- |
| bk_biz_id                      | int    | 是                                 | 业务ID                                                    |
| bk_cloud_id                    | int    | 是                                 | 云区域ID                                                   |
| bk_host_id                     | int    | 否                                 | 主机ID                                                    |
| bk_addressing                  | int    | 否                                 | 寻址方式，1: 0，静态 2: 1，动态                                    |
| ap_id                          | int    | 否                                 | 接入点ID                                                   |
| install_channel_id             | int    | 否                                 | 安装通道ID                                                  |
| inner_ip                       | string | 否                                 | 内网IPV4地址，inner_ip和inner_ipv6必选其一                        |
| outer_ip                       | string | 否                                 | 外网IP                                                    |
| login_ip                       | string | 否                                 | 登录IP                                                    |
| data_ip                        | string | 否                                 | 数据IP                                                    |
| inner_ipv6                     | string | 否                                 | 内网IPv6                                                  |
| outer_ipv6                     | string | 否                                 | 外网IPv6                                                  |
| os_type                        | string | 否                                 | 操作系统，1：LINUX 2：WINDOWS 3：AIX 4：SOLARIS                  |
| auth_type                      | string | 否                                 | 认证类型，1：PASSWORD，密码认证 2: KEY，秘钥认证 3：TJJ_PASSWORD，默认为密码认证 |
| account                        | string | 否                                 | 账户                                                      |
| password                       | string | 否                                 | 密码                                                      |
| port                           | string | 否                                 | 端口                                                      |
| key                            | string | 否                                 | 密钥                                                      |
| is_manual                      | bool   | 否                                 | 是否手动模式                                                  |
| retention                      | int    | 否                                 | 密码保留天数，默认保留一天                                           |
| peer_exchange_switch_for_agent | bool   | 否                                 | 加速设置，默认为True                                            |
| bt_speed_limit                 | string | 否                                 | 传输限速                                                    |
| data_path                      | string | 否                                 | 数据文件路径                                                  |

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

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "job_type": "INSTALL_AGENT",
    "hosts": [
        {
            "bk_cloud_id": 0,
            "ap_id": 1,
            "bk_biz_id": 2,
            "os_type": "LINUX",
            "inner_ip": "127.0.0.1",
            "outer_ip": "127.0.0.2",
            "login_ip": "127.0.0.3",
            "data_ip": "127.0.0.4",
            "account": "root",
            "port": 22,
            "auth_type": "PASSWORD",
            "password": "password",
            "key": "key",
            "retention": 1
        },
        {
            "bk_cloud_id": 2,
            "ap_id": 1,
            "bk_biz_id": 2,
            "os_type": "LINUX",
            "inner_ip": "127.0.0.1",
            "outer_ip": "127.0.0.2",
            "login_ip": "127.0.0.3",
            "data_ip": "127.0.0.4",
            "account": "root",
            "port": 22,
            "auth_type": "PASSWORD",
            "password": "password",
            "key": "key",
            "retention": 1
        }
    ]
}
```

### 返回结果示例

```json
{
  "result": false,
  "code": 3801013,
  "data": {
    "job_id": "",
    "ip_filter": [
      {
        "bk_biz_id": 2,
        "bk_biz_name": "蓝鲸",
        "ip": "127.0.0.1",
        "inner_ip": "127.0.0.1",
        "inner_ipv6": null,
        "bk_host_id": null,
        "bk_cloud_name": "1",
        "bk_cloud_id": 2,
        "status": "IGNORED",
        "job_id": "",
        "exception": "no_proxy",
        "msg": "该云区域下不存在代理"
      }
    ]
  },
  "message": "不存在可用代理（3801013）",
  "errors": null
}
```

### 返回结果参数说明

#### response

| 字段      | 类型     | 描述                         |
| ------- | ------ | -------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
| code    | int    | 错误编码。 0表示success，>0表示失败错误  |
| message | string | 请求失败返回的错误信息                |
| data    | array  | 请求返回的数据，见data定义            |

#### data

| 字段        | 类型    | 描述                     |
| --------- | ----- | ---------------------- |
| job_id    | int   | 任务ID                   |
| ip_filter | array | 过滤失败的主机信息，见ip_filter定义 |

##### ip_filter

| 字段            | 类型     | 描述             |
| ------------- | ------ | -------------- |
| bk_biz_id     | int    | 主机业务ID         |
| bk_biz_name   | string | 主机业务名称         |
| ip            | string | IP地址           |
| inner_ip      | string | 内网IPV4地址       |
| inner_ipv6    | string | 内网IPV6地址       |
| bk_host_id    | int    | 主机ID           |
| bk_cloud_name | string | 云区域名称          |
| bk_cloud_id   | int    | 云区域ID          |
| status        | string | 执行状态，见status定义 |
| job_id        | int    | 作业ID           |
| exception     | string | 过滤原因           |
| msg           | string | 失败的具体信息        |

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
