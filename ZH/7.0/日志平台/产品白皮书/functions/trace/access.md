
   实际业务中，一次请求需要关联到多个任务模块，因此，就需要一些可以帮助理解系统行为、用于分析性能问题的工具，以便发生故障的时候，能够快速定位和解决问题。想要在请求上下文中理解分布式系统的行为，就需要监控那些横跨了不同的模块、不同的服务器之间的关联动作，最终完成整个链路的追踪动作。
   
![-w2021](../media/trace_1_2.png)

   图例：的一次检索操作的调用示例(通过 demo 业务--全链路跟踪进行体验）
全链路跟踪核心步骤一般有三个：代码埋点，数据存储、查询展示。

全链路监控支持 OpenTracing（OpenTelemetry）开源协议，符合协议标准的日志均可采集接入。

## 数据结构

![-w2021](../media/trace_1_1.png)

图例：opentracing 数据结构示例


## 数据上报

集成 SDK：OpenTelemetry 同时提供包括 Java | C# | Go | JavaScript | Python | Rust | C++ | Erlang/Elixir 在内的各种 SDK，以及各种封装可用的常见框架以及库，如 MySQL | Redis | Django | Kafka | Jetty | Akka | RabbitMQ | Spring | Flask | net/http | gorilla/mux | WSGI | JDBC | PostgreSQL 等，用户可以非常方便的获取使用，优点是接入快效率高。
OpenTelemetry 官网地址：https://opentelemetry.io/

github 地址:https://github.com/open-telemetry

自主实现：按 OpenTracing/OpenTelemetry 协议进行代码埋点，日志输出上报，同为目前常用方式，优点是灵活可控。

## 数据采集&中转

数据上报初代码埋点外，同时涉及数据上报方式，sdk 接入过程中需要设置 exporter，而自主实现过程中，同样可以选择日志落地本地磁盘，还是网络传输形式落地到指定的 collector。
内部游戏业务推荐使用 tlog(tglog)方式接入，一则技术方案熟悉，二则性能稳定有保障，目前多个业务以 tlog 形式接入；同时用户可以选择 kafka 等其它组件作为 collector，平台侧同样支持对数据进行处理入库。
 
![-w2021](../media/trace_1_3.png)

图例：tlog 接入表字段定义示例（opentracing）

## 数据清洗

通过蓝鲸数据平台，可以对数据进行清洗，数据清洗模板示例：

![-w2021](../media/trace_1_4.png)

清洗之后，数据入库 ES，字段设置：

![-w2021](../media/trace_1_5.png)

## 索引集接入

管理->索引集管理->新建

- 是否为 trace 日志：是
- 数据源：从数据平台中选择对应的索引集

![-w2021](../media/trace_1_6.png)

至此，就可以正常使用全链路相关功能。

