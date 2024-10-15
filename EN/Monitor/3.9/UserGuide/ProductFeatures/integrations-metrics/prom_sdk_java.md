# Prometheus SDK (Java) Instructions for Use

## 1. Background

Prometheus is an open source complete monitoring solution that completely subverts the testing and alarming models of traditional monitoring systems and forms a new model based on centralized rule calculation, unified analysis and alarming.

The Java side mainly uses two SDKs, micrometer and simpleclient. Micrometer is maintained by the Spring community and is mainly suitable for use under the Spring system; simpleclient is maintained by the Prometheus team and is mainly suitable for other non-Spring scenarios.

## 2. SDK Description

1. Warehouse

micrometer-metrics/micrometer (recommended for spring environment)
prometheus/client_java (does not depend on spring)

2. Environment dependency description

JDK version >= 1.8

benchmark:

micrometer : none yet
simpleclient : client_java/benchmarks

## 3. Use cases

Data burying point

### 1. Use micrometer

Introduce SDK

```
<dependency>
   <groupId>io.micrometer</groupId>
   <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
<dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-actuator</artifactId>
</dependency>
<!-- requires pushgateway to be introduced -->
<dependency>
<groupId>io.prometheus</groupId>
<artifactId>simpleclient_pushgateway</artifactId>
</dependency>
```

Spring Boot will automatically configure a MeterRegistry object based on the micrometer-registry-prometheus introduced above (actually instantiating its subclass PrometheusMeterRegistry), and inject it into the class that needs to be collected

```
@Autowired
private MeterRegistry registry;
```

#### Counter

```
Counter counter = Counter
     .builder("counter")
     .baseUnit("beans") // optional
     .description("a description of what this counter does") // optional
     .tags("region", "test") // optional
     .register(registry);

// Do something
counter.increment();
```

#### Gauge

```
Gauge gauge = Gauge
     .builder("gauge", myObj, myObj::gaugeValue)
     .description("a description of what this gauge does") // optional
     .tags("region", "test") // optional
     .register(registry);

// Do something
gauge.set(27);
```


#### Exemplars

Note: Only supported by Spring Boot 2.7, related issue: [Support for
Prometheus Exemplars]()


Access OpenTelemetry: [opentelemetry SDK (Java) Instructions for Use](../integrations-traces/otel_sdk_java.md)


Introducing OpenTelemetry API:

```
<dependency>
     <groupId>io.opentelemetry</groupId>
     <artifactId>opentelemetry-api</artifactId>
</dependency>
```

Declare the SpanContextSupplier object

```
// Implement SpanContextSupplier
public class OpenTelemetrySpanContextSupplier implements SpanContextSupplier {
   @Override
   public String getTraceId() {
     String traceId = Span.current().getSpanContext().getTraceId();
     return TraceId.isValid(traceId) ? traceId : null;
   }

   @Override
   public String getSpanId() {
     String spanId = Span.current().getSpanContext().getSpanId();
     return SpanId.isValid(spanId) ? spanId : null;
   }
}

// Generate Spring Bean
@Configuration
public class SpanConfiguration {
     @Bean
     public SpanContextSupplier spanContextSupplier(){
         return new OpenTelemetrySpanContextSupplier();
     }
}
```

#### other

Micrometer does not directly support Summary and Histogram, but it abstracts higher-level APIs to support these two indicators, such as timers:

```
Timer.Sample sample = Timer.start(registry);

//Do something

Timer timer = Timer
     .builder("my.timer")
     .description("a description of what this timer does") // optional
     .tags("region", "test") // optional
     .register(registry);
sample.stop(timer)
```

For advanced usage of micrometer, please refer to: https://micrometer.io/docs/concepts

#### HTTP interface

Open the endpoint of prometheus

```
management:
  endpoints:
    web:
      exposure:
        include: "prometheus"
```
Call the /actuator/prometheus interface of the service to obtain the current prometheus data

#### Pushgateway

Implement HttpConnectionFactory:

```
public class BkConnectionFactory implements HttpConnectionFactory {
     private final String token;

     public BkConnectionFactory(String token) {
         this.token = token;
     }

     @Override
     public HttpURLConnection create(String url) throws IOException {
         HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(url).openConnection();
         httpURLConnection.setRequestProperty("X-BK-TOKEN", token);
         return httpURLConnection;
     }
}
```

Generate PrometheusPushGatewayManager Bean:

