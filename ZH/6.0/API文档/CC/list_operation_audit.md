### 功能描述

根据条件获取操作审计日志

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型      | 必选   |  描述                       |
|---------------------|------------|--------|-----------------------------|
| page                | object     | 是     | 分页参数                    |
| condition           | object     | 否     | 操作审计日志查询条件                   |

#### page

| 字段      |  类型      | 必选   |  描述                |
|-----------|------------|--------|----------------------|
| start     |  int       | 否     | 记录开始位置         |
| limit     |  int       | 是     | 每页限制条数,最大 200 |
| sort      |  string    | 否     | 排序字段             |

#### condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id     |int      |否      | 业务 id                                               |
| resource_type  |string      |否      | 操作的具体资源类型 |
| action     |    array  |  否    |  操作类型 |
|   operation_time   |    object  |  是    | 操作时间 |
|   user   |    string  |  否    | 操作人 |
|    resource_name  |    string  |  否    | 资源名称 |
|    category  |    string  |  否    | 查询的类型 |
| fuzzy_query    | bool         | 否   | 是否使用模糊查询对资源名称进行查询，**模糊查询效率低，性能差** |
| condition | array | 否 | 指定查询条件，与 user 和 resource_name 不能同时提供 |

##### condition.condition

| 字段     | 类型         | 必选 | 描述                                                         |
| -------- | ------------ | ---- | ------------------------------------------------------------ |
| field    | string       | 是   | 对象的字段，仅为"user"，"resource_name"                      |
| operator | string       | 是   | 操作符，$in 为属于，$nin 为不属于，$regex 为包含，$regex 仅允许 resource_name 使用 |
| value    | string/array | 是   | 字段对应的值，$in 和$nin 需要 array 类型，$regex 需要 string 类型   |

### 请求参数示例

```json
{
    "condition":{
        "bk_biz_id":2,
        "resource_type":"host",
        "action":[
            "create",
            "delete"
        ],
        "operation_time":{
            "start":"2020-09-23 00:00:00",
            "end":"2020-11-01 23:59:59"
        },
        "user":"admin",
        "resource_name":"1.1.1.1",
        "category":"host",
        "fuzzy_query": false
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":"-operation_time"
    }
}
```

```json
{
    "condition":{
        "bk_biz_id":2,
        "resource_type":"host",
        "action":[
            "create",
            "delete"
        ],
        "operation_time":{
            "start":"2020-09-23 00:00:00",
            "end":"2020-11-01 23:59:59"
        },
      	"condition":[
          {
            "field":"user",
            "operatior":"$in",
            "value":"admin"
          },
          {
            "field":"resource_name",
            "operatior":"$in",
            "value":"1.1.1.1"
          }
        ],
        "category":"host"
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":"-operation_time"
    }
}
```

### 返回结果示例

```json
{
    "result":true,
    "bk_error_code":0,
    "bk_error_msg":"success",
    "permission":null,
    "data":{
        "count":2,
        "info":[
            {
                "id":7,
                "audit_type":"",
                "bk_supplier_account":"",
                "user":"admin",
                "resource_type":"host",
                "action":"delete",
                "operate_from":"",
                "operation_detail":null,
                "operation_time":"2020-10-09 21:30:51",
                "bk_biz_id":1,
                "resource_id":4,
                "resource_name":"2.2.2.2"
            },
            {
                "id":2,
                "audit_type":"",
                "bk_supplier_account":"",
                "user":"admin",
                "resource_type":"host",
                "action":"delete",
                "operate_from":"",
                "operation_detail":null,
                "operation_time":"2020-10-09 17:13:55",
                "bk_biz_id":1,
                "resource_id":1,
                "resource_name":"1.1.1.1"
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述         |
|-----------|-----------|--------------|
| count     | int       | 记录条数     |
| info      | array     | 操作审计的记录信息 |
