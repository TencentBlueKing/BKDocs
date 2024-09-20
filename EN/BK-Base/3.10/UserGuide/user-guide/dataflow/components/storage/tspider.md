# Tspider
The bottom layer of the Tspider node is a distributed relational database storage based on MySQL.

Legend, Tspider node

![](../../../../assets/dataflow/components/storage/dataflow-tspider.png)

#### How to use
- Node name: automatically generated, consisting of the upstream result table and the current node type
- Result data table: inherited from the upstream node
- Storage cluster: Usually the default cluster group cluster is optional, and other optional clusters are related to the project to which the task belongs.
- Expiration time: the expiration time saved after the data is stored in the database

In addition, the Tspider node can specify whether the field is an index field based on the output of the upstream node result table.

Configuration example is as follows:

![](../../../../assets/dataflow/components/storage/dataflow-tspider-example.png)

For running tasks, after double-clicking the node, the data in Tspider can be queried on the data query tab page:

![](../../../../assets/dataflow/components/storage/dataflow-tspider-query.png)