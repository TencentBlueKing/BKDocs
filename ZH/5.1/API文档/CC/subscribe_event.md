
### 请求地址

/api/c/compapi/v2/cc/subscribe_event/



### 请求方法

POST


### 功能描述

订阅事件

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型      | 必选   |  描述                                            |
|---------------------|------------|--------|--------------------------------------------------|
| bk_supplier_account | string     | 是     | 开发商账号                                       |
| subscription_name   | string     | 是     | 订阅的名字                                       |
| system_name         | string     | 是     | 订阅事件的系统的名字                             |
| callback_url        | string     | 是     | 回调函数                                         |
| confirm_mode        | string     | 是     | 事件发送成功校验模式,可选 1-httpstatus,2-regular |
| confirm_pattern     | string     | 是     | callback的httpstatus或正则                       |
| subscription_form   | string     | 是     | 订阅的事件,以逗号分隔                            |
| timeout             | int        | 是     | 发送事件超时时间                                 |

### 请求参数示例

```python
{
  "bk_supplier_account": "0",
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

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data":{
        "subscription_id": 1
    }
}
```

### 返回结果参数说明

#### data

| 字段            | 类型    | 描述             |
|-----------------|---------|------------------|
| subscription_id | int     | 新增订阅的订阅ID |