```
@Configuration
public static class PrometheusPushGatewayConfiguration {
@Bean
public PrometheusPushGatewayManager prometheusPushGatewayManager(CollectorRegistry collectorRegistry,PrometheusProperties prometheusProperties, Environment environment) {
PrometheusProperties.Pushgateway properties = prometheusProperties.getPushgateway();
Duration pushRate = properties.getPushRate();
String job = getJob(properties, environment);
PushGateway pushGateway = initializePushGateway(properties.getBaseUrl());
pushGateway.setConnectionFactory(new BkConnectionFactory("${token}")); // Token monitored by BlueKing
return new PrometheusPushGatewayManager(pushGateway, collectorRegistry, pushRate, job, groupingKey, shutdownOperation);
}

private PushGateway initializePushGateway(String url) {
try {
return new PushGateway(new URL(url));
}
catch (MalformedURLException ex) {
logger.warn(LogMessage
.format("Invalid PushGateway base url '%s': update your configuration to a valid URL", url));
return new PushGateway(url);
}
}

private String getJob(PrometheusProperties.Pushgateway properties, Environment environment) {
String job = properties.getJob();
job = (job != null) ? job : environment.getProperty("spring.application.name");
return (job != null) ? job : FALLBACK_JOB;
}
}
```

Configure properties:

```
management:
   metrics:
     export:
       prometheus:
         pushgateway:
           base-url: localhost:9091 #Blue Shield monitoring push url
           enabled: true #Enable publishing through Prometheus Pushgateway
           job: #The job identifier of this application instance, the default value is ${spring.application.name}
           push-rate: 1m #Frequency used to push indicators
```

### 2. Use simpleclient

Introduce SDK

```
<!-- The client -->
<dependency>
   <groupId>io.prometheus</groupId>
   <artifactId>simpleclient</artifactId>
   <version>0.15.0</version> <!-- If Spring Boot Dependency is referenced, the version does not need to be specified -->
</dependency>
<!-- Hotspot JVM metrics-->
<dependency>
   <groupId>io.prometheus</groupId>
   <artifactId>simpleclient_hotspot</artifactId>
   <version>0.15.0</version> <!-- If Spring Boot Dependency is referenced, the version does not need to be specified -->
</dependency>
<!-- Expose HTTP interface -->
<dependency>
   <groupId>io.prometheus</groupId>
   <artifactId>simpleclient_httpserver</artifactId>
   <version>0.15.0</version> <!-- If Spring Boot Dependency is referenced, the version does not need to be specified -->
</dependency>
<!-- Use pushgateway -->
<dependency>
   <groupId>io.prometheus</groupId>
   <artifactId>simpleclient_pushgateway</artifactId>
   <version>0.15.0</version> <!-- If Spring Boot Dependency is referenced, the version does not need to be specified -->
</dependency>
Counter
Counter counter = Counter.build().name("requests_total").help("Total requests.").register();
// Do something
counter.inc()
```

#### Gauge

```
Gauge gauge = Gauge.build().name("inprogress_requests").help("Inprogress requests.").register();
// Do something
gauge.set(0.1)
```

#### Summary

```
Summary requestLatency = Summary.build()
     .name("requests_latency_seconds")
     .help("request latency in seconds")
     .register();
Summary.Timer requestTimer = requestLatency.startTimer();
//Do something
requestTimer.observeDuration();
```

#### Histogram

```
Histogram requestLatency = Histogram.build()
      .name("requests_latency_seconds").help("Request latency in seconds.").register();
Histogram.Timer requestTimer = requestLatency.startTimer();
//Do something
requestTimer.observeDuration();
```

#### Exemplars

Access OpenTelemetry: opentelemetry SDK (Java) Instructions for use

Simpleclient version 0.11.0 or above will support it, and it will be automatically enabled by default.

(Note: To access the http interface, you need to bring the header 'Accept: application/openmetrics-text; version=1.0.0; charset=utf-8' to obtain the data)

#### HTTP interface

```
HTTPServer server = new HTTPServer.Builder()
     .withPort(1234)
     .build();
```

You can get the data by calling the "/metrics" path of port 1234.

#### Pushgateway

Note: pushgateway does not currently support exemplars

Implement HttpConnectionFactory, refer to: "Implementing HttpConnectionFactory" of Pushgateway in micrometer

Start Pushgateway

```
PushGateway pushGateway = new PushGateway("10.0.0.1:9091"); // BlueKing monitored push url
pushGateway.setConnectionFactory(new BkConnectionFactory("${token}")); // Token monitored by BlueKing
pushGateway.pushAdd(CollectorRegistry.defaultRegistry, "my-job"); // This method will be pushed once when called once. You need to implement the trigger method yourself, such as using ScheduledExecutorService to trigger regularly.
```


## 4. Frequently Asked Questions
TODO

## 5. Additional information
TODO