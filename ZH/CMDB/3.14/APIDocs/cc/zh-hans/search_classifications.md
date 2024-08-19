
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_classifications/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询模型分类

### 请求参数



#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|

### 请求参数示例

``` python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
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
            "bk_classification_icon": "icon-cc-business",
            "bk_classification_id": "bk_host_manage",
            "bk_classification_name": "主机管理",
            "bk_classification_type": "inner",
            "bk_supplier_account": "0",
            "id": 1
         }
     ]
}
```

### 返回结果参数说明
#### response

| 名称    | 类型   | 描述                                       |
| ------- | ------ | ------------------------------------------ |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                     |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                             |

#### data

| 字段                   | 类型     | 描述                                                                                          |
|------------------------|----------|-----------------------------------------------------------------------------------------------|
| bk_classification_id   | string   | 分类 ID，英文描述用于系统内部使用                                                              |
| bk_classification_name | string   | 分类名                                                                                        |
| bk_classification_type | string   | 用于对分类进行分类（如：inner 代码为内置分类，空字符串为自定义分类）                           |
| bk_classification_icon | string   | 模型分类的图标,取值可参考，取值可参考[(classIcon.json)](resource_define/classIcon.json) |
| id                     | int      | 数据记录 ID                                                                                    |
| bk_supplier_account| string| 开发商账户 |