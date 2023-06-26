
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/list_process_detail_by_ids/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询某业务下进程 ID 对应的进程详情 (v3.9.8)

### 请求参数



#### 接口参数

|字段|类型|必填|描述|
|---|---|---|---|
|bk_biz_id|int|Yes| 进程所在的业务 ID |
|bk_process_ids|array|Yes|进程 ID 列表，最多传 500 个|
|fields|array|No|进程属性列表，控制返回结果的进程实例信息里有哪些字段，能够加速接口请求和减少网络流量传输<br>为空时返回进程所有字段,bk_process_id 为必返回字段|


### 请求参数示例

``` json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id":1,
    "bk_process_ids": [
        43,
        44
    ],
    "fields": [
        "bk_process_id",
        "bk_process_name",
        "bk_func_id",
        "bk_func_name"
    ]
}
```

### 返回结果示例
``` json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
        {
            "bk_func_id": "",
            "bk_func_name": "pr1",
            "bk_process_id": 43,
            "bk_process_name": "pr1"
        },
        {
            "bk_func_id": "",
            "bk_func_name": "pr2",
            "bk_process_id": 44,
            "bk_process_name": "pr2"
        }
    ]
}
```

### 返回结果参数说明

| 名称  | 类型  | 描述 |
|---|---|--- |
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data | array | 请求返回的数据 |

#### data
| 名称  | 类型  | 描述 |
|---|---|--- |
|bk_func_id|string|功能 ID|
|bk_func_name|string|进程名称|
|bk_process_id|int|进程 id|
|bk_process_name|string|进程别名|