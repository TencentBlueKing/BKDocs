# 告警策略如何配置

### 告警策略介绍
告警策略兼容 Prometheus alerting rule 规则，提供在线编辑，导入/导出，告警内容预览等功能

### 新建告警策略
新建告警策略流程如下：

> 入口：http://bcs.bktencent.com/console/monitor/ (有多个项目请在导航切换，域名地址请以安装部署的域名为准)

在监控中心，点击`新建策略`按钮

![-w2021](./_image/2020-11-16-17-31-29.jpg)

填写策略名称，注意名称必须全局唯一，保存后不能修改

![-w2021](./_image/2020-11-16-17-37-22.jpg)

规则表达式使用 PromQL 语法，详情参考 [QUERYING PROMETHEU](https://prometheus.io/docs/prometheus/latest/querying/basics/)

告警内容支持模板，支持的函数和语法，详情参考 [告警模板使用说明](./alerting_template.md)

针对不同的告警需求，选择汇总等待时间，重复通知间隔等

![-w2021](./_image/2020-11-16-17-39-40.jpg)


通知支持微信，邮件，电话，短信等，注意需要运维配置相关通知渠道

![-w2021](./_image/2020-11-16-17-40-34.jpg)

通知也支持通用的接口回调方式，文档参考 [告警接口回调说明](./notice_webhook.md)

### 导入/导出策略
支持导入/导出，注意：只允许导出非系统内置策略
![-w2021](./_image/2020-11-17-10-45-45.jpg)

导入格式参考：
```yaml
version: '1.0'
rules:
- alertname: CPU告警测试
  comment: 系统默认添加的策略
  expr: (1 - (avg by(cluster_id, instance) (irate(node_cpu_seconds_total{mode="idle"}[5m]))))
    * 100
  for: 120
  operator: '>='
  threshold: 0.0
  message: 服务器 {{ $labels.instance | ip }}, 当前CPU使用率 {{ $value | printf "%.2f%%" }},
    已持续{{ $for | duration }}超过设定阈值{{ $threshold }}%, 请检查服务是否正常
  labels: {}
  annotations: {}
  enabled: true
  notice_config:
    group_wait: 60
    group_interval: 60
    repeat_interval: 60
    receiver_configs:
      esb_notice_configs:
      - receivers:
        - admin
        wechat: true
        wechat_work: true
        email: true
        sms: false
        phone: false
      webhook_configs: []
```