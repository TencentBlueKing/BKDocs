# CMDB process indicator description

| Indicators | Unit | Remarks | Collection method (Linux) |---|
| --- | --- | --- | --- | --- |
| Process.CPU | % | The current CPU usage of the process | Collect from /proc/{pid}/stat: Obtain the total system CPU time of the process and the total user CPU time during the collection interval, and then compare it with the last collected value The difference is the current process CPU usage time, and the usage ratio is the current CPU usage time divided by the collection interval (current_total_time - last_total_time) / (gap_time) |
| Process.Mem | % | The current memory usage of the process | Collected from /proc/{pid}/statm: Use the physical usage of the current process divided by the overall physical memory of the machine |
| Process.FileDescriptor | Number of file handles | | lsof -p ${pid} to get the number of file handles occupied by a single process |
| Process.RES | MB | Physical memory | The size of physical memory used by the task | Collected from /proc/{pid}/statm |
| Process.VIRT | MB | Virtual Memory | The size of virtual memory used by the task | Collected from /proc/{pid}/statm |


## Description of indicators collected by dynamic process plug-in

- Metric: CPU usage
   - Type: Process
   - Unit: %
   - Metric: process.perf.cpu_total_pct
   -Meaning: The proportion of CPU consumed by the process running
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the values of utime and stime, which respectively represent the time the process runs in user mode and the time it runs in system mode.
         - total = utime + stime
         - Obtain total data twice per unit time, namely total1 and total2
         - CPU usage = (total2 - total1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetProcessTimes` to obtain the UserTime, KernelTime, ExitTime, and CreationTime of the process
         - total = KernelTime + UserTime
         - Obtain total data twice per unit time, namely total1 and total2
         - CPU usage = (total2 - total1) / unit time

- Metric: Memory usage
   - Type: Process
   - Unit: %
   - Metric: process.perf.mem_usage_pct
   -Meaning: The proportion of memory space consumed by the process running
   - Collection method-Linux:
         - Parse the /proc/pid/statm file to obtain the value of rss
         - Memory usage = rss / total memory space size
   - Collection method-Windows:
         - Call Win32 API `GetProcessMemoryInfo` to obtain the WorkingSetSize value of the process, which represents the amount of memory space used by the current process to run.
         - Memory usage = WorkingSetSize / total memory space size

- Metric: Number of file handles
   - Type: Process
   - Unit: count
   - Metric: process.perf.fd_num
   -Meaning: The number of files used by the process to run
   - Collection method-Linux:
         - Parse the /proc/pid/fd file. Each line represents an open file. The total number of lines is the number of files used by the current process.
   - Collection method-Windows: N/A

- Metric: File handle hard limit
   - Type: Process
   - Unit: count
   - Metric: proc.fd_limit_hard
   - Meaning: Linux handle hard limit, the maximum limit on the number of resources of the process fd
   - Collection method-Linux:
         - Parse the /proc/pid/limits file to obtain the HardLimit value. This value represents the hard limit of the open file running by the current process.
   - Collection method-Windows: N/A
   - PS: SoftLimit represents the value set by the kernel to the resource; HardLimit represents the upper limit of SoftLimit.

- Indicator: File handle soft limit
   - Type: Process
   - Unit: count
   - Metric: proc.fd_limit_soft
   - Meaning: Linux handle soft limit, the current value of the limit on the number of process fd resources
   - Collection method-Linux:
         - Parse the /proc/pid/limits file to obtain the value of SoftLimit. This value represents the soft limit of the open file running by the current process.
   - Collection method-Windows: N/A
   - PS: SoftLimit represents the value set by the kernel to the resource, and Hard Limit represents the upper limit of SoftLimit.

- Metric: Physical Memory
   - Type: Process
   - Unit: KB
   - Metric: process.perf.mem_res
   -Meaning: The size of the memory used by the process to run
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the value of rss, which represents the amount of memory space used by the current process.
   - Collection method-Windows:
         - Call Win32 API `GetProcessMemoryInfo` to obtain the value of WorkingSetSize, which represents the amount of memory space used by the current process to run.

- Metric: Virtual Memory
   - Type: Process
   - Unit: KB
   - Metric: process.perf.mem_virt
   -Meaning: The size of the virtual space used by the process to run
   - Collection method-Linux:
         - Parse the /proc/pid/statm file to obtain the value of size, which represents the size of the virtual memory space
   - Collection method-Windows:
         - Call Win32 API `GetProcessMemoryInfo` to obtain the value of PrivateUsage, which represents the size of the virtual memory space

- Metric: Process start time
   - Type: Process
   - Unit: seconds
   - Metric: process.perf.cpu_start_time
   -Meaning: time when the process starts
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the value of starttime, which indicates how long it takes for the process to start after the system starts.
         - Parse the /proc/stat file to obtain the value of btime, which represents the time when the system started
         - Process start time = starttime + btime
   - Collection method-Windows:
         - Call Win32 API `GetProcessTimes` to obtain the value of CreationTime, which represents the startup time of the process

- Metric: Process running time
   - Type: Process
   - Unit: seconds
   - Metric: process.perf.uptime
   -Meaning: The total time the process runs
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the value of starttime, which indicates how long it takes for the process to start after the system starts.
         - Parse the /proc/stat file to obtain the value of btime, which represents the time when the system started
         - Process start time = starttime + btime
         - Process running time = current time - Process start time
   - Collection method-Windows:
         - Call Win32 API `GetProcessTimes` to obtain the value of startup time CreationTime
         - Process running time = current time - Process start time

- Indicator: process takes up system state time- Type: Process
   - Unit: seconds
   - Metric: process.perf.cpu_system
   - Meaning: the time the process occupies system state
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the value of stime, which indicates the time the current process occupies system state.
   - Collection method-Windows:
         - Call Win32 API `GetProcessTimes` to obtain the value of the startup time KernelTime, which represents the time the process occupies system state.

- Indicator: Process time occupied by user mode
   - Type: Process
   - Unit: seconds
   - Metric: process.perf.cpu_user
   - Meaning: The process occupies user mode time
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the value of utime, which indicates the time the current process occupies system state.
   - Collection method-Windows:
         - Call the Win32 API `GetProcessTimes` to obtain the value of the startup time UserTime, which represents the time the process occupies the system state.

- Indicator: Overall occupied time
   - Type: Process
   - Unit: seconds
   - Metric: process.perf.cpu_total_ticks
   - Meaning: Overall occupied time
   - Collection method-Linux:
         - Parse the /proc/pid/stat file to obtain the values of utime and stime
         - Overall occupation time = utime + stime
   - Collection method-Windows:
         - Call Win32 API `GetProcessTimes` to obtain UserTime and KernelTime, which respectively represent the time occupied by the user state and the time occupied by the system state.
         - Overall occupied time = UserTime + KernelTime

- Indicator: process IO cumulative reads
   - Type: Process
   - Unit: count
   - Metric: proc.io.read_bytes
   - Meaning: The cumulative number of read operations by the process
   - Collection method-Linux:
         - Parse the /proc/pid/io file to obtain the value of syscr
         - Process IO cumulative reads = syscr
   - Collection method-Windows:
         - Call Win32 API `GetProcessIoCounters` to obtain IOCount data ReadOperationCount, ReadTransferCount, WriteOperationCount, WriteTransferCount
         - The cumulative number of IO read operations by the process = ReadOperationCount

- Indicator: process IO cumulative writes
   - Type: Process
   - Unit: count
   - Metric: proc.io.write_bytes
   -Meaning: The number of cumulative write operations of the process
   - Collection method-Linux:
         - Parse the /proc/pid/io file to obtain the value of syscw
         - The number of cumulative IO write operations of the process = syscw
   - Collection method-Windows:
         - Call Win32 API `GetProcessIoCounters` to obtain IOCount data ReadOperationCount, ReadTransferCount, WriteOperationCount, WriteTransferCount
         - The cumulative number of IO write operations by the process = WriteOperationCount

- Metric: Process IO read rate
   - Type: Process
   - Unit: bytes/s
   - Metric: proc.io.read_speed
   -Meaning: The reading rate of the current process per unit time
   - Collection method-Linux:
         - Parse the /proc/pid/io file to obtain the read_bytes value. This value represents the cumulative read bytes size of the current process.
         - Get read_bytes twice per unit time, namely read_bytes1, read_bytes2
         - Process IO read rate = (read_bytes2-read_bytes1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetProcessIoCounters` to obtain IOCount data ReadOperationCount, ReadTransferCount, WriteOperationCount, WriteTransferCount
         - Obtain the value of ReadTransferCount twice per unit time, namely ReadTransferCount1 and ReadTransferCount2.
         - Process IO read rate = (ReadTransferCount2 - ReadTransferCount1) / unit time

- Metric: Process IO write rate
   - Type: Process
   - Unit: bytes/s
   - Metric: proc.io.write_speed
   -Meaning: The writing rate of the current process per unit time
   - Collection method-Linux:
         - Parse the /proc/pid/io file to obtain the value of write_bytes. This value represents the cumulative size of butes written by the current process.
         - Obtain the value of syscr twice per unit time, respectively write_bytes1, write_bytes2
         - Process IO write rate = (write_bytes2 - write_bytes1) / unit time
   - Collection method-Windows:
         - Call Win32 API `GetProcessIoCounters` to obtain IOCount data ReadOperationCount, ReadTransferCount, WriteOperationCount, WriteTransferCount
         - Get the value of WriteTransferCount twice per unit time, namely WriteTransferCount1 and WriteTransferCount2
         - Process IO write rate = (WriteTransferCount2 - WriteTransferCount1) / unit time

