
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/list_service_instance_by_set_template/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据集群模版 id 获取服务实例列表

### 请求参数



#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_biz_id            | int  | 是   | 业务 id |
| set_template_id            | int  | 是   | 集群模版 ID |
| page       |  object    | 否     | 查询条件 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大 500 |

### 请求参数示例

```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",  
  "bk_biz_id": 1,
  "set_template_id":1,
  "page": {
    "start": 0,
    "limit": 10
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
        "count": 2,
        "info": [
            {
                "bk_biz_id": 3,
                "id": 1,
                "name": "10.0.0.1_lgh-process-1",
                "labels": null,
                "service_template_id": 50,
                "bk_host_id": 1,
                "bk_module_id": 59,
                "creator": "admin",
                "modifier": "admin",
                "create_time": "2020-10-09T02:46:25.002Z",
                "last_time": "2020-10-09T02:46:25.002Z",
                "bk_supplier_account": "0"
            },
            {
                "bk_biz_id": 3,
                "id": 3,
                "name": "127.0.122.2_lgh-process-1",
                "labels": null,
                "service_template_id": 50,
                "bk_host_id": 3,
                "bk_module_id": 59,
                "creator": "admin",
                "modifier": "admin",
                "create_time": "2020-10-09T03:04:19.859Z",
                "last_time": "2020-10-09T03:04:19.859Z",
                "bk_supplier_account": "0"
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

#### data 字段说明

| 字段|类型|描述|
|---|---|---|
|count|int|总数|
|info|array|返回结果|

#### info 字段说明

| 字段|类型|说明|
|---|---|---|
|id|int|服务实例 ID|
|name|string|服务实例名称|
|bk_biz_id|int|业务 id|
|bk_module_id|int|模型 id|
|service_template_id|int|服务模版 ID|
| labels           | map  |标签信息 |
|bk_host_id|int|主机 id|
| creator              | string             | 本条数据创建者                                                                                 |
| modifier             | string             | 本条数据的最后修改人员            |
| create_time         | string | 创建时间     |
| last_time           | string | 更新时间     |
| bk_supplier_account | string       | 开发商账号 |