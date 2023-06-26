# 监控告警服务简介

## 告警功能简介

蓝鲸 PaaS3.0 开发者中心集成了 ***容器服务*** 的 `Prometheus` 告警功能，可以将蓝鲸应用的**异常事件**通过企业微信、邮件等多种方式触达开发者。

用户可以用通过 [我的告警页面] 来查看当前应用的告警情况，以更好的排除应用的不稳定因素。

## 告警处理

如果收到了告警，我应该如何处理：

- [应用内存使用率过高/应用 CPU 使用率过高](./handle_resource_alerts.md)
- [RabbitMQ 服务相关告警](./handle_rabbitmq_alerts.md)
- [数据库慢查询告警](./handle_slow_query_alerts.md)
- [应用可用性告警](./handle_availability_alerts.md)
