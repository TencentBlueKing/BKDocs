# TDW access

## Introduction

tdw access synchronizes the data from Luozi out of the database to HDFS to the platform

## Collection principle

The platform's TDW task pulls data from HDFS

## Data access

### Data information

It defines the basic information of the source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

* HDFS URL

* Data directory

* account password

### Access method

The access method is temporarily unmodifiable.

#### The access interface example is as follows

![](../../../../assets/access_new_tdw.png)