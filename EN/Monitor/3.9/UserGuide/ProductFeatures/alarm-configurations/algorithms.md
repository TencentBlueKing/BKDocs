# value: current value
# history_value: the average value of the first n time points
# ceil: increase
# floor: decrease
# Calculate the increase/decrease between the current value (value) and the average value at the previous time point (history_value)

# Average calculation example of the first n time points (data period 1 minute)
Taking the date 2019-08-26 12:00:00 as an example, if n is 5, the historical time and corresponding values are as follows:
```

||Time|Value|
|---|---|---|
|1 |2019-8-26 11:59:00 | 12 |
|2 |2019-8-26 11:58:00 | 22 |
|3 |2019-8-26 11:57:00 | 32 |
|4 |2019-8-26 11:56:00 | 42 |
|5 |2019-8-26 11:55:00 | 52 |

```python
history_value = (12 + 22 + 32 + 42 + 52) / 5 = 32
```

- Example: When value(90), ceil(100), history_value(32), it is judged as abnormal

### Year-on-year amplitude

#### Applicable scene

- Scenario: Suitable for monitoring events with a daily cycle. The event will clearly cause the indicator to increase or decrease, but it is necessary to monitor the scenario where the change exceeds a reasonable range.

     For example, there is a rush sale event at 10 a.m. every day, and the content of the event remains unchanged, so the number of requests will increase to a certain extent at 10:00 every day compared to 09:59. Because the activity content remains unchanged, the increase in request volume is within a certain range. Use this policy to spot unusual request volumes.

#### Configuration method

![-w2021](media/15730233179624.jpg)

#### working principle

```python
# Algorithm example:
Current value − previous time value >= difference value at the same time on any day in the past 5 days × 2 + 3

Taking the date 2019-08-26 12:00:00 as an example, if n is 5, the historical time and corresponding values are as follows:
```

||Time|Value|Previous moment|Previous moment value|Difference|
|---|---|---|---|---|---|
|0 |2019-8-26 12:00:00 | 26 |2019-8-26 11:59:00 | 10 |16|
|1 |2019-8-25 12:00:00 | 25 |2019-8-25 11:59:00 | 18 |7 |
|2 |2019-8-24 12:00:00 | 24 |2019-8-24 11:59:00 | 30 |6 |
|3 |2019-8-23 12:00:00 | 23 |2019-8-23 11:59:00 | 31 |8|
|4 |2019-8-22 12:00:00 | 22 |2019-8-22 11:59:00 | 32 |10|
|5 |2019-8-21 12:00:00 | 21 |2019-8-21 11:59:00 | 33 |12|

```python
# The current value
value=26
#Previous moment value
prev_value = 10
# Comparison operators (=, >, >=, <, <=, !=)
method = ">="
# Volatility
ratio = 2
# Amplitude
shock=3
# The difference between the current value and the previous value
current_diff = 16
#Same time difference within 5 days
prev5_diffs = [7, 6, 8, 10, 12]

The same time difference on the previous day (2019-8-24): 6 * ratio(2) + shock(3) = 15
current_diff(16) >= 15

# Current value (26) - previous value (10) >= difference at the same time 2 days ago 6 * 2 + 3
At this time, the algorithm detection determines that the detection result is abnormal:
```

### Year-on-year range

#### Applicable scene

Boiling frog type - data rises or falls slowly

![-w2021](media/15807168374571.jpg)

Suitable for curve scenarios with a daily cycle.

Since the data in this model changes slowly, no alarm can be detected using [Monogram Strategy] or [Year-to-Year Amplitude], because these two models are mainly used in situations where there is a sudden increase, sudden decrease, or is greater than or less than the specified value. .

[Year-over-year interval] is only applicable to this situation, because as the data changes, the gap between the current value and the model value becomes larger and larger, and the interval comparison mainly compares the current value with the historical model value.

#### Configuration method

![-w2021](media/15892524354204.jpg)

#### working principle

- Implementation principles & examples:

```python
# Algorithm example:
Current value >= Absolute value at the same time in the past 5 days × 2 + 3

Taking the date 2019-08-26 12:00:00 as an example, if n is 5, the historical time and corresponding values are as follows:
```

||Time|Value|
|---|---|---|
|0 |2019-8-26 12:00:00 | 26 |
|1 |2019-8-25 12:00:00 | 16 |
|2 |2019-8-24 12:00:00 | 14 |
|3 |2019-8-23 12:00:00 | 13 |
|4 |2019-8-22 12:00:00 | 16 |
|5 |2019-8-21 12:00:00 | 15 |

```python
# The current value
value=11
# Comparison operators (=, >, >=, <, <=, !=)
method = ">="
# Volatility
ratio = 2
# Amplitude
shock=3

The same time value on the third day before (2019-8-23): 13 * ratio(2) + shock(3) = 26
value(26) >= 26

# Current value (26) >= absolute value at the same time 3 days ago 13 * 2 + 3
At this time, the algorithm detection determines that the detection result is abnormal:
```

### Chain amplitude

#### Applicable scene

- Suitable for scenarios where the indicator suddenly increases or drops. If the indicator drops sharply, the value of ratio (volatility) configuration needs to be < -1
- This algorithm freely opens the ring-to-chain algorithm, and can monitor sudden changes in data by configuring the volatility and amplitude. At the same time, the minimum threshold can filter out invalid data

#### Configuration method

![-w2021](media/15892523996558.jpg)

#### working principle

```python
# The current value (value) and the previous value (prev_value) are both >= (threshold), and the difference between them >= the previous value (prev_value) * (ratio) + (shock)

# value: current value
# prev_value: value at the previous moment
# threshold: lower limit of threshold
# ratio: volatility
# shock: amplitude

Take the date 2019-08-26 12:00:00 as an example:
```

||Time|Value|
|---|---|---|
| 0 |2019-8-26 12:00:00 | 46 |
| 1 |2019-8-26 11:59:00 | 12 |


```python
# The current value
value=46
#Previous moment value
prev_value = 12
# Volatility
ratio = 2
# Amplitude
shock=3

value(46) >= 10 and prev_value(12) >=10
value(46) >= prev_value(12) * (ratio(2) + 1) + shock(3)

At this time, the algorithm detection determines that the detection result is abnormal:
# The current value (46) and the previous value (12) are both >= (10), and the difference between them >= the previous value (12) * (2) + (3)
```

## Built-in special detection algorithm

The built-in special algorithm does not require configuration and is bound to the corresponding indicator by default.

### System restart

![](media/16621299662664.jpg)

Built-in detection algorithm: judgment based on time series data system.env.uptime.

```python
# The host running time is between 0 and 600 seconds
# The current running time of the host is smaller than the previous period value, or the previous period value is empty.
```

### Process port

![](media/16621300201982.jpg)


Built-in detection algorithm: based on time series data system.proc_port.exists and nonlisten, not_accurate_listen judgment

```python
# exists != 1 The process does not exist
# nonlisten != [] port does not exist
# not_accurate_listen != [] The process exists, but the port is inconsistent with the cmdb registered port
```

## Log keyword detection algorithm

Only static thresholds are supported