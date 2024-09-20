# CMSI 消息组件

目前，API 网关提供的消息通知组件为：
- 发送邮件：/api/c/compapi/cmsi/send_mail/
- 发送微信：/api/c/compapi/cmsi/send_weixin/
- 发送短信：/api/c/compapi/cmsi/send_sms/
- 发送语音：/api/c/compapi/cmsi/send_voice_msg/

API 网关定义了消息通知组件的接口协议，提供了组件的默认实现（对接 SMTP 服务、企业微信接口、腾讯云接口）。
但是，这些组件并不能直接使用，需要配置对应的服务地址或账号后，才能使用。
如果，默认的实现不满足需求，可依照接口协议，参考 [CMSI 消息组件代码](https://github.com/Tencent/bk-PaaS/tree/develop/paas2/esb/components/generic/templates/cmsi)，
以自定义组件的方式，提供这些消息组件。

## 消息组件更新配置

### 发送邮件

发送邮件组件，默认支持通过 SMTP 服务发送邮件，组件配置 SMTP 服务地址、账号等信息后，即可发送邮件。

访问 `蓝鲸 API 网关`，在顶部导航菜单**组件管理**下，点击左侧菜单**组件管理**，打开组件管理页。筛选出系统 CMSI 下的组件 `send_mail`，点击**编辑**。

在**组件配置**标签下，更新组件的配置信息：
- smtp_host: SMTP 服务域名或 IP
- smtp_port: SMTP 服务端口
- smtp_user: SMTP 账号用户名
- smtp_pwd: SMTP 账号密码
- smtp_usessl: 是否使用 SSL
- smtp_usetls: 是否使用 TLS
- mail_sender: 邮件发送者

以腾讯 QQ 邮箱 SMTP 服务器为例，可将配置设置为：
```
smtp_host: smtp.qq.com
smtp_port: 465
smtp_user: 123456@qq.com
smtp_pwd: xxx
smtp_usessl: true
smtp_usetls: false
mail_sender: 123456@qq.com
```

### 发送微信

发送微信组件，支持发送企业微信或微信公众号消息，组件配置企业微信账号或微信公众号账号后，即可发送微信消息。

访问 `蓝鲸 API 网关`，在顶部导航菜单**组件管理**下，点击左侧菜单**组件管理**，打开组件管理页。筛选出系统 CMSI 下的组件 `send_weixin`，点击**编辑**。

在**组件配置**标签下，先选择消息类型（wx_type，可选值：企业微信、微信公众号）。

wx_type 为企业微信时，更新配置：
- wx_qy_corpid: 企业微信应用 ID
- wx_qy_corpsecret: 企业微信应用秘钥
- wx_qy_agentid: AgentID

wx_type 为微信公众号时，更新配置：
- wx_app_id：开发者ID(AppID)
- wx_secret：开发者秘钥(AppSecret)
- wx_token：令牌(Token)
- wx_template_id：消息模板的模板ID

> 注意：微信账号为高度敏感信息，注意保密。

更多信息，请参考[发送微信组件](./send-weixin.md)

### 发送短信

发送短信组件，默认对接腾讯云发送短信接口，组件配置腾讯云应用账号后，即可发送短信消息。

访问 `蓝鲸 API 网关`，在顶部导航菜单**组件管理**下，点击左侧菜单**组件管理**，打开组件管理页。筛选出系统 CMSI 下的组件 `send_sms`，点击**编辑**。

在**组件配置**标签下，更新组件的配置信息：
- qcloud_app_id：腾讯云应用 ID
- qcloud_app_key：腾讯云应用秘钥
- qcloud_sms_sign：短信签名，短信签名需在腾讯云短信签名管理中创建

> 注意：
> - 腾讯云账号为高度敏感信息，注意保密
> - 发送短信前，需要到腾讯云上，在应用下创建短信签名，及短信正文模版

### 发送语音

发送语音组件，默认对接腾讯云发送语音接口，组件配置腾讯云应用账号后，即可发送语音消息。

访问 `蓝鲸 API 网关`，在顶部导航菜单**组件管理**下，点击左侧菜单**组件管理**，打开组件管理页。筛选出系统 CMSI 下的组件 `send_voice_msg`，点击**编辑**。

在**组件配置**标签下，更新组件的配置信息：
- qcloud_app_id：腾讯云应用 ID
- qcloud_app_key：腾讯云应用秘钥

> 注意：腾讯云账号为高度敏感信息，注意保密
