
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/find_host_topo_relation/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

获取主机与拓扑的关系

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
 bk_biz_id| int| 是|业务 ID|
| bk_set_ids|array | 否| 集群 ID 列表，最多 200 条|
| bk_module_ids|array | 否| 模块 ID 列表，最多 500 条| 
| bk_host_ids|array | 否| 主机 ID 列表，最多 500 条| 
| page| object| 是|分页信息|

#### page 字段说明

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
|start|int|否|获取数据偏移位置|
|limit|int|是|过去数据条数限制，建议 为 200|

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "page":{
        "start":0,
        "limit":10
    },
    "bk_biz_id":2,
    "bk_set_ids": [1, 2],
    "bk_module_ids": [23, 24],
    "bk_host_ids": [25, 26]
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "data": {
        "count": 2,
        "data": [
            {
                "bk_biz_id": 2,
                "bk_host_id": 2,
                "bk_module_id": 2,
                "bk_set_id": 2,
                "bk_supplier_account": "0"
            },
            {
                "bk_biz_id": 1,
                "bk_host_id": 1,
                "bk_module_id": 1,
                "bk_set_id": 1,
                "bk_supplier_account": "0"
            }
        ],
        "page": {
            "limit": 10,
            "start": 0
        }
    },
    "message": "success",
    "permission": null,
    "request_id": "f5a6331d4bc2433587a63390c76ba7bf"
}
```



### 返回结果参数说明
#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误   |
| message | string | 请求失败返回的错误信息                   |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                          |

#### data 字段说明

| 名称  | 类型  | 说明 |
|---|---|---|
| count| int| 记录条数 |
| data| object array |  业务下主机与集群，模块，集群的数据详情列表 |
| page| object| 页 |

#### data.data 字段说明
| 名称  | 类型  | 说明 |
|---|---|---|
| bk_biz_id | int | 业务 ID |
| bk_set_id | int | 集群 ID |
| bk_module_id | int | 模块 ID |
| bk_host_id | int | 主机 ID |
| bk_supplier_account | string | 开发商账号 |

#### data.page 字段说明
| 名称  | 类型  | 说明 |
|---|---|---|
|start|int|数据偏移位置|
|limit|int|过去数据条数限制|