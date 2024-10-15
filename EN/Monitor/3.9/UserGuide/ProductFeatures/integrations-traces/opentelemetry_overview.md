# Opentelemetry Introduction


|Standards |Overview |Traces |Metrics |Logs |Status |
|---|---|---|---|---|---|
|OpenTracing |Initiated at the end of 2015 and approved as the third CNCF project in 2016 |✓ | | |Stop updating |
|OpenCensus |2017 originated from Google project leader from Google, Microsoft |✓ |✓ | |Stop updating |
|OpenMetrics |Originated in 2017 by the Prometheus community project leader from Grafana, Gitlab | |✓ | |Continuously updated |
|OpenTelemetry |2019 merged from OpenTracing and OpenCensus. |✓ |✓ |✓ |Thriving |

Judging from the development history and goals of OpenTelemetry, OTel actually wants to solve the data linkage problem of metric-trace-log. The idea of data linkage was proposed in 2010, and Opentracing was also developed, but it has always only been in trace data. At the same level, related linkages were also implemented under the specification of private protocols in different companies. Until the emergence of OTel in 2019, it mainly standardized the SDK tools and architecture. It is really possible to achieve unification in the future.

![](media/16621059451793.jpg)
> https://peter.bourgon.org/blog/2017/02/21/metrics-tracing-and-logging.html
> https://static.googleusercontent.com/media/research.google.com/zh-CN//archive/papers/dapper-2010-1.pdf


Open telemetry architecture
![](media/16621059656703.jpg)


> https://opentelemetry.io/docs/


BlueKing Monitoring is fully compatible with OTel's protocol, and also uses OTel's SDK directly for data reporting. Based on the BlueKing Monitoring architecture, we developed Collector to meet the product capability needs of APM.