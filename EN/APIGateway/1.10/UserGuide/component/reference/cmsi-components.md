# CMSI message component

Currently, the message notification components provided by API Gateway are:
- Send email: /api/c/compapi/cmsi/send_mail/
- Send WeChat: /api/c/compapi/cmsi/send_weixin/
- Send SMS: /api/c/compapi/cmsi/send_sms/
- Send voice: /api/c/compapi/cmsi/send_voice_msg/

The API gateway defines the interface protocol of the message notification component and provides the default implementation of the component (connecting to SMTP service, enterprise WeChat interface, and Tencent Cloud interface).
However, these components cannot be used directly. They need to configure the corresponding service address or account before they can be used.
If the default implementation does not meet the requirements, you can follow the interface protocol and refer to [CMSI message component code](https://github.com/Tencent/bk-PaaS/tree/develop/paas2/esb/components/generic/templates/ cmsi),
These message components are provided as custom components.

## Message component update configuration

### send email

The send email component supports sending emails through the SMTP service by default. After the component configures the SMTP service address, account and other information, it can send emails.

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_mail` under the system CMSI and click **Edit**.

Under the **Component Configuration** tab, update the component's configuration information:
- smtp_host: SMTP service domain name or IP
- smtp_port: SMTP service port
- smtp_user: SMTP account user name
- smtp_pwd: SMTP account password
- smtp_usessl: whether to use SSL
- smtp_usetls: whether to use TLS
- mail_sender: email sender

Taking Tencent QQ mailbox SMTP server as an example, the configuration can be set as:
```
smtp_host: smtp.qq.com
smtp_port: 465
smtp_user: 123456@qq.com
smtp_pwd:xxx
smtp_usessl: true
smtp_usetls: false
mail_sender: 123456@qq.com
```

### Send WeChat

The Send WeChat component supports sending corporate WeChat or WeChat public account messages. After the component is configured with a corporate WeChat account or WeChat public account, WeChat messages can be sent.

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_weixin` under the system CMSI and click **Edit**.

Under the **Component Configuration** tab, first select the message type (wx_type, optional values: Enterprise WeChat, WeChat official account).

When wx_type is Enterprise WeChat, update the configuration:
- wx_qy_corpid: Enterprise WeChat application ID
- wx_qy_corpsecret: Enterprise WeChat application secret key
- wx_qy_agentid: AgentID

When wx_type is a WeChat official account, update the configuration:
- wx_app_id: Developer ID (AppID)
- wx_secret: Developer secret key (AppSecret)
- wx_token: Token
- wx_template_id: template ID of the message template

> Note: WeChat accounts are highly sensitive information, please keep them confidential.

For more information, please refer to [Send WeChat Component](./send-weixin.md)

### sending a text message

The SMS sending component is connected to the Tencent Cloud SMS sending interface by default. After the component is configured with a Tencent Cloud application account, SMS messages can be sent.

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_sms` under the system CMSI and click **Edit**.

Under the **Component Configuration** tab, update the component's configuration information:
- qcloud_app_id: Tencent Cloud application ID
- qcloud_app_key: Tencent Cloud application key
- qcloud_sms_sign: SMS signature, SMS signature needs to be created in Tencent Cloud SMS signature management

> Note:
> - Tencent Cloud account is highly sensitive information, please keep it confidential
> - Before sending a text message, you need to go to Tencent Cloud and create a text message signature and text message text template under the application

### Send voice

The send voice component is connected to the Tencent Cloud send voice interface by default. After the component is configured with a Tencent Cloud application account, it can send voice messages.

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_voice_msg` under the system CMSI and click **Edit**.

Under the **Component Configuration** tab, update the component's configuration information:
- qcloud_app_id: Tencent Cloud application ID
- qcloud_app_key: Tencent Cloud application key

> Note: Tencent Cloud account is highly sensitive information, please keep it confidential