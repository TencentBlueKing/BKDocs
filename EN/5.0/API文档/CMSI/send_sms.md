
### 请求地址

/api/c/compapi/cmsi/send_sms/



### 请求方法

POST


### 功能描述

发送短信

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段               |  类型      | 必选   |  描述      |
|--------------------|------------|--------|------------|
| receiver           |  string    | 否     | 短信接收者，包含接收者电话号码，多个以逗号分隔，若receiver、receiver__username同时存在，以receiver为准 |
| receiver__username |  string    | 否     | 短信接收者，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔，若receiver、receiver__username同时存在，以receiver为准 |
| content            |  string    | 是     | 短信内容 |
| is_content_base64  |  bool      | 否     | 消息内容是否base64编码，默认False，不编码，请使用base64.b64encode方法编码 |

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
    "code": "00",
    "message": "OK",
}
```