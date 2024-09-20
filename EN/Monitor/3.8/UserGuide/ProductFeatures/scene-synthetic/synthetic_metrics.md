# Description of dial test indicators


### TCP

- Indicator: Time consuming
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.tcp.task_duration
   - Meaning: the time taken for a TCP dial test
   - Collection method-Linux:
         - Create a TCP dial test task, access the specified configuration file address, and record the request (start time) and the end time of the request (end time).
         - Time taken = end time - start time
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: single point availability
   - Type: dial test
   - Unit: %
   - Metric: uptimecheck.tcp.avaliable
   -Meaning: Proportion of dial test availability rate
   - Collection method-Linux:
         - When the dial test, that is, TCP access to the specific configuration file address fails, it is 0, and when the access is successful, it is 1
         - Dialing test availability ratio = dialing test success status / total number of dialing tests * 100%
   - Collection method-Windows: The calculation method is the same as Linux

### UDP

- Indicator: Time consuming
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.udp.task_duration
   -Meaning: The time consumption of a UDP dial test task
   - Collection method-Linux:
         - Establish a UDP connection to access the characteristic IP in the configuration file, and calculate the time of request and the time of successful response respectively.
         - Time taken = Successful response time - Request time
         - PS: If the response is unsuccessful or the response does not meet expectations, the time consumption will not be calculated.
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: single point availability
   - Type: dial test
   - Unit: %
   - Metric: uptimecheck.udp.available
   -Meaning: Proportion of dial test availability rate
   - Collection method-Linux:
         - It is 0 when the dial test, that is, UDP access to the specific configuration file address fails, and 1 when the access is successful.
         - Dialing test availability ratio = dialing test success status / total number of dialing tests * 100%
   - Collection method-Windows: The calculation method is the same as Linux

### HTTP

- Indicator: Time consuming
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.http.task_duration
   -Meaning: The time taken for an HTTP dial test task
   - Collection method-Linux:
         - Establish an HTTP connection to access the characteristic IP in the configuration file, and calculate the time of request and the time of successful response respectively.
         - Time taken = Successful response time - Request time
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: single point availability
   - Type: dial test
   - Unit: %
   - Metric: uptimecheck.http.available
   -Meaning: Proportion of dial test availability rate
   - Collection method-Linux:
         - When the dial test, that is, HTTP access to the specific configuration file address fails, it is 0, and when the access is successful, it is 1
         - Dialing test availability ratio = dialing test success status / total number of dialing tests * 100%
   - Collection method-Windows: The calculation method is the same as Linux

### ICMP

- Indicator: average rtt
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.icmp.avg_rtt
   - Meaning: average round trip time (rtt is the time it takes for a small datagram to arrive at the server and return)
   - Collection method-Linux:
         - Calculate the overall RTT time TotalRTT and the number of data received RecvCount in a dial test task.
         - Average RTT = TotalRTT / RecvCount
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: Packet loss rate
   - Type: dial test
   - Unit: %
   - Metric: uptimecheck.icmp.loss_percent
   - Meaning: Packet loss rate
   - Collection method-Linux:
         - Calculate the total number of data received in a dial test task TotalCount The number of data received RecvCount
         - Packet loss rate = (TotalCount - RecvCount) / TotalCount
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: Availability
   - Type: dial test
   - Unit: %
   - Metric: uptimecheck.icmp.available
   -Meaning: Dial test availability
   - Collection method-Linux:
         - Dial test availability rate = 1 - Packet loss rate
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: Maximum RTT
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.icmp.max_rtt
   - Meaning: the longest RTT time during a dial test task
   - Collection method-Linux:
         - When the dial test task receives the return value, the callback function is triggered and the maximum RTT time is recorded.
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: Minimum RTT
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.icmp.min_rtt
   - Meaning: the shortest RTT time during a dial test task
   - Collection method-Linux:
         - When the dial test task receives the return value, the callback function is triggered and the shortest RTT time is recorded.
   - Collection method-Windows: The calculation method is the same as Linux

- Indicator: average time taken
   - Type: dial test
   - Unit: ms
   - Metric: uptimecheck.icmp.task_duration
   - Meaning: the average time taken for a dial test task (same as avg_rtt)
   - Collection method-Linux:
         - Calculate the overall RTT time TotalRTT and the number of data received RecvCount in a dial test task.
         - Average time taken = TotalRTT / RecvCount
   - Collection method-Windows: The calculation method is the same as Linux