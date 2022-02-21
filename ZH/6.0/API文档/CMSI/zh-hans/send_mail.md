
### 请求方法

POST


### 请求地址

/api/c/compapi/cmsi/send_mail/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### {{ _("功能描述") }}

{{ _("发送邮件") }}

### {{ _("请求参数") }}



#### {{ _("接口参数") }}

| {{ _("字段") }}               |  {{ _("类型") }}      | {{ _("必选") }}   |  {{ _("描述") }}      |
|--------------------|------------|--------|------------|
| receiver           |  string    | {{ _("否") }}     | {{ _("邮件接收者，包含邮件完整地址，多个以逗号分隔，若receiver、receiver__username同时存在，以receiver为准") }} |
| receiver__username |  string    | {{ _("否") }}     | {{ _("邮件接收者，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔，若receiver、receiver__username同时存在，以receiver为准") }} |
| sender             |  string    | {{ _("否") }}     | {{ _("发件人") }} |
| title              |  string    | {{ _("是") }}     | {{ _("邮件主题") }} |
| content            |  string    | {{ _("是") }}     | {{ _("邮件内容") }} |
| cc                 |  string    | {{ _("否") }}     | {{ _("抄送人，包含邮件完整地址，多个以逗号分隔") }} |
| cc__username       |  string    | {{ _("否") }}     | {{ _("抄送人，包含用户名，用户需在蓝鲸平台注册，多个以逗号分隔，若cc、cc__username同时存在，以cc为准") }} |
| body_format        |  string    | {{ _("否") }}     | {{ _("邮件格式，包含'Html', 'Text'，默认为'Html'") }} |
| is_content_base64  |  bool      | {{ _("否") }}     | {{ _("邮件内容是否base64编码，默认False，不编码，请使用base64.b64encode方法编码") }} |
| attachments        |  list      | {{ _("否") }}     | {{ _("邮件附件") }} |

##### attachments

| {{ _("字段") }}               |  {{ _("类型") }}      | {{ _("必选") }}   |  {{ _("描述") }}      |
|--------------------|------------|--------|------------|
| filename           |  string    | {{ _("是") }}     | {{ _("文件名") }}  |
| content            |  string    | {{ _("是") }}     | {{ _("文件内容，文件内容为原文件内容的 base64 编码字符串") }}  |
| type               |  string    | {{ _("否") }}     | {{ _("文件类型，默认为文件名后缀，如 a.png 文件类型为 'png'") }} |
| disposition        |  string    | {{ _("否") }}     | {{ _("文件 Content-Disposition，图片文件(type=image, jpg, png, jpeg)默认为 'inline'，其他文件默认为 'attachment'")  }}  |
| content_id         |  string    | {{ _("否") }}     | {{ _("文件 Content-ID，文件为图片文件时生效；默认为 '<文件名>'") }} |

### {{ _("请求参数示例") }}

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "receiver": "admin@bking.com",
    "sender": "admin@bking.com",
    "title": "This is a Test",
    "content": "<html>Welcome to Blueking</html>",
}
```

### {{ _("返回结果示例") }}

```python
{
    "result": true,
    "code": "00",
    "message": "OK",
}
```