## Present the number of page visits through the report

## Scenario

A new function has been launched on the product. I want to present the real-time number of page visits and daily visit trends through reports, so as to provide data support for the next iteration.

Since the amount of business data is very large, directly querying the database will lead to slow queries, so the presented chart data is pre-calculated through data development tasks.

## Preconditions

- Completed [Data Reporting](../user-guide/datahub/data-access/concepts.md).
- Completed [Data Cleaning](../user-guide/datahub/data-clean/detail.md).
- Understand [real-time computing](../user-guide/dataflow/stream-processing/concepts.md), [offline computing] of [data development](../user-guide/dataflow/ide/concepts.md) (../user-guide/dataflow/batch-processing/concepts.md).
- Learn about [Superset BI](../user-guide/dataview/superset.md).

## Steps

### Combing data flow

- Count the number of visitors **per minute** through **real-time calculation**.
- Count the number of visitors **every day** through **offline calculation**.

![](media/15892693371456.jpg)


### Create data development task

Create a new [data development task](../user-guide/dataflow/ide/concepts.md) and complete it through [real-time computing node](../user-guide/dataflow/stream-processing/concepts.md) To count the number of visitors per minute, [offline computing node](../user-guide/dataflow/batch-processing/concepts.md) counts the number of visitors every day. The effect is as follows:

![-w1725](media/15861555228060.jpg)


Next, we will introduce how to create a data development task.

#### Select data source

Select the **real-time data source** after data storage and cleaning in the canvas.

![-w1702](media/15861567430220.jpg)


#### Create a new real-time computing node

Create a new **real-time computing node**, connect it behind the data source, and perform statistics every minute.

![-w1919](media/15861557672676.jpg)

After the node **Connect a storage**, after starting the task, you can query the statistics per minute as follows:

![-w1478](media/15861561652917.jpg)

At the same time, connect an HDFS storage as a data source for offline tasks. (The data source storage type for offline calculation is HDFS)

> Why Tspider (MySQL) and HDFS are connected to the real-time computing node? This is because MySQL has a faster response time for small data queries and is used for chart presentation.


#### Create a new offline computing node

Connect an offline computing node after the result data table (HDFS storage) generated in the previous step, and select 1 day as the statistical frequency to count daily PV once a day.

![-w1917](media/15861571450299.jpg)

After the above node, connect a storage and start the task. On the second day, you can view the daily statistics as follows:

![-w1653](media/15861563029540.jpg)

> If the data in the offline task data source has multiple days and you want to calculate the past data, you can use the [offline recalculation](../user-guide/dataflow/batch-processing/rerun.md) function.

The data is ready. Next, use Superset BI to create a graph.

### Create a Superset BI chart

Follow the guidelines of [Superset BI](../user-guide/dataview/superset.md) to complete the report production. The effect is as follows.

![-w1329](media/15843337149517.jpg)