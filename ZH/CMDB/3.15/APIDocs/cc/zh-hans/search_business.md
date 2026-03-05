
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_business/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询业务

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| fields         |  array   | 否     | 指定查询的字段，参数为业务的任意属性，如果不填写字段信息，系统会返回业务的所有字段 |
| condition      |  dict    | 否     | 查询条件，参数为业务的任意属性，如果不写代表搜索全部数据，(历史遗留字段，请勿继续使用，请用 biz_property_filter) |
| biz_property_filter| object| 否| 业务属性组合查询条件 |
| page           |  dict    | 否     | 分页条件 |

Note: 业务分为两类，未归档的业务和已归档的业务。
- 若要查询已归档的业务，请在 condition 中增加条件`bk_data_status:disabled`。
- 若要查询未归档的业务，请不要带字段"bk_data_status",或者在 condition 中增条件`bk_data_status: {"$ne":disabled"}`。
- `biz_property_filter`与`condition`两个参数只能有一个生效，参数`condition`不建议继续使用。
- 参数`biz_property_filter` 中涉及到的数组类元素个数不超过 500 个。参数`biz_property_filter`中涉及到的`rules`数量不超过 20 个。参数`biz_property_filter`
的嵌套层级不超过 3 层。

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大 200 |
| sort     |  string | 否     | 排序字段，通过在字段前面增加 -，如 sort:&#34;-field&#34; 可以表示按照字段 field 降序 |

### 请求参数示例

```python
{
    "bk_app_code":"esb_test",
    "bk_app_secret":"xxx",
    "bk_username": "xxx",
    "bk_token":"xxx",
    "bk_supplier_account":"123456789",
    "fields":[
        "bk_biz_id",
        "bk_biz_name"
    ],
    "biz_property_filter":{
        "condition":"AND",
        "rules":[
            {
                "field":"bk_biz_maintainer",
                "operator":"equal",
                "value":"admin"
            },
            {
                "condition":"OR",
                "rules":[
                    {
                        "field":"bk_biz_name",
                        "operator":"in",
                        "value":[
                            "test"
                        ]
                    },
                    {
                        "field":"bk_biz_id",
                        "operator":"equal",
                        "value":1
                    }
                ]
            }
        ]
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":""
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 1,
        "info": [
            {
                "bk_biz_id": 1,
                "bk_biz_name": "esb-test",
                "default": 0
            }
        ]
    }
}
```

### 返回结果参数说明
#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| data    | object | 请求返回的数据                           |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int       | 记录条数 |
| info      | array     | 业务实际数据 |

#### info
| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_biz_id     | int       | 业务 id |
| bk_biz_name     | string       | 业务名称 |
|default | int | 表示业务类型 |