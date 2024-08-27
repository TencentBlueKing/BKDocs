# Prometheus SDK （Java） 使用说明

## 一. 背景

Prometheus是一个开源的完整监控解决方案，其对传统监控系统的测试和告警模型进行了彻底的颠覆，形成了基于中央化的规则计算、统一分析和告警的新模型

Java侧主要使用了两种SDK , micrometer 和 simpleclient , 其中 micrometer 是Spring 社区维护 , 主要适用于 Spring 体系下使用  ; simpleclient 为 Prometheus 团队维护 , 主要适用于其他非 Spring 场景 

## 二. SDK 说明

1. 仓库

micrometer-metrics/micrometer (spring 环境推荐)
prometheus/client_java (不依赖 spring )

2. 环境依赖说明

JDK版本 >= 1.8

benchmark : 

micrometer : 暂无
simpleclient : client_java/benchmarks

## 三.使用案例

数据埋点

### 1. 使用micrometer

引入SDK

```
<dependency>
  <groupId>io.micrometer</groupId>
  <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-actuator</artifactId>
</dependency>
<!-- 需要pushgateway才引入 -->
<dependency>
	<groupId>io.prometheus</groupId>
	<artifactId>simpleclient_pushgateway</artifactId>
</dependency>
```

Spring Boot 会根据上面引入的micrometer-registry-prometheus , 自动配置一个 MeterRegistry 对象 (实际是实例化了其子类 PrometheusMeterRegistry ) , 在需要采集的类注入

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

注 : Spring Boot 2.7 才支持 , 相关issue:  [Support for 
Prometheus Exemplars]()


接入 OpenTelemetry : [opentelemetry SDK(Java) 使用说明](../integrations-traces/otel_sdk_java.md)


引入 OpenTelemetry API :

```
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-api</artifactId>
</dependency>
```

声明 SpanContextSupplier 对象

```
// 实现SpanContextSupplier 
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

// 生成Spring Bean
@Configuration
public class SpanConfiguration {
    @Bean
    public SpanContextSupplier spanContextSupplier(){
        return new OpenTelemetrySpanContextSupplier();
    }
}
```

#### 其他

micrometer不直接支持 Summary 和 Histogram , 但他抽象出更高级的API支持这两种指标的支持 , 如计时器:

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

关于 micrometer 进阶的使用方法 , 参考 :  https://micrometer.io/docs/concepts

#### HTTP 接口 

开启prometheus的endpoint

```
management:
  endpoints:
    web:
      exposure:
        include: "prometheus"
```

调用服务的 /actuator/prometheus 接口即可获取当前的prometheus 数据

#### Pushgateway

实现 HttpConnectionFactory :

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

生成PrometheusPushGatewayManager Bean :

```
@Configuration
public static class PrometheusPushGatewayConfiguration {
	@Bean
	public PrometheusPushGatewayManager prometheusPushGatewayManager(CollectorRegistry collectorRegistry,PrometheusProperties prometheusProperties, Environment environment) {
		PrometheusProperties.Pushgateway properties = prometheusProperties.getPushgateway();
		Duration pushRate = properties.getPushRate();
		String job = getJob(properties, environment);
		PushGateway pushGateway = initializePushGateway(properties.getBaseUrl());
		pushGateway.setConnectionFactory(new BkConnectionFactory("${token}")); // 蓝鲸监控的Token
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

配置properties:

```
management:
  metrics:
    export:
      prometheus:
        pushgateway:
          base-url: localhost：9091 #蓝盾监控的push url
          enabled: true #通过Prometheus Pushgateway启用发布
          job: #此应用程序实例的作业标识符 , 缺省值为 ${spring.application.name}
          push-rate: 1m #用于推送指标的频率
```

### 2. 使用 simpleclient

引入SDK

```
<!-- The client -->
<dependency>
  <groupId>io.prometheus</groupId>
  <artifactId>simpleclient</artifactId>
  <version>0.15.0</version> <!-- 若引用了 Spring Boot Dependency , 可以不指定版本 -->
</dependency>
<!-- Hotspot JVM metrics-->
<dependency>
  <groupId>io.prometheus</groupId>
  <artifactId>simpleclient_hotspot</artifactId>
  <version>0.15.0</version> <!-- 若引用了 Spring Boot Dependency , 可以不指定版本 -->
</dependency>
<!-- 暴露HTTP 接口 -->
<dependency>
  <groupId>io.prometheus</groupId>
  <artifactId>simpleclient_httpserver</artifactId>
  <version>0.15.0</version> <!-- 若引用了 Spring Boot Dependency , 可以不指定版本 -->
</dependency>
<!-- 使用 pushgateway -->
<dependency>
  <groupId>io.prometheus</groupId>
  <artifactId>simpleclient_pushgateway</artifactId>
  <version>0.15.0</version> <!-- 若引用了 Spring Boot Dependency , 可以不指定版本 -->
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

接入 OpenTelemetry : opentelemetry SDK(Java) 使用说明

simpleclient 版本 0.11.0 以上就会支持 , 默认会自动开启

( 注: 访问http接口需要带上头部 'Accept: application/openmetrics-text; version=1.0.0; charset=utf-8' 才可以获取到数据 )

#### HTTP 接口

```
HTTPServer server = new HTTPServer.Builder()
    .withPort(1234)
    .build();
```

调用1234端口的"/metrics"路径就可以获取到数据

#### Pushgateway

注: pushgateway 暂不支持 exemplars

实现 HttpConnectionFactory , 参考 : micrometer 中 Pushgateway 的 "实现 HttpConnectionFactory"

启动Pushgateway

```
PushGateway pushGateway = new PushGateway("127.0.0.1:9091"); // 蓝鲸监控的push url
pushGateway.setConnectionFactory(new BkConnectionFactory("${token}")); // 蓝鲸监控的Token
pushGateway.pushAdd(CollectorRegistry.defaultRegistry , "my-job"); // 该方法调用一次就会push一次,需要自己实现触发方式,比如使用ScheduledExecutorService定时触发
```


## 四. 常见问题
TODO

## 五. 附带信息
TODO



