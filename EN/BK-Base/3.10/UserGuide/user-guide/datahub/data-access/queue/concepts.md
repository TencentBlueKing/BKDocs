# Message queue access

## Introduction

Message queue access provides real-time message queue data reporting function. It can dynamically sense the addition of content in the message queue, and supports real-time collection of new data and reporting to the platform. Currently only Kafka message queue is supported.

## Data access

### Data definition

Defines the basic information of source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

Each access object defines the message queue type and message queue connection information. Currently only Kafka message queue is supported.

* Broker address: Kafka’s broker address;
* Consumer group: Kafka consumer consumer group;
* Consumption Topic: Fill in the Kafka topic that needs to be consumed;
* Maximum number of concurrencies: Choose how many partitions to use to process data in the original message queue;
* Whether to use encryption: whether to encrypt the data in the message queue;


### Access method

The collector collects data in real time and cannot be configured temporarily.

