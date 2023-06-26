# 主机-操作系统指标

内置的主机指标是通过 basereport 进行采集,不同的监控系统可能在计算方法上会有差异,了解计算方法能够好的理解采集上来的数据。

| 指标 | 类型 | 单位 | 含义 | 采集方法(Linux) | 采集方法(Windows) |
|------| --- | ---- | -----| -------------- | ---------------- |
| 5 分钟平均负载 | CPU | % | 五分钟内同时处于就绪状态的平均进程数 | awk ‘{print $2}’ /proc/loadavg | N/A |
| cpu 总使用率 | CPU | % | 当前消耗的总 CPU 百分比 | delta(busy) / delta(total) * 100 busy = user + sys + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total = busy + idle | for /f “tokens=1,2,* delims==” %i in (‘wmic path Win32_PerfFormattedData_Counters_ProcessorInformation where "Name=’_Total’" get PercentIdleTime/value &#124; findstr PercentIdleTime’) do (set /a 100-%j) |
| cpu 单核使用率 | CPU | % | 当前单个 CPU 消耗的百分比 | delta(busy) / delta(total) * 100 busy = user + sys + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total = busy + idle | for /f “tokens=1,2,* delims==” %i in (‘wmic path Win32_PerfFormattedData_Counters_ProcessorInformation where “not name like ‘%Total%’” get PercentIdleTime/value &#124; findstr PercentIdleTime’) do (set /a 100-%j) |
| 接收字节流量 | 网络 | KB/s | 网卡每秒接收的比特数，即网卡的上行带宽 | 读取/proc/net/dev 文件 第 1 项 SpeedRecv = delta(new.BytesRecv, old.BytesRecv) / interval | wmic path Win32_PerfRawData_Tcpip_NetworkInterface get BytesReceivedPersec/value &#124; findstr BytesReceivedPersec |
| 发送字节流量 | 网络 | KB/s | 网卡每秒发送的比特数，即网卡的下行带宽 | 读取/proc/net/dev 文件第 9 项 SpeedSent = delta(new.BytesSent, old.BytesSent) / interval | wmic path Win32_PerfRawData_Tcpip_NetworkInterface get BytesSentPersec/value &#124; findstr BytesSentPersec  |
| 发送包速率 | 网络 | 个/s | 网卡每秒接收的数据包数 | 读取/proc/net/dev 文件 第 10 项 SpeedPacketsSent = (counterDiff(once.Stat[i].PacketsSent, val.PacketsSent, NetCoutnerMaxSize)) / interval | wmic path Win32_PerfRawData_Tcpip_NetworkInterface get PacketsSentPersec/value &#124; findstr PacketsSentPersec |
| 接收包速率 | 网络 | 个/s | 网卡每秒发送的数据包数 | 读取/proc/net/dev 文件 第 2 项 SpeedPacketsRecv = delta(new.PacketsRecv, old.PacketsRecv) / interval | wmic path Win32_PerfRawData_Tcpip_NetworkInterface get PacketsReceivedPersec/value &#124; findstr PacketsReceivedPersec |
| established 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 ESTABLISHED 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep ESTABLISHED | netstat -ano -p tcp &#124; more +4 &#124; find " ESTABLISHED " |
| time_wait 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 TIME_WAIT 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep TIME_WAIT | netstat -ano -p tcp &#124; more +4 &#124; find " TIME_WAIT " |
| listen 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 LISTEN 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep LISTEN | netstat -ano -p tcp &#124; more +4 &#124; find " LISTENING " |
| last_ack 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 LAST_ACK 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep LAST_ACK | netstat -ano -p tcp &#124; more +4 &#124; find " LAST_ACK " |
| syn_recv 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 SYN_RECV 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep SYNC_RECV | netstat -ano -p tcp &#124; more +4 &#124; find " SYN_RECV " |
| syn_sent 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 SYN_SENT 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep SYNC_SENT | netstat -ano -p tcp &#124; more +4 &#124; find " SYN_SENT "  |
| fin_wait1 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 FIN_WAIT1 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep FIN_WAIT1 | netstat -ano -p tcp &#124; more +4 &#124; find " FIN_WAIT_1 " |
| fin_wait2 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 FIN_WAIT2 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep FIN_WAIT2 | netstat -ano -p tcp &#124; more +4 &#124; find " FIN_WAIT_2 " |
| closing 连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 CLOSING 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep CLOSING | netstat -ano -p tcp &#124; more +4 &#124; find " CLOSING " |
| closed 状态连接数 | 网络 | 个 | 当前服务器下 TCP 链接处于 CLOSED 状态的连接数 | 系统 netlink 实现 验证方法 netstat -pant&#124;grep CLOSED | netstat -ano -p tcp &#124; more +4 &#124; find " CLOSE " |
| UDP 接收包量 | 网络 | 个 | UDP 包接受数 | 读取 /proc/net/snmp 文件 InDatagrams 项 cat /proc/net/snmp&#124;grep Udp:&#124;grep -v ‘InDatagrams’&#124;awk ‘{print $2}’ | wmic path Win32_PerfFormattedData_Tcpip_UDPv4 get DatagramsReceivedPersec/value |
| UDP 发送包量 | 网络 | 个 | UDP 包发送数 | 读取 /proc/net/snmp 文件 OutDatagrams 项 cat /proc/net/snmp&#124;grep Udp:&#124;grep -v ‘InDatagrams’&#124;awk ‘{print $5}’ | 读取/proc/net/dev 文件 第 2 项 SpeedPacketsRecv = delta(new.PacketsRecv, old.PacketsRecv) / interval |
| 可用物理内存 | 内存 | MB | 可用内存容量 | 读取 /proc/meminfo 文件 MemTotal 字段*1024     `cat /proc/meminfo |grep 'MemTotal'|awk -F ':' '{print $2}'|awk '{print $1}'|awk '{print $1 * 1024}'`       | `for /f “tokens=1,2,* delims==” %i in (‘wmic OS get FreePhysicalMemory/value| findstr FreePhysicalMemory’) do (set /a %j/1024)` |
| 交换分区已用量 | 内存 | MB | 交换分区使用容量 | 读取 /proc/meminfo 文件 golang 系统调用 syscall.Sysinfo sysinfo.Totalswap - sysinfo.Freeswap 验证方法 free -m | wmic os get TotalSwapSpaceSize/value |
| 物理内存使用率 | 内存 | %  | 内存使用百分比 | 读取 /proc/meminfo 文件[MemTotal-MemFree]/MemTotal*100.0 | wmic os get FreePhysicalMemory,TotalVisibleMemorySize/value |
| 物理内存使用量 | 内存 | MB | 已经使用的内存容量 | 读取 /proc/meminfo 文件[MemTotal-MemFree]*1024 | wmic os get FreePhysicalMemory,TotalVisibleMemorySize/value &#124; findstr “FreePhysicalMemory TotalVisibleMemorySize” |
| 应用内存使用量 | 内存 | MB | 应用进程使用的内存量 | 读取 /proc/meminfo 文件 如果有 MemAvailable 字段(不同系统版本有差异)(MemTotal-MemAvailable)/1024,如果没有该字段，MemAvailable=MemFree+Buffers+Cached | N/A |
| 应用内存使用率 | 内存 | %  | 应用进程内存量占总内存的百分比 | 读取 /proc/meminfo 文件 (MemTotal-MemAvailable)/(MemTotal*100.0)，如果没有 MemAvailable 字段，则 MemAvailable=MemFree+Buffers+Cached | N/A |
| 磁盘使用率 | 磁盘 | % | 磁盘已用空间的百分占比 | golang 系统调用 syscall.Statfs 相当于 df | for /f “tokens=1,2,* delims==” %i in (‘wmic path Win32_PerfFormattedData_PerfDisk_LogicalDisk where “name like ‘%:%’” get PercentFreeSpace/value &#124; findstr PercentFreeSpace’) do (set /a 100-%j) |
| 读速率 | 磁盘 | 次/s | 磁盘每秒输出次数 | 读取 /proc/diskstats 每一行的第四项 float64((new_stat.ReadCount - stat.ReadCount)) / 60 只上报逻辑分区 | wmic path Win32_PerfFormattedData_PerfDisk_LogicalDisk get DiskReadsPersec/value |
| 写速率 | 磁盘 | 次/s | 磁盘每秒写入次数 | 读取 /proc/diskstats 第 8 项 float64((new_stat.WriteCount - stat.WriteCount)) / 60 只上报逻辑分区 | wmic path Win32_PerfFormattedData_PerfDisk_LogicalDisk get DiskWritesPersec/value |
| 磁盘 IO 使用率 | 磁盘 | % | 磁盘处于活动时间的百分比 | 读取 /proc/diskstats 文件读取 /proc/diskstats 第 13 项 (new_stat.IoTime - stat.IoTime)/60.0 / 1000.0 | for /f “tokens=1,2,* delims==” %i in (‘wmic path Win32_PerfFormattedData_PerfDisk_LogicalDisk where "Name=’_Total’" get PercentIdleTime/value &#124; findstr PercentIdleTime’) do (set /a 100-%j) |
| 系统进程数 | 进程 | 个 | 系统已启动进程数量 | 抓取/proc 目录下所有子目录数量 | wmic path win32_process get ProcessId/value |
