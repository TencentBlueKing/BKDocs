# 主机-操作系统指标

内置的主机指标是通过 bkmonitorbeat 进行采集,不同的监控系统可能在计算方法上会有差异,了解计算方法能够好的理解采集上来的数据。

## CPU

### CPU 总览

|  CPU指标  |  含义  |
|  :-----  |  :-----  |
|  user  |  用户态时间  |
|  nice  |  用户态时间（低优先级，nice>0）|
|  system  |  内核态时间  |
|  idle  |  空闲时间  |
|  iowait  |  I/O等待时间  |
|  irq  |  硬中断  |
|  softirq  |  软中断  |
|  steal  |  花费在其他虚拟化环境运行的时间  |

- 指标：CPU 总使用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.usage
  - 含义：当前消耗的 CPU 百分比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - busy = user + nice+ sys + irq + softirq + steal
        - total = busy + idle + iowait
        - CPU 总使用率 = delta(busy) / delta(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - busy = user + system
        - total = idle + user + system
        - CPU 总使用率 = delta(busy) / delta(total) * 100

- 指标：CPU 空闲率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.idle
  - 含义：当前空闲的 CPU 百分比
  - 采集方法-Linux：
    - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
    - total = user + nice + sys + idle + irq + softirq + steal + iowait
    - CPU 空闲率 = delta(idle) / delta(total) * 100
  - 采集方法-Windows：
    - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
    - total = idle + user + system
    - CPU 空闲率 = delta(idle) / delta(total) * 100

- 指标：等待 IO 的时间占比
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.iowait
  - 含义：CPU 等待 IO 的百分比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 等待 IO 的时间占比 = delta(iowait) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：CPU 虚拟机时间占比
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.stolen
  - 含义：CPU 分配给虚拟机的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 虚拟机时间占比 = deltal(steal) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：CPU 系统占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.system
  - 含义：CPU 运行在系统程序的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 系统占用率 = deltal(sys) / detal(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - CPU 系统占用率 = delta(system) / delta(total) * 100

- 指标：CPU 用户占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.user
  - 含义：CPU 运行在用户程序的时间占比
  - 采集方法-Linux :
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 用户占用率 = deltal(user) / detal(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - CPU 用户占用率 = delta(user) / delta(total) * 100

- 指标：CPU 内核虚拟机占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.guest
  - 含义：CPU 内核在虚拟机上运行的占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 内核虚拟机占用率 = deltal(guest + guestnice) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：CPU 硬中断占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.interrupt
  - 含义：CPU 花费在硬中断上的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 硬中断占用率 = deltal(irq) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：CPU 软中断占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.softirq
  - 含义：CPU 花费在软中断上的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 软中断占用率 = deltal(softirq) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：CPU 低优先级程序占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_summary.nice
  - 含义：低优先级程序在用户态执行的 CPU 占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - CPU 低优先级程序占用率 = deltal(nice) / detal(total) * 100
  - 采集方法-Windows：N/A

### CPU 单核

- 指标：单核 CPU 使用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.usage
  - 含义：当前单核 CPU 使用率百分比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - busy = user + nice + sys + irq + softirq + steal
        - total = busy + idle + iowait
        - 单核 CPU 使用率 = delta(busy) / delta(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - busy = user + system
        - 单核 CPU 使用率 = delta(busy) / delta(total) * 100

- 指标：单核 CPU 空闲率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.idle
  - 含义：当前单核 CPU 空闲率百分比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 空闲率 = delta(idle) / delta(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - 单核 CPU 空闲率 = delta(idle) / delta(total) * 100

- 指标：单核 CPU 等待 IO 的时间占比
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.iowait
  - 含义：单核 CPU 等待 IO 的百分比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 等待 IO 的时间占比 = delta(iowait) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：单核 CPU 虚拟机时间占比
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.stolen
  - 含义：单核 CPU 分配给虚拟机的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 虚拟机时间占比 = deltal(steal) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：单核 CPU 系统占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.system
  - 含义：单核 CPU 运行在系统程序的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 系统占用率 = deltal(sys) / detal(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - 单核 CPU 系统占用率 = delta(system) / delta(total) * 100

- 指标：单核 CPU 用户占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.user
  - 含义：单核 CPU 运行在用户程序的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 用户占用率 = deltal(user) / detal(total) * 100
  - 采集方法-Windows：
        - 调用 Win32 API `GetSystemTimes` 获取 idle、user、system
        - total = idle + user + system
        - 单核 CPU 用户占用率 = delta(user) / delta(total) * 100

- 指标：单核 CPU 内核虚拟机占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.guest
  - 含义：单核 CPU 内核在虚拟机上运行的占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 内核虚拟机占用率 = deltal(guest + guestnice) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：单核 CPU 硬中断占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.interrupt
  - 含义：单核 CPU 花费在硬中断上的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 硬中断占用率 = deltal(irq) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：单核 CPU 软中断占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.softirq
  - 含义：单核 CPU 花费在软中断上的时间占比
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 软中断占用率 = deltal(softirq) / detal(total) * 100
  - 采集方法-Windows：N/A

- 指标：单核 CPU 低优先级程序占用率
  - 类型：CPU
  - 单位：%
  - Metric：cpu_detail.nice
  - 含义：低优先级程序在用户态执行的单核 CPU 占比
  - 采集方法-Linux：
        - 通过解析 /proc/stat 文件获取 user、nice、sys、irq、softirq、steal、guest、guestnice、idle、iowait信息
        - total = user + nice + sys + idle + irq + softirq + steal + iowait
        - 单核 CPU 低优先级程序占用率 = deltal(nice) / detal(total) * 100
  - 采集方法-Windows：N/A

### CPU 负载

Linux /proc/loadavg 文件内容如下
```shell
> cat /proc/loadavg
> 4.61 4.36 4.15 9/84 5662
> lavg_1 (4.61) 1 分钟平均负载
> lavg_5 (4.36) 5 分钟平均负载
> lavg_15(4.15) 15 分钟平均负载
> nr_running (9) 在采样时刻，运行队列的任务的数目，与 /proc/stat 的 procs_running 表示相同意思
> nr_threads (84) 在采样时刻，系统中活跃的任务的个数（不包括运行已经结束的任务）
> last_pid(5662) 最大的 pid 值，包括轻量级进程，即线程。
```

- 指标：1 分钟平均负载
  - 类型：CPU
  - 单位：-
  - Metric：system.load.load1
  - 含义：CPU 1 分钟内的平均负载
  - 采集方法-Linux：
        - 解析 /proc/loadavg 文件第 1 项数据即 1 分钟 CPU 平均负载
  - 采集方法-Windows：N/A

- 指标：5 分钟平均负载
  - 类型：CPU
  - 单位：-
  - Metric：system.load.load5
  - 含义：CPU 5 分钟内的平均负载
  - 采集方法-Linux：
        - 解析 /proc/loadavg 文件第 2 项数据即 5 分钟 CPU 平均负载
  - 采集方法-Windows：N/A

- 指标：15 分钟平均负载
  - 类型：CPU
  - 单位：-
  - Metric：system.load.load15
  - 含义：CPU 15 分钟内的平均负载
  - 采集方法-Linux：
        - 解析 /proc/loadavg 文件第 3 项数据即 15 分钟 CPU 平均负载
  - 采集方法-Windows：N/A

## DISK

- 指标：磁盘 IO 使用率
  - 类型：磁盘
  - 单位：%
  - Metric：io.util
  - 含义：磁盘处于活动时间的百分比
  - 采集方法-Linux：
        - 解析 /proc/diskstats 文件第 13 项获得 IoTime 指标
        - 单位时间 60s 内取两次 IoTime，分别为 IoTime1、IoTime2
        - 磁盘 IO 使用率 = (IoTime2 - IoTime1) / 60.0 / 1000.0
  - 采集方法-Windows：
        - 调用 Win32 API `GetLogicalDriveStringsW` 获取 ReadTime、WriteTime
        - IoTime = ReadTime + WriteTime
        - 单位时间内取两次 IoTime，分别为 IoTime1、IoTime2
        - 磁盘 IO 使用率 = (IoTime2 - IoTime1) / 60.0 / 1000.0

- 指标：磁盘写速率
  - 类型：磁盘
  - 单位：次/s
  - Metric：io.w_s
  - 含义：磁盘每秒写入次数
  - 采集方法-Linux：
        - 解析 /proc/diskstats 文件第 8 项获取 WriteCount 指标
        - 单位时间 60s 内取两次 WriteCount，分别为 WriteCount1、WriteCount2
        - 磁盘写速率 = (WriteCount2 - WriteCount1) / 60
        - PS：只上报逻辑分区
  - 采集方法-Windows：
        - 调用 Win32 API `GetLogicalDriveStringsW` 获取 WriteCount
        - 单位时间 60s 内取两次 WriteCount，分别为 WriteCount1、WriteCount2
        - 磁盘写速率 = (WriteCount2 - WriteCount1) / 60

- 指标：磁盘读速率
  - 类型：磁盘
  - 单位：次/s
  - Metric：io.rkb_s
  - 含义：磁盘每秒读取次数
  - 采集方法-Linux：
        - 解析 /proc/diskstats 文件每一行的第 4 项获取 ReadCount 指标
        - 单位时间 60s 内取两次 ReadCount，分别为 ReadCount1、ReadCount2
        - 磁盘读速率 = (ReadCount2 - ReadCount1) / 60
        - PS：只上报逻辑分区
  - 采集方法-Windows：
        - 调用 Win32 API `GetLogicalDriveStringsW` 获取 ReadCount
        - 单位时间 60s 内取两次 ReadCount，分别为 ReadCount1、ReadCount2
        - 磁盘读速率 = (ReadCount2 - ReadCount1) / 60

- 指标：磁盘使用率
  - 类型：磁盘
  - 单位：%
  - Metric：disk.is_use
  - 含义：磁盘已用空间的百分占比
  - 采集方法-Linux：
        - 调用 syscall.Statfs 接口获取磁盘的 Free、Total 信息
        - 磁盘使用率 = (Total - Free) / Total * 100%
  - 采集方法-Windows：
        - 调用 Win32 API `GetDiskFreeSpaceExW` 获取特定磁盘的 Total、Free、Used、UsedPercent
        - 磁盘使用率 = Used / Total * 100%

- 指标：磁盘空闲大小
  - 类型：磁盘
  - 单位：bytes
  - Metric：disk.free
  - 含义：磁盘剩余空间大小
  - 采集方法-Linux：
        - 调用 unix.Statfs 接口获取磁盘的 Free、Total 信息
        - Free 即表示磁盘空闲空间大小
  - 采集方法-Windows：
        - 调用 Win32 API `GetDiskFreeSpaceExW` 获取特定磁盘的 Total、Free、Used、UsedPercent
        - Free 即表示磁盘空间空闲的大小

- 指标：磁盘总空间大小
  - 类型：磁盘
  - 单位：bytes
  - Metric：disk.total
  - 含义：磁盘总空间大小
  - 采集方法-Linux：
        - 调用 unix.Statfs 接口获取磁盘的 Free、Total 信息
        - Total 即表示总共的磁盘空间大小
  - 采集方法-Windows：
        - 调用 Win32 API `GetDiskFreeSpaceExW` 获取特定磁盘的 Total、Free、Used、UsedPercent
        - Total 即表示总共的磁盘空间大小

- 指标：磁盘已用空间大小
  - 类型：磁盘
  - 单位：bytes
  - Metric：disk.used
  - 含义：磁盘已用的空间大小
  - 采集方法-Linux：
        - 调用 unix.Statfs 接口获取磁盘的 Free、Total 信息
        - 磁盘已用空间大小 = Used = Total - Free
  - 采集方法-Windows：
        - 调用 Win32 API `GetDiskFreeSpaceExW` 获取特定磁盘的 Total、Free、Used、UsedPercent
        - Used 即表示磁盘已用的空间大小

## ENV

- 指标：总进程数
  - 类型：进程
  - 单位：count
  - Metric：env.procs
  - 含义：当前总进程数
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 processes 字段即为当前总进程数量
  - 采集方法-Windows：N/A

- 指标：正在运行进程数
  - 类型：进程
  - 单位：count
  - Metric：env.proc_running_current
  - 含义：当前运行进程数量
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 procs_running 字段即为当前运行进程数量
  - 采集方法-Windows：N/A

- 指标：正在等待 IO 的进程数
  - 类型：进程
  - 单位：count
  - Metric：env.procs_blocked_current
  - 含义：当前正在等待 IO 进程数量
  - 采集方法-Linux：
        - 解析 /proc/stat 文件获取 procs_block 字段即为当前等待进程数量
  - 采集方法-Windows：N/A

## MEMORY

- 指标：物理内存总大小
  - 类型：内存
  - 单位：KB
  - Metric：mem.total
  - 含义：当前主机物理内存大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemTotal 字段即为物理内存总大小
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent
        - Total 所对应的值即为当前机器物理内存总大小

- 指标：物理内存空闲量
  - 类型：内存
  - 单位：KB
  - Metric：mem.free
  - 含义：当前主机物理内存处于空闲状态的大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemFree 字段即为物理内存空闲量
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent
        - Free 所对应的值即为当前机器物理内存空闲量

- 指标：Cache 缓存的空间大小
  - 类型：内存
  - 单位：KB
  - Metric：mem.cached
  - 含义：当前主机物理内存用于 Cache 缓存文件的空间大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 Cached 字段即物理内存 Cache 大小
  - 采集方法-Windows：N/A

- 指标：Buffer 的空间大小
  - 类型：内存
  - 单位：KB
  - Metric：mem.buffer
  - 含义：当前主机物理内存用于 Buffer 的空间大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 Buffers 字段即物理内存 Buffer 大小
  - 采集方法-Windows：N/A

- 指标：应用程序内存可用量
  - 类型：内存
  - 单位：KB
  - Metric：mem.usable
  - 含义：当前主机物理内存可用于启动应用程序的内存大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemAvailable 字段为用于启动应用程序的内存大小
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent

- 指标：应用程序内存可用率
  - 类型：内存
  - 单位：%
  - Metric：mem.pct_usable
  - 含义：当前主机物理内存可用于启动应用程序的内存百分比
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemTotal、MemAvailable
        - 应用内存可用率 = MemAvailable / MemTotal * 100%
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent
        - 应用内存可用率 = 1 - UsedPercent

- 指标：应用程序内存使用量
  - 类型：内存
  - 单位：KB
  - Metric：mem.used
  - 含义：当前主机物理内存被用于应用程序的大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemTotal、MemAvailable
        - 应用程序内存使用量 = MemTotal * (1-MemAvailable/MemTotal)
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent
        - 应用程序内存使用量 = Total * UsedPercent

- 指标：应用程序内存使用占比
  - 类型：内存
  - 单位：%
  - Metric：mem.pct_used
  - 含义：当前主机物理内存被用于应用程序的占比
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemTotal、MemAvailable
        - 应用程序内存使用占比 = (1-MemAvailable/MemTotal) * 100%
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPercent
        - 应用程序内存使用占比 = UsedPercent

- 指标：物理内存已用量
  - 类型：内存
  - 单位：KB
  - Metric：mem.psc_used
  - 含义：当前物理内存已被使用的大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 MemTotal、MemAvailable
        - 物理内存已被使用的大小 = MemTotal - MemAvailable
  - 采集方法-Windows：
        - 调用 Win32 API `GlobalMemoryStatusEx` 获取 Total、Available、Free、UsedPerTotal
        - 物理内存已被使用的大小 = UsedPercent * Total

- 指标：共享内存使用量
  - 类型：内存
  - 单位：KB
  - Metric：mem.shared
  - 含义：共享内存所使用的内存大小
  - 采集方法-Linux：
        - 解析 /proc/meminfo 文件获取内存信息并且解析出 ShmemHugePages
        - 共享内存所使用的内存大小 = ShmemHugePages
  - 采集方法-Windows：N/A

## SWAP

- 指标：SWAP 空闲量
  - 类型：内存
  - 单位：bytes
  - Metric：swap.free
  - 含义：交换空间处于空闲状态的大小
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free、Total
        - 交换空间空闲状态大小取 Free 对应值
  - 采集方法-Windows：N/A

- 指标：SWAP 总量
  - 类型：内存
  - 单位：bytes
  - Metric：swap.total
  - 含义：交换空间总大小
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free、Total
        - SWAP 总量取 Total 对应值
  - 采集方法-Windows：N/A

- 指标：SWAP 已用量
  - 类型：内存
  - 单位：bytes
  - Metric：swap.used
  - 含义：交换空间处于使用状态的大小
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free、Total
        - SWAP 已用量 = Total - Free
  - 采集方法-Windows：N/A

- 指标：SWAP 已用占比
  - 类型：内存
  - 单位：bytes
  - Metric：swap.pct_used
  - 含义：交换空间处于使用状态的大小占总大小的占比
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free、Total
        - SWAP 已用占比 = (Total - Free) / Total
  - 采集方法-Windows：N/A

- 指标：Swap 交换进内存大小
  - 类型：内存
  - 单位：KB
  - Metric：swap.swap_in
  - 含义：SWAP 从硬盘到内存
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free、Total
        - Used = Total - Free
        - 单位时间内获取两次 SWAP 的状态信息，分别计算出 Used1、Used2
        - Swap 交换进内存大小 = Used2 - Used1
  - 采集方法-Windows：N/A

- 指标：Swap 交换出内存大小
  - 类型：内存
  - 单位：KB
  - Metric：swap.swap_out
  - 含义：SWAP 从硬盘到内存
  - 采集方法-Linux：
        - 调用接口 unix.Sysinfo 获取 SWAP 空间相关指标 Free Total
        - 单位时间内获取两次 SWAP 的状态信息，分别计算出 Free1， Free2
        - Swap 交换出内存大小 = Free2 - Free1
  - 采集方法-Windows：N/A

## NETSTAT

### NIC（网卡）

- 指标：网卡入包量
  - 类型：网卡
  - 单位：个/秒
  - Metric：net.speed_packets_recv
  - 含义：每秒接收的包的速率
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
              - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
              - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 单位时间内获取两次接收端的 packets 的值，分别为 packets1、packets2
        - 网卡入包量 = (packets2 - packets1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 单位时间内获取两次 BytesRecv 的值，分别为 BytesRecv1、BytesRecv2
        - 网卡入包量计算方式 = (BytesRecv2 - BytesRecv1) / 单位时间

- 指标：网卡出包量
  - 类型：网卡
  - 单位：个/秒
  - Metric：net.speed_packets_sent
  - 含义：每秒发送的包的速率
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
              - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
              - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 单位时间内获取两次发送端的 packets 的值，分别为 packets2、packets1
        - 网卡出包量 = (packets2 - packets1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 单位时间内获取两次 PacketsSent 的值，分别为 PacketsSent1、PacketsSent2
        - 网卡出包量计算方式 = （PacketsSent2 - PacketsSent1）/ 单位时间

- 指标：网卡入流量
  - 类型：网卡
  - 单位：bytes/s
  - Metric：net.speed_recv
  - 含义：网卡每秒接收的字节数
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
              - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
              - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 单位时间内获取两次接收端的 bytes 的差值，分别为 bytes1、bytes2
        - 网卡入流量 = (bytes2 - bytes1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 单位时间内获取两次 BytesRecv 的值，分别为 BytesRecv1、BytesRecv2
        - 网卡入流量计算方式 = （BytesRecv2 - BytesRecv1）/ 单位时间

- 指标：网卡出流量
  - 类型：网卡
  - 单位：bytes/s
  - Metric：net.speed_sent
  - 含义：网卡每秒发送的 bytes
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
              - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
              - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 单位时间内获取两次发送端的 bytes 的值，分别为 bytes1、bytes2
        - 网卡出流量 = (bytes2 - bytes1) / 单位时间
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 单位时间内获取两次 BytesSent 的值，分别为 BytesSent1、BytesSent2
        - 网卡出流量计算方式 = （BytesSent2 - BytesSent1）/ 单位时间

- 指标：网卡错误包
  - 类型：网卡
  - 单位：count
  - Metric：net.errors
  - 含义：网卡驱动程序检测到的发送或接收错误的总数
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
            - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
            - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 网卡错误包取 errs 所对应的数据即可，对于接收端取接收端的 errs ，发送端取发送端的 errs 即可
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 网卡错误包，需要统计接收端错误时，取值 Errin；需要统计发送端错误时，取值 Errout

- 指标：网卡丢弃包
  - 类型：网卡
  - 单位：count
  - Metric：net.dropped
  - 含义：网卡驱动程序丢弃的数据包总数
  - 采集方法-Linux：
        - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
            - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
            - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
        - 网卡丢弃包取 drop 所对应的数据即可，对于接收端取接收端的 drop，发送端取发送端的 drop 即可
  - 采集方法-Windows：
        - 调用 Win32 API `GetIfEntry2` 获取网卡数据 BytesSent、BytesRecv、PacketsSent、PacketsRecv、Errin、Errout、Dropin、Dropout
        - 网卡丢弃包，需要统计接收端错误时，取值 Dropin；需要统计发送端错误时，取值 Dropout

- 指标：网卡冲突包
  - 类型：网卡
  - 单位：count
  - Metric：net.collisions
  - 含义：网卡上检测到的冲突数
  - 采集方法-Linux：
    - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
      - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
      - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
      - 网卡冲突包取 colls 所对应的值即可
  - 采集方法-Windows：N/A

- 指标：网卡载波丢失数
  - 类型：网卡
  - 单位：count
  - Metric：net.carrier
  - 含义：由设备驱动程序检测到的载波损耗的数量
  - 采集方法-Linux：
    - 解析 /proc/net/dev 文件获取网卡相关的信息，相关信息如下
      - 接收端：bytes、packets、errs、drop、fifo、frame、compressed、multicast
      - 发送端：bytes、packets、errs、drop、fifo、colls、carrier、compressed
      - 网卡载波丢失数取 carrier 所对应的值即可
  - 采集方法-Windows：N/A

### Socket

#### TCP

- 指标：closing 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_closing
  - 含义：TCP 连接处于 closing 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_CLOSING 状态下的套接字数量
        - closing 连接数取 TCP_CLOSING 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 CLOSE 属性对应值

- 指标：estab 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_estab
  - 含义：TCP 连接处于 estab 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_ESTABLISHED 状态下的套接字数量
        - estab 连接数取 TCP_ESTABLISHED 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 ESTABLISHED 属性对应值

- 指标：finwait1 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_finwait1
  - 含义：TCP 连接处于 finwait1 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_FIN_WAIT1 状态下的套接字数量
        - finwait1 连接数取 TCP_FIN_WAIT1 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 FIN_WAIT_1 属性对应值

- 指标：finwait2 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_finwait2
  - 含义：TCP 连接处于 finwait2 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_FIN_WAIT2 状态下的套接字数量
        - finwait2 连接数取 TCP_FIN_WAIT2 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 FIN_WAIT_2 属性对应值

- 指标：lastact 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_lastack
  - 含义：TCP 连接处于 lastact 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_LAST_ACK 状态下的套接字数量
        - lastact 连接数取 TCP_LAST_ACK 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 LAST_ACK 属性对应值

- 指标：listen 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_listen
  - 含义：TCP 连接处于 listen 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_LISTEN 状态下的套接字数量
        - listen 连接数取 TCP_LISTEN 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 LISTENING 属性对应值

- 指标：synrecv 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_synrecv
  - 含义：TCP 连接处于 synrecv 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_SYN_RECV 状态下的套接字数量
        - synrecv 连接数取 TCP_SYN_RECV 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 SYN_RECV 属性对应值

- 指标：synsent 连接数
  - 类型：TCP
  - 单位：count
  - Metric：netstat.cur_tcp_synsent
  - 含义：TCP 连接处于 synsent 状态的数量
  - 采集方法-Linux：
        - 调用 netlink 接口获取处于 TCP_SYN_SENT 状态下的套接字数量
        - synsent 连接数取 TCP_SYN_SENT 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` 命令获取 SYN_SENT 属性对应值

#### UDP

- 指标：UDP 接收包量
  - 类型：UDP
  - 单位：count
  - Metric：netstat.cur_udp_indatagrams
  - 含义：UDP 接收包量
  - 采集方法-Linux：
        - 解析 /proc/net/snmp 文件获取 udp 指标 InDatagrams、NoPorts、InErrors、OutDatagrams、RcvbufErrors、SndbufErrors、InCsumErrors
        - UDP 接收包量取 InDatagrams 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 执行 `netsh interfac ipv4 show udpstats` 命令获取 InDatagrams、NoPorts、InErrors、OutDatagrams
        - UDP 接收包量取 InDatagrams 对应值即可

- 指标：UDP 发送包量
  - 类型：UDP
  - 单位：count
  - Metric：netstat.cur_udp_outdatagrams
  - 含义：UDP 发送包量
  - 采集方法-Linux：
        - 解析 /proc/net/snmp 文件获取 udp 指标 InDatagrams、NoPorts、InErrors、OutDatagrams、RcvbufErrors、SndbufErrors、InCsumErrors
        - UDP 发送包量取 OutDatagrams 对应值即可
  - 采集方法-Windows：
        - 调用 CMD 接口执行 `netsh interfac ipv4 show udpstats` 命令获取 InDatagrams、NoPorts、InErrors、OutDatagrams
        - UDP 发送包量取 OutDatagrams 对应值即可


## FAQ

### 为什么蓝鲸监控的Linux CPU使用率有些不一样?

```
cpuUsed = user  + nice + system + iowait + irq + softirq + steal + guest + guestnice #红色的指标如果存在就会计算，如不存在，则只计算黑体字部分

cpuTotal = cpuUsed + idle

cpuUsedPercent=delta(cpuUsed) / delta(cpuTotal) * 100

#steal 需要Linux内核大于2.6.11支持
#guest需要Linux内核大于2.6.24支持
#guestnice需要Linux内核大于3.2.0支持
```

因此，如果您的Linux内核版本高于2.6.11，蓝鲸监控更准确。



### 富容器的应用内存问题


富容器读取/proc/meminfo，不能准确反映容器内的应用内存使用情况



