# 主机-操作系统-系统事件

| 事件 | 含义 | 采集方法(Linux) | 采集方法(Windows) |
|---- | ---- | --------------- | -------------------------- |
| Agent 心跳丢失-GSE | 监测 GSE 的 Agent 是否正常 | GSE服务上报 | N/A |
| 磁盘只读-GSE | 监测磁盘状态 | GSE Agent 上报 | N/A |
| 磁盘写满-GSE | 监测磁盘状态 | GSE Agent 上报 | N/A |
| Corefile 产生-GSE | 监测 /proc/sys/kernel/core_pattern 中目录内文件的变化 |GSE Agent 上报 | N/A |
| PING 不可达告警-GSE | 监测 PING 不可达事件告警  | GSE 服务上报  | N/A |
| 进程端口 | 进程对应端口 | processbeat 上报数据匹配产生 | wmic path win32_process get */value 和 netstat -ano |
| 主机重启 | 监测系统启动异常告警 | basereport 根据Uptime和数据上报状况进行确认 | N/A |

