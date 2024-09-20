# 配置消息通知：短信

配置地址：以“admin”的角色进入“开发者中心” -> “API 网关” -> “通道管理” -> 选择系统 “[CMSI] 蓝鲸消息管理” -> 选择 “[CMSI] 发送短信”

## 组件配置

- dest_url: 若用户不擅长用 Python，可以提供一个其他语言的接口，填到 dest_url，ESB 仅作请求转发即可打通短信配置
- qcloud_app_id: SDK AppID
- qcloud_app_key: App Key
- qcloud_sms_sign: 在腾讯云 SMS 申请的签名，比如：腾讯科技

## 组件示例

本示例已 腾讯云 sms 为示例

### 1、创建签名

先进入 腾讯云云产品 -> 短信

![-w2021](../assets/markdown-img-paste-20200403173430929.png)

国内短信 -> 签名管理 -> 创建签名

![-w2021](../assets/noticeWay06.png)

> 注意：国内短信由签名+正文组成，签名符号为【】（注：全角），发送短信内容时必须带签名;

### 2、创建正文模板

国内短信 -> 正文模板管理 -> 创建正文模板

模板示例：{1}为您的登录验证码，请于{2}分钟内填写。如非本人操作，请忽略本短信。（其中{1}、{2}为可自定义的内容，须从 1 开始连续编号，如{1}、{2}等）

> 注意：短信模板内容不能含有【】符号

![-w2021](../assets/noticeWay07.png)

模板实例：《蓝鲸作业平台》通知{1}该信息如非本人订阅，请忽略本短信。

### 3、创建应用

应用管理 -> 应用列表 -> 创建应用

![-w2021](../assets/markdown-img-paste-20200403173623741.png)

点击应用名 -> 获取 SDK AppID、App Key

![-w2021](../assets/markdown-img-paste-20200403173813685.png)

### 4、配置通道

以“admin”的角色进入“开发者中心” -> “API 网关” -> “通道管理” -> 选择系统 “[CMSI] 蓝鲸消息管理” -> 选择 “[CMSI] 发送短信”

```bash
qcloud_app_id：SDK AppID
qcloud_app_key：App Key
qcloud_sms_sign: 腾讯蓝鲸
```

是否开启：是

提交修改

![-w2021](../assets/markdown-img-paste-20200403172817676.png)

填写完成后提交修改

### 5、测试接口

使用 Postman 工具请求为例

```bash
http://{PaaS_URL}/api/c/compapi/cmsi/send_sms/
```

```json
{
    "bk_app_code":"test",
    "bk_app_secret":"test",
    "bk_username": "admin",
    "receiver": "telephone number",
    "content": "【腾讯蓝鲸】《蓝鲸作业平台》通知您在蓝鲸作业平台《助手》业务中的任务《the_new_role》执行成功！，请登录蓝鲸作业平台(http://xxxxxx)查看详细信息！该信息如非本人订阅，请忽略本短信。"
}
```

![-w2020](../assets/noticeWay04.png)
<center>测试接口</center>

![-w2020](../assets/noticeWay05.png)
<center>手机接收成功</center>

### 6、排查接口问题

相关日志信息，登录 PaaS 机器查看

```bash
tail -f /data/bkce/logs/open_paas/esb.log
```

### 7、FAQ

1、"message": "签名格式错误或者签名未审批"

说明：蓝鲸消息通道已经配置成功，可以发送请求到腾讯云。

解决方法：请去 腾讯云短信 -> 国内短信 -> 正文模板管理 -> 创建正文模板

2、"message": "验证码模板参数格式错误"

说明：蓝鲸消息通道、腾讯云模板 已经配置成功，模板匹配出现问题。

解决方法：请参考 通过的正文模板进行发送短信，主要注意模板参数位置和空格。


## 各产品配置

[各产品短信配置](./send_sms.md#7faq)

