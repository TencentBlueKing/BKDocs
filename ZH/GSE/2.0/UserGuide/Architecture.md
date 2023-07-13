# 产品架构

![product](./assets/product.png)

如图所示为蓝鲸管控平台（GSE-BlueKing General Service Engine）内部整体架构简图，API层面基于蓝鲸网关服务对外提供接口服务，内部支持HTTP、TCP私有协议、GRPC等多种协议族通讯。后台模块主要由任务服务（GSE Task）、进程管理服务（GSE Proc）、文件服务（GSE File）、数据服务（GSE Data）、基础平台服务（GSE Cluster）组成，其中基础平台服务（GSE Cluster）与管控节点的Agent配合，负责完成内部信令消息的上行下达。在管控节点层面，Agent负责完成任务执行、文件传输、数据传输、进程操作等工作，其针对主流操作系统发行版本进行了兼容适配，可以在混合环境中实现管控。

## 模块介绍

**任务服务（GSE Task）**

任务服务模块，该模块以基础平台服务（GSE Cluster）为基础，提供目标管控节点上的远程作业任务执行能力, 如Bash、Perl、Bat、PowerShel、Python、SQL等。

**进程管理服务（GSE Proc）**

进程管理服务模块，该模块基于任务服务（GSE Task）实现针对管控节点上进程的管理功能, 如进程的注册托管、进程启停控制、进程CPU/MEM资源保护等。

**文件服务（GSE File）**

文件服务模块，该模块提供文件快速传输能力，结合BT网络协议和内部私有协议实现在不同的文件大小和节点规模下，动态调整组网策略以此达到最佳的文件传输效率，为业务提供高效稳定的底层文件传输服务；

**数据服务（GSE Data）**

数据服务模块，提供海量数据传输和路由管理能力, 结合蓝鲸采集器插件提供业务自定义数据的采集和上报能力。该服务提供无损升级和Agent侧的故障转移能力，为日常变更和故障发生时提供数据传输保障, 同时还提供全链路数据压缩功能, 以此减少传输链路带宽消耗。

**基础平台服务（GSE Cluster）**

基础平台服务模块, 承接海量管控节点的Agent会话链接和路由管理。结合内部消息槽机制和Agent平台化框架，提供面向目标管控节点信令消息的向下分发和向上投递功能, 为内部任务、数据、文件等通道模块提供了基础信令服务。

**蓝鲸智能代理（GSE Agent）**

蓝鲸智能 Agent 代理程序，可以安装在业务需要管控的实体机、虚拟机或者容器里面，是蓝鲸管控平台提供的任务执行、文件传输、数据传输、进程管理的实际执行者，Agent所在机器的通讯策略、网络状况需要在安装前调整好才能发挥其所有能力。

## 操作系统支持
> 部分低版本系统如Windows 2003、Windows 2008以及部分Linux/Windows的32位机型在1.0版本中保持兼容支持，2.0高版本将不再支持

### 官方支持的操作系统

- **Linux 系统：**

| OS 及版本 | OS 内核版本 | CPU 架构 | glibc 版本 |
|  ----  | ----  | ----  | ----  |
| TencentOS Server 2.6 for ARM64(TK4) | 5.4.119-19-0008 | aarch64 | glibc 2.17 |
| TencentOS Server 3.1 (TK4) | 5.4.119-19-0008 | x86_64 | glibc 2.28 |
| TencentOS Server 2.2 (Final) | 3.10.107-1-tlinux2_kvm_guest-0049 | x86_64 | glibc 2.17 |
| TencentOS Server 1.2 (tkernel2) | 3.10.106-1-tlinux2_kvm_guest-0024 | x86_64 | glibc 2.12 |

- **Windows 系统：**

| OS 及版本 | 
|  ----  |
| Windows Server 2019 For Tencent |
| Windows Server 2016 For Tencent |
| Windows Server 2012 R2 For Tencent |

### 社区适配后支持的操作系统

- **Linux 系统：**

| OS 及版本 | OS 内核版本 | CPU 架构 | glibc 版本 |
|  ----  | ----  | ----  | ----  |
| CentOS 8.2 ARM64 | 4.18.0-240.10.1.el8_3.aarch64 | aarch64 | glibc 2.28 |
| CentOS 7.9 ARM64 | 4.18.0-193.28.1.el7.aarch64 | aarch64 | glibc 2.17 |
| CentOS 8.0 64 位 | 4.18.0-305.10.2.el8_4.x86_64 | x86_64 | glibc 2.28 |
| CentOS 7.2 64 位 | 3.10.0-1127.19.1.el7.x86_64 | x86_64 | glibc 2.17 |
| CentOS 6.8 64 位 | 2.6.32-642.6.2.el6.x86_64 | x86_64 | glibc 2.12 |
| Ubuntu Server 20.04 LTS ARM64 | 5.4.0-80-generic | aarch64 | glibc 2.31 |
| Ubuntu Server 20.04 LTS 64 位 | 5.4.0-90-generic | x86_64 | glibc 2.31 |
| Ubuntu Server 18.04.1 LTS 64 位 | 4.15.0-142-generic | x86_64 | glibc 2.23 |
| Ubuntu Server 16.04.1 LTS 64 位 | 4.15.0-142-generic | x86_64 | glibc 2.23 |
| Ubuntu Server 14.04.1 LTS 64 位 | 3.13.0-128-generic | x86_64 | glibc 2.19 |
| Debian 10.2 64 位 | 4.19.0-18-amd64 | x86_64 | glibc 2.28 |
| Debian 9.13 64 位 | 4.9.0-13-amd64 | x86_64 | glibc 2.24 |
| Debian 8.2 64 位 | 3.16.0-6-amd64 | x86_64 | glibc 2.19 |
| Debian 7.4 64 位 | 3.2.0-4-amd64 | x86_64 | glibc 2.13 |
| FreeBSD 11.1 64 位 | 3.10.0-1062.18.1.el7.x86_64 | x86_64 | glibc 2.17 |

- **Windows 系统：**

| OS 及版本 | 
|  ----  
| Windows Server 2019 数据中心版 64 位 中文版 |
| Windows Server 2016 数据中心版 64 位中文版 |
| Windows Server 2012 R2 数据中心版 64 位中文版 |

- **其他系统：**

AIX
