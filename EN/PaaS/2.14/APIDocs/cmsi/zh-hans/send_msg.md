
### 请求方法

POST


### 请求地址

/api/c/compapi/cmsi/send_msg/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

通用消息发送接口

### 请求参数

#### 接口参数

|             字段   |     类型   |必选    |  描述    |
|--------------------|------------|--------|------------|
| msg_type           |  string    | 是     | 发送信息的类型，可通过 get_msg_type 组件获取 |
| receiver__username |  string    | 是     | 接收者，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔 |
| title              |  string    | 是     | 主题 |
| content            |  string    | 是     | 内容  |
| sender             |  string    | 否     | 发件人，msg_type 为 mail 时有效 |
| cc__username       |  string    | 否     | 抄送人，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔，msg_type 为 mail 时有效 |
| body_format        |  string    | 否     | 邮件格式，包含'Html', 'Text'，默认为'Html'， msg_type 为 mail 时有效 |
| attachments        |  list      | 否     | 邮件附件， msg_type 为 mail 时有效 |
| date               |  string    | 否     | 通知发送时间，默认为当前时间 "YYYY-mm-dd HH:MM"，msg_type 为 weixin 时有效 |
| remark             |  string    | 否     | 通知尾部文字，msg_type 为 weixin 时有效|
| wx_qy_agentid      |  string    | 否     | 企业微信 AgentId，msg_type 为 weixin 时有效 |
| wx_qy_corpsecret   |  string    | 否     | 企业微信 CorpSecret，msg_type 为 weixin 时有效 |
| is_content_base64  |  bool      | 否     | 通知文字 content 是否 base64 编码，默认 False，不编码，若编码请使用 base64.b64encode 方法 |


##### attachments

|             字段   |     类型   |必选    |  描述    |
|--------------------|------------|--------|------------|
| filename           |  string    | 是     | 文件名 |
| content            |  string    | 是     | 文件内容，文件内容为原文件内容的 base64 编码字符串" |
| type               |  string    | 否     | 文件类型，默认为文件名后缀，如 a.png 文件类型为 'png' |
| disposition        |  string    | 否     | 文件 Content-Disposition，图片文件(type=image, jpg, png, jpeg)默认为 'inline'，其他文件默认为 'attachment'  |
| content_id         |  string    | 否     | 文件 Content-ID，文件为图片文件时生效；默认为 '<文件名>' |

### 请求参数示例

```python
{
    "bk_app_code": "esb-test",
    "bk_app_secret": "esb-test-secret",
    "bk_username": "admin",
    "msg_type": "mail",
    "receiver__username": "admin,yunchao",
    "title": "xxx",
    "content": "xxx"
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