# SQL Query FAQ

### Query MySQL data prompt query timeout

Exception prompts MySQL query timeout, often because the amount of data stored in the table is relatively large or the SQL query is complex. First, check whether these two factors exist.

#### 1. The amount of data in the table is too large or the query SQL is complex, causing the MySQL query to time out.

First consider streamlining the SQL, such as shortening the time range of the query in where or removing the order by sorting condition. These can greatly improve the query speed. If it is inconvenient to streamline SQL due to business needs, it is recommended to store another copy of the data into HDFS for data query. HDFS supports large data volumes and complex SQL queries. Reference for storing data in HDFS: [data storage](../../. ./datahub/data-shipper.md).

#### 2. The amount of data in the table is small and querying SQL is relatively simple, but the query times out.

At this time, it may be due to high load on the underlying storage cluster or other reasons. You need to contact the platform to troubleshoot the problem.