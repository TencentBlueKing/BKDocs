# How to add a new notification channel

The notification channel uses the PaaS notification ESB component. The independent deployment version of BlueKing needs to be set up in the developer center backend.

## Configure the notification channel in the notification ESB component

![-w2021](../media/15366583245319.jpg)
<center>Message management notification settings of BlueKing Integration Platform (PaaS)</center>

For detailed settings, please visit the settings documentation provided by BlueKing PaaS.

- [How to configure notification channels, such as email, WeChat, SMS, etc.?](../../../PaaS Platform/Product White Paper/Scenario Case/noticeWay.md)
- [Experience Sharing-Testing whether the email service is normal](http://bk.tencent.com/s-mart/community/question/95#/)

## Determine the notification method in global configuration

Confirm the channel for message notification in monitoring.

![-w2021](media/16051505458005.jpg)


## Alarm notification setting entrance

Global configuration affects the selection of notification methods. Alarms that meet the policy can be configured through the alarm group configuration.

![-w2021](media/15773279204886.jpg)

## Pay attention to the activation matters of WeChat

When WeChat does not receive an alert, pay attention to check whether it has been turned on.

![WeChatWorkScreenshot](media/WeChatWorkScreenshot_dfed1d6a-63d0-48bd-8dc4-f9d59d677cb4.png)