# 流水线通知发送到钉钉


## 关键词：发送通知、钉钉

## 业务挑战

如果不能及时收到流水线通知，在某些场景下（比如：任务执行报错），用户将无法及时获取流水线执行“状态”并进行有效干预

## BKCI优势

BKCI新增了钉钉通知插件，可通过群机器人的形式发送消息通知。

## 解决方案

1、 在钉钉群管理页面，增加自定义机器人。

![&#x56FE;1](../../../assets/scene-notification-sent-nail-a.png)

2、 推荐使用“加签”的安全设置，完成设置后记录机器人Webhook和加签信息。

![&#x56FE;1](../../../assets/scene-notification-sent-nail-b.png)

3、 在BKCI流水线编排中，增加“钉钉消息通知”插件，若没有请在BKCI应用市场中添加。

![&#x56FE;1](../../../assets/scene-notification-sent-nail-c.png)

4、 配置插件信息，如下所示：

![&#x56FE;1](../../../assets/scene-notification-sent-nail-d.png)

5、流水线执行可在群里看到消息和

![&#x56FE;1](../../../assets/scene-notification-sent-nail-e.png)

注：

1、消息类型支持普通文本消息和MD信息。

2、@流水线启动人的功能，暂时只适用LDAP账号体系有同步钉钉号的情况， 其他账号体系暂未适配，后续有其他客户需求了适配即可。
