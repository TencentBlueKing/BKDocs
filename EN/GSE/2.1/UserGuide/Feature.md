# Product Features

BlueKing General Service Engine, hereinafter referred to as 'GSE', provides basic channel capabilities such as task execution, file transfer, data transfer, and process management.

![feature](./assets/feature.png)

- **Task execution**: Provides remote task execution capabilities on target control nodes, such as Bash, Perl, Bat, PowerShell, Python, SQL, etc.;
- **File transfer**: Provides fast file transfer capabilities, combines BT network protocol and internal private protocol to dynamically adjust networking strategies under different file sizes and node scales to achieve the best file transfer efficiency, and provides efficient and stable underlying file transfer services for businesses;
- **Data transmission**: Provides massive data transmission and routing management capabilities, and combines the BlueKing collector plug-in to provide business custom data collection and reporting capabilities. This service provides lossless upgrades and Agent-side failover capabilities, provides data transmission guarantees for daily changes and failures, and also provides full-link data compression functions to reduce transmission link bandwidth consumption;
- **Process management**: Provides process management functions on target control nodes, such as process registration and hosting, process start and stop control, process CPU/MEM resource protection, etc.;

## Detailed features

### Task execution

**Task type:**

| Task type | Description |
| ----------- | ------------- |
| Command Type | Linux supports Bash command, Windows supports CMD command, supports the launch of various custom executable file format programs, and supports the execution of various interpreted language programs. |
| Script Type | Linux supports Shell scripts, Windows supports Bat scripts (additional support for Shell scripts with cygwin installed), and various interpreted script programs supported by the system (Python, PowerShell, Perl, etc.). |

**Task Control:**

| Task Control | Description |
| ------------- | ---------------------------------- |
| Specified User Execution | The Linux system supports executing tasks by specified users. For example, if the user sets ps to be executed as user00, only the results within the scope of the user's permissions can be seen; due to the limitations of the Windows operating system, only users who have enabled the machine password verification function can specify users to execute tasks, otherwise the task must be executed as the SYSTEM user. |
| Inherit User Environment | The Linux / Windows system supports specifying a user and inheriting the environment variables set by the user. |
| Verify machine password | Users can choose whether to verify the machine password. If not, the Windows system does not support the function of executing tasks by specified users. |

**Task management:**

| Task management | Description |
| ------------- | ------------------------- |
| Status management | The core logic of task processing supports more accurate and efficient task status confirmation and management mechanisms to ensure that the task status is not affected in abnormal situations such as Agent downtime. |
| Easy-to-use API | Provides easy-to-use HTTP protocol API support with low access cost, which is convenient for querying the execution status of specified tasks and the execution status of all Agent tasks under the task. |

### File transfer

**Transfer mode:**

| Transfer mode | Description |
| ----------- | ------------------------ |
| BT mode | For files larger than 10KB, BT will be automatically enabled as the preferred transfer method. |
| Direct transfer mode | For small files below 10KB, TCP data stream direct transfer mode will be used. |
| Hybrid mode | In BT mode, if BT transmission fails to persist, it will try to use direct transmission mode to transmit BT file segments. When BT transmission is restored, it will automatically switch to BT mode. |

**Transfer type:**

| Transfer type | Description |
| ------------- | -------------------------------------- |
| File transfer | Transfer a single file to a specified machine node. The file can be in any format and a readable file in any readable directory. After the file transfer is completed, the target file permissions will be automatically synchronized with the source file. For direct transmission mode, MD5 verification will be performed after the file transfer is completed. For BT mode and hybrid mode, hash value verification of file integrity will be performed. |
| Directory transfer | Supports transferring user-specified directories to a specified writable directory of a batch of machines to ensure that the directory structure and permissions remain unchanged. |
| Regular matching transfer | Supports users matching a batch of files through wildcards (in accordance with general regular expressions) to transfer to a specified writable directory of a specified machine to ensure that the format and permissions of the files are consistent with the source files after the transfer is completed. |
| Dynamic Strategy Transmission | Dynamically control the transmission strategy according to the size and structure of the file to be transmitted, support non-compressed transmission under directory, regular, and wildcard path matching modes, avoid additional decompression overhead, and reduce transmission time. |

**Transmission Control:**

