
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_objects/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据可选条件查询模型

### 请求参数



#### 接口参数

| 字段                 |  类型      | 必选   |  描述                                                    |
|----------------------|------------|--------|----------------------------------------------------------|
| creator              | string     | 否     | 本条数据创建者                                           |
| modifier             | string     | 否     | 本条数据的最后修改人员                                   |
| bk_classification_id | string     | 否     | 对象模型的分类 ID，只能用英文字母序列命名                 |
| bk_obj_id            | string     | 否     | 对象模型的 ID，只能用英文字母序列命名                     |
| bk_obj_name          | string     | 否     | 对象模型的名字，用于展示，可以使用人类可以阅读的任何语言 |                                             |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "creator": "user",
    "modifier": "user",
    "bk_classification_id": "test",
    "bk_obj_id": "biz"
    "bk_obj_name": "aaa"
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
    "data": [
        {
            "bk_classification_id": "bk_organization",
            "create_time": "2018-03-08T11:30:28.005+08:00",
            "creator": "cc_system",
            "description": "",
            "id": 4,
            "bk_ispaused": false,
            "ispre": true,
            "last_time": null,
            "modifier": "",
            "bk_obj_icon": "icon-XXX",
            "bk_obj_id": "XX",
            "bk_obj_name": "XXX",
            "position": "{\"test_obj\":{\"x\":-253,\"y\":137}}",
            "bk_supplier_account": "0"
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

| 字段                 | 类型               | 描述                                                                                           |
|----------------------|--------------------|------------------------------------------------------------------------------------------------|
| id                   | int                | 数据记录的 ID                                                                                   |
| creator              | string             | 本条数据创建者                                                                                 |
| modifier             | string             | 本条数据的最后修改人员                                                                         |
| bk_classification_id | string             | 对象模型的分类 ID，只能用英文字母序列命名                                                       |
| bk_obj_id            | string             | 对象模型的 ID，只能用英文字母序列命名                                                           |
| bk_obj_name          | string             | 对象模型的名字，用于展示                                                                       |
| bk_supplier_account  | string             | 开发商账号                                                                                     |
| bk_ispaused          | bool               | 是否停用, true or false                                                                        |
| ispre                | bool               | 是否预定义, true or false                                                                      |
| bk_obj_icon          | string             | 对象模型的 ICON 信息，用于前端显示，取值可参考[(modleIcon.json)](/static/esb/api_docs/res/cc/modleIcon.json)|
| position             | json object string | 用于前端展示的坐标                                                                             |
| description           | string     | 数据的描述信息                                           |