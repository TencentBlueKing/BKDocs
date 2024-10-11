# Overview of log data access


There are many ways to access log data, and each method has its corresponding scenarios and corresponding functions. There are four major types of access methods in total.


## Category 1: Collect and report from source logs

Collecting and reporting logs from the source is the most complete logging capability and has all logging functions.

* Environment: physical environment, container environment
* Log format: Line log, segment log, Windows Event, K8s Event
* Access method: Collector collection, Push reporting
* Log processing: log cleaning, log clustering
* Storage management: log index management, hot and cold data management
* Log consumption: log retrieval, log archiving, log extraction, log alarm, log visualization


## Category 2: Access from ES storage

The logs have been collected into ES storage by other tools, directly connected to the ES storage source, and used in the logs.

* Log consumption: log retrieval, log visualization, log alarm

## Category 3: Access from computing platform

The BlueKing computing platform also has log access capabilities, meeting most log collection capabilities, and uses the same log collector as BKLog.

Compared with BKLog, it has advanced log cleaning capabilities, and cleaning between BKLog and computing platforms can be switched.

The computing platform will have fewer data access scenarios, such as the lack of container logs, windows events, push reporting, etc.

## Category 4: Custom reporting

Report through the yaml configuration file of K8s and the OTel SDK.