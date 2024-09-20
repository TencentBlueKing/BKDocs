# Offline flow table

The result table stored in HDFS can be used for offline calculations at the hourly and daily levels.

Scenario: The data source is the distribution of return codes per minute, and it is expected to count the distribution of return codes every day.


The overall canvas effect is as follows:
![-w1109](media/16640635910914.jpg)

#### Source of offline data
Results table stored in HDFS
![-w1322](media/16640658538637.jpg)


#### How to use

- Select the corresponding offline flow meter.
![-w599](media/16640632757854.jpg)

- Reconfigure offline calculation
![-w1568](media/16640636158049.jpg)

#### Types of downstream nodes that can be connected
- Offline calculation