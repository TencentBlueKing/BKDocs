# How to add a new notification channel

The notification channels for monitoring all use the notification channels of BlueKing's PaaS, so if you want to add notification channels to monitoring, you only need to learn how to add notification channels to PaaS, and you can provide notification capabilities for all SaaS.

The notification channel uses the notification ESB component of PaaS, and the independent deployment version (enterprise version, community version) of BlueKing needs to be set up in the developer center backend.

## Configure the notification channel in the notification ESB component

![-w2021](../../Other/media/15366583245319.jpg)
<center>Message management notification settings of BlueKing Integration Platform (PaaS)</center>

For detailed settings, please visit the settings documentation provided by BlueKing PaaS.

- [How to configure notification channels, such as email, WeChat, SMS, etc.?](../../../../../APIGateway/1.10/UserGuide/component/reference/cmsi-components.md)
- [Experience Sharing-Testing whether the email service is normal](http://bk.tencent.com/s-mart/community/question/95#/)

## Determine the notification method in global configuration

Confirm the channel for message notification in monitoring.

![](media/16616779138794.jpg)


## Alarm notification setting entrance

Global configuration affects the selection of notification methods. Alarms that meet the policy can be configured through the alarm group configuration.

![-w2021](media/15773279204886.jpg)

