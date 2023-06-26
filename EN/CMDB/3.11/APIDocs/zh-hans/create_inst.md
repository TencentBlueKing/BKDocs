
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/create_inst/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

创建实例

- 该接口只适用于自定义层级模型和通用模型实例上，不适用于业务、集群、模块、主机等模型实例

### 请求参数



#### 接口参数

| 字段                       |  类型      | 必选   |  描述                                      |
|----------------------------|------------|--------|--------------------------------------------|
| bk_obj_id                  | string     | 是     | 模型 ID                 |
| bk_inst_name | string     | 是     | 实例名 |
| bk_biz_id                  | int        | 否     | 业务 ID， 当创建的是自定义主线层级模型实例时则必传 |
| bk_parent_id                  | int        | 否     | 当创建的是自定义主线层级模型实例时则必传，代表父层级实例 ID|

 注意：当操作的是自定义主线层级模型实例时，而又有使用权限中心的，对于 cmdb 小于 3.9 的版本，还需要传包含实例所在业务 id 的 metadata 参数，否则会导致权限中心鉴权失败，格式为
"metadata": {
    "label": {
        "bk_biz_id": "64"
    }
}

其它属于实例属性的字段均也可为入参。


### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id":"test3",
    "bk_inst_name":"example18",
    "bk_biz_id":0
}
```

### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "data": {
        "bk_biz_id": 0,
        "bk_inst_id": 1177099,
        "bk_inst_name": "example18",
        "bk_obj_id": "test3",
        "bk_supplier_account": "0",
        "create_time": "2022-01-05T17:28:27.069+08:00",
        "last_time": "2022-01-05T17:28:27.069+08:00",
        "test4": ""
    },
    "message": "success",
    "permission": null,
    "request_id": "87de106ab55549bfbcc46e47ecf5bcc7"
}
```

### 返回结果参数说明
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

| 字段       | 类型      | 描述     |
|----------- |-----------|----------|
| bk_inst_id | int       | 实例 id   |
| bk_biz_id |     int   |业务 id    |
| bk_inst_name |   string     | 实例名   |
| bk_obj_id |      string  |   模型 id |
| bk_supplier_account| string       | 开发商账号                                                 |
| create_time         | string | 创建时间     |
| last_time           | string | 更新时间     |