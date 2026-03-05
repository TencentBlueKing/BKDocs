
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/update_biz_custom_field/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

更新业务自定义模型属性

### 请求参数



#### 接口参数

| 字段                |  类型   | 必选   |  描述                                   |
|---------------------|---------|--------|-----------------------------------------|
| id                  | int     | 是     | 目标数据的记录 ID                        |
| bk_biz_id           | int     | 是     | 业务 id                                |
| description         | string  | 否     | 数据的描述信息                          |
| isonly              | bool    | 否     | 表明唯一性                              |
| isreadonly          | bool    | 否     | 表明是否只读                            |
| isrequired          | bool    | 否     | 表明是否必填                            |
| bk_property_group   | string  | 否     | 字段分栏的名字                          |
| option              | object  | 否     | 用户自定义内容，存储的内容及格式由调用方决定, 以数字内容为例（{"min":1,"max":2}）|
| bk_property_name    | string  | 否     | 模型属性名，用于展示                    |
| bk_property_type    | string  | 否     | 定义的属性字段用于存储数据的数据类型（singlechar,longchar,int,enum,date,time,objuser,singleasst,multiasst,timezone,bool)|
| unit                | string  | 否     | 单位                                    |
| placeholder         | string  | 否     | 占位符                                  |
| bk_asst_obj_id      | string  | 否     | 如果有关联其它的模型，那么就必需设置此字段，否则就不需要设置 |

#### bk_property_type

| 标识       | 名字     |
|------------|----------|
| singlechar | 短字符   |
| longchar   | 长字符   |
| int        | 整形     |
| enum       | 枚举类型 |
| date       | 日期     |
| time       | 时间     |
| objuser    | 用户     |
| singleasst | 单关联   |
| multiasst  | 多关联   |
| timezone   | 时区     |
| bool       | 布尔     |


### 请求参数示例

```json
{

    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "id":1,
    "bk_biz_id": 2,
    "description":"test",
    "placeholder":"test",
    "unit":"1",
    "isonly":false,
    "isreadonly":false,
    "isrequired":false,
    "bk_property_group":"default",
    "option":{"min":1,"max":4},
    "bk_property_name":"aaa",
    "bk_property_type":"int",
    "bk_asst_obj_id":"0"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": null
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