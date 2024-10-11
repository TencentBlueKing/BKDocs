# Terminology explanation

* **Index set**: A collection of one or more ES indexes that meet certain conditions. The prerequisite for retrieval and monitoring must be to form an index set. For specific usage, see [Index Set Management](../functions/manager/index_es.md)
* **Data classification**: Data classification is determined based on the collection object. This data classification is basically the same as the monitoring classification. This data label will also be appended to this data when it is used. The built-in data dimensions will also differ.

     ![-w2020](media/15774260466296.jpg)

     1. **Application**: refers to the user's use of the application and the application's operational data. Such as mobile terminal usage, number of business application logins, etc.
     2. **Service**: refers to the service module running on the server operating system. Such as database, process, etc. Corresponding to the CMDB-service topology, there will be differences in data collection for multiple instances.
     3. **Host**: refers to the host system and hardware level. Such as CPU MEM server hardware failure, etc. Corresponds to CMDB-host topology
     4. **Data Center**: refers to the network and equipment related content related to the data center. Corresponds to CMDB-Device Management