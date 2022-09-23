# 安装步骤

## NFS 存储搭建

见 [附录 NFS 方案](../附录/NFSSolution.md) 如果已经有相应的存储方案，则忽略此步骤。

## 工作目录初始化

### 创建公共目录

在 JOB 服务器上创建公共目录。
```bash
${BK_HOME}/logs/job				负责给作业平台写程序运行日志的位置，可清理
${BK_HOME}/job					作业平台的主目录即${JOB_HOME}

${BK_HOME}/run_data/job/data1	主：作业日志和文件的存放挂载 nfs 位置（数据重要不可丢）
${BK_HOME}/run_data /job/data2	备机：作业日志和文件的存放挂载 nfs 位置
（如果没有NFS备机则不需要创建这个目录）
```

### 挂载 nfs

```bash
mount 存储机器IP1:/data/bkee/job/data ${BK_HOME}/run_data/job/data1
mount 存储机器IP2:/data/bkee/job/data ${BK_HOME}/run_data/job/data2
mount 存储机器IP1:/data/bkee/job/log ${BK_HOME}/run_data/job/log1
mount 存储机器IP2:/data/bkee/job/log ${BK_HOME}/run_data/job/log2
```

## 解压 job_ee-x.x.x.tgz

到 `${JOB_HOME}` 目录下，将安装包解压出来。

## JDK/JRE 安装

略，请用 JDK1.8 版本安装

## 证书安装

见 [附录证书安装](../附录/CertificatesInstallation.md) 一般此步骤已经通过蓝鲸安装自动化脚本初始化过。

## MQ 部署

### RabbitMQ

部署方式是集群，搭建方法由平台方提供（略），这里重点要说的是对 RabbitMQ 设置作业平台的消息队列的镜像模式，保证高可用。 在搭建所有集群节点启动后，执行步骤如下：

进入 RabbitMQ 主节点的 RabbitMQ 的 sbin 目录下执行如下命令：

```bash
./rabbitmqctl set_policy bk_job_mirror "^bk.job" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
```

## 修改配置文件

## 启动 Job 服务器

### 修改内存参数


通过设置 Linux 系统环境变量 JOB_JAVA_OPTS 如下：

设置启动内存为 8g，以 GB 为单位。如果机器配置不行，则设置比如 512m 以 MB 为单位，两个值要配置成一样的，保证避免大小颠倒出错以及内存一次性申请性能，然后再启动。

```bash
export JOB_JAVA_OPTS="–Xms8g –Xmx8g"
```

内存的配置与并发任务数量和每个任务包含的 IP 数量以及每个 IP 的打印日志量等 3 个维度结合得出如下推荐值，当然各种组合是灵活的，可能存在突发的情况

计算细则如下：

每行日志最多 256 字节，瞬间输出 2000 行，2000*256=51200 =512KB 内存。
100 个 IP 就是 100*512KB=50MB 内存。
10 个并发任务就是 50MB*10 = 500MB 内存。 加上系统的交换以及作业中其他模块开销，需要 1.5G。一共 2G 内存。

当然一般很少作业会出现瞬间输出 2000 行日志的行为，除非是 cat 打印某个文件这类操作，这类行为不建议，会拉高机器的负载。 所以正常情况下，作业系统的的内存需求量远低于表格所描述， 建议起始内存 4GB，64G 的机器最大建议到 32G，一般最大的为机器 真实内存的一半，后面不建议再增加。

最后得出如下表格:

| 任务数 | IP 数 | 日志行数 | 内存 |
|--|--|--|--|
| 10  | 100 | 2000 | 2G  |
| 100 | 100 | 2000 | 8G  |
| 200 | 100 | 2000 | 16G |
| 500 | 100 | 2000 | 32G |

### 修改端口

默认端口是 8080，API 端口为 8443,如果被其他进程占用了请修改，但是要注意相应的 Nginx 以及 ESB 接口配置也要变更，否则会无法访问。修改方式在 job.conf 中
```bash
# Job 的进程 web 端口，非 Nginx 端口
job.listen.port=8080
# Job 的进程 API 端口，非 Nginx 端口
job.listen_ssl.port=8443
```

### 运行服务器
