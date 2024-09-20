# Offline calculation window type
The window type determines the range of data loaded.


## Scroll window
The scheduling cycles of the data window and offline tasks are consistent.

Taking the scheduling period as 1 hour as an example, the data window is also 1 hour. When the offline task is scheduled at 19 o'clock, the data during [18:00-19:00) will be obtained by default.

The window offset field can be modified to adjust the range of data acquisition.

## Sliding window

Each scheduling cycle supports obtaining data ranges that are inconsistent with the length of the scheduling cycle.

> The default window length is consistent with the scheduling period.

Scenario: Count the number of user logins in the last 24 hours every hour, then the scheduling period is 1 hour and the window length is 24 hours

## Accumulation window

Scenario: The cumulative sales of the day are counted every hour, the scheduling period is 1 hour, and the data accumulation range is 1 day.

At 1 o'clock, the sales between 0 and 1 o'clock will be counted, at 2 o'clock, the sales between 0 and 2 o'clock will be counted, and so on. At 0 o'clock on the second day, the sales between 0 and 24 o'clock will be counted. On day 1 of day 2, sales between 0 and 1 o'clock on day 2 will be counted.


## Full data
Scenario: The data source is an offline dimension table, and all data in the offline dimension table will be loaded.