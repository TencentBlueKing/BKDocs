# 主机-进程-指标

| 指标 | 单位  | 备注 | 采集方式(Linux) |
| --- | --- | --- | --- | --- |
| Process.CPU | % | 进程当前占用 CPU 的使用率 | 从/proc/{pid}/stat 中采集：获得采集间隔中，进程系统 CPU 总时间及用户 CPU 总时间，然后与上一次采集值对比的差值为当次进程 CPU 使用时间，使用率为当次 CPU 使用时间除以采集间隔(current_total_time - last_total_time) / (gap_time) |
| Process.Mem | % | 进程当前占用内存的使用率 | 从/proc/{pid}/statm 采集：使用当前进程的物理使用量除以机器整体物理内存量 |
| Process.FileDescriptor |  文件句柄数 | | lsof -p ${pid} 来获取单个进程占用的文件句柄数 |
| Process.RES | MB | 物理内存 | 任务已使用的物理内存大小 | 从/proc/{pid}/statm 采集 |
| Process.VIRT | MB | 虚拟内存 | 任务已使用的虚拟内存大小 | 从/proc/{pid}/statm 采集 |

