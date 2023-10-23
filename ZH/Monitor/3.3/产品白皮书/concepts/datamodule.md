# 数据模型

数据模型主要是介绍监控的数据上报格式、存储格式和监控管理运作的关系。

### 用户关心的数据分层

不管是以什么方式进行数据的采集，上报；不论数据是从哪上报上来；不论是时序数据，事件数据还是日志数据都是为用户关心的数据分层而服务。

1. **用户体验**：指的是用户使用应用的情况，应用的运营数据。 如 移动端的使用情况，业务应用的登录数等
2. **服务**：指的是运行在服务器操作系统之上的服务模块。 如 数据库，进程等。 对应 CMDB-服务拓扑
3. **主机**：指的主机系统和硬件的层面。 如 CPU MEM 服务器硬件故障等。 对应 CMDB-主机拓扑
4. **数据中心**：指的是和数据中心相关的网络和设备相关内容。 对应 CMDB-设备管理

![-w2021](media/15743267097583.jpg)

### 监控实现逻辑解耦

明白用户关心的数据分层，所有的实现手段都进行了解耦，简而言之所有的以下所有的方式都是为数据分层而服务。

* **数据上报来源**：3 种
    * **监控采集**
        * 默认采集：操作系统 Basereport， 进程 Process 都是默认安装和下发的。系统事件也是默认采集的一种
        * 采集配置：通过采集配置下发的采集任务，如脚本，Exporter，DataDog，JMX，日志采集等
        * 拨测任务：拨测是一种特定的场景任务，其实也属于采集配置中的一类
    * **自定义上报**：无需监控平台进行下发和管理的采集来源，只要符合监控平台的数据格式即可，包含自定义事件上报和自定义时序数据
    * **数据平台**：是已经接入数据平台的[结果表]数据进行监控

* **采集方式**： 8 种
    * Script 脚本插件采集：插件管理中维护，Linux 支持 Bash,Python; Windows 支持 Powershell、vbs、Python
    * Exporter 插件采集：支持[Prometheus](https://prometheus.io/docs/instrumenting/exporters/)的采集协议。可以很方便的将 Exporter 转为监控平台平台的插件
    * DataDog 插件采集：支持[DataDog](https://github.com/DataDog/datadog-agent)的采集。 可以很方便的将 DataDog 转为监控平台平台的插件
    * JMX 插件采集：采集任何开启了 JMX 服务端口的 Java 进程的服务状态。用户可在插件管理中定义
    * basereport 基础采集器：默认安装的操作系统指标采集器
    * processbeat 进程采集器：默认的进程采集器，进程的信息依据 CMDB 的进程管理
    * bkunifylogbeat 日志采集器：蓝鲸默认的日志采集器，日志采集器支持 Linux 和 Windows
    * bkmonitorbeat 采集器：支持拨测服务相关的数据采集，如 TCP,UDP,HTTP(s)，不仅是拨测还负责其他插件的管理工作

*  **数据目标范围**：
    * 基于 CMDB 的主机拓扑：监控最小粒度为主机 IP，依据 CMDB 的拓扑结构进行配置
    * 基于 CMDB 的服务拓扑：监控最小粒度为服务实例 instance，依据 CMDB 的拓扑结构进行配置
    * 数据的维度：通过自定义上报或者数据平台来源的数据无法区别 CMDB 的拓扑结构

* **数据类型**： 3 种
    * 时序数据：[time series](https://zh.wikipedia.org/wiki/%E6%99%82%E9%96%93%E5%BA%8F%E5%88%97)监控最重要的数据类型，通过时序数据可以发现大部分的问题。 最重要的三要素就是指标，维度，时间。 并且时间上是连续的
    * 事件数据：事件是已发生的一件事情记录，时间上连续，由多个连续异常点构成
    * 日志数据：日志数据是由系统，应用产生的文本记录。 是重要的监控定位信息之一
        * 日志的产生方式：文件日志(行日志，段日志) 系统日志(设备日志，Windows Event 日志)
        * 日志的内容格式：文本，json，二进制等

## 监控平台基本数据结构

### 自定义事件数据

```json
{
    # 数据通道标识，必需项
    "data_id": 11223344,
    # 数据通道标识验证码，必需项
    "access_token": "d9007a0d11111111111118693c1a",
    "data": [{
        # 事件标识名，最大长度128
                "event_name": "input_your_event_name",
                "event": {
                    # 事件内容，必需项
                    "content": "user xxx login failed"
                },
        # 来源标识如IP，必需项
        "target": "127.0.0.1",
        # 自定义维度，非必需项
        "dimension": {
            "module": "db",
            "location": "guangdong"
        },
        # 数据时间，精确到毫秒，非必需项
        "timestamp": 1600308754824
    }]
}
```

### 时序数据结构

```json
{
    # 数据通道标识，必需项
    "data_id": 11223344,
    # 数据通道标识验证码，必需项
    "access_token": "d9007a0d11111111111118693c1a",
    "data": [{
        # 指标，必需项
        "metrics": {
            "http_request_total": 10
        },
        # 来源标识如IP，必需项
        "target": "127.0.0.1",
        # 自定义维度，非必需项
        "dimension": {
            "module": "db",
            "location": "guangdong"
        },
        # 数据时间，精确到毫秒，非必需项
        "timestamp": 1600308839050
    }]
}
```

## Promtheus 的数据结构

监控平台支持[Promtheus 的数据结构](https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md)

参考 Promtheus 的基本数据上报格式。

```bash
<-----<metric name>{<label name>=<label value>, ...}-------><--value-->
http_request_total{status="200", method="GET", route="/api"} 94355
http_request_total{status="404", method="POST", route="/user"} 94334
```

* **metric**：指标的名称(metric name)可以反映被监控样本的含义(比如，http_request_total - 表示当前系统接收到的 HTTP 请求总量)。指标名称只能由 ASCII 字符、数字、下划线以及冒号组成并必须符合正则表达式`[a-zA-Z_:][a-zA-Z0-9_:]*`

* **label**：标签(label)反映了当前样本的特征维度，通过这些维度 Prometheus 可以对样本数据进行过滤，聚合等。标签的名称只能由 ASCII 字符、数字以及下划线组成并满足正则表达式`[a-zA-Z_][a-zA-Z0-9_]*`。在监控平台平台中等同于 **dimension**