| Transmission Control | Description |
| ------------- | -------------------------------------------------- |
| Regional Chain Control | Let the file follow the specified path, through the relay of multiple transfer nodes, and finally reach the target machine, and the source file and the target file are not in the same physical or logical area. We call this transmission method regional chain transmission. Regional chain control refers to specifying the path of file transfer through certain rules to meet the transmission requirements between two areas with special dedicated line links. |
| Cross-regional penetration | Cross-regional penetration refers to two areas that were originally isolated from each other. Due to special purposes, directional transparent transmission is required for this transmission. The BlueKing Management Platform allows authorized users to appropriately configure the network to complete forward and reverse penetration between directional areas. |

### Data transmission

**Collection method:**

| Collection method | Description |
| ---------- | ------ |
| Collector plug-in | Supports data collection and reporting in the BlueKing collector plug-in mode. The Agent will automatically load the collection plug-in and monitor the plug-in's survival status. If the collection plug-in terminates abnormally, the collection plug-in will be re-launched. If it fails to be pulled up multiple times, an alarm will be triggered. |

**Transmission control:**

| Transmission control | Description |
| -------------- | ------------------------ |
| Dynamic load balancing | Since the amount of data collected may be large and fluctuates with business characteristics, in order to reasonably allocate the utilization of server machines and reduce the load imbalance caused by changes in data volume, the system supports dynamic adjustment of data forwarding based on multi-dimensional weighted load information to achieve the purpose of server load balancing within the cluster. |
| Full-link data compression | Supports full-link data compression transmission capabilities under hybrid network topologies such as Agent to server and Proxy to server. Data compression can greatly reduce the consumption of link bandwidth during transmission. |
| Lossless Service Upgrade | Combine the capabilities of the network protocol stack to provide lossless upgrades of service modules, provide smooth transition support for data transmission during daily changes, and provide guarantees for the quality of business data transmission. |
| Fast Failover | Based on the internal dynamic detection mechanism, it supports the fast failover capability of the data link, which can maximize the guarantee that data transmission is not affected when a failure occurs. |
| High-performance Transmission | Provide high-performance data transmission capabilities based on memory and network deep optimization, ensure that the performance of the core forwarding node is maximized under the condition of uniform overall load, and provide efficient and low-latency data transmission services. |

### Process Management

**Management Dimension:**

| Management Dimension | Description |
| ------------------- | ----------------------------------- |
| Process Registration and Hosting | The hosted process is guarded by the Agent. When the process exits abnormally, it will be automatically pulled up according to the configured instructions, and the Agent will execute the "Process CPU/MEM Resource Protection" strategy for the hosted process. |
| Process Start and Stop Control | Provide APIs related to process operations, through which scenario-based operations such as starting and stopping processes on multiple hosts can be implemented at the same time. |
| Process CPU/MEM resource protection | Agent monitors the CPU/MEM resources of itself and the processes it hosts. When the CPU/MEM resource usage of the monitored process exceeds the configured usage threshold, it will be forced to restart. |

### Platform capabilities

**Hybrid network management:**

| Hybrid network management | Description |
| ----------------- | - |
| IPv4/IPv6 hybrid network | Supports management of IPv6 environment, IPv4 environment, and IPv6 and IPv4 mixed network environment. |
| Heterogeneous network penetration | Supports management of hybrid cloud environment by breaking through DHCP, NAT, Virtual IP and other restrictions in common heterogeneous network environments. |

**Signaling control:**

| Signaling control | Description |
| --------- | ----- |
| High performance | Deeply optimized core signaling control logic shortens the system time consumption of large-scale signaling and improves the system carrying capacity. |
| Low latency | Implements MsgBus components based on internal private protocols, has efficient routing addressing and fast routing recovery capabilities, and provides low-latency signaling delivery and forwarding services. |

**SRE:**

| SRE | Description |
| ------- | ------- |
| Operable and maintainable | Provides supporting operation and maintenance tools for troubleshooting existing network failures and quickly detecting the status and quality of existing network services. |
| Observable | Provides online logs, indicator monitoring, and call chain tracking based on the OpenTelemetry protocol. |
| Measurable | Provides internal operation data reporting and statistics based on private protocols to facilitate system service operation analysis. |