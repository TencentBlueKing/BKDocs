# Opentelemetry SDK (Java) 使用说明

## 一. 背景

通过 OT 的 Java agent , 动态注入字节码以捕获大部分流行的库和框架中的调用链数据 , 然后进行上报

## 二. SDK地址

[OpenTelemetry auto-instrumentation and instrumentation libraries for Java](https://github.com/open-telemetry/opentelemetry-java-instrumentation)

##三. 基本用法

1. 注册应用 : 蓝鲸监控作为opentelemety作为数据接收端， 通过SDK上报的基础上，需要注册对应的应用，以及获取到对应的token。上报数据需要携带token。 复制SecureKey 和 4317端口的url , 分别记为 token 和 url
    ![](media/16613330035765.jpg)
    ![](media/16613330305844.jpg)

2. 下载jar : 从 [Release](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/) 页面下载最新的 opentelemetry-javaagent.jar , 将其存放到 业务服务的机器上面 , agent.jar的全路径记为 path

3. 添加参数 : 在业务服务的启动参数中, 添加参数:` " -Dotel.resource.attributes=service.name=${service_name},bk.data.token=${OT_token} -Dotel.exporter.otlp.endpoint=${OT_host} -Dotel.metrics.exporter=none -javaagent:${agent_path} "` , 其中

    * service_name : 表示业务的服务名称, 用户自定义, 用于监控面板的展示
    * OT_token : 步骤1中蓝鲸监控的 token
    * OT_host : 步骤1中蓝鲸监控的 url

4. 观察数据: 

数据检索 -> trace检索 最直观有

![](media/16613334890975.jpg)

观测场景 -> 应用监控 查看应用拓扑和服务列表

注： 数据接入需要10分钟的统计才会出相应的数据

![](media/16613332046757.jpg)


## 四. 进阶用法

1. OT agent目前支持这些框架: [supported-libraries](https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/#suppressing-specific-agent-instrumentation) , 可以根据自己的实际需要关闭 : -Dotel.instrumentation.[name].enabled=false , 减少一些性能开销 (注: 有些框架的数据太嘈杂 , 所以OT agent默认禁用了 , 详情可以参考 : [disabled-instrumentations](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/docs/supported-libraries.md#disabled-instrumentations))

2. 可以对自己的业务代码创建span , 引入对应版本的 [opentelemetry-extension-annotations](https://mvnrepository.com/artifact/io.opentelemetry/opentelemetry-extension-annotations) , 然后在方法上使用 @WithSpan , agent 就会自动将该方法的调用链采集上报 , 详情参考 : [Annotations](https://opentelemetry.io/docs/instrumentation/java/automatic/annotations/)

3. 除了上述使用properties参数接入OT , 也可以使用环境变量 , 配置文件 , SPI 方式进行接入 , 详情参考 : [Agent Configuration](https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/#configuring-the-agent)

4. 只是添加扩展满足业务的需求 , 比如自定义ID生成等 , 打包成jar后使用 -Dotel.javaagent.extensions=xxx.jar 引入 , 详情参考: [Extension](https://github.com/open-telemetry/opentelemetry-java-instrumentation/tree/main/examples/extension#extensions-examples)

5. 调试可以使用 -Dotel.javaagent.debug=true , 输入日志会在标准输出中打印出来

6. Logger上下文:  trace_id=%mdc{trace_id} span_id=%mdc{span_id} trace_flags=%mdc{trace_flags} , 支持的logger框架: [Supported logging libraries](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/docs/logger-mdc-instrumentation.md#supported-logging-libraries)

## 五. 注意事项

* JDK最小版本: 1.8
* 支持的框架与web服务器: https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/docs/supported-libraries.md
* 基准开销:
    * 版本: 1.14.0 
    * 用例: [opentelemetry-java-instrumentation/benchmark-overhead](https://github.com/open-telemetry/opentelemetry-java-instrumentation/tree/main/benchmark-overhead)
    * 数据: [opentelemetry-java-instrumentation/results.csv](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/gh-pages/benchmark-overhead/results/release/results.csv)
    * 结论: 启动耗时增加9% , 内存增加17% , GC耗时增加8% , 循环耗时增加1.6% , HTTP平均耗时增加 0.5% , 95%的HTTP增加耗时1.5% , 

