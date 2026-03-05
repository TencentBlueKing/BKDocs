
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/subscribe_event/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

订阅事件

### 请求参数



#### 接口参数

| 字段                |  类型      | 必选   |  描述                                            |
|---------------------|------------|--------|--------------------------------------------------|
| subscription_name   | string     | 是     | 订阅的名字                                       |
| system_name         | string     | 是     | 订阅事件的系统的名字                             |
| callback_url        | string     | 是     | 回调函数                                         |
| confirm_mode        | string     | 是     | 事件发送成功校验模式,可选 1-httpstatus,2-regular |
| confirm_pattern     | string     | 是     | callback 的 httpstatus 或正则                       |
| subscription_form   | string     | 是     | 订阅的事件,以逗号分隔                            |
| timeout             | int        | 是     | 发送事件超时时间                                 |

### 请求参数示例

```json
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "subscription_name":"mysubscribe",
  "system_name":"SystemName",
  "callback_url":"http://127.0.0.1:8080/callback",
  "confirm_mode":"httpstatus",
  "confirm_pattern":"200",
  "subscription_form":"hostcreate",
  "timeout":10
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data":{
        "subscription_id": 1
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
| data | object | 请求返回的数据 |

#### data

| 字段            | 类型    | 描述             |
|-----------------|---------|------------------|
| subscription_id | int     | 新增订阅的订阅 ID |