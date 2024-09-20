Indicator design
----

Indicator design includes two parts: `Indicator statistical caliber design` and `Indicator design`.

![-w1598](media/16381509611233.jpg)


## Indicator statistical caliber
Define the calculation logic of indicators to unify the team's indicator statistical caliber.

In addition to common aggregate functions (count/count_distinct/max/min/avg/sum) form generation methods

![-w1599](media/16381508996186.jpg)

Custom SQL is also supported

![-w939](media/16381513529294.jpg)



## Indicators
Based on the statistical caliber, time period and dimension, the specific indicator values for statistical analysis are instantiated and a result table is created.

In the process of generating indicators, you can standardize the indicator generation method and naming rules.

- Real-time indicators

![-w1916](media/16381509216339.jpg)

- Offline indicators

![-w1914](media/16381509373190.jpg)