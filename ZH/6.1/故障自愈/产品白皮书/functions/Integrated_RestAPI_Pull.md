# 集成 REST API 拉取

如果企业使用的监控产品故障自愈未集成，可以把监控产品的告警使用 [REST API 推送](REST_API_PUSH_Alarm_processing_automation.md) 至故障自愈，或故障自愈定期从监控产品通过 **REST API 拉取** 的方式获取告警。

本文介绍如何周期性拉取监控产品告警。

## 启用 REST API 拉取告警源

在【管理告警源】菜单中，【启用】REST API 拉取 告警源。

![-w1679](../assets/15681929342797.jpg)

参照 REST API 拉取 的接入流程，完成告警源的接入。

![-w1676](../assets/15681930099043.jpg)

![-w1676](../assets/15681930877100.jpg)

## 创建自愈方案

参照 [对接 Open-falcon](Integrated_Openfalcon.md#Add_FTA)，完成自愈的接入。
