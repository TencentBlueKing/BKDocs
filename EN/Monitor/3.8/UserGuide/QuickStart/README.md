# Quick Start

To quickly get in touch with the monitoring platform, you will first have a basic understanding through the quick start.

## Access process

![-w2021](media/15800415288588.jpg)

Basically the access process has the following stages:

1. **[Preparation](prepare.md)**: The monitoring target and process information of the monitoring platform mainly rely on the configuration of CMDB, the collection link of monitoring depends on the deployment of BlueKing Agent, and the use of monitoring functions depends on [permissions settings](../QuickStart/perm.md)
2. **Data collection**: Monitoring itself works around data. Where does the data come from? Either through [monitoring plug-in](../ProductFeatures/integrations-metric-plugins/plugins.md) and [collection configuration] (../ProductFeatures/integrations-metrics/collect_tasks.md), or actively report it through [Custom Reporting] (../ProductFeatures/integrations-metrics/custom_sdk_push.md), or directly use [Computing Platform] (. ./ProductFeatures/alarm-configurations/bigdata_monitor.md) result table data
3. **Data Check**: Whether the data is collected successfully depends on whether the relevant graphic data can be viewed. Each collection task has a **Check View** to view the data collected by the current host/instance. Of course, you can also retrieve an arbitrary indicator from [Data Visualization](../ProductFeatures/data-visualization/data_view_intro.md)
4. **Policy Configuration**: The collected data can be viewed or alerted. The indicators that you want to alert are set through the policy configuration. You can plan in advance what alarm groups you need to use when notifying alarms.
5. **Alarm processing**: When the policy takes effect and an alarm is triggered, we can view it through [Event Center] (../ProductFeatures/alarm-analysis/alerts.md) or through [Alarm Notification] (. ./ProductFeatures/alarm-configurations/rules.md) receives the corresponding alarm content, and can quickly perform **alarm confirmation** or [alarm shielding] (../ProductFeatures/alarm-handling/block.md) for alarm events. )
6. **Others**: There are many other advanced features available. [Import and export](../Appendix/import_export.md), [Global configuration](../Appendix/admin_config.md)

## Four stages of monitoring

The monitoring platform has so many functions and documents. How to use the monitoring platform step by step? It can be roughly divided into four levels:

* Tier 1: Ready-to-use out of the box -- **For entry-level users**
* Layer 2: Extended collection and automatic alarm processing -- **For advanced users**
*Level 3: Advanced policy control and configuration sharing -- **For expert users**
*Level 4: Platform management and plug-in development -- **Applicable to administrators and secondary developers**

### First layer: out of the box

* Host-operating system monitoring
     * Machines managed in the CMDB and with Agent installed will be collected by default.
     * Default collected indicators [host-operating system-indicators](../ProductFeatures/scene-host/host_monitor.md)
     * Events collected by default [Host-Operating System-System Events](../ProductFeatures/scene-host/host_events.md)
     * Host monitoring Host chart viewing and comparison functions [Host monitoring](../ProductFeatures/scene-host/host_monitor.md)
* Built-in default policy [built-in policy](../ProductFeatures/scene-host/builtin_host_rules.md)
* Host-process monitoring
     * The process configured by CMDB will collect by default
     * Process indicators and events collected by default [Host-Process-Indicator](../ProductFeatures/scene-process/process_monitor_overview.md)
*Official plug-ins: 20 official plug-ins are built-in, which can be used directly in collection to meet the monitoring needs of commonly used components. Provide dynamic collection requirements and automatically add and delete collections
     * [Built-in official plug-ins](../ProductFeatures/integrations-metric-plugins/builtin_plugins.md)
     * [Collection configuration](../ProductFeatures/integrations-metrics/collect_tasks.md)
* Policy configuration: It can meet the monitoring needs of IP, service instances, and cluster modules, and provides 8 detection algorithms. And support the data monitoring needs of the data platform
     * [Algorithm Description](../ProductFeatures/alarm-configurations/algorithms.md)
     * [Policy Configuration](../ProductFeatures/alarm-configurations/rules.md)
     * [Alarm Group](../ProductFeatures/alarm-configurations/alarm_group.md)
     * [How to monitor data of computing platform](../ProductFeatures/alarm-configurations/bigdata_monitor.md)
* Monitoring and shielding: Provides shielding granularity for service instances, IPs, cluster modules, policies, and events
      * [Alarm blocking](../ProductFeatures/alarm-handling/block.md)
* Dashboard: Provides different chart configurations to support drawing requirements for log data, data platform data, and monitoring and collected indicator data.
      * [Dashboard](../ProductFeatures/data-visualization/data_view_intro.md)
* Comprehensive dial test: Provides monitoring requirements that simulate user requests.
      * [Service Dial Test](../ProductFeatures/scene-synthetic/synthetic_monitor.md)
* Log collection and monitoring
     * Log collection and field extraction can be carried out through the log platform
     * Convenient log retrieval function
     * Log keyword alarm function and log indicator data monitoring capabilities
     * Log indicator data drawing ability
     * [How to monitor the data of the log platform](../ProductFeatures/alarm-configurations/log_monitor.md)

### Second layer: Extended collection and automatic alarm processing

* Online plug-in production: Expand collection capabilities through online plug-in production. Plug-in production provides five convenient plug-in production types: script, Exporter, JMX, and BK-Pull. You can implement a useful collection plug-in in a few minutes. It also provides remote collection methods to meet situations where Agent deployment is inconvenient.
* Custom reporting: Expand collection capabilities through custom reporting. Reporting through HTTP can meet the needs of flexible business indicator data reporting capabilities.
* Alarm callback capability: Alarm callback through HTTP can be automatically triggered.
* Fault self-healing capability: Through fault self-healing docking and docking monitoring, processing actions are opened.
    
    
### Layer 3: Advanced policy control and configuration sharing

* Refined control: no data alarm, alarm recovery, alarm convergence and summary control
* Customized alarm notification template: meet personalized needs through templates
* Policy suppression capability: small range priority is greater than large range
* Host operation field: Use the operation field of the host to control whether to monitor, which can be connected with operations related to release and fault handling.
* Ignore process port range end: some process port ranges are not intended for monitoring
* Import and export: Batch import and export of collection, strategies, and plug-ins can be used to quickly share configurations

### The fourth layer: platform management and plug-in development

* Plug-in program development: When there is no suitable plug-in on the market, you can develop it yourself. There are two languages: Python and Golang. You can choose which one you are better at.
* Global management: There are many functions controlled in global configuration, such as disk blacklist, alarm storm threshold, notification channel settings
* Self-monitoring: monitoring of monitoring to ensure the stability of the platform