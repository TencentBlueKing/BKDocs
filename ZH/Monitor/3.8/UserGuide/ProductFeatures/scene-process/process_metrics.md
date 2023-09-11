# CMDB进程指标说明

| 指标 | 单位  | 备注 | 采集方式(Linux) |
| --- | --- | --- | --- | --- |
| Process.CPU | % | 进程当前占用 CPU 的使用率 | 从/proc/{pid}/stat 中采集：获得采集间隔中，进程系统 CPU 总时间及用户 CPU 总时间，然后与上一次采集值对比的差值为当次进程 CPU 使用时间，使用率为当次 CPU 使用时间除以采集间隔(current_total_time - last_total_time) / (gap_time) |
| Process.Mem | % | 进程当前占用内存的使用率 | 从/proc/{pid}/statm 采集：使用当前进程的物理使用量除以机器整体物理内存量 |
| Process.FileDescriptor |  文件句柄数 | | lsof -p ${pid} 来获取单个进程占用的文件句柄数 |
| Process.RES | MB | 物理内存 | 任务已使用的物理内存大小 | 从/proc/{pid}/statm 采集 |
| Process.VIRT | MB | 虚拟内存 | 任务已使用的虚拟内存大小 | 从/proc/{pid}/statm 采集 |


## 动态进程插件采集的指标说明

