# 增强服务：蓝鲸 APM

为了更好地对蓝鲸SaaS应用进行应用监控，可通过简单的服务申请和配置，接入蓝鲸监控的应用监控服务。从而实现对SaaS应用的调用链监控，更好地保证SaaS应用的正常运行，同时在排查问题时提供更加便捷的排查手段。


## 使用指南

蓝鲸 Python 开发框架已经集成OpenTelemetry SDK，只需以下 2 步即可开启：

1.requirements.txt 中修改 blueapps 依赖版本：
```python
blueapps[opentelemetry]==4.4.5
```

2.在config/default.py 文件的 INSTALLED_APPS 中添加：
```python
INSTALLED_APPS += (
    ...,
    "blueapps.opentelemetry.instrument_app",
)
ENABLE_OTEL_TRACE = True
BK_APP_OTEL_INSTRUMENT_DB_API = True # 是否开启 DB 访问 trace（开启后 span 数量会明显增多）
```

其他语言和框架可参考官方文档接入：
- OpenTelemetry SDK(golang) : https://opentelemetry.io/docs/instrumentation/go/
- OpenTelemetry SDK(Java) : https://github.com/open-telemetry/opentelemetry-java