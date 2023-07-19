# **移动端版本体验简介**

>> 注意，移动端版本体验目前仅在二方企业内支持

版本体验服务可以将流水线构建出来的ipa/apk包发布到企业微信上的版本体验应用上，便于产品、测试团队、公司内其他成员协助你的业务验证产品新特性，发现产品潜在缺陷，让你的产品在内部验证流程上得到闭环。

## **移动端版本体验的特色功能**
- 与企业微信的应用整合，同时继承企业微信鉴权，使用更方便、更安全
- 提供BKCI插件，与编译构建流水线整合
- 支持ipa和apk的下载和安装
- 支持历史版本下载
- 下载链接动态生成，可根据链接有效时间进行访问管理
- 文件储存支持腾讯云COS
- 支持版本体验的人员和时间管理，体验人员从企业微信通讯录同步
- 支持新版本的消息通知
- 后台服务支持横向扩展


## **技术架构**
![](../../assets/image-client-experince-instructure.png)


## **应用管理**
- 通过企业微信「工作台」（版本体验），你可以快速进行应用的体验和管理

![](../../assets/image-client-experience-application-1.png)

![](../../assets/image-client-experience-application-2.png)


## **应用下载**
- 点击「下载」，你可以快速下载应用，ipa会提示跳转safari进行下载，该下载链接为动态生成，可配置按下载次数或有效时间进行访问限制管理

![](../../assets/image-client-experince-download.png)


## **流水线插件**
- 「版本体验插件」与编译构建流水线整合，并提供体验权限的管理，新版本通知等功能

![](../../assets/image-client-experince-plugin.png)


## **版本通知**
- 版本体验插件在勾选「通知」后，在应用上传成功后给有权限的人员发送企业微信通知消息

![](../../assets/image-client-experince-notification.png)

## **部署成本**
- [部署移动端版本体验需要的硬件资源](client-experience-cost.md)
