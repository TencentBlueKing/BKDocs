## BK Agent，强大的执行代理

蓝鲸智能 Agent 程序，可以安装在业务需要管控的实体机、虚拟机或者容器里面，

蓝鲸 Agent 是蓝鲸管控平台提供三大服务能力（命令执行、文件传输、数据上报）的实际执行者，蓝鲸 Agent 所在机器的通讯策略、网络状况需要在安装前调整好才能发挥其所有能力。

## BK TaskServer，提供海量管控能力

蓝鲸管控平台任务及控制服务端程序，该程序提供对集群内 Agent 的管理能力，并支持对 Agent 批量下发执行发命令或脚本，最快任务流转时间小于 2s。

## BK FileServer，基于 BT 协议，传输更高效

管控平台文件传输控制服务端程序，该程序对指定范围内 Agent 节点提供 BT 种子服务，保证对传输的安全性、不同区域及业务模块间的隔离性，并控制 BT 传输在有限的贪婪特性范围内。

单独部署 BK FileServer 并不能提供文件传输服务，受限于安全性考虑，BK FileServer 必须和 BK TaskServer 配合才能完成完整的文件分发流程。

## BK DataServer，海量数据处理不再是瓶颈

蓝鲸管控平台数据传输服务端程序。该服务端主要提供对 Agent 采集的数据进行汇聚、分类、流转能力。

对于普通的千兆网卡机器，BK DataServer 能够最大提供 100MB/s 的数据处理能力。

BK DataServer 可以单独为用户提供数据服务，而不需要其他服务端程序配合。

## Gse Agent 操作系统支持列表

### 官方支持的操作系统

- **Linux 系统：**

| OS 及版本 | OS 内核版本 | CPU 架构 | glibc 版本 |
|  ----  | ----  | ----  | ----  |
| TencentOS Server 3.1 (TK4) | 5.4.119-19-0008 | x86_64 | glibc 2.28 |
| TencentOS Server 2.2 (Final) | 3.10.107-1-tlinux2_kvm_guest-0055 | x86_64 | glibc 2.17 |
| TencentOS Server 1.2 (tkernel2) | 3.10.107-1-tlinux2_kvm_guest-0053 | x86_64 | glibc 2.12 |
| TencentOS Server 2.6 for ARM64(TK4) | 5.4.119-19-0007 | aarch64 | glibc 2.17 |

- **Windows 系统：**

| OS 及版本 | 
|  ----  |
| Windows Server 2016 For Tencent |
| Windows Server 2012 R2 For Tencent |
| Windows Server 2008 for Tencent |


### 社区适配后支持的操作系统

- **Linux 系统：**

| OS 及版本 | OS 内核版本 | CPU 架构 | glibc 版本 |
|  ----  | ----  | ----  | ----  |
| CentOS 8.2 ARM64 | 4.18.0-240.10.1.el8_3.aarch64 | aarch64 | glibc 2.28 |
| CentOS 8.0 64 位 | 4.18.0-305.10.2.el8_4.x86_64 | x86_64 | glibc 2.28 |
| CentOS 7.9 ARM64 | 4.18.0-193.28.1.el7.aarch64 | aarch64 | glibc 2.17 |
| CentOS 7.9 64 位 | 3.10.0-1160.45.1.el7.x86_64 | x86_64 | glibc 2.17 |
| CentOS 7.2 64 位 | 3.10.0-1127.19.1.el7.x86_64 | x86_64 | glibc 2.17 |
| CentOS 6.9 32 位 | 2.6.32-696.el6.i686 | i686 | glibc 2.12 |
| CentOS 6.8 64 位 | 2.6.32-642.6.2.el6.x86_64 | x86_64 | glibc 2.12 |
| Ubuntu Server 20.04 LTS 64 位 | 5.4.0-80-generic | aarch64 | glibc 2.31 |
| Ubuntu Server 20.04 LTS 64 位 | 5.4.0-90-generic | x86_64 | glibc 2.31 |
| Ubuntu Server 16.04.1 LTS 64 位 | 4.15.0-142-generic | x86_64 | glibc 2.23 |
| Ubuntu Server 16.04.1 LTS 32 位 | 4.4.0-92-generic 115-Ubuntu | i686 | glibc 2.23 |
| Ubuntu Server 14.04.1 LTS 64 位 | 3.13.0-128-generic 177-Ubuntu | x86_64 | glibc 2.19 |
| Ubuntu Server 14.04.1 LTS 32 位 | 3.13.0-128-generic | i686 | glibc 2.19 |
| Debian 10.2 64 位 | 4.19.0-18-amd64 | x86_64 | glibc 2.28 |
| Debian 9.13 64 位 | 4.9.0-13-amd64 | x86_64 | glibc 2.24 |
| Debian 8.2 64 位 | 3.16.0-6-amd64 | x86_64 | glibc 2.19 |
| Debian 8.2 32 位 | 3.16.0-4-686-pae | i686 | glibc 2.19 |
| Debian 7.4 64 位 | 3.2.0-4-amd64 | x86_64 | glibc 2.13 |
| FreeBSD 11.1 64 位 | 3.10.0-1062.18.1.el7.x86_64 | x86_64 | glibc 2.17 |

- **Windows 系统：**

| OS 及版本 | 
|  ----  
| Windows Server 2019 数据中心版 64 位 中文版 |
| Windows Server 2016 数据中心版 64 位中文版 |
| Windows Server 2012 R2 数据中心版 64 位中文版 |
| Windows Server 2003 企业版 SP2 32 位 |

- **其他系统：**

AIX