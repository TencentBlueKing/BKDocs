## 安装 Profiling SDK

1. 创建 APM 应用并开启Profiling 功能
2. 安装依赖：

**maven**
``` 
<dependency>
  <groupId>io.pyroscope</groupId>
  <artifactId>agent</artifactId>
  <version>0.13.0</version>
</dependency>
```

**gradle**

``` 
implementation("io.pyroscope:agent:0.13.0")
```

3. 在你的 Java 项目的入口中，加入如下参考代码来配置 Pyroscope Agent：

``` 
Map<String, String> labels = new HashMap<>();
labels.put("{YOUR_LABEL_KEY}", "{YOUR_LABEL_VALUE}");
PyroscopeAgent.start(
        new Config.Builder()
  // 设置服务名称，服务名称可以有多种设置方法，详见下面解释
                .setApplicationName("{YOUR_SERVICE_NAME}")
                .setServerAddress("{HTTP_PUSH_URL}/pyroscope")
    // 设置自定义 labels
                .setLabels(labels)
  // 填写应用的 TOKEN
                .setAuthToken("{YOUR_APP_TOKEN}")
                .build()
);
```

项目启动后，你的应用就会按照默认的上报间隔每 10 秒来上报一次 Profiling 数据，等待最多十分钟（Profiling 每十分钟对数据进行服务发现）就可以在页面上看到上报的 Profiling 数据了。

## 安装Profiling-Opentelemetry SDK
如果你想将 profiling 数据和 trace 数据进行关联，可以参考此章节。

1. 安装依赖

**maven**

``` 
<dependency>
    <groupId>io.pyroscope</groupId>
    <artifactId>otel</artifactId>
    <version>0.10.1.4</version>
</dependency>
```

**gradle**

``` 
implementation("io.pyroscope:otel:0.10.1.4")
```

配置 `TraceProvider`：

``` 
import io.opentelemetry.sdk.trace.SdkTracerProviderBuilder;
import io.otel.pyroscope.PyroscopeOtelConfiguration;
import io.opentelemetry.sdk.OpenTelemetrySdk;

SdkTracerProviderBuilder providerBuilder = SdkTracerProvider.builder();
PyroscopeOtelConfiguration pyroscopeTelemetryConfig = new PyroscopeOtelConfiguration.Builder()
        .setAddSpanName(true)
        .setAppName("my-opentelemetry-proj-java")
        .setPyroscopeEndpoint("{HTTP_PUSH_URL}/pyroscope")
        .setRootSpanOnly(false)
        .build();
providerBuilder.addSpanProcessor(new PyroscopeOtelSpanProcessor(pyroscopeTelemetryConfig));
OpenTelemetrySdk.builder().setTracerProvider(providerBuilder.build()).buildAndRegisterGlobal();
```

2. 创建 Span 进行测试

```
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.context.Scope;

Tracer tracer = GlobalOpenTelemetry.getTracer("HelloController");

Span span = tracer.spanBuilder("hello").startSpan();
try (Scope scope = span.makeCurrent()) {
    return "hello world";
} finally {
    span.end();
}
```

项目启动后，Profiling 数据将会在 Label 字段中被添加上关联的 SpanId 信息，在页面的 Trace 和 Profiling 页面都可以相互检索。