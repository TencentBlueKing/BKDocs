# Host monitoring

Host monitoring is a scenario specially customized for viewing host and process-related information. In this scenario, host-related information can be quickly obtained.

## Preliminary steps

When the CMDB under this business does not have a host, the data monitored by the host is empty. Therefore, you must first learn how to add a host and add process information, service instance information, etc. in the CMDB.

* [如How to create a business and import hosts into the business](../../../../配置平台/产品白皮书/快速入门/case1.md)
* [How CMDB manages processes and service instances](../../../../配置平台/产品白皮书/场景案例/CMDB_management_process.md)
**working principle**:

Operating system indicator collection process

![-w2021](media/16046499751434.jpg)

Process information collection process

![-w2021](media/16046499586323.jpg)

System event collection process

![-w2021](media/16046500239629.jpg)

> Information: System events refer to operating system events collected by monitoring by default.

**Main configuration process**:

* (1) Configure the platform to add machines and configure business topology and process information
* (2) Deliver collection configuration (automatic)
* (3) Check the host monitoring page to see if there is data reported

## List of main functions

* Host information overview
* Host perspective (operating system indicators)
* Process perspective (process indicators)
* Generate system events

## Function Description

### Host list page

![image-20210421150136059](media/image-20210421150136059.png)

* [1] **Basic summary information**: Number of hosts with unrecovered alarms, number of hosts with CPU usage exceeding 80%, number of hosts with application memory usage exceeding 80%, number of hosts with disk IO exceeding 80%
* 【2】
     * **Collection and Delivery**: If the Agent is not installed, you need to install the Agent first from the node management or CMDB. If there is "no data reporting", you can use the collection and delivery button to trigger the delivery and installation of the collector.
     * **Indicator Comparison**: Select different hosts to quickly compare the same indicators.
     * **Copy IP**: IPs can be copied in batches, and the copied IPs can also be used in search conditions in a consistent format.
*【3】Search conditions and field selection: There are a variety of search conditions available.

> Note: Do you want to check the host through the business topology? Selecting the cluster module in the search can achieve the effect of querying by business topology.

*【4】**Pinning function**: You can pin the host you follow to the top, and the subsequent sorting is also the sorting within the top.
*【5】**Collection status**: There are several statuses as follows:
     *Normal: Data collection is normal
     * Agent is not installed: If there is no Agent, there will be no data. The collection function of Agent monitoring must be installed on the CMDB and node management before it can be used.
     * Unknown: If the status cannot be determined, please contact the administrator. less seen
     * No data reporting: It means that the Agent is installed. Basereport may not be installed or is abnormal. You can try "Collect and Deliver" to reinstall the default collector installation of the host-operating system.
* [6] **Unrecovered Alarms**: Unrecovered alarms are alarm events of related hosts that have not been recovered in the current event center.
*【7】**Application memory usage**: In addition to memory usage, there are other fields that can be selected

![-w2021](media/15761393519097.jpg)

* [8] **Process Information**: The name of the process configured in the CMDB and a simple status. Red represents an exception. Click to enter to view.

#### Scenario 1: View the disk space usage of machines in a cluster and sort them

![-w2021](media/15840812567108.jpg)

#### Scenario 2: Comparison of host monitoring indicators

![image-20210421150429200](media/image-20210421150429200.png)

### Host details page

![Large picture-data comparison-search-sort-group](media/%E5%A4%A7%E5%9B%BE-%E6%95%B0%E6%8D%AE%E5%AF%B9%E6 %AF%94-%E6%90%9C%E7%B4%A2-%E6%8E%92%E5%BA%8F-%E5%88%86%E7%BB%84.gif)

* [1] **Host Perspective**: Mainly looking at the indicators at the host-operating system level. Such as CPU MEM DISK, etc. View details [Host-Operating System-Metrics](../addenda/host-metrics.md)
* [2] **Process Perspective**: Mainly looking at process-level indicators. For details, view [Host-Process-Metrics](../addenda/process-metrics.md)
* [3] **View Control**: The views of the host scene are relatively simple, mainly to meet the needs of out-of-box use. If you want to make complex charts, you can directly add them to the dashboard.
* [4] **Associated information**: Host-related information, associated alarm events and policy information.
* [5] **Process Monitoring Configuration Indicators**: Because process monitoring relies on the process configuration information of CMDB, you need to be familiar with [How CMDB manages processes](../../../../配置平台/产品白皮书/场景案例/CMDB_management_process.md)

### Advanced

In addition to collecting operating system indicators and process indicators, the basereport collector also reports system events. There are currently 7 built-in system events [Host-Operating System-System Events](../addenda/host-events.md)

![image-20210421150618223](media/image-20210421150618223.png)