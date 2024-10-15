## Installing Profiling SDK

1. Create an APM application and enable Profiling
2. Installation dependencies:

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

3. In the entry to your Java project, add the following reference code to configure Pyroscope Agent:

``` 
Map<String, String> labels = new HashMap<>();
labels.put("{YOUR_LABEL_KEY}", "{YOUR_LABEL_VALUE}");
PyroscopeAgent.start(
        new Config.Builder()
  // Set the service name. The service name can be set in multiple ways. For details, see the following
                .setApplicationName("{YOUR_SERVICE_NAME}")
                .setServerAddress("{HTTP_PUSH_URL}/pyroscope")
    // Set custom labels
                .setLabels(labels)
  // Enter the TOKEN of the application
                .setAuthToken("{YOUR_APP_TOKEN}")
                .build()
);
```

After the project is started, your application will report the Profiling data every 10 seconds according to the default reporting interval, and wait up to 10 minutes (Profiling data every 10 minutes service discovery) to see the Profiling data reported on the page.

## Install the Profiling-Opentelemetry SDK
If you want to correlate profiling data with trace data, you can refer to this section.

1. Installation dependency

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

Configure `TraceProvider`：

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

2. Create a Span for testing

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

After the project is started, the Profiling data will be added to the Label field with associated SpanId information, and both the Trace and Profiling pages of the page can be retrieved from each other.