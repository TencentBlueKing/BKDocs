# 导航说明

简单了解下导航的功能说明，能够快速的了解监控平台的功能分布。

![](media/16611817843294.jpg)

![](media/16612243844773.jpg)


## 首页

* [首页](../ProductFeatures/data-visualization/home.md)：展示本业务的统计信息，监控配置情况，快速了解需要处理的事项

## 仪表盘

* [仪表盘](../ProductFeatures/data-visualization/dashboard.md)：通过指标生成视图，替换自定义监控的场景
* [邮件订阅](../ProductFeatures/data-visualization/report_email.md): 通过邮件订阅报表可以定期的查看报表数据

## 数据检索

* [指标检索](../ProductFeatures/data-visualization/explore_metrics.md)：查看采集的指标原始内容
* [日志检索](../ProductFeatures/data-visualization/explore_logs.md)：查看采集的日志原始内容
* [事件检索](../ProductFeatures/data-visualization/explore_events.md)：查看采集的事件原始内容
* [Trace检索](../ProductFeatures/data-visualization/explore_traces.md)：查看采集的Trace原始内容

## 告警事件

* [事件中心](../ProductFeatures/alarm-analysis/alerts.md)：记录所有的告警事件和告警通知的内容，可以进行告警详情的查看和处理，如告警确认和告警的事件屏蔽
* [处理记录](../ProductFeatures/alarm-analysis/alert_recording.md):告警的通知和调用周边系统的处理记录都可以进行查看和分析。 

## 观测场景

基于不同场景会订制出不同的场景信息和视角来帮助在这个场景下的用户可以快速的掌握相应的信息。未来可以扩展更多的场景，如网络，硬件，容器等。

* [主机监控](../ProductFeatures/scene-host/host_monitor.md)：查看主机和进程相关信息的场景
* [综合拨测](../ProductFeatures/scene-synthetic/synthetic_monitor.md)：通过远程拨测服务判断服务是否正常。提供在这个场景在的各种视角和信息
* [容器监控](../ProductFeatures/scene-k8s/k8s_monitor_overview.md)：提供k8s云原生的监控解决方案。
* [应用监控](../ProductFeatures/scene-apm/apm_monitor_overview.md)：提供基于Opentelemetry的应用性能监控。
* 自定义场景：基于数据源进行场景呈现，如同一个监控插件的数据源，跨多个数据采集任务，同时进行观测。也可以满足个性化的可视化图表配置。 

## 监控配置

所有和监控配置相关的内容都是在监控配置中定义，报表视图，监控场景和分析定位都是查看类不存在监控配置的修改。

* [告警策略](../ProductFeatures/alarm-configurations/rules.md)：所有监控策略的配置入口，可以配置监控采集的时序数据，系统事件数据，自定义上报的事件和时序数据，数据平台接入，日志关键字监控等。有相应的算法支撑
* [告警组](../ProductFeatures/alarm-configurations/alarm_group.md)：设置常用的一组人和通知方式
* [告警屏蔽](../ProductFeatures/alarm-handling/block.md)：屏蔽告警通知， 有基于范围屏蔽，基于策略，基于事件屏蔽
* [处理套餐](../ProductFeatures/alarm-handling/what_fta.md)： 可以通过设置处理套餐，联动JOB、标准运维、ITSM、HTTP回调等周边服务。

## 集成

* [插件制作](../ProductFeatures/integrations-metric-plugins/plugins.md)：所有的采集配置都需要先定义插件(除了内置插件 如日志)，插件包含内置插件和自定义插件， 业务私有插件和公共插件，插件的本地采集和远程采集模式，支持不同的操作系统
* [采集任务](../ProductFeatures/integrations-metrics/collect_tasks.md)：所有的采集时序和日志类都是从采集来实现目标机器的采集过程。满足动态和静态的采集
* [自定义指标](../ProductFeatures/integrations-metrics/custom_sdk_push.md)：支持自定义指标数据的PUSH上报。
* [自定义事件](../integrations-events/custom_events_http.md)：支持自定义事件数据PUSH。
* [告警源](../integrations-alerts/custom_alerts_source.md)：支持添加各种监控工具或平台的告警源，满足一站式监控管理需求。
* [导入导出](../Appendix/import_export.md)：批量的进行配置的导入和导出操作。

## 平台设置

是影响整个监控平台的配置，也可以看到平台的运行状况。

* [全局配置](../Appendix/admin_config.md)：监控系统的全局开关，如数据的保存周期，水印开关，消息队列设置等
* [自监控](../Appendix/self_monitor.md)：监控平台自身的运行状态信息： 存活状态，运行状态，业务运营信息等
* [日历服务](../ProductFeatures/alarm-configurations/calendar_rules.md):通过设置日历满足告警策略基于日历进行是否生效告警策略。


