
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/create_module/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

创建模块

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id      | int     | 是     | 业务 ID |
| bk_set_id      | int     | 是     | 集群 id |
| data           | dict    | 是     | 业务数据 |

#### data

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_parent_id      | int     | 是     | 父实例节点的 ID，当前实例节点的上一级实例节点，在拓扑结构中对于 module 一般指的是 set 的 bk_set_id |
| bk_module_name    | string  | 是     | 模块名 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "bk_set_id": 10,
    "data": {
        "bk_parent_id": 10,
        "bk_module_name": "test"
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
        "bk_bak_operator": null,
        "bk_biz_id": 1,
        "bk_module_id": 37825,
        "bk_module_name": "test",
        "bk_module_type": "1",
        "bk_parent_id": 10,
        "bk_set_id": 10,
        "bk_supplier_account": "0",
        "create_time": "2022-02-22T20:25:19.049+08:00",
        "default": 0,
        "host_apply_enabled": false,
        "last_time": "2022-02-22T20:25:19.049+08:00",
        "operator": null,
        "service_category_id": 2,
        "service_template_id": 0,
        "set_template_id": 0
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
| 字段      | 类型      | 描述         |
|-----------|-----------|--------------|
| bk_bak_operator | string | 备份维护人 |
| bk_module_id | int | 模型 id |
|bk_biz_id|int|业务 id|
| bk_module_id      | int    | 主机所属的模块 ID                      |
| bk_module_name              | string      | 模块名   |
|bk_module_type|string|模块类型|
|bk_parent_id|int|父节点的 ID|
| bk_set_id | int | 集群 id |
| bk_supplier_account | string | 开发商账号 |
| create_time         | string | 创建时间     |
| last_time           | string | 更新时间     |
|default | int | 表示模块类型 |
| host_apply_enabled|bool|是否启用主机属性自动应用|
| operator | string | 主要维护人 |
|service_category_id|integer|服务分类 ID|
|service_template_id|int|服务模版 ID|
| set_template_id      | int  | 集群模板 ID     |