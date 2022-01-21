### 功能描述

点分五位查询进程实例的相关信息 (v3.9.13)

- 该接口专供 GSEKit 使用，在 ESB 文档中为 hidden 状态

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

|字段|类型|必填|描述|
|---|---|---|---|
| bk_biz_id  | int64       | Yes      | 业务 ID |
|bk_set_ids|int64 array|No|集群 ID 列表，若为空，则代表任意一集群|
|bk_module_ids|int64 array|No|模块 ID 列表，若为空，则代表任意一模块|
|ids|int64 array|No|服务实例 ID 列表，若为空，则代表任意一实例||
|bk_process_names|string array|No|进程名称列表，若为空，则代表任意一进程。`该字段与bk_func_id互斥，二者只能选其一，不能同时有值`|
|bk_func_ids|string array|No|进程的功能 ID 列表，若为空，则代表任一进程。`bk_process_name，二者只能选其一，不能同时有值`|
|bk_process_ids|int64 array|No|进程 ID 列表，若为空，则代表任一进程|
|fields|string array|No|进程属性列表，控制返回结果的进程实例信息里有哪些字段，能够加速接口请求和减少网络流量传输<br>为空时返回进程所有字段,bk_process_id,bk_process_name,bk_func_id 为必返回字段|
|page|dict|Yes|分页条件|

这些字段的条件关系是关系与(&amp;&amp;)，只会查询同时满足所填条件的进程实例<br>
举例来说：如果同时填了 bk_set_ids 和 bk_module_ids，而 bk_module_ids 都不属于 bk_set_ids，则查询结果为空

#### page

| 字段  | 类型 |必选| 描述 |
| ---  | ---  | ---  | --- |
| start|int|No|记录开始位置，默认为 0 |
| limit|int|Yes|每页限制条数,最大 500 |
| sort  | string | 否   | 排序字段，'-'表示倒序, 只能是进程的字段，默认按 bk_process_id 排序 |


### 请求参数示例

``` json
{
    "set": {
        "bk_set_ids": [
            11,
            12
        ]
    },
    "module": {
        "bk_module_ids": [
            60,
            61
        ]
    },
    "service_instance": {
        "ids": [
            4,
            5
        ]
    },
    "process": {
        "bk_process_names": [
            "pr1",
            "alias_pr2"
        ],
        "bk_func_ids": [],
        "bk_process_ids": [
            45,
            46,
            47
        ]
    },
    "fields": [
        "bk_process_id",
        "bk_process_name",
        "bk_func_id",
        "bk_func_name"
    ],
    "page": {
        "start": 0,
        "limit": 100,
        "sort": "bk_process_id"
    }
}
```

### 返回结果示例
``` json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "count": 2,
        "info": [
            {
                "set": {
                    "bk_set_id": 11,
                    "bk_set_name": "set1",
                    "bk_set_env": "3"
                },
                "module": {
                    "bk_module_id": 60,
                    "bk_module_name": "mm1"
                },
                "host": {
                    "bk_host_id": 4,
                    "bk_cloud_id": 0,
                    "bk_host_innerip": "192.168.15.22"
                },
                "service_instance": {
                    "id": 4,
                    "name": "192.168.15.22_pr1_3333"
                },
                "process_template": {
                    "id": 48
                },
                "process": {
                    "bk_func_id": "",
                    "bk_func_name": "pr1",
                    "bk_process_id": 45,
                    "bk_process_name": "pr1"
                }
            },
            {
                "set": {
                    "bk_set_id": 11,
                    "bk_set_name": "set1",
                    "bk_set_env": "3"
                },
                "module": {
                    "bk_module_id": 60,
                    "bk_module_name": "mm1"
                },
                "host": {
                    "bk_host_id": 4,
                    "bk_cloud_id": 0,
                    "bk_host_innerip": "192.168.15.22"
                },
                "service_instance": {
                    "id": 4,
                    "name": "192.168.15.22_pr1_3333"
                },
                "process_template": {
                    "id": 49
                },
                "process": {
                    "bk_func_id": "",
                    "bk_func_name": "pr2",
                    "bk_process_id": 46,
                    "bk_process_name": "alias_pr2"
                }
            }
        ]
    }
}
```

### 返回结果参数说明

| 名称  | 类型  | 描述 |
|---|---|--- |
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |

- data 字段说明

| 名称  | 类型  | 描述 |
|---|---|--- |
|count|int|符合条件的进程实例总数量|
|set|object|进程所属的集群信息|
|module|object|进程所属的模块信息|
|host|object|进程所属的主机信息|
|service_instance|object|进程所属的服务实例信息|
|process|object|进程自身的详细信息|
