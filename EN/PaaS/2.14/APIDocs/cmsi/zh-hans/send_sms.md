
### 请求方法

POST


### 请求地址

/api/c/compapi/cmsi/send_sms/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

发送短信

### 请求参数

#### 接口参数

| 字段               |  类型      | 必选   |  描述      |
|--------------------|------------|--------|------------|
| receiver           |  string    | 否     | 短信接收者，包含接收者电话号码，多个以逗号分隔，若 receiver、receiver__username 同时存在，以 receiver 为准 |
| receiver__username |  string    | 否     | 短信接收者，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔，若 receiver、receiver__username 同时存在，以 receiver 为准 |
| content            |  string    | 是     | 短信内容 |
| is_content_base64  |  bool      | 否     | 消息内容是否 base64 编码，默认 False，不编码，请使用 base64.b64encode 方法编码 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "receiver": "1234567890",
    "receiver__username": "admin",
    "content": "Welcome to Blueking",
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "OK",
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|----------|-----------|
|  result   |    bool    |      返回结果，true 为成功，false 为失败     |
|  code     |    int     |      返回码，0 表示成功，其它值表示失败 |
|  message  |    string  |      错误信息      |