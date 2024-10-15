# Navigation instructions

A brief understanding of the navigation function description can help you quickly understand the function distribution of the monitoring platform.

## basic skills

![-w2021](media/16046485032608.jpg)

* Label 1) Select the business drop-down to obtain the list of authorized businesses in the CMDB.
* Label 2)
     * Product document address: Documents for this white paper
     * Version log: You can view the description of each version iteration
     * Problem feedback: Quick feedback on monitoring problems or needs.
* Label 3) Fixed method of navigation

### Report View

Mainly through the presentation of views and reports, we can solve daily inspections and discover potential problems. Alarm reports, event reports and other capabilities will be added in the future.

* [Home](report/home.md): Display the statistical information of this business, monitor the configuration, and quickly understand the matters that need to be processed
* [Dashboard](report/dashboard.md): Generate views through indicators to replace custom monitoring scenarios

### Monitoring scenario

Different scene information and perspectives will be customized based on different scenarios to help users in this scenario quickly grasp the corresponding information. In the future, more scenarios can be expanded, such as network, hardware, containers, etc.

* [Host Monitor](scene/host-monitor.md): Scenario for viewing host and process related information
* [Service Dial Test](scene/dial.md): Use remote dial test service to determine whether the service is normal. Provide various perspectives and information in this scene
     * Dial-up test tasks: Management of service dial-up test tasks
     * Dial-up test node: source node settings required for service dial-up test

### Analysis and positioning

After receiving an alarm, a quick problem location will be provided. Various location tools will be provided, such as event and log retrieval, as well as data retrieval, trace links, application topology, etc.

* [Event Center](analyze/event.md): records all alarm events and alarm notification contents, and can view and process alarm details, such as alarm confirmation and alarm event shielding
* [Data retrieval](analyze/data-search.md): View the original content of the collected logs

### Monitoring configuration

All content related to the monitoring configuration is defined in the monitoring configuration. Report views, monitoring scenarios and analysis positioning are modifications of the viewing class that does not exist in the monitoring configuration.

* [Plug-in production] (conf/plugins.md): All collection configurations need to define plug-ins first (except built-in plug-ins such as logs). Plug-ins include built-in plug-ins and custom plug-ins, business private plug-ins and public plug-ins, and local collection of plug-ins. and remote acquisition mode, supporting different operating systems
* [Collection tasks] (conf/collect-tasks.md): All collection timings and log classes are implemented from collection to realize the collection process of the target machine. Meet dynamic and static collection
* [Alarm Policy] (conf/rules.md): Configuration entry for all monitoring strategies. You can configure the time series data collected by monitoring, system event data, custom reported events and time series data, data platform access, and log keyword monitoring. wait. There is corresponding algorithm support
* [Alarm Group](conf/alarm-group.md): Set a commonly used group of people and notification methods
* [Alarm shielding] (conf/block.md): shield alarm notifications, including range-based shielding, policy-based shielding, and event-based shielding
* [Classification Management](conf/service-class.md): CMDB’s service module classification, manages data content based on service classification
* [Configuration Import and Export](conf/import-export.md): Import and export configurations in batches
* [Custom reporting](conf/custom-report.md): Supports reporting settings for custom events and custom time series data

### Platform configuration

It affects the configuration of the entire monitoring platform, and you can also see the operating status of the platform.

* [Global Configuration] (global/admin-config.md): Global switches of the monitoring system, such as data storage period, watermark switch, message queue settings, etc.
* [Self-monitoring](global/self-monitor.md): Monitor the operating status information of the platform itself: survival status, running status, business operation information, etc.