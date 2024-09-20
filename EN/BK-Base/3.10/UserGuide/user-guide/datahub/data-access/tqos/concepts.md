# TQOS access

## Introduction

Tqos access is similar to log access. The tqos log access process is optimized, the log path is filled in by default, and the tqosid table is provided for users to choose.

## Collection principle

TQOS logs are stored on the servers of Tencent Data Analysis Platform TQoS business, and log collectors are deployed on these log servers to collect logs, filter and report them.

## Data access

### Data information

It defines the basic information of the source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

Select TQOS ID

### Access method

The collector is a real-time collection and cannot be configured temporarily.

#### The access interface example is as follows

![](../../../../assets/access_new_tqos.png)