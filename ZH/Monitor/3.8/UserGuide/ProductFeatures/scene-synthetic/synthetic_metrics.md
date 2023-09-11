# 拨测指标说明


### TCP

- 指标：耗时
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.tcp.task_duration
  - 含义：一次 TCP 拨测的耗时
  - 采集方法-Linux：
        - 建立一次 TCP 拨测任务，并且访问指定配置文件地址，分别记录下发出请求（开始时间）以及请求结束的时间（结束时间）
        - 耗时 = 结束时间 - 开始时间
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：单点可用率
  - 类型：拨测
  - 单位：%
  - Metric：uptimecheck.tcp.avaliable
  - 含义：拨测可用率占比
  - 采集方法-Linux：
        - 当拨测即 TCP 访问特定配置文件地址失败时为 0，当访问成功为 1
        - 拨测可用率占比 = 拨测成功状态 / 总的拨测次数 * 100%
  - 采集方法-Windows：计算方式与 Linux 相同

### UDP

- 指标：耗时
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.udp.task_duration
  - 含义：一次 UDP 拨测任务的耗时
  - 采集方法-Linux：
        - 建立一次 UDP 连接访问配置文件中的特点 IP，分别计算发出请求的时间以及响应成功的时间
        - 耗时 = 成功响应时间 - 发出请求时间
        - PS：响应不成功或响应与预期不符则不计算耗时
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：单点可用率
  - 类型：拨测
  - 单位：%
  - Metric：uptimecheck.udp.available
  - 含义：拨测可用率占比
  - 采集方法-Linux：
        - 当拨测即 UDP 访问特定配置文件地址失败时为 0，当访问成功为 1
        - 拨测可用率占比 = 拨测成功状态 / 总的拨测次数 * 100%
  - 采集方法-Windows：计算方式与 Linux 相同

### HTTP

- 指标：耗时
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.http.task_duration
  - 含义：一次 HTTP 拨测任务的耗时
  - 采集方法-Linux：
        - 建立一次 HTTP 连接访问配置文件中的特点 IP，分别计算发出请求的时间以及响应成功的时间
        - 耗时 = 成功响应时间 - 发出请求时间
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：单点可用率
  - 类型：拨测
  - 单位：%
  - Metric：uptimecheck.http.available
  - 含义：拨测可用率占比
  - 采集方法-Linux：
        - 当拨测即 HTTP 访问特定配置文件地址失败时为 0，当访问成功为 1
        - 拨测可用率占比 = 拨测成功状态 / 总的拨测次数 * 100%
  - 采集方法-Windows：计算方式与 Linux 相同

### ICMP

- 指标：平均 rtt
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.icmp.avg_rtt
  - 含义：平均往返时间（rtt 一个很小的数据报到服务器并返回所经历的时间）
  - 采集方法-Linux：
        - 在一次拨测任务中分别计算总体的 RTT 时间 TotalRTT 以及接收数据的次数 RecvCount
        - 平均 RTT = TotalRTT / RecvCount
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：丢包率
  - 类型：拨测
  - 单位：%
  - Metric：uptimecheck.icmp.loss_percent
  - 含义：丢包率
  - 采集方法-Linux：
        - 在一次拨测任务中分别计算总体接收数据的次数 TotalCount 接收到数据的次数 RecvCount
        - 丢包率 = (TotalCount - RecvCount) / TotalCount
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：可用率
  - 类型：拨测
  - 单位：%
  - Metric：uptimecheck.icmp.available
  - 含义：拨测可用率
  - 采集方法-Linux：
        - 拨测可用率 = 1 - 丢包率
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：最大 RTT
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.icmp.max_rtt
  - 含义：一次拨测任务过程中最长的 RTT 时间
  - 采集方法-Linux：
        - 当拨测任务接收到返回值时触发回调函数，记录最大的 RTT 时间
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：最小 RTT
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.icmp.min_rtt
  - 含义：一次拨测任务过程中最短的 RTT 时间
  - 采集方法-Linux：
        - 当拨测任务接收到返回值时触发回调函数，记录最短的 RTT 时间
  - 采集方法-Windows：计算方式与 Linux 相同

- 指标：平均耗时
  - 类型：拨测
  - 单位：ms
  - Metric：uptimecheck.icmp.task_duration
  - 含义：一次拨测任务的平均耗时（与 avg_rtt 相同）
  - 采集方法-Linux：
        - 在一次拨测任务中分别计算总体的 RTT 时间 TotalRTT 以及接收数据的次数 RecvCount
        - 平均耗时 = TotalRTT / RecvCount
  - 采集方法-Windows：计算方式与 Linux 相同

