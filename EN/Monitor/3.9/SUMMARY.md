# Summary

## monitoring platform
*[Product Announcement](https://bk.tencent.com/s-mart/community/question/6431)
* [Product Introduction](UserGuide/Overview/README.md)
* [Core Benefits](UserGuide/Overview/benefits.md)
* [Term explanation](UserGuide/Term/glossary.md)
* [Product Architecture]()
     * [Architecture Diagram](UserGuide/ProductArchitecture/architecture.md)
     * [Data Model](UserGuide/ProductArchitecture/datamodule.md)
     * [Monitoring Space](UserGuide/ProductArchitecture/namespace.md)
* [Quick Start]()
     * [Getting Started](UserGuide/QuickStart/README.md)
     * [Preparation](UserGuide/QuickStart/prepare.md)
     * [Permission Application](UserGuide/QuickStart/perm.md)
     * [Quick Start Cases](UserGuide/QuickStart/best_practices.md)
     * [PC navigation instructions](UserGuide/QuickStart/menu.md)
     * [Mobile version instructions](UserGuide/QuickStart/h5_app.md)
     * [SDK access instructions](UserGuide/QuickStart/sdk_list.md)
     * [BKMonitor As Code](UserGuide/QuickStart/as_code.md)
* [Product Features]()
     * [Collector]()
         * [Monitoring collector installation](UserGuide/ProductFeatures/collectors/install.md)
         * [Collector-FAQ](UserGuide/ProductFeatures/collectors/collectors_faq.md)
     * [Integration-Indicator Plugin]()
         * [Start plug-in production](UserGuide/ProductFeatures/integrations-metric-plugins/plugins.md)
         * [Plug-in production Script](UserGuide/ProductFeatures/integrations-metric-plugins/script_collect.md)
         * [Plug-in production Exporter](UserGuide/ProductFeatures/integrations-metric-plugins/import_exporter.md)
         * [Plug-in production BK-Pull](UserGuide/ProductFeatures/integrations-metric-plugins/howto_bk-pull.md)
         * [Plug-in production DataDog](UserGuide/ProductFeatures/integrations-metric-plugins/import_datadog_online.md)
         * [Plug-in production JMX](UserGuide/ProductFeatures/integrations-metric-plugins/plugin_jmx.md)
         * [Plug-in production SNMP](UserGuide/ProductFeatures/integrations-metric-plugins/plugin_snmp.md)
         * [Official plug-in list](UserGuide/ProductFeatures/integrations-metric-plugins/builtin_plugins.md)
     * [Integration-Indicator Data]()
         * [What are metrics and dimensions](UserGuide/ProductFeatures/integrations-metrics/what_metrics.md)
         * [Metric output magnitude reference](UserGuide/ProductFeatures/integrations-metrics/recommend_metrics.md)
         * [Start metric data collection](UserGuide/ProductFeatures/integrations-metrics/collect_tasks.md)
         * [Built-in variable list](UserGuide/ProductFeatures/integrations-metrics/variables.md)
         * [HTTP simple reporting](UserGuide/ProductFeatures/integrations-metrics/custom_metrics_http.md)
         * [Integrated Prom SDK](UserGuide/ProductFeatures/integrations-metrics/custom_sdk_push.md)
         * [Prom SDK Java usage instructions](UserGuide/ProductFeatures/integrations-metrics/prom_sdk_java.md)
         * [Prom SDK Golang User Guide](UserGuide/ProductFeatures/integrations-metrics/prom_sdk_golang.md)
         * [Prom SDK Python usage instructions](UserGuide/ProductFeatures/integrations-metrics/prom_sdk_python.md)
         * [Prom SDK C++ usage instructions](UserGuide/ProductFeatures/integrations-metrics/prom_sdk_cpp.md)
         * [How to monitor open source components](UserGuide/ProductFeatures/integrations-metrics/component_monitor.md)
         * [How to implement multi-instance collection](UserGuide/ProductFeatures/integrations-metrics/multi_instance_monitor.md)
         * [How to implement Agentless data reporting](UserGuide/ProductFeatures/integrations-metrics/noagent_monitor.md)
         * [Customized metric reporting-FAQ](UserGuide/ProductFeatures/integrations-metrics/custom_metrics_faq.md)
     * [Integration-Trace data]()
         * [What is OpenTelemetry](UserGuide/ProductFeatures/integrations-traces/opentelemetry_overview.md)
         * [OTel SDK Java User Guide](UserGuide/ProductFeatures/integrations-traces/otel_sdk_java.md)
         * [OTel SDK Golang User Guide](UserGuide/ProductFeatures/integrations-traces/otel_sdk_golang.md)
         * [OTel SDK Python User Guide](UserGuide/ProductFeatures/integrations-traces/otel_sdk_python.md)
         * [OTel SDK C++ User Guide](UserGuide/ProductFeatures/integrations-traces/otel_sdk_cpp.md)
         * [BlueKing SaaS Framework Instructions](UserGuide/ProductFeatures/integrations-traces/otel_sdk_bksaas.md)
         * [Trace Access-FAQ](UserGuide/ProductFeatures/integrations-traces/otel_sdk_faq.md)
    * [Integration-Profile Data]()
        * [Profiling User Guide](UserGuide/ProductFeatures/integrations-profiles/profiling_usage.md)
        * [GO - Profiling Access Guide](UserGuide/ProductFeatures/integrations-profiles/go.md)
        * [Java - Profiling Access Guide](UserGuide/ProductFeatures/integrations-profiles/java.md)
        * [Perf - Profiling Access Guide](UserGuide/ProductFeatures/integrations-profiles/perf.md)
        * [Profile Access-FAQ](UserGuide/ProductFeatures/integrations-profiles/faq.md)
     * [Integration-EventData]()
         * [Event reporting-HTTP JSON](UserGuide/ProductFeatures/integrations-events/custom_events_http.md)
        * [Event Reporting-Command Line Tool](UserGuide/ProductFeatures/integrations-events/custom_report_tools.md)
         * [SNMP Trap collection plug-in](UserGuide/ProductFeatures/integrations-events/snmp_trap.md)
     * [Integration-Alarm Source]()
         * [Alarm source access instructions](UserGuide/ProductFeatures/integrations-alerts/custom_alerts_source.md)
         * [Alert source plug-in production](UserGuide/ProductFeatures/integrations-alerts/plugin_alerts.md)
     * [Data Exploration-Visualization]()
         * [Data Visualization](UserGuide/ProductFeatures/data-visualization/data_view_intro.md)
         * [Homepage data](UserGuide/ProductFeatures/data-visualization/home.md)
         * [Dashboard](UserGuide/ProductFeatures/data-visualization/dashboard.md)
         * [Email subscription](UserGuide/ProductFeatures/data-visualization/report_email.md)
         * [Temporary sharing](UserGuide/ProductFeatures/data-visualization/share.md)
         * [Metric retrieval](UserGuide/ProductFeatures/data-visualization/explore_metrics.md)
         * [Event retrieval](UserGuide/ProductFeatures/data-visualization/explore_events.md)
         * [Log retrieval](UserGuide/ProductFeatures/data-visualization/explore_logs.md)
         * [Trace retrieval](UserGuide/ProductFeatures/data-visualization/explore_traces.md)
         * [Profiling retrieval](UserGuide/ProductFeatures/data-visualization/explore_profiling.md)
         * [Data collection visualization](UserGuide/ProductFeatures/data-visualization/data_quick_view.md)
         * [Multi-metric calculation and PromQL](UserGuide/ProductFeatures/data-visualization/mutil_metric.md)
     * [Alarm Configuration-Policy]()
         * [Alarm policy creation](UserGuide/ProductFeatures/alarm-configurations/rules.md)
         * [Detection algorithm description](UserGuide/ProductFeatures/alarm-configurations/algorithms.md)
         * [Log Alarm-Source Collection End](UserGuide/ProductFeatures/alarm-configurations/keywords_event.md)
         * [Log Alarm-Source Log Platform](UserGuide/ProductFeatures/alarm-configurations/log_monitor.md)
         * [Indicator Monitoring-Source Computing Platform](UserGuide/ProductFeatures/alarm-configurations/bigdata_monitor.md)
         * [Associated alarm strategy](UserGuide/ProductFeatures/alarm-configurations/composite_monitor.md)
         * [Event Alarm Strategy](UserGuide/ProductFeatures/alarm-configurations/events_monitor.md)
         * [Associated Calendar Service](UserGuide/ProductFeatures/alarm-configurations/calendar_rules.md)
         * [How to perform second-level monitoring](UserGuide/ProductFeatures/alarm-configurations/collect_interval.md)
     * [Alarm notification and management]()
         * [Notification Convergence and Rollup](UserGuide/ProductFeatures/alarm-configurations/coverge.md)
         * [Alarm group and rotation](UserGuide/ProductFeatures/alarm-configurations/alarm_group.md)
         * [Alarm dispatch](UserGuide/ProductFeatures/alarm-configurations/alarm_routing.md)
         * [Alarm blocking](UserGuide/ProductFeatures/alarm-handling/block.md)
         * [Differences between different alarm blocking](UserGuide/ProductFeatures/alarm-handling/block_case1.md)
         * [How to customize notification template](UserGuide/ProductFeatures/alarm-configurations/notify_case.md)
         * [How to add a new notification channel](UserGuide/ProductFeatures/alarm-configurations/notify_setting.md)
     * [Alarm handling-fault self-healing]()
         * [What is fault self-healing](UserGuide/ProductFeatures/alarm-handling/what_fta.md)
         * [Enable fault self-healing](UserGuide/ProductFeatures/alarm-handling/fta_quickstart.md)
         * [Express package list](UserGuide/ProductFeatures/alarm-handling/solutions_express.md)
         * [Built-in variable list](UserGuide/ProductFeatures/alarm-handling/solutions_parameters_all.md)
         * [Defense Rule List](UserGuide/ProductFeatures/alarm-handling/solutions_convergence_rules.md)
         * [Handling Package-Callback](UserGuide/ProductFeatures/alarm-handling/solutions_http_callback.md)
         * [Processing Package-Job Platform](UserGuide/ProductFeatures/alarm-handling/solutions_job.md)
         * [Handling Package-Standard Operation and Maintenance](UserGuide/ProductFeatures/alarm-handling/solutions_sops.md)
         * [Handling Package-Process Service](UserGuide/ProductFeatures/alarm-handling/solutions_itsm.md)
         * [Case: WeChat group custom robot](UserGuide/ProductFeatures/alarm-handling/solutions_http_callback_case1.md)
     * [Alarm viewing and analysis]()
         * [Alarm events](UserGuide/ProductFeatures/alarm-analysis/alerts.md)
         * [Alarm processing details](UserGuide/ProductFeatures/alarm-analysis/alert_recording.md)
         * [Notification content description](UserGuide/ProductFeatures/alarm-analysis/messages_example.md)
     * [Intelligent monitoring]()
         * [Strategy-Metric Anomaly Detection](UserGuide/ProductFeatures/aiops/aiops_metrics_intelligent_detect.md)
         * [Strategy-Metrics Forecast](UserGuide/ProductFeatures/aiops/aiops_metrics_forecast.md)
         * [Strategy-Metrics Outline Detection](UserGuide/ProductFeatures/aiops/aiops_metrics_outline.md)
         * [Observation Scenario-Scene Detection](UserGuide/ProductFeatures/aiops/aiops_multi_metrics_detect.md)
         * [Alarm Analysis-Dimension Drilldown](UserGuide/ProductFeatures/aiops/aiops_multidimensional.md)
         * [Alarm Analysis-Metric Recommendation](UserGuide/ProductFeatures/aiops/aiops_similar_metrics.md)
     * [Observation Scenario-Host Monitoring]()
       * [Enable host monitoring](UserGuide/ProductFeatures/scene-host/host_monitor.md)
         * [Host Metrics Description](UserGuide/ProductFeatures/scene-host/host_metrics.md)
         * [Host event description](UserGuide/ProductFeatures/scene-host/host_events.md)
         * [Host Policy Description](UserGuide/ProductFeatures/scene-host/builtin_host_rules.md)
     * [Observation Scenario-Process Monitoring]()
         * [Enable process monitoring](UserGuide/ProductFeatures/scene-process/process_monitor_overview.md)
         * [Process Metrics Description](UserGuide/ProductFeatures/scene-process/process_metrics.md)
         * [Process Policy Description](UserGuide/ProductFeatures/scene-process/process_default_rules.md)
         * [Process Monitor-CMDB](UserGuide/ProductFeatures/scene-process/process_cmdb_monitor.md)
         * [Process Monitoring-Collection Plug-in](UserGuide/ProductFeatures/scene-process/process_pattern_monitor.md)
         * [Process Configuration Method-CMDB](UserGuide/ProductFeatures/scene-process/process_cases.md)
     * [Observation scenario-k8s monitoring]()
         * [Enable container monitoring](UserGuide/ProductFeatures/scene-k8s/k8s_monitor_overview.md)
         * [Container Monitoring Component](UserGuide/ProductFeatures/scene-k8s/k8s_monitor_operator.md)
         * [Container event description](UserGuide/ProductFeatures/scene-k8s/k8s_events.md)
         * [Container Policy Description](UserGuide/ProductFeatures/scene-k8s/k8s_default_rules.md)
         * [VS Prometheus](UserGuide/ProductFeatures/scene-k8s/howto_migrate_prometheus.md)
     * [Observation scene-comprehensive dial test]()
         * [Enable synthetic dial test](UserGuide/ProductFeatures/scene-synthetic/synthetic_monitor.md)
         * [Description of dial test indicators](UserGuide/ProductFeatures/scene-synthetic/synthetic_metrics.md)
     * [Observation scene-APM]()
         * [Enable APM](UserGuide/ProductFeatures/scene-apm/apm_monitor_overview.md)
         * [APM Metrics Description](UserGuide/ProductFeatures/scene-apm/apm_metrics.md)
         * [APM Policy Description](UserGuide/ProductFeatures/scene-apm/apm_default_rules.md)
     * [other]()
        * [Batch import and export](UserGuide/Appendix/import_export.md)
        * [Other small functions](UserGuide/Appendix/tricks.md)
        * [Global configuration](UserGuide/Appendix/admin_config.md)
        * [Self-monitoring](UserGuide/Appendix/self_monitor.md)
* [Secondary development]()
     * [Exporter plug-in development](UserGuide/Dev/plugin_exporter_dev.md)
     * [DataDog plug-in development](UserGuide/Dev/plugin_datadog_dev.md)
     * [How to make DataDog plug-in offline](UserGuide/Dev/import_datadog_offline.md)
     * [Plug-in package configuration file explanation](UserGuide/Dev/plugins_explain.md)
* [API Documentation]()
     * [API Overview](APIDocs/README.md)
     * [Add alarm shield](APIDocs/zh-hans/add_shield.md)
     * [Delete Alarm Strategy](APIDocs/zh-hans/delete_alarm_strategy.md)
     * [Delete strategy configuration](APIDocs/zh-hans/delete_alarm_strategy_v2.md)
     * [Delete notification group](APIDocs/zh-hans/delete_notice_group.md)
     * [Disable alarm shielding](APIDocs/zh-hans/disable_shield.md)
     * [Edit Alarm Shield](APIDocs/zh-hans/edit_shield.md)
     * [Export dial test task configuration](APIDocs/zh-hans/export_uptime_check_task.md)
     * [Query event flow record](APIDocs/zh-hans/get_event_log.md)
     * [Get alarm shield](APIDocs/zh-hans/get_shield.md)
     * [Get ES data](APIDocs/zh-hans/get_ts_data.md)
     * [Import dial test node configuration](APIDocs/zh-hans/import_uptime_check_node.md)
     * [Import dial test task configuration](APIDocs/zh-hans/import_uptime_check_task.md)
     * [Get alarm shielding list](APIDocs/zh-hans/list_shield.md)
     * [Create storage cluster information](APIDocs/zh-hans/metadata_create_cluster_info.md)
     * [Create monitoring data source](APIDocs/zh-hans/metadata_create_data_id.md)
     * [Create event group](APIDocs/zh-hans/metadata_create_event_group.md)
     * [Create monitoring result table](APIDocs/zh-hans/metadata_create_result_table.md)
     * [Dimension split configuration to create result table](APIDocs/zh-hans/metadata_create_result_table_metric_split.md)
     * [Create custom time series group](APIDocs/zh-hans/metadata_create_time_series_group.md)
     * [Delete event group](APIDocs/zh-hans/metadata_delete_event_group.md)
     * [Delete custom time series group](APIDocs/zh-hans/metadata_delete_time_series_group.md)
     * [Get monitoring data source specific information](APIDocs/zh-hans/metadata_get_data_id.md)
   * [Query the specific content of the event group](APIDocs/zh-hans/metadata_get_event_group.md)
     * [Get detailed information of the monitoring result table](APIDocs/zh-hans/metadata_get_result_table.md)
     * [Query the specified storage information of the specified result table](APIDocs/zh-hans/metadata_get_result_table_storage.md)
     * [Get the specific content of the custom time series group](APIDocs/zh-hans/metadata_get_time_series_group.md)
     * [Query the currently existing label information](APIDocs/zh-hans/metadata_list_label.md)
     * [Query monitoring result table](APIDocs/zh-hans/metadata_list_result_table.md)
     * [Get all transfer cluster information](APIDocs/zh-hans/metadata_list_transfer_cluster.md)
     * [Modify storage cluster information](APIDocs/zh-hans/metadata_modify_cluster_info.md)
     * [Modify the configuration information of the specified data source](APIDocs/zh-hans/metadata_modify_data_id.md)
     * [Modify event group](APIDocs/zh-hans/metadata_modify_event_group.md)
     * [Modify monitoring result table](APIDocs/zh-hans/metadata_modify_result_table.md)
     * [Modify custom timing group](APIDocs/zh-hans/metadata_modify_time_series_group.md)
     * [Create event group](APIDocs/zh-hans/metadata_query_event_group.md)
     * [Get the specific content of custom timing grouping](APIDocs/zh-hans/metadata_query_tag_values.md)
     * [Query event group](APIDocs/zh-hans/metadata_query_time_series_group.md)
     * [Upgrade the specified monitoring order business result table to a full business result table](APIDocs/zh-hans/metadata_upgrade_result_table.md)
     * [Save alarm strategy](APIDocs/zh-hans/save_alarm_strategy.md)
     * [Save alarm strategy](APIDocs/zh-hans/save_alarm_strategy_v2.md)
     * [Save notification group](APIDocs/zh-hans/save_notice_group.md)
     * [Search alarm strategy](APIDocs/zh-hans/search_alarm_strategy.md)
     * [Query alarm strategy list](APIDocs/zh-hans/search_alarm_strategy_v2.md)
     * [Search event](APIDocs/zh-hans/search_event.md)
     * [Search notification group](APIDocs/zh-hans/search_notice_group.md)
     * [Start and stop alarm strategy](APIDocs/zh-hans/switch_alarm_strategy.md)
     * [Batch update strategy partial configuration](APIDocs/zh-hans/update_partial_strategy_v2.md)
* [Error code](../ErrorCode/monitor.md)
