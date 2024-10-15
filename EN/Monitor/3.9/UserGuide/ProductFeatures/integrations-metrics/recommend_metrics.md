## 1. Introduction to time series database

Time series data is a database specially optimized for time series data. It mainly has the following characteristics:
    
- Special optimization for batch writing. Taking the BlueKing monitoring platform as an example, it currently supports a write speed of 10k per second by default.
- Data is automatically indexed. Compared with relational databases, the time series database writes data by default to distinguish whether the field type is an indicator or a dimension. Time series data will automatically index dimension fields, eliminating the need for table structure maintenance and making it easier for users to use dimension fields for aggregation and query filtering.
- Indicator data storage compression. Due to the immutable dimensionality of time series data, time series databases mostly use columnar storage mode, which can achieve considerable data compression ratios. Taking the host monitoring data of the BlueKing monitoring platform as an example, our 200,000 hosts occupy 15TB of data for 30 days, and the average disk space used by each host per day is 2MB.
- Since time series databases index dimension fields by default, the number of dimension combinations will greatly affect the performance of time series data. Dimension combinations: refers to the number of combinations of dimension names and values in time series data after deduplication. For example:

     ```
usage{ip="10.0.0.1"} 100
usage{ip="10.0.0.1"} 200
usage{ip="10.0.0.1"} 300
```
    
     Among them, after deduplication of the `ip` field value, there are only `10.0.0.1` and `10.0.0.1`, and the number of dimension combinations is 2. Therefore, we strongly do not recommend reporting random attributes as dimensions, such as request ID, time, user ID, etc.

## 2. Default support for magnitude

The monitoring platform provides default storage instances that can support:

- The total number of dimension combinations does not exceed 10m
- The growth rate of dimension combination needs to be controlled below 100 per minute
- The number of indicators does not exceed 5k
- No more than 10k indicator points are reported per second

If the reported data is outside this range, storage needs to be split.

## 3. Common optimization methods

- If there are too many indicators, please confirm whether the reported indicator name contains dimension information. For example: `cpu_0_usage 100` indicates the single-core usage of CPU0. This metric should be changed to usage{cpu="0"} 100.
- If you find that there are too many dimension combinations, please confirm whether the dimension information contains unnecessary information. For example: `memory_usage{room_id="585bcc656d", room_type="battle", instanceID="0.1.0.1"} 50` means that the instance ID is 0.1.0.1, the listening port is 5260, and the room ID is 585bcc656d. The process memory usage is 50 %. However, because the room ID is a random value, it can easily lead to excessive pressure on the time series database index. At this time, it is recommended to remove the room_id indicator.