- 指标：CPU 使用率
  - 类型：进程
  - 单位：%
  - Metric：process.perf.cpu_total_pct
  - 含义：进程运行所消耗的 CPU 的占比
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 utime、stime 的值，其分别表示进程运行在用户态下的时间以及运行在系统态下的时间
        - total = utime + stime
        - 单位时间内获取两次 total 的数据，分别为 total1、total2
        - CPU使用率 = (total2 - total1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取进程的 UserTime、KernelTime、ExitTime、CreationTime
        - total = KernelTime + UserTime
        - 单位时间内获取两次 total 的数据，分别为 total1、total2
        - CPU使用率 = (total2 - total1) / 单位时间

- 指标：内存使用率
  - 类型：进程
  - 单位：%
  - Metric：process.perf.mem_usage_pct
  - 含义：进程运行所消耗的内存空间的占比
  - 采集方法-Linux：
        - 解析 /proc/pid/statm 文件获取 rss 的值
        - 内存使用率 = rss / 总共的内存空间大小
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessMemoryInfo` 获取进程的 WorkingSetSize 值，其表示当前进程运行所使用的内存空间大小
        - 内存使用率 = WorkingSetSize / 总共的内存空间大小

- 指标：文件句柄数
  - 类型：进程
  - 单位：count
  - Metric：process.perf.fd_num
  - 含义：进程运行所使用的文件的数量
  - 采集方法-Linux：
        - 解析 /proc/pid/fd 文件其中每一行表示打开的一个文件，总行数即为当前进程所使用的文件的数量
  - 采集方法-Windows：N/A

- 指标：文件句柄硬限制
  - 类型：进程
  - 单位：count
  - Metric：proc.fd_limit_hard
  - 含义：Linux 句柄硬限制，对进程 fd 的资源数的限制的最大值
  - 采集方法-Linux：
        - 解析 /proc/pid/limits 文件获取 HardLimit 的值，这个值代表当前进程所运行开启文件的硬限制
  - 采集方法-Windows：N/A
  - PS：SoftLimit 表示 kernel 设置给资源的值；HardLimit 表示 SoftLimit 的上限

- 指标：文件句柄软限制
  - 类型：进程
  - 单位：count
  - Metric：proc.fd_limit_soft
  - 含义：Linux 句柄软限制，对进程 fd 资源数的限制的当前值
  - 采集方法-Linux：
        - 解析 /proc/pid/limits 文件获取 SoftLimit 的值，这个值代表当前进程所运行开启文件的软限制
  - 采集方法-Windows：N/A
  - PS：SoftLimit 表示 kernel 设置给资源的值，Hard Limit 表示 SoftLimit 的上限

- 指标：物理内存
  - 类型：进程
  - 单位：KB
  - Metric：process.perf.mem_res
  - 含义：进程运行所使用的内存的大小
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 rss 的值，其表示当前进程运行所使用的内存空间大小
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessMemoryInfo` 获取 WorkingSetSize 的值，其表示当前进程运行所使用的内存空间大小

- 指标：虚拟内存
  - 类型：进程
  - 单位：KB
  - Metric：process.perf.mem_virt
  - 含义：进程运行所使用的虚拟的大小
  - 采集方法-Linux：
        - 解析 /proc/pid/statm 文件获取 size 的值，其表示虚拟内存空间的大小
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessMemoryInfo` 获取 PrivateUsage 的值，其表示虚拟内存空间的大小

- 指标：进程启动时间
  - 类型：进程
  - 单位：秒
  - Metric：process.perf.cpu_start_time
  - 含义：进程启动的时间
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 starttime 的值，其表示进程在系统启动多久之后再启动的
        - 解析 /proc/stat 文件获取 btime 的值，其表示系统启动的时间
        - 进程启动时间 = starttime + btime
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取 CreationTime 的值，其表示进程的启动时间

- 指标：进程运行时间
  - 类型：进程
  - 单位：秒
  - Metric：process.perf.uptime
  - 含义：进程运行的总时长
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 starttime 的值，其表示进程在系统启动多久之后再启动的
        - 解析 /proc/stat 文件获取 btime 的值，其表示系统启动的时间
        - 进程启动时间 = starttime + btime
        - 进程运行时间 = 当前时间 - 进程启动时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取启动时间 CreationTime 的值
        - 进程运行时间 = 当前时间 - 进程启动时间

- 指标：进程占用系统态时间
  - 类型：进程
  - 单位：秒
  - Metric：process.perf.cpu_system
  - 含义：进程占用系统态的时间
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 stime 的值，其表示当前进程占用系统态的时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取启动时间 KernelTime 的值，其表示进程占用系统态的时间

- 指标：进程占用用户态时间
  - 类型：进程
  - 单位：秒
  - Metric：process.perf.cpu_user
  - 含义：进程占用用户态时间
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 utime 的值，其表示当前进程占用系统态的时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取启动时间 UserTime 的值，其表示进程占用系统态的时间

- 指标：整体占用时间
  - 类型：进程
  - 单位：秒
  - Metric：process.perf.cpu_total_ticks
  - 含义：整体占用时间
  - 采集方法-Linux：
        - 解析 /proc/pid/stat 文件获取 utime、stime 的值
        - 整体占用时间 = utime + stime
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessTimes` 获取 UserTime、KernelTime 其分别表示用户态占用的时间以及系统态占用的时间
        - 整体占用时间 = UserTime + KernelTime

- 指标：进程 IO 累计读
  - 类型：进程
  - 单位：count
  - Metric：proc.io.read_bytes
  - 含义：进程累计读取操作的次数
  - 采集方法-Linux：
        - 解析 /proc/pid/io 文件获取 syscr 的值
        - 进程 IO 累计读 = syscr
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessIoCounters` 获取 IOCount 数据 ReadOperationCount、ReadTransferCount、WriteOperationCount、WriteTransferCount
        - 进程累计 IO 读操作的次数 = ReadOperationCount

- 指标：进程 IO 累计写
  - 类型：进程
  - 单位：count
  - Metric：proc.io.write_bytes
  - 含义：进程累计写入操作的次数
  - 采集方法-Linux：
        - 解析 /proc/pid/io 文件获取 syscw 的值
        - 进程累计 IO 写操作的次数 = syscw
  - 采集方法-Windows：
        - 调用  Win32 API  `GetProcessIoCounters` 获取 IOCount 数据 ReadOperationCount、ReadTransferCount、WriteOperationCount、WriteTransferCount
        - 进程累计 IO 写操作的次数 = WriteOperationCount

- 指标：进程 IO 读速率
  - 类型：进程
  - 单位：bytes/s
  - Metric：proc.io.read_speed
  - 含义：单位时间内当前进程读取的速率
  - 采集方法-Linux：
        - 解析 /proc/pid/io 文件获取 read_bytes 的值，这个值表示当前进程累计的读取 bytes 大小
        - 单位时间内获取两次 read_bytes，分别为 read_bytes1、read_bytes2
        - 进程 IO 读取速率= (read_bytes2-read_bytes1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessIoCounters` 获取 IOCount 数据 ReadOperationCount、ReadTransferCount、WriteOperationCount、WriteTransferCount
        - 单位时间内获取两次 ReadTransferCount 的值，分别为 ReadTransferCount1、ReadTransferCount2
        - 进程 IO 读取速率 = (ReadTransferCount2 - ReadTransferCount1) / 单位时间

- 指标：进程 IO 写速率
  - 类型：进程
  - 单位：bytes/s
  - Metric：proc.io.write_speed
  - 含义：单位时间内当前进程写入的速率
  - 采集方法-Linux：
        - 解析 /proc/pid/io 文件获取 write_bytes 的值，这个值表示当前进程累计写入 butes 的大小
        - 单位时间内获取两次 syscr 的值， 分别为 write_bytes1、write_bytes2
        - 进程 IO 写速率= (write_bytes2 - write_bytes1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetProcessIoCounters` 获取 IOCount 数据 ReadOperationCount、ReadTransferCount、WriteOperationCount、WriteTransferCount
        - 单位时间内获取两次 WriteTransferCount 的值，分别为 WriteTransferCount1、WriteTransferCount2
        - 进程 IO 写速率 = (WriteTransferCount2 - WriteTransferCount1) / 单位时间

