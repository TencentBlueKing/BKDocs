# Host-process-metrics



| Indicators | Unit | Remarks | Collection method (Linux) |
| --- | --- | --- | --- |
| Process.CPU | % | The current CPU usage of the process | Collect from /proc/{pid}/stat: Obtain the total system CPU time of the process and the total user CPU time during the collection interval, and then compare it with the last collected value The difference is the current process CPU usage time, and the usage ratio is the current CPU usage time divided by the collection interval (current_total_time - last_total_time) / (gap_time) |
| Process.Mem | % | The current memory usage of the process | Collected from /proc/{pid}/statm: Use the physical usage of the current process divided by the overall physical memory of the machine |
| Process.FileDescriptor | Number of file handles | | lsof -p ${pid} to get the number of file handles occupied by a single process |
| Process.RES | MB | Physical memory | The size of physical memory used by the task, collected from /proc/{pid}/statm |
| Process.VIRT | MB | Virtual memory | The size of virtual memory used by the task, collected from /proc/{pid}/statm |