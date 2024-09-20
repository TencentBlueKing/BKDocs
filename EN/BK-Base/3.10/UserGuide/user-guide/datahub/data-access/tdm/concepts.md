# TDM access

## Introduction

TDM access synchronization provides a way to access Tencent Data Master's data to the platform

## Collection principle

The platform's TDM task pulls data from TDM to the platform

## Data access

### Data information

Defines the basic information of source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

* SourceId

*EventName

* Business feature ID (optional)

### Access method

The access method cannot be modified temporarily, and only real-time incremental collection method is provided.

#### The access interface example is as follows

![](../../../../assets/access_new_tdm.png)