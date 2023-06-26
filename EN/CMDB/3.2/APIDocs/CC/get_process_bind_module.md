### 请求地址

/api/c/compapi/v2/cc/get_process_bind_module/

### 请求方法

GET

### 功能描述

获取进程绑定模块

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选	 | 描述 |
|----------------------|------------|--------|-----------------------|
| bk_supplier_account | string |是 | 开发商 ID |
| bk_biz_id | int | 是 | 业务 ID |
| bk_process_id | int | 是 | 进程 ID |

### 请求参数示例

```json
{
    "bk_supplier_account": "0",
    "bk_biz_id": 3,
    "bk_process_id": 1
}
```

### 返回结果示例

```json
{
    "result":true,
    "bk_error_code":0,
    "bk_error_msg":"",
    "data":[
        {
            "bk_module_name":"db",
            "set_num":10,
            "is_bind":0
        },
        {
            "bk_module_name":"gs",
            "set_num":5,
            "is_bind":1
        }
    ]
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| result | bool | 请求成功与否，true:请求成功，false:请求失败 |
| bk_error_code | string | 组件返回错误编码。0 表示 success，>0 表示失败错误 |
| bk_error_msg | string | 请求失败返回的错误消息 |
| data | object | 请求返回的数据 |

#### data

| 名称 | 类型 | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false:请求失败 |
| bk_error_code | int | 错误编码。 0 表示  success，>0 表示失败错误 |
| bk_error_msg | string | 请求失败返回的错误信息 |
| data | object | 请求返回的数据 |

#### data 字段说明

| 名称 | 类型 | 描述 |
|---|---|------|
| bk_module_name| string| 模块名 |
| set_num| int | 所属集群个数 |
| is_bind| int | 是否绑定 |
