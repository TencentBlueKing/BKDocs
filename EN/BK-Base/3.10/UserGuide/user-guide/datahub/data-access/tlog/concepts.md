# TLOG access

## Introduction

Tlog access is similar to log access. The tlog log access process is optimized, the log path is filled in by default, and the tlog table is provided for users to choose.

## Collection principle

Same log access

## Access preparation

* Job execution permission. The collector is issued and restarted depending on the job, so the user needs job execution permission.

## Data access

### Data information

It defines the basic information of the source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

* Collection range: access by module or IP

* Log path supports wildcard characters

*Operating systems currently support Linux and Windows

* TLOG table: The user selects the table name under this business

* Whether the first character is a delimiter. If not selected, the second field will be used as the filter field

* Field separator, can be modified, default is vertical bar\(\|\)

### Access method

The collector is a real-time collection and cannot be configured temporarily.

#### The access interface example is as follows

![](../../../../assets/access_new_tlog.png)