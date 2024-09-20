# Dimension drill down


## scenes to be used

- Pain point: If the single indicator alarm policy configured in BlueKing Monitoring is not configured with complete dimension information, it may not be possible to accurately determine which dimension is the cause of the current anomaly when the alarm is issued. The dimensional drill-down function can automatically analyze abnormal dimensional information and assist in locating problems.
- Usage: The more the indicator fluctuation is inconsistent with the expected dimension value, the higher the anomaly score will be. If the distribution difference of abnormal scores of each dimension value in a dimension is larger, the dimension is more abnormal (the more worthy of investigation, the higher the JS divergence will be).

![](media/16925964022720.jpg)

> Note: The dimension drill-down function currently only supports time series type data (single indicator), and does not support multi-indicator calculations, and the data source must contain detailed dimensions for drill-down.


## Instructions

In the [Dimension Drill Down] tab of the [Alarm Details] side-swipe page, you can view the abnormal dimensions drilled down on the current alarm, the abnormal score distribution, and the detailed curves of the abnormal dimensions.

![](media/16925964740438.jpg)