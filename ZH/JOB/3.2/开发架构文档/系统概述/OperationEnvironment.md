# 运营环境
## 软件环境

| **软件名称** | **版本** | **备注**                                                                    |
|--------------|----------|----------------------------------------------------------------------------|
| Linux OS     | 2.6+     | 操作系统,指明内核版本不低于 2.6，发行版(Ubuntu or Centos or SUSE)并不重要|
| JDK          | 1.8      | 虚拟机，作业平台是运行在 Java 上的服务程序，需要 jdk1.8 支持                   |
| RabbitMQ     | 3.3+     | 由集成平台提供的消息队列服务                                                  |
| Redis        | 2.8.19   | 作业平台分布式缓存                                                        |
| Mysql        | 5.5      | 作业平台数据主存储数据库                                                      |

## 硬件环境

<table>
    <tr>
        <th rowspan="2">服务/模块</th>
        <th colspan="7">机型</th>
    </tr>
    <tr>
        <th>CPU</th>
        <th>内存</th>
        <th>存储</th>
        <th>网卡</th>
        <th>操作系统</th>
        <th>数量</th>
        <th>备注</th>
    </tr>
    <tr>
        <td>JOB 作业平台后台服务器</td>
        <td>12C</td>
        <td>32G</td>
        <td>500M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3+</td>
        <td>部署作业平台下 JOB 服务程序</td>
    </tr>
    <tr>
        <td>NFS 作业执行日志及文件上传存储服务器</td>
        <td>8C</td>
        <td>16G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>两台作为互 NFS 的高可用方案，企业也可用自已其他的存储方案，不一定要用NFS。</td>
    </tr>
    <tr>
        <td>RabbitMQ</td>
        <td>4C</td>
        <td>8G</td>
        <td>100M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>RabbitMQ 镜像模式部署</td>
    </tr>
	    <tr>
        <td>Redis</td>
        <td>4C</td>
        <td>16G</td>
        <td>100M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>Redis sentinel 部署模式</td>
    </tr>
</table>

- 说明：RabbitMQ/Redis 建议与微服务分开部署