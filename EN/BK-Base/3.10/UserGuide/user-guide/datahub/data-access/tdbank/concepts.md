# TDBANK access

## Introduction

tdbank access is a way to import tdbank data. Consumption data is reported to the platform through tdbank's tube.

Users first create tube consumption in tdbank, and then configure it on the platform.

## Collection principle

The platform's tdbank task consumes data from the tube

## Data access

### Data information

It defines the basic information of the source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

Access object parameters can be queried from the tdbank page, please refer to [How to query tdbank parameters](./tdbank-query.md)

* Master address

*Consumer group

*Consumption Topic

* Interface name There are two interface types according to the user's access method in TDBANK: tid and iname, the default is tid

tid: Send to TDBANK through messages, or flow from oceanus to message middleware through tdbus
iname: TDBANK file type access, or direct access to the message middleware through oceanus
For specific information, please consult: TDBank_TDW_TRC_Helper

* The interface value is combined with the interface name to distinguish data ownership.

* Whether it is a mixed data source\(You need to find the data writer to confirm, multiple interfaces of mixed data exist in the same file\)

* Delimiter. Valid when mixing data sources. Supports ASCII code to fill in invisible characters

### Access method

The access method is temporarily unmodifiable.

#### The access interface example is as follows

![](../../../../assets/access_new_tdbank.png)