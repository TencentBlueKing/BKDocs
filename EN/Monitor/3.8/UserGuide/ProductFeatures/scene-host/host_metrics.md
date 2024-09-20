# Host-OS Metrics

The built-in host indicators are collected through bkmonitorbeat. Different monitoring systems may have differences in calculation methods. Understanding the calculation methods can better understand the collected data.

## CPU

### CPU Overview

| CPU Metrics | Meaning |
| :----- | :----- |
| user | user mode time |
| nice | User mode time (low priority, nice>0) |
| system | kernel time |
| idle | idle time |
| iowait | I/O waiting time |
| irq | hard interrupt |
| softirq | softirq |
| steal | Time spent running in other virtualized environments |

- Metric: Total CPU usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.usage
   -Meaning: Current consumed CPU percentage
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - busy = user + nice+ sys + irq + softirq + steal
         - total = busy + idle + iowait
         - Total CPU usage = delta(busy) / delta(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - busy = user + system
         - total = idle + user + system
         - Total CPU usage = delta(busy) / delta(total) * 100

- Metric: CPU idle rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.idle
   - Meaning: Current idle CPU percentage
   - Collection method-Linux:
     - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
     - total = user + nice + sys + idle + irq + softirq + steal + iowait
     -CPU idle rate = delta(idle) / delta(total) * 100
   - Collection method-Windows:
     - Call Win32 API `GetSystemTimes` to get idle, user, system
     - total = idle + user + system
     -CPU idle rate = delta(idle) / delta(total) * 100

- Indicator: Proportion of time waiting for IO
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.iowait
   - Meaning: Percentage of CPU waiting for IO
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - The proportion of time waiting for IO = delta(iowait) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: CPU virtual machine time proportion
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.stolen
   - Meaning: The proportion of CPU time allocated to the virtual machine
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         -CPU virtual machine time ratio = deltal(steal) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: CPU system usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.system
   - Meaning: The proportion of time the CPU is running system programs
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - CPU system usage = deltal(sys) / detal(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         - CPU system usage = delta(system) / delta(total) * 100

- Indicator: CPU user usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.user
   - Meaning: The proportion of time the CPU is running in the user program
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         -CPU user usage = deltal(user) / detal(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         -CPU user usage = delta(user) / delta(total) * 100

- Indicator: CPU core virtual machine occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.guest
   - Meaning: The proportion of CPU cores running on the virtual machine
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - CPU core virtual machine occupancy = deltal(guest + guestnice) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: CPU hard interrupt usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.interrupt
   - Meaning: The proportion of time the CPU spends on hard interrupts
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         -CPU hard interrupt usage = deltal(irq) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: CPU soft interrupt occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.softirq
   - Meaning: The proportion of time the CPU spends on soft interrupts
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         -CPU softirq usage = deltal(softirq) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: CPU low-priority program occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_summary.nice
   - Meaning: The proportion of CPU that low-priority programs execute in user mode
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - CPU low-priority program occupancy = deltal(nice) / detal(total) * 100
   - Collection method-Windows: N/A
### CPU single core

- Metric: Single-core CPU usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.usage
   - Meaning: Current single-core CPU usage percentage
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - busy = user + nice + sys + irq + softirq + steal
         - total = busy + idle + iowait
         - Single-core CPU usage = delta(busy) / delta(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         - busy = user + system
         - Single-core CPU usage = delta(busy) / delta(total) * 100

- Indicator: Single-core CPU idle rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.idle
   - Meaning: Current single-core CPU idle rate percentage
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU idle rate = delta(idle) / delta(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         - Single-core CPU idle rate = delta(idle) / delta(total) * 100

- Indicator: The proportion of time a single-core CPU waits for IO
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.iowait
   - Meaning: Percentage of single-core CPU waiting for IO
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - The proportion of time a single-core CPU waits for IO = delta(iowait) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: Single-core CPU virtual machine time proportion
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.stolen
   - Meaning: The proportion of time allocated by a single-core CPU to the virtual machine
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU virtual machine time ratio = deltal(steal) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: Single-core CPU system usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.system
   - Meaning: The proportion of time a single-core CPU runs system programs
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU system usage = deltal(sys) / detal(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         - Single-core CPU system usage = delta(system) / delta(total) * 100

- Indicator: Single-core CPU user occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.user
   - Meaning: The proportion of time a single-core CPU runs in user programs
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU user usage = deltal(user) / detal(total) * 100
   - Collection method-Windows:
         - Call Win32 API `GetSystemTimes` to get idle, user, system
         - total = idle + user + system
         - Single-core CPU user usage = delta(user) / delta(total) * 100

- Indicator: Single-core CPU core virtual machine occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.guest
   - Meaning: The proportion of single-core CPU cores running on the virtual machine
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU core virtual machine occupancy = deltal(guest + guestnice) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: Single-core CPU hard interrupt usage
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.interrupt
   - Meaning: The proportion of time a single-core CPU spends on hard interrupts
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU hard interrupt usage = deltal(irq) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: Single-core CPU soft interrupt occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.softirq
   - Meaning: The proportion of time a single-core CPU spends on soft interrupts
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU soft interrupt usage = deltal(softirq) / detal(total) * 100
   - Collection method-Windows: N/A

- Indicator: Single-core CPU low-priority program occupancy rate
   - Type: CPU
   - Unit: %
   - Metric: cpu_detail.nice
   - Meaning: The proportion of single-core CPU used by low-priority programs executed in user mode
   - Collection method-Linux:
         - Obtain user, nice, sys, irq, softirq, steal, guest, guestnice, idle, iowait information by parsing the /proc/stat file
         - total = user + nice + sys + idle + irq + softirq + steal + iowait
         - Single-core CPU low-priority program occupancy = deltal(nice) / detal(total) * 100
   - Collection method-Windows: N/A

### CPU load

The contents of the Linux /proc/loadavg file are as follows
```shell
> cat /proc/loadavg
> 4.61 4.36 4.15 9/84 5662
> lavg_1 (4.61) 1 minute load average
> lavg_5 (4.36) 5 minute load average
> lavg_15(4.15) 15 minute load average
> nr_running (9) At the sampling time, the number of tasks in the running queue, which has the same meaning as procs_running of /proc/stat
> nr_threads (84) The number of active tasks in the system at the sampling time (excluding tasks that have finished running)
> last_pid(5662) The largest pid value, including lightweight processes, i.e. threads.
```

- Metric: 1 minute load average
   - Type: CPU
   -Unit:-
   - Metric: system.load.load1
   - Meaning: Average load of the CPU in 1 minute
   - Collection method-Linux:
         - Parse the first data of the /proc/loadavg file, which is the 1-minute average CPU load
   - Collection method-Windows: N/A
- Metric: 5 minute load average
   - Type: CPU
   -Unit:-
   - Metric: system.load.load5
   - Meaning: CPU load average over 5 minutes
   - Collection method-Linux:
         - Parse the second data of the /proc/loadavg file, which is the 5-minute average CPU load
   - Collection method-Windows: N/A

- Metric: 15-minute load average
   - Type: CPU
   -Unit:-
   - Metric: system.load.load15
   - Meaning: CPU load average over 15 minutes
   - Collection method-Linux:
         - Parse the third item of data in the /proc/loadavg file, which is the 15-minute average CPU load
   - Collection method-Windows: N/A

## DISK

- Metric: Disk IO usage
   - Type: Disk
   - Unit: %
   - Metric: io.util
   - Meaning: Percentage of time the disk was active
   - Collection method-Linux:
         - Parse item 13 of the /proc/diskstats file to obtain the IoTime indicator
         - Take two IoTimes within 60s per unit time, namely IoTime1 and IoTime2
         - Disk IO usage = (IOTime2 - IoTime1) / 60.0 / 1000.0
   - Collection method-Windows:
         - Call Win32 API `GetLogicalDriveStringsW` to obtain ReadTime and WriteTime
         - IoTime = ReadTime + WriteTime
         - Take two IoTimes per unit time, namely IoTime1 and IoTime2
         - Disk IO usage = (IOTime2 - IoTime1) / 60.0 / 1000.0

- Metric: disk write rate
   - Type: Disk
   - Unit: times/s
   - Metric: io.w_s
   -Meaning: disk writes per second
   - Collection method-Linux:
         - Parse item 8 of the /proc/diskstats file to obtain the WriteCount indicator
         - Take two WriteCounts within 60 seconds per unit time, namely WriteCount1 and WriteCount2.
         - Disk write rate = (WriteCount2 - WriteCount1) / 60
         - PS: Only logical partitions are reported
   - Collection method-Windows:
         - Call Win32 API `GetLogicalDriveStringsW` to get WriteCount
         - Take two WriteCounts within 60 seconds per unit time, namely WriteCount1 and WriteCount2.
         - Disk write rate = (WriteCount2 - WriteCount1) / 60

- Metric: Disk read rate
   - Type: Disk
   - Unit: times/s
   - Metric: io.rkb_s
   -Meaning: Disk reads per second
   - Collection method-Linux:
         - Parse the 4th item of each line of the /proc/diskstats file to obtain the ReadCount indicator
         - Take two ReadCounts within 60 seconds per unit time, namely ReadCount1 and ReadCount2.
         - Disk read rate = (ReadCount2 - ReadCount1) / 60
         - PS: Only logical partitions are reported
   - Collection method-Windows:
         - Call Win32 API `GetLogicalDriveStringsW` to get ReadCount
         - Take two ReadCounts within 60 seconds per unit time, namely ReadCount1 and ReadCount2.
         - Disk read rate = (ReadCount2 - ReadCount1) / 60

- Metric: Disk usage
   - Type: Disk
   - Unit: %
   - Metric: disk.is_use
   - Meaning: Percentage of disk used space
   - Collection method-Linux:
         - Call the syscall.Statfs interface to obtain the Free and Total information of the disk
         - Disk usage = (Total - Free) / Total * 100%
   - Collection method-Windows:
         - Call Win32 API `GetDiskFreeSpaceExW` to get the Total, Free, Used and UsedPercent of a specific disk
         - Disk usage = Used / Total * 100%

- Indicator: disk free size
   - Type: Disk
   - Unit: bytes
   - Metric:disk.free
   -Meaning: The amount of remaining space on the disk
   - Collection method-Linux:
         - Call the unix.Statfs interface to obtain the Free and Total information of the disk
         - Free means the amount of free space on the disk
   - Collection method-Windows:
         - Call Win32 API `GetDiskFreeSpaceExW` to get the Total, Free, Used and UsedPercent of a specific disk
         - Free means the amount of free disk space

- Indicator: total disk space size
   - Type: Disk
   - Unit: bytes
   - Metric: disk.total
   - Meaning: total disk space size
   - Collection method-Linux:
         - Call the unix.Statfs interface to obtain the Free and Total information of the disk
         - Total means the total disk space size
   - Collection method-Windows:
         - Call Win32 API `GetDiskFreeSpaceExW` to get the Total, Free, Used and UsedPercent of a specific disk
         - Total means the total disk space size

- Indicator: Disk used space
   - Type: Disk
   - Unit: bytes
   - Metric:disk.used
   -Meaning: The amount of space used on the disk
   - Collection method-Linux:
         - Call the unix.Statfs interface to obtain the Free and Total information of the disk
         - Disk used space size = Used = Total - Free
   - Collection method-Windows:
         - Call Win32 API `GetDiskFreeSpaceExW` to get the Total, Free, Used and UsedPercent of a specific disk
         - Used means the amount of space used on the disk

## ENV

- Indicator: Total number of processes
   - Type: Process
   - Unit: count
   - Metric: env.procs
   - Meaning: Current total number of processes
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain the processes field, which is the current total number of processes
   - Collection method-Windows: N/A

- Indicator: Number of running processes
   - Type: Process
   - Unit: count
   - Metric: env.proc_running_current
   -Meaning: The number of currently running processes
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain the procs_running field, which is the number of currently running processes.
   - Collection method-Windows: N/A

- Metric: Number of processes waiting for IO
   - Type: Process
   - Unit: count
   - Metric: env.procs_blocked_current
   - Meaning: The number of processes currently waiting for IO
   - Collection method-Linux:
         - Parse the /proc/stat file to obtain the procs_block field, which is the current number of waiting processes.
   - Collection method-Windows: N/A

## MEMORY

- Metric: Total physical memory size
   - Type: Memory
   - Unit: KB
   - Metric: mem.total
   -Meaning: Current host physical memory size
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse the MemTotal field which is the total size of physical memory
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent
         - The value corresponding to Total is the total size of the current machine's physical memory

- Indicator: Physical memory free amount
   - Type: Memory
   - Unit: KB
   - Metric:mem.free
   - Meaning: The size of the current host physical memory in an idle state
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse the MemFree field which is the free amount of physical memory
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent
         - The value corresponding to Free is the amount of free physical memory on the current machine.

- Indicator: Cache cache space size
   - Type: Memory
   - Unit: KB
   - Metric: mem.cached
   - Meaning: The current host physical memory space used for Cache cache files
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out the Cached field, which is the physical memory Cache size
   - Collection method-Windows: N/A

- Indicator: Buffer space size
   - Type: Memory
   - Unit: KB
   - Metric:mem.buffer
   -Meaning: The amount of space used by the current host physical memory for Buffer
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out the Buffers field, which is the physical memory Buffer size
   - Collection method-Windows: N/A
- Metric: Application memory available
   - Type: Memory
   - Unit: KB
   - Metric:mem.usable
   -Meaning: The amount of memory that the current host physical memory can use to start the application
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse the MemAvailable field to the memory size used to start the application
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent

- Metric: Application memory availability
   - Type: Memory
   - Unit: %
   - Metric: mem.pct_usable
   -Meaning: The percentage of current host physical memory that can be used to launch applications
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out MemTotal and MemAvailable
         - Application memory availability = MemAvailable / MemTotal * 100%
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent
         - Application memory availability = 1 - UsedPercent

- Metric: Application memory usage
   - Type: Memory
   - Unit: KB
   - Metric:mem.used
   -Meaning: The current host physical memory is used for the size of the application
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out MemTotal and MemAvailable
         - Application memory usage = MemTotal * (1-MemAvailable/MemTotal)
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent
         - Application memory usage = Total * UsedPercent

- Indicator: application memory usage ratio
   - Type: Memory
   - Unit: %
   - Metric: mem.pct_used
   -Meaning: The proportion of the current host physical memory used by applications
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out MemTotal and MemAvailable
         - Application memory usage ratio = (1-MemAvailable/MemTotal) * 100%
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPercent
         - Application memory usage ratio = UsedPercent

- Indicator: physical memory used
   - Type: Memory
   - Unit: KB
   - Metric: mem.psc_used
   -Meaning: The size of the current physical memory that has been used
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out MemTotal and MemAvailable
         - Size of physical memory used = MemTotal - MemAvailable
   - Collection method-Windows:
         - Call Win32 API `GlobalMemoryStatusEx` to get Total, Available, Free, UsedPerTotal
         - The size of physical memory that has been used = UsedPercent * Total

- Metric: Shared memory usage
   - Type: Memory
   - Unit: KB
   - Metric:mem.shared
   -Meaning: The memory size used by shared memory
   - Collection method-Linux:
         - Parse the /proc/meminfo file to obtain memory information and parse out ShmemHugePages
         - Memory size used by shared memory = ShmemHugePages
   - Collection method-Windows: N/A

## SWAP

- Indicator: SWAP idle amount
   - Type: Memory
   - Unit: bytes
   - Metric: swap.free
   -Meaning: The size of the swap space in a free state
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free and Total
         - The free state size of the swap space takes the corresponding value of Free
   - Collection method-Windows: N/A

- Indicator: SWAP total amount
   - Type: Memory
   - Unit: bytes
   - Metric: swap.total
   - Meaning: total size of swap space
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free and Total
         - The total amount of SWAP is taken as the corresponding value of Total
   - Collection method-Windows: N/A

- Indicator: SWAP used
   - Type: Memory
   - Unit: bytes
   - Metric: swap.used
   - Meaning: The size of the swap space in use
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free and Total
         - SWAP Used = Total - Free
   - Collection method-Windows: N/A

- Indicator: SWAP used proportion
   - Type: Memory
   - Unit: bytes
   - Metric: swap.pct_used
   -Meaning: The proportion of the swap space in use to the total size
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free and Total
         - SWAP used ratio = (Total - Free) / Total
   - Collection method-Windows: N/A

- Indicator: Swap swap into memory size
   - Type: Memory
   - Unit: KB
   - Metric: swap.swap_in
   - Meaning: SWAP from hard disk to memory
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free and Total
         - Used = Total - Free
         - Obtain SWAP status information twice per unit time and calculate Used1 and Used2 respectively.
         - Swap swap into memory size = Used2 - Used1
   - Collection method-Windows: N/A

- Indicator: Swap swapped out memory size
   - Type: Memory
   - Unit: KB
   - Metric: swap.swap_out
   - Meaning: SWAP from hard disk to memory
   - Collection method-Linux:
         - Call the interface unix.Sysinfo to obtain SWAP space related indicators Free Total
         - Acquire SWAP status information twice per unit time, and calculate Free1 and Free2 respectively.
         - Swap swap out memory size = Free2 - Free1
   - Collection method-Windows: N/A

## NETSTAT

### NIC (network card)

- Indicator: Network card incoming packets
   - Type: Network card
   - Unit: pieces/second
   - Metric: net.speed_packets_recv
   -Meaning: Rate of packets received per second
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
               - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
               - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - Obtain the packets values of the receiving end twice per unit time, namely packets1 and packets2.
         - The amount of packets received by the network card = (packets2 - packets1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - Get BytesRecv values twice per unit time, namely BytesRecv1 and BytesRecv2
         - Network card incoming packet calculation method = (BytesRecv2 - BytesRecv1) / unit time

- Indicator: Network card outgoing packets
   - Type: Network card
   - Unit: pieces/second
   - Metric: net.speed_packets_sent
   -Meaning: Rate of packets sent per second
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
               - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
               - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - Obtain the packets values of the sender twice per unit time, namely packets2 and packets1.
         - The amount of packets sent by the network card = (packets2 - packets1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - Obtain the value of PacketsSent twice per unit time, namely PacketsSent1 and PacketsSent2.
         - Calculation method of packet outgoing volume of network card = (PacketsSent2 - PacketsSent1) / unit time
- Indicator: network card incoming traffic
   - Type: Network card
   - Unit: bytes/s
   - Metric: net.speed_recv
   -Meaning: The number of bytes received by the network card per second
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
               - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
               - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - Obtain the difference in bytes from the two receiving ends per unit time, which are bytes1 and bytes2 respectively.
         - Network card incoming traffic = (bytes2 - bytes1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - Get BytesRecv values twice per unit time, namely BytesRecv1 and BytesRecv2
         - Network card incoming traffic calculation method = (BytesRecv2 - BytesRecv1) / unit time

- Indicator: network card outgoing traffic
   - Type: Network card
   - Unit: bytes/s
   - Metric: net.speed_sent
   - Meaning: bytes sent by the network card per second
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
               - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
               - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - Obtain the bytes values of the sending end twice per unit time, which are bytes1 and bytes2 respectively.
         - Network card outgoing traffic = (bytes2 - bytes1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - Obtain BytesSent values twice per unit time, namely BytesSent1 and BytesSent2
         - Network card outgoing traffic calculation method = (BytesSent2 - BytesSent1) / unit time

- Indicator: Network card error packet
   - Type: Network card
   - Unit: count
   - Metric: net.errors
   - Meaning: Total number of send or receive errors detected by the network card driver
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
             - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
             - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - For network card error packets, just take the data corresponding to errs. For the receiving end, take the errs of the receiving end, and for the sending end, take the errs of the sending end.
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - Network card error packet. When it is necessary to count the receiving end errors, it takes the value Errin; when it is necessary to count the sending end errors, it takes the value Errout.

- Indicator: Network card dropped packets
   - Type: Network card
   - Unit: count
   - Metric: net.dropped
   - Meaning: Total number of packets dropped by the network card driver
   - Collection method-Linux:
         - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
             - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
             - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
         - The network card discards the packet and takes the data corresponding to the drop. For the receiving end, take the drop of the receiving end, and for the sending end, take the drop of the sending end.
   - Collection method-Windows:
         - Call Win32 API `GetIfEntry2` to obtain network card data BytesSent, BytesRecv, PacketsSent, PacketsRecv, Errin, Errout, Dropin, Dropout
         - The network card discards packets. When it is necessary to count the errors on the receiving end, it takes the value Dropin; when it is necessary to count the errors on the sending end, it takes the value Dropout.

- Indicator: Network card conflict packet
   - Type: Network card
   - Unit: count
   - Metric: net.collisions
   - Meaning: Number of conflicts detected on the network card
   - Collection method-Linux:
     - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
       - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
       - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
       - For network card conflict packets, just take the value corresponding to colls
   - Collection method-Windows: N/A

- Indicator: Number of network card carrier losses
   - Type: Network card
   - Unit: count
   - Metric: net.carrier
   - Meaning: Number of carrier losses detected by the device driver
   - Collection method-Linux:
     - Parse the /proc/net/dev file to obtain information related to the network card. The relevant information is as follows
       - Receiver: bytes, packets, errs, drop, fifo, frame, compressed, multicast
       - Sender: bytes, packets, errs, drop, fifo, colls, carrier, compressed
       - The number of network card carrier losses can be determined by the value corresponding to carrier.
   - Collection method-Windows: N/A

### Socket

#### TCP

- Indicator: number of closing connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_closing
   - Meaning: The number of TCP connections in the closing state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_CLOSING state
         - The number of closing connections can be determined by the corresponding value of TCP_CLOSING
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the CLOSE attribute

- Metric: Number of estab connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_estab
   - Meaning: Number of TCP connections in estab state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_ESTABLISHED state
         - The number of estab connections can be taken as the corresponding value of TCP_ESTABLISHED
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the ESTABLISHED attribute

- Indicator: number of finwait1 connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_finwait1
   - Meaning: Number of TCP connections in finwait1 state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_FIN_WAIT1 state
         - The number of finwait1 connections can be the corresponding value of TCP_FIN_WAIT1
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the FIN_WAIT_1 attribute

- Indicator: number of finwait2 connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_finwait2
   - Meaning: Number of TCP connections in finwait2 state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_FIN_WAIT2 state
         - The number of finwait2 connections can be determined by the corresponding value of TCP_FIN_WAIT2
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the FIN_WAIT_2 attribute

- Indicator: number of lastact connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_lastack
   - Meaning: The number of TCP connections in the lastact state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_LAST_ACK state
         - The number of lastact connections can be determined by the corresponding value of TCP_LAST_ACK
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the LAST_ACK attribute
         - Indicator: Number of listen connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_listen
   - Meaning: The number of TCP connections in the listen state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_LISTEN state
         - The number of listen connections can be determined by the corresponding value of TCP_LISTEN
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the LISTENING attribute

- Indicator: number of synrecv connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_synrecv
   - Meaning: Number of TCP connections in synrecv state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_SYN_RECV state
         - The number of synrecv connections can be determined by the corresponding value of TCP_SYN_RECV
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the SYN_RECV attribute

- Indicator: number of synsent connections
   - Type: TCP
   - Unit: count
   - Metric: netstat.cur_tcp_synsent
   - Meaning: The number of TCP connections in the synsent state
   - Collection method-Linux:
         - Call the netlink interface to obtain the number of sockets in the TCP_SYN_SENT state
         - The number of synsent connections can be determined by the corresponding value of TCP_SYN_SENT.
   - Collection method-Windows:
         - Call CMD to execute the `netstat -ano -p TCP |more +4 && netstat -ano -p TCPv6 |more +4` command to obtain the corresponding value of the SYN_SENT attribute

#### UDP

- Indicator: UDP received packet volume
   - Type: UDP
   - Unit: count
   - Metric: netstat.cur_udp_indatagrams
   - Meaning: UDP received packet volume
   - Collection method-Linux:
         - Parse the /proc/net/snmp file to obtain udp indicators InDatagrams, NoPorts, InErrors, OutDatagrams, RcvbufErrors, SndbufErrors, InCsumErrors
         - UDP received packet volume can be obtained by taking the corresponding value of InDatagrams
   - Collection method-Windows:
         - Call CMD to execute the `netsh interfac ipv4 show udpstats` command to obtain InDatagrams, NoPorts, InErrors, and OutDatagrams
         - UDP received packet volume can be obtained by taking the corresponding value of InDatagrams

- Indicator: UDP sent packet volume
   - Type: UDP
   - Unit: count
   - Metric: netstat.cur_udp_outdatagrams
   - Meaning: UDP sending packet volume
   - Collection method-Linux:
         - Parse the /proc/net/snmp file to obtain udp indicators InDatagrams, NoPorts, InErrors, OutDatagrams, RcvbufErrors, SndbufErrors, InCsumErrors
         - UDP sent packets can be obtained by taking the corresponding value of OutDatagrams
   - Collection method-Windows:
         - Call the CMD interface to execute the `netsh interfac ipv4 show udpstats` command to obtain InDatagrams, NoPorts, InErrors, and OutDatagrams
         - UDP sent packets can be obtained by taking the corresponding value of OutDatagrams


## FAQ

### Why is the Linux CPU usage monitored by BlueKing different?

```
cpuUsed = user + nice + system + iowait + irq + softirq + steal + guest + guestnice #The red indicator will be calculated if it exists. If it does not exist, only the bold part will be calculated.

cpuTotal = cpuUsed + idle

cpuUsedPercent=delta(cpuUsed) / delta(cpuTotal) * 100

#steal requires Linux kernel greater than 2.6.11 support
#guest requires Linux kernel greater than 2.6.24 support
#guestnice requires Linux kernel greater than 3.2.0 support
```

Therefore, if your Linux kernel version is higher than 2.6.11, BlueKing monitoring is more accurate.



### Application memory problem of rich containers


Rich containers read /proc/meminfo, which cannot accurately reflect the application memory usage in the container.