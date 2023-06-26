
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/count_object_instances/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

通用模型实例数量查询 (v3.10.1+)

### 请求参数



#### 接口参数

|    字段    |  类型  | 必选 | 描述                                                                                                            |
|------------|--------|------|-----------------------------------------------------------------------------------------------------------------|
| bk_obj_id  | string |  是  | 模型 ID                                                                                                          |
| conditions | object |  否  | 组合查询条件,  组合支持 AND 和 OR 两种方式，可以嵌套，最多嵌套 3 层, 每层 OR 条件最大支持 20 个, 不指定该参数表示匹配全部(即 conditions 为 null) |
| time_condition      | object     | 否     | 按时间查询模型实例的查询条件 |

#### conditions

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| condition |  string  | 是    | 规则操作符|
| rules |  array  | 是     | 所选业务的范围条件规则 |

#### conditions.rules

|   字段   |  类型  | 必选 |  描述                                                                                                     |
|----------|--------|------|-----------------------------------------------------------------------------------------------------------|
| field    | string |  是  | 条件字段                                                                                                  |
| operator | string |  是  | 操作符, 可选值 equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between 等|
| value    |   -    |  否  | 条件字段期望的值, 不同的 operator 对应不同的 value 格式, 数组类型值最大支持 500 个元素                          |

组装规则详细可参考: https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md

#### time_condition

| 字段   | 类型   | 必选 |  描述              |
|-------|--------|-----|--------------------|
| oper  | string | 是  | 操作符，目前只支持 and |
| rules | array  | 是  | 时间查询条件         |

#### time_condition.rules

| 字段   | 类型   | 必选 | 描述                             |
|-------|--------|-----|----------------------------------|
| field | string | 是  | 取值为模型的字段名                  |
| start | string | 是  | 起始时间，格式为 yyyy-MM-dd hh:mm:ss |
| end   | string | 是  | 结束时间，格式为 yyyy-MM-dd hh:mm:ss |  

### 请求参数示例

```json
{
    "bk_app_code":"code",
    "bk_app_secret":"secret",
    "bk_username": "xxx",
    "bk_token":"xxxx",
    "bk_obj_id":"bk_switch",
    "conditions":{
        "condition": "AND",
        "rules": [
            {
                "field": "bk_inst_name",
                "operator": "equal",
                "value": "switch"
            },
            {
                "condition": "OR",
                "rules": [
                    {
                         "field": "bk_inst_id",
                         "operator": "not_in",
                         "value": [2,4,6]
                    },
                    {
                        "field": "bk_inst_id",
                        "operator": "equal",
                        "value": 3
                    }
                ]
            }
        ]
    },
    "time_condition": {
        "oper": "and",
        "rules": [
            {
                "field": "create_time",
                "start": "2021-05-13 01:00:00",
                "end": "2021-05-14 01:00:00"
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
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 1
    }
}
```

### 返回结果参数

#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                           |

#### data

| 字段  |   类型  | 描述                       |
|-------|---------|----------------------------|
| count | int | 返回满足条件的实例数据数量 |