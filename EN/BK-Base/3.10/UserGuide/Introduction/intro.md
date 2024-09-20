# Platform Introduction

BlueKing Basic Computing Platform (BK-BASE) is a basic platform focusing on the field of operation and maintenance, creating one-stop, low-threshold basic services. By simplifying the collection and acquisition of operation and maintenance data, it improves data development efficiency, assists operation and maintenance personnel in making real-time operation and maintenance decisions, and assists the digital and intelligent transformation of enterprise operation systems.


## Data Integration Service

- Based on the GSE unified data pipeline, self-service data source access is realized. Currently supported data sources include: log file collection, MySQL database collection, file upload, etc.

- Supports data access management, data source trends and original data content preview.

- Supports cleaning operations such as formatted extraction and conversion of original data sources based on fields. Currently, it supports more than 10 cleaning operators (including JSON deserialization, CSV deserialization, URL deserialization, traversal, segmentation, replacement, fetching, etc.) values and assignments, etc.).

- Supports direct storage and storage of data sources after cleaning, analytical data storage, time series storage (VictoriaMetrics), full-text retrieval (ElasticSearch), distributed file system (HDFS), message queue (Redis, Kafka) and relational database ( MySQL).

## Data Development Services

- Drag-and-drop data development IDE supports multiple data sources and data processing workflows, and can operate and manage the status of each workflow at the same time.

- Supports 3 types of data sources: real-time data sources, offline data sources and related data sources.

- Supports multiple data processing methods: real-time SQL, offline SQL, offload processing, confluence processing and algorithm model.

- Supports online debugging of data workflow and full-link data quality monitoring.

## Data query service

- Supports standard 2003 SQL query syntax.

- Support full text search.

## Permission Management Service

-Permission management and application based on two dimensions: project and data (business).

- Support role management, including project administrator, data developer, data administrator, etc.

- Supports data authorization management based on Token code.

- Support document management for application and approval.