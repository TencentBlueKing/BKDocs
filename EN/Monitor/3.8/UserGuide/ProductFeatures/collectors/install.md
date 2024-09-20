# Monitoring collector installation

## noun

* gse_agent: refers to the Agent provided by the BlueKing platform
* Collector: It is a program that collects data and reports data through gse_agent.
* The relationship between collector and gse_agent
    
     gse_agent is a unified entrance for data reporting. Monitoring collectors are hosted on gse_agent. When gse_agent is started, the collectors hosted by gse_agent will start automatically. If the machine is restarted or the collector is terminated unexpectedly, the collector will be automatically started as long as gse_agent survives.

## Plug-in function

The data collection of the monitoring function depends on the collector. Some plug-ins are enabled by default and some are enabled on demand.

Function | Dependent plug-ins | Installation status | Operation method
---|---|---|---
Basic pipeline | gse_agent | Installed by default on hosts connected to CMDB | If it is not installed or is abnormal, see the Agent installation guide
Operating system, process, system event, log keyword event, dial test, k8s, custom reporting command line | bkmonitorbeat | Default installation | Default installation, if not installed in node management
Custom character type | gsecmdline | Default installation, not recommended. Functions can be replaced by custom reporting | Generally no installation is required, version 2.0.2 or above is required
Cross-cloud custom reporting (events/indicators), ping service | bkmonitorproxy | Direct connection using public services, cloud area requires manual installation | Installation in node management
Log file collection | bkunifylogbeat | Not installed by default | Installed in node management

Note: Supported system types include Windows, Linux, AIX, system architecture x86, x86_64, arm32, arm64, etc.

The default installation path of the collector is /usr/local/ges/plugins/bin
![](media/16612270124093.jpg)



## Install collector

Plug-in installation and hosting are unified operations through node management. Open node management.

* Select IP

     Select the business, operating system type, IP, and click "Next"
![](media/16612270215096.jpg)



* Select plugin

     Plug-in update, select the plug-in that needs to be updated. Generally, just update bkmonitorbeat. If you need other monitoring functions, install/update the corresponding plug-in. See the first table of this article.
![](media/16612270275922.jpg)


* Update plugin
    
     The update plug-in is updated by calling the job API (gse_agent needs to be in a normal state).

![](media/16612270613700.jpg)
![](media/16612270861770.jpg)


* Check status

     After the update is completed, the execution status will show success or failure.
![](media/16612270957278.jpg)


* View log

     View the detailed plugin update log as shown.
![](media/16612271094922.jpg)


## Hosted plugins

Plug-in hosting is a function of gse_agent to manage plug-ins. It will control the start, stop, and automatic startup of the gse_agent plug-in process. The rules are as follows:

The gse_agent installed through [Node Management] and the gse_agent plug-in installed through [Node Management] will be managed by gse_agent by default (that is, if gse_agent survives, the relevant gse_agent plug-in will be automatically started).

If it is not installed through node management, such as manually installing gse_agent by the user (generally it will not appear), bkmonitorbeat is not managed by default. If bkmonitorbeat is unexpectedly terminated or the machine is restarted, bkmonitorbeat will not be started automatically. Hosted bkmonitorbeat plug-in, which can be operated through [Node Management]

Select business, IP->batch plug-in operation

[(Cancel) Hosting] The operation path of the plug-in is as follows: Process Management->Hosting (Cancel Hosting)->Official Plug-in->Plug-in Name->Execute Immediately



## Resource usage limit of collector

The collector is hosted by gse_agent. When the resources exceed the quota limit, gse_agent will restart the collector.