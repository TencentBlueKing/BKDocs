
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/get_mainline_object_topo/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

获取主线模型的业务拓扑

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx"
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
  "data": [
    {
      "bk_obj_id": "biz",
      "bk_obj_name": "business",
      "bk_supplier_account": "0",
      "bk_next_obj": "set",
      "bk_next_name": "set",
      "bk_pre_obj_id": "",
      "bk_pre_obj_name": ""
    },
    {
      "bk_obj_id": "set",
      "bk_obj_name": "set",
      "bk_supplier_account": "0",
      "bk_next_obj": "module",
      "bk_next_name": "module",
      "bk_pre_obj_id": "biz",
      "bk_pre_obj_name": "business"
    },
    {
      "bk_obj_id": "module",
      "bk_obj_name": "module",
      "bk_supplier_account": "0",
      "bk_next_obj": "host",
      "bk_next_name": "host",
      "bk_pre_obj_id": "set",
      "bk_pre_obj_name": "set"
    },
    {
      "bk_obj_id": "host",
      "bk_obj_name": "host",
      "bk_supplier_account": "0",
      "bk_next_obj": "",
      "bk_next_name": "",
      "bk_pre_obj_id": "module",
      "bk_pre_obj_name": "module"
    }
  ]
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
| 字段      |  类型      |  描述      |
|-----------|------------|------------|
|bk_obj_id | string | 模型的唯一 ID |
|bk_obj_name | string |模型名称|
|bk_supplier_account | string |开发商帐户名称|
|bk_next_obj | string |当前模型的下一个模型唯一 ID|
|bk_next_name | string |当前模型的下一个模型名称|
|bk_pre_obj_id | string |当前模型的前一个模型的唯一 ID|
|bk_pre_obj_name | string |当前模型的前一个模型的名称|