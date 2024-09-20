# Terminology explanation

This document is mainly an explanation of various functions and nouns for easy viewing and indexing. In addition, it is to unify the nouns and avoid deviations in understanding.

## Monitoring core concepts

### Metric & Dimension

- **Indicator:** Generally called Metric(s), Item or metric in the industry, that is, the content to be monitored is usually the ordinate in the coordinate system, such as CPU usage, number of people online, etc. In the SQL statement, it is usually `select indicator`

- **Dimension:** Generally called Dimension in the industry, the conditions for distinguishing indicators, such as IP, host name or platform (IOS, Andriod), are generally `Group by dimension` in SQL statements

# What are indicators and dimensions?
[View more](../ProductFeatures/integrations-metrics/what_metrics.md)

### Monitoring/collection target

- **Monitoring/Collection Targets:** Collection or monitoring targets are the target range of management, such as clusters, modules, IP, etc. Equivalent to a built-in dimension range
     - **Dynamic:** Only nodes in the CMDB can be selected. Collection targets can be dynamically added and deleted by nodes, and monitoring targets can be aggregated and judged based on data.
     - **Static:** You can only select/manually enter the host IP. The target will not change and relies on manual addition and deletion.
- **Collector IP address:** The location where the collector/plug-in runs
- **Cloud area:** The default is 0, directly connected area; when there are multiple cloud areas, BlueKing will uniformly manage the data and operations of multiple cloud areas.

### Monitoring objects

- **Monitoring objects:** Monitoring objects are layered/classified throughout the entire monitoring platform and log retrieval data, making the managed data and collected data identifiable
     - **Application**: refers to the user's use of the application and the application's operational data. Such as the usage of mobile terminals, the number of logins to business applications, etc.
     - **Service**: refers to the service module running on the server operating system. The minimum granularity of management is service instances, such as databases, processes, etc. Corresponding to CMDB-service topology
     - **Host**: Refers to the host system and hardware level. The minimum granularity of management is the host IP, such as CPU MEM server hardware failure, etc. Corresponds to CMDB-host topology
     - **Data Center**: Refers to the network and equipment related content related to the data center. Corresponds to CMDB-Device Management
     - View more [data model](../Architecture/datamodule.md)

### Alarm level

Alarms are divided into three levels

  * **Fatal**: Emergency is the most serious. Serious problems occur in core indicators, which will affect the stability of the business and require focus. Red
  * **Warning**: Critical generally serious, requiring attention, may lead to more serious problems, orange
  * **Reminder**: Warning prompt function, need to understand, there are signs of problems, yellow

### Collection method

* **gse_agent**: refers to the agent provided by the BlueKing platform
* **Collector**: Monitor built-in collectors, such as bkmonitorbeat management collection plug-in and bkunifylogbeat log collector.
* **Collection plug-in**: User-defined collection plug-in, which can be infinitely expanded based on standard requirements
* **Interval between the two**:
     * The collector is generally built-in by default and will not be destroyed after deployment and startup. It supports the management of multiple configuration files in one process and can manage collection plug-ins.
     * Collection plug-in: Mainly user-defined. Although there are also built-in ones, it is up to the user to decide whether they need or upgrade them. It can be a process, configuration or script. They all have a common feature. If not used, they will be deleted on the original target machine. The process class only supports one configuration file per process.

### Alarm handling

* **Abnormal points**: Time series data are detected by algorithm to detect abnormal points.
* **Alarm event**: Multiple abnormal points are events of the same type and are generally persistent.
* **Alarm notification**: Multiple alarm events are summarized into alarm notifications through convergence rules, storm suppression, etc.

## CMDB related concepts

A lot of monitored metadata information relies on CMDB, so you need to understand some concepts of CMDB and even the relevant configurations.

### Business

Business is one of the namespaces used by the monitoring platform to manage all host resources.

### Service module

### Service instance instance

- **Service instance:** The minimum granularity of the service module. When selecting the `service` monitoring object, the minimum granularity is the service instance, not the IP. View more[Design Concept](../Overview/README.md)

![-w2021](../Architecture/media/15744838270079.jpg)

### Service classification

- **Service Category:** Category of service module such as: `Database: Mysql`, monitoring can be managed based on service category, such as configuration viewing, export and import, professional view, etc.