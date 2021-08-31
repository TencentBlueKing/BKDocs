# 配置消息通知：微信消息

配置地址：以“admin”的角色进入“开发者中心” -> “API 网关” -> “通道管理” -> 选择系统 “[CMSI] 蓝鲸消息管理” -> 选择 “[CMSI] 发送微信消息”


## 微信公众号


https://mp.weixin.qq.com/

## 组件配置

- wx_type: 微信公众号
- wx_app_id: 开发者 ID(AppID)
- wx_secret: 开发者密码(AppSecret)
- wx_token：令牌(Token)
- wx_template_id: 模板消息 id



### 6、排查接口问题

相关日志信息，登录 PaaS 机器查看

```bash
tail -f /data/bkce/logs/open_paas/esb.log
```

### 7、FAQ

1、"errmsg": "模版未审批或内容不匹配"

解决方法：请去 腾讯云语音消息 -> 应用管理 -> 语音模板 -> 选择相应的应用 -> 创建语音模板




## 企业微信


### 组件配置

- dest_url: 若用户不擅长用 Python，可以提供一个其他语言的接口，填到 dest_url，ESB 仅作请求转发即可打通语音消息配置
- qcloud_app_id: SDK AppID
- qcloud_app_key: App Key




### 组件示例


#### 1、创建应用

#### 4、配置通道

以“admin”的角色进入“开发者中心” -> “API 网关” -> “通道管理” -> 选择系统 “[CMSI] 蓝鲸消息管理” -> 选择 “[CMSI] 公共语音通知”

```bash
qcloud_app_id：SDK AppID
qcloud_app_key：App Key
```

是否开启：是

提交修改

![-w2021](../assets/2020040720315877.png)

填写完成后提交修改

#### 5、测试接口

使用 Postman 工具请求为例

```bash
http://{PaaS_URL}/api/c/compapi/cmsi/send_voice_msg/
```

```json
{
    "bk_app_code":"test",
    "bk_app_secret":"test",
    "bk_username": "admin",
    "auto_read_message": "蓝鲸监控通知，xxxx任务执行失败",
    "user_list_information": [{
        "username": "admin",
        "mobile_phone": "telephone number"
    }]
}
```

![-w2021](../assets/send_voice_msg03.png)


## 各产品配置

[各产品短信配置](../../../常见问题/通知/短信通知.md)

