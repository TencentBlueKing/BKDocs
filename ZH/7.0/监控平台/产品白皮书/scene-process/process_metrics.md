# CMDB进程指标说明

| 指标 | 单位  | 备注 | 采集方式(Linux) |
| --- | --- | --- | --- | --- |
| Process.CPU | % | 进程当前占用 CPU 的使用率 | 从/proc/{pid}/stat 中采集：获得采集间隔中，进程系统 CPU 总时间及用户 CPU 总时间，然后与上一次采集值对比的差值为当次进程 CPU 使用时间，使用率为当次 CPU 使用时间除以采集间隔(current_total_time - last_total_time) / (gap_time) |
| Process.Mem | % | 进程当前占用内存的使用率 | 从/proc/{pid}/statm 采集：使用当前进程的物理使用量除以机器整体物理内存量 |
| Process.FileDescriptor |  文件句柄数 | | lsof -p ${pid} 来获取单个进程占用的文件句柄数 |
| Process.RES | MB | 物理内存 | 任务已使用的物理内存大小 | 从/proc/{pid}/statm 采集 |
| Process.VIRT | MB | 虚拟内存 | 任务已使用的虚拟内存大小 | 从/proc/{pid}/statm 采集 |


## 动态进程插件采集的指标说明

指标名 | 中文名 | 单位 | 描述
---|---|---|---
process.perf.memory_size | 虚拟内存 | byte |
process.perf.memory_rss_bytes | 物理内存 | byte |
process.perf.memory_rss_pct | 物理内存使用率 | *100% |
process.perf.cpu_start_time | 进程启动时间 | 时间戳 |
process.perf.cpu_user | 进程占用用户态时间 | millseconds |
process.perf.cpu_system | 进程占用系统态时间 | millseconds |
process.perf.cpu_total_ticks | 整体占用时间 | millseconds | user+system
process.perf.cpu_total_pct | cpu使用率 | *100 | %
process.perf.fd_open | 占用fd数 |  |进程打开的文件描述符数量 
process.perf.fd_limit_soft | 进程fd软上限 |  |进程fd控制值 
process.perf.fd_limit_hard | 进程fd硬上限 |  |进程fd控制值 
process.perf.io_read_bytes | 读取字节数 | byte | 进程读取的byte总数
process.perf.io_write_bytes | 写入字节数 | byte | 进程读取的write总数
process.perf.io_read_speed | 读取速率 | byte/s | 进程读速率，(current-last)/time
process.perf.io_write_speed | 写入速率 | byte/s | 进程写速率，(current-last)/time
process.port.alive | 端口存活 |  | 进程端口是否存活 |


