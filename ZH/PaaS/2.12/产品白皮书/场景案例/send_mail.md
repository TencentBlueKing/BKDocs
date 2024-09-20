# 配置消息通知：邮件

配置地址：以“admin”的角色进入“开发者中心” -> “API 网关” -> “通道管理” -> 选择系统 “[CMSI] 蓝鲸消息管理” -> 选择 “[CMSI] 发送邮件”

## 组件配置

- dest_url: 若用户不擅长用 Python，可以提供一个其他语言的接口，填到 dest_url，ESB 仅作请求转发即可打通邮件配置
- smtp_host: SMTP 服务器地址 (注意区分企业邮箱还是个人邮箱)
- smtp_port: SMTP 服务器端口 (注意区分企业邮箱还是个人邮箱)
- smtp_user: SMTP 服务器账号
- smtp_pwd: SMTP 服务器账号密码 (一般为授权码)
- smtp_usessl: 默认为 False
- smtp_usetls: 默认为 False
- mail_sender: 默认的邮件发送者 (smtp_user 相同)

## 组件示例

本示例已 QQ 邮箱为示例

### 1、开启 SMTP 服务

QQ 邮箱的 SMTP 服务，默认是关闭的。

登录 QQ 邮箱，点击顶部导航栏的 “设置” -> 账户 -> 找到“POP3/SMTP 服务”和“IMAP/SMTP 服务”项，点“开启”。

![-w2020](../assets/noticeWay01.png)
<center>开启服务</center>

开启之后，点击“生成授权码”。

这个授权码将作为 smtp_pwd。

### 2、找到 SMTP 配置

[QQ 邮箱 SMTP 默认配置](https://service.mail.qq.com/cgi-bin/help?subtype=1&&id=20010&&no=1000557)：

```bash
smtp_host ：smtp.qq.com
smtp_port ：465
smtp_user ：demo@qq.com （个人QQ邮箱地址）
smtp_pwd ：授权码
smtp_usessl ：True
```

![-w2020](../assets/noticeWay02.png)
<center>填写变量值</center>

填写完成后提交修改

### 3、测试接口

使用 Postman 工具请求为例

```bash
http://{PaaS_URL}/api/c/compapi/cmsi/send_mail/
```

```json
{
    "bk_app_code":"test",
    "bk_app_secret":"test",
    "bk_username": "admin",
    "receiver": "demo@qq.com",
    "sender": "demo@qq.com",
    "title": "This is a Test",
    "content": "<html>Welcome to Blueking</html>"
}
```
其中 sender 一定要跟管道配置 smtp_user 保持一致

![-w2020](../assets/noticeWay03.png)
<center>测试接口</center>

### 4、排查接口问题

1. 相关日志信息，登录 PaaS 机器查看

```bash
tail -f /data/bkce/logs/open_paas/esb.log
```

2. 请检查是否将端口打开


### 5、FAQ

1、"message": "Request JSON string is wrong in format, which cannot be analyzed"

解决方法：请求格式错误，请使用 JSON 格式。