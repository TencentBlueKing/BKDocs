
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/list_biz_hosts/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据业务 ID 查询业务下的主机，可附带其他的过滤信息，如集群 id,模块 id 等

### 请求参数



#### 接口参数

| 字段                 | 类型   | 必选 | 描述                                                         |
| -------------------- | ------ | ---- | ------------------------------------------------------------ |
| page                 | object   | 是   | 查询条件                                                     |
| bk_biz_id            | int    | 是   | 业务 id                                                       |
| bk_set_ids           | array  | 否   | 集群 ID 列表，最多 200 条 **bk_set_ids 和 set_cond 只能使用其中一个** |
| set_cond             | array  | 否   | 集群查询条件 **bk_set_ids 和 set_cond 只能使用其中一个**        |
| bk_module_ids        | array  | 否   | 模块 ID 列表，最多 500 条 **bk_module_ids 和 module_cond 只能使用其中一个** |
| module_cond          | array  | 否   | 模块查询条件 **bk_module_ids 和 module_cond 只能使用其中一个**  |
| host_property_filter | object | 否   | 主机属性组合查询条件                                         |
| fields               | array  | 是   | 主机属性列表，控制返回结果的主机里有哪些字段，能够加速接口请求和减少网络流量传输 |

#### host_property_filter
该参数为主机属性字段过滤规则的组合，用于根据主机属性字段搜索主机。组合支持 AND 和 OR 两种方式，可以嵌套，最多嵌套 2 层。
过滤规则为四元组 `field`, `operator`, `value`

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| condition       |  string    | 否     |  组合查询条件|
| rules      |  array    | 否     | 规则 |


#### rules
| 名称     | 类型   | 必填 | 默认值 | 说明   | Description                                                  |
| -------- | ------ | ---- | ------ | ------ | ------------------------------------------------------------ |
| field    | string | 是   | 无     | 字段名 |         字段名                                                     |
| operator | string | 是   | 无     | 操作符 | 可选值 equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between |
| value    | -      | 否   | 无     | 操作数 | 不同的 operator 对应不同的 value 格式                            |

组装规则可参考: <https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md>

#### set_cond
| 字段     | 类型   | 必选 | 描述                          |
| -------- | ------ | ---- | ----------------------------- |
| field    | string | 是   | 取值为集群的字段              |
| operator | string | 是   | 取值为：$eq $ne               |
| value    | string | 是   | field 配置的集群字段所对应的值 |

#### module_cond
| 字段     | 类型   | 必选 | 描述                          |
| -------- | ------ | ---- | ----------------------------- |
| field    | string | 是   | 取值为模块的字段              |
| operator | string | 是   | 取值为：$eq $ne               |
| value    | string | 是   | field 配置的模块字段所对应的值 |

#### page

| 字段  | 类型   | 必选 | 描述                 |
| ----- | ------ | ---- | -------------------- |
| start | int    | 是   | 记录开始位置         |
| limit | int    | 是   | 每页限制条数,最大 500 |
| sort  | string | 否   | 排序字段             |



### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "0",
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_host_id"
    },
    "set_cond": [
        {
            "field": "bk_set_name",
            "operator": "$eq",
            "value": "set1"
        }
    ],
    "bk_biz_id": 3,
    "bk_module_ids": [54,56],
    "fields": [
        "bk_host_id",
        "bk_cloud_id",
        "bk_host_innerip",
        "bk_os_type",
        "bk_mac"
    ],
    "host_property_filter": {
        "condition": "AND",
        "rules": [
            {
                "field": "bk_host_innerip",
                "operator": "equal",
                "value": "127.0.0.1"
            },
            {
                "condition": "OR",
                "rules": [
                    {
                        "field": "bk_os_type",
                        "operator": "not_in",
                        "value": [
                            "3"
                        ]
                    },
                    {
                        "field": "bk_cloud_id",
                        "operator": "equal",
                        "value": 0
                    }
                ]
            }
        ]
    }
}
```

### 返回结果示例

```json
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "request_id": "e43da4ef221746868dc4c837d36f3807",
  "data": {
    "count": 2,
    "info": [
      {
        "bk_cloud_id": 0,
        "bk_host_id": 1,
        "bk_host_innerip": "192.168.15.18",
        "bk_mac": "",
        "bk_os_type": null
      },
      {
        "bk_cloud_id": 0,
        "bk_host_id": 2,
        "bk_host_innerip": "192.168.15.4",
        "bk_mac": "",
        "bk_os_type": null
      }
    ]
  }
}
```

### 返回结果参数说明
#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data | object | 请求返回的数据 |

#### data

| 字段  | 类型  | 描述         |
| ----- | ----- | ------------ |
| count | int   | 记录条数     |
| info  | array | 主机实际数据 |

#### data.info
| 名称             | 类型   | 说明          | Description                     |
| ---------------- | ------ | ------------- | -------------------------------  |
| bk_os_type       | string | 操作系统类型  | 1:Linux;2:Windows;3:AIX         |                            |
| bk_mac           | string | 内网 MAC 地址   |                                 |                               |                              |
| bk_host_innerip  | string | 内网 IP        |                                 |
| bk_host_id       | int    | 主机 ID        |                                 |
| bk_cloud_id      | int    | 云区域        |                                 |