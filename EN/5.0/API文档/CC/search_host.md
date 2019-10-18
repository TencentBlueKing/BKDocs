
### 请求地址

/api/c/compapi/v2/cc/search_host/



### 请求方法

POST


### 功能描述

根据条件查询主机

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id  |  int     | 否     | 业务ID |
| ip         |  dict    | 否     | 主机ip列表 |
| condition  |  array   | 否     | 组合条件 |
| page       |  dict    | 否     | 查询条件 |
| pattern    |  string  | 否     | 按表达式搜索 |

#### ip

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| data      |  array    | 否     | ip 数组 |
| exact     |  int      | 否     | 是否根据ip精确搜索 |
| flag      |  string   | 否     | bk_host_innerip只匹配内网ip,bk_host_outerip只匹配外网ip, bk_host_innerip,bk_host_outerip同时匹配 |

#### condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_obj_id    |  string    | 否     | 对象名,可以为biz,set,module,host,object |
| fields     |  array      | 否     | 查询输出字段 |
| condition     |  array      | 否     | 查询条件 |

#### condition.condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| field     |  string    | 否     | 对象的字段 |
| operator  |  string    | 否     | 操作符, $eq为相等，$neq为不等，$in为属于，$nin为不属于 |
| value     |  string    | 否     | 字段对应的值 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大200 |
| sort     |  string | 否     | 排序字段 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "ip": {
        "data": [],
        "exact": 1,
        "flag": "bk_host_innerip|bk_host_outerip"
    },
    "condition": [
        {
            "bk_obj_id": "host",
            "fields": [],
            "condition": []
        },
        {
            "bk_obj_id":"module",
            "fields":[],
            "condition":[]
        },
        {
            "bk_obj_id":"set",
            "fields":[],
            "condition":[]
        },
        {
            "bk_obj_id":"biz",
            "fields":[],
            "condition":[]
        },
        {
            "bk_obj_id": "object",
            "fields": [],
            "condition": [
                {
                    "field": "bk_inst_id",
                    "operator": "$eq",
                    "value": 76
                }
            ]
        }
    ],
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_host_id"
    },
    "pattern": ""
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "count": 1,
        "info": [
            {
                "host": {
                    "bk_cpu": 8,
                    "bk_os_name": "linux centos",
                    "bk_host_id": 11,
                    "import_from": "",
                    "bk_os_version": "7.2",
                    "bk_disk": 1789,
                    "operator": null,
                    "create_time": "2018-03-22T16:52:53.239+08:00",
                    "bk_mem": 7843,
                    "bk_host_name": "test-1",
                    "bk_host_innerip": "10.0.0.1",
                    "bk_comment": "",
                    "bk_os_bit": "64-bit",
                    "bk_outer_mac": "",
                    "bk_childid": null,
                    "bk_input_from": "agent",
                    "bk_asset_id": "",
                    "bk_service_term": null,
                    "bk_cloud_id": [
                        {
                            "bk_obj_name": "",
                            "id": "0",
                            "bk_obj_id": "plat",
                            "bk_obj_icon": "",
                            "bk_inst_id": 0,
                            "bk_inst_name": "default area"
                        }
                    ],
                    "bk_sla": "",
                    "bk_cpu_mhz": 2534,
                    "bk_host_outerip": "",
                    "bk_os_type": "1",
                    "bk_mac": "00:00:00:00:00:00",
                    "bk_bak_operator": null,
                    "bk_sn": "",
                    "bk_cpu_module": "Intel(R)"
                },
                "set": [
                    {
                        "bk_biz_id": 2,
                        "bk_service_status": "1",
                        "description": "",
                        "bk_set_env": "1",
                        "default": 0,
                        "bk_parent_id": 35,
                        "bk_capacity": null,
                        "bk_set_id": 3,
                        "create_time": "2018-06-06T20:53:53.591+08:00",
                        "bk_supplier_account": "123456789",
                        "bk_set_name": "test",
                        "bk_set_desc": "",
                        "last_time": "2018-06-13T14:20:20.149+08:00"
                    }
                ],
                "biz": [
                    {
                        "bk_biz_id": 2,
                        "language": "1",
                        "life_cycle": "1",
                        "bk_biz_developer": "",
                        "bk_biz_maintainer": "admin",
                        "bk_biz_tester": "admin",
                        "time_zone": "Asia/Shanghai",
                        "default": 0,
                        "create_time": "2018-03-22T15:49:57.319+08:00",
                        "bk_biz_productor": "admin",
                        "bk_supplier_account": "123456789",
                        "operator": "",
                        "bk_biz_name": "test",
                        "last_time": "2018-06-05T15:03:55.699+08:00",
                        "bk_supplier_id": 0
                    }
                ],
                "module": [
                    {
                        "bk_biz_id": 2,
                        "bk_module_id": 38,
                        "default": 0,
                        "bk_bak_operator": "",
                        "create_time": "2018-03-26T16:56:59.486+08:00",
                        "bk_module_name": "test_1",
                        "bk_supplier_account": "123456789",
                        "operator": "admin",
                        "bk_set_id": 3,
                        "bk_parent_id": 3,
                        "last_time": "2018-03-26T16:56:59.486+08:00",
                        "bk_module_type": "1"
                    }
                ]
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int       | 记录条数 |
| info      | array     | 主机实际数据 |

#### data.info

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| biz      | array       | 主机所属的业务信息 |
| set      | array       | 主机所属的集群信息 |
| module   | array       | 主机所属的模块信息 |
| host     | dict        | 主机自身属性 |