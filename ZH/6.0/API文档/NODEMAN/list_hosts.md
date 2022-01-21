### 功能描述

查询主机列表

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| bk_biz_id | list | 否 | 业务 ID |
| bk_host_id | list | 否 | 主机 ID |
| condition | list | 否 | 搜索条件，支持 os_type, ip, status <br> version, bk_cloud_id, node_from 和 模糊搜索 query |
| exclude_hosts | list | 否 | 跨页全选排除主机 |
| extra_data | list | 否 | 额外信息, 如 ['identity_info', 'job_result', 'topology'] |
| page | int | 否 | 当前页数 |
| pagesize | int | 否 | 分页大小 |
| only_ip | bool | 否 | 只返回 IP |
| running_count | bool | 否 | 返回正在运行机器数量 |
| conditions | list | 否 | 返回正在运行机器数量 |

### 请求参数示例
```plain
{
		"bk_host_id": [1],
		"only_ip": true,
    "page":1,
    "pagesize":50,
    "extra_data":[
        "job_result",
        "identity_info"
    ],
    "conditions":[
        {
            "key":"inner_ip",
            "value":[
                "127.0.0.1"
            ]
        },
        {
            "key":"status",
            "value":[
                "TERMINATED"
            ]
        },
        {
            "key":"os_type",
            "value":[
                "LINUX"
            ]
        },
        {
            "key":"is_manual",
            "value":[
                1
            ]
        },
        {
            "key":"bk_cloud_id",
            "value":[
                0
            ]
        },
        {
            "key":"version",
            "value":[
                "1.6.15"
            ]
        },
        {
            "key":"topology",
            "value":{
                "bk_biz_id":5,
                "bk_set_ids":[
                    5
                ],
                "bk_module_ids":[
                    13
                ]
            }
        }
    ],
    "bk_biz_id":[
        5
    ]
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": {
        "total": 1,
        "list": [
            {
                "bk_host_id": 7124,
                "updated_at": "2021-02-24 15:24:15+0800",
                "bk_cloud_name": "直连区域",
                "bk_biz_name": "节点管理测试用",
                "operate_permission": true,
                "identity_info": {
                    "auth_type": "PASSWORD",
                    "account": "root",
                    "re_certification": true,
                    "port": 22
                },
                "version": "",
                "inner_ip": "127.0.0.1",
                "extra_data": {
                    "bt_speed_limit": null,
                    "peer_exchange_switch_for_agent": 1
                },
                "status": "TERMINATED",
                "bk_cloud_id": 0,
                "login_ip": "127.0.0.1",
                "topology": [
                    "节点管理测试用 / 空闲机池 / 空闲机"
                ],
                "bk_biz_id": 5,
                "created_at": "2021-02-23 14:43:43+0800",
                "outer_ip": "",
                "ap_id": 1,
                "data_ip": "",
                "is_manual": true,
                "os_type": "LINUX",
                "status_display": "异常",
                "job_result": {
                    "instance_id": "host|instance|host|127.0.0.1-0-0",
                    "status": "FAILED",
                    "job_id": 291,
                    "current_step": "正在手动安装"
                }
            }
        ]
    },
    "result": true,
    "request_id": "a339b4efba3a4b5489f06fa68b32f514"
}
```
