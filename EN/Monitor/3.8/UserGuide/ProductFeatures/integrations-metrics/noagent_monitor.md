# How to implement monitoring without Agent

Sometimes the target machine cannot install BlueKing Agent for some reasons. like:

*Cannot be installed using root
* Do not allow installation of other Agents
* No installation permission

However, operation and maintenance still need to ensure the stability of its services and increase monitoring. The monitoring platform has the following solutions:

## Option 1 Comprehensive dial test

The service dial test itself is to simulate the user's request situation to see the status of the service, and judge based on the connectivity and response content. It is to look at the problem from the perspective of the overall cluster service.

Please check the specific usage: [Introduction to dial test function](../scene-synthetic/synthetic_monitor.md)

## Option 2 Customized reporting HTTP method

Custom reporting can be custom timing or custom event reporting, and data can be reported to the monitoring by the service's own monitoring program or the service program itself.

Please check the specific usage: [Introduction to custom reporting function](./custom_metrics_http.md)

## Option 3 Customized reporting SDK PUSH method

You can use the SDK of Prometheus and Opentelemetry to report data.

See the specific usage: [Custom indicator reporting-Prometheus SDK](./custom_sdk_push.md)

## Solution 4 Remote collection plug-in

### Remote plug-in definition

When the status information of the service is exposed remotely, such as nginx status, you can make a plug-in and set it as a `remote plug-in', which will have the ability to collect remotely.

![-w2021](media/15769100952860.jpg)

### BK-Pull Definition

When the data format of Exporter is exposed remotely, such as pushgayway, a bk-pull plug-in can be made to meet the data pulling capability.

![-w2021](media/15769101086174.jpg)

### Solution 4 Monitoring based on computing platform

Data can be transferred to the data platform through other means or database synchronization, and monitoring can use the data from the data platform for monitoring configuration.

See the specific usage: [How to monitor based on data from the computing platform](../alarm-configurations/bigdata_monitor.md)