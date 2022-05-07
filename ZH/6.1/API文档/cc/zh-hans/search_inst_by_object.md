
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_inst_by_object/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询给定模型的实例信息

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account |  string  | 否     | 开发商账号 |
| bk_obj_id           |  string  | 是     | 自定义模型 ID |
| fields              |  array   | 否     | 指定查询的字段 |
| condition           |  dict    | 否     | 查询条件 |
| page                |  dict    | 否     | 分页条件 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大 200 |
| sort     |  string | 否     | 排序字段 |

#### fields 参数说明

参数为查询的目标实例对应的模型定义的所有字段


#### condition 参数说明

condition 参数为查询的目标实例对应的模型定义的所有字段

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_obj_id": "xxx",
    "fields": [
    ],
    "condition": {
    },
    "page": {
        "start": 0,
        "limit": 10,
        "sort": ""
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 4,
        "info": [
            {
                "bk_inst_id": 0,
                "bk_inst_name": "default area",
                "bk_supplier_account": "123456789"
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
| count     | int       | info 集合中元素的数量 |
| info      | array     | 查询的模型的实例集合 |

#### info

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_inst_id         | int       | 实例 ID |
| bk_inst_name       | string    | 实例名 |
| bk_supplier_account | string    | 开发商账号 |