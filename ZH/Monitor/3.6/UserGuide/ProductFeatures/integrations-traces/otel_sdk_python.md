# Opentelemetry SDK ( Python ) 使用说明 


## 简介

OpenTelemetry Python SDK是社区提供的一套适用于 `python` 项目的 API 集合，捕获观测类数据，如 trace、metric、logs 等，并推送到可观测管理平台。

## 安装依赖

### 安装 `API SDK` 包

```
pip install opentelemetry-api
pip install opentelemetry-sdk
```

### 安装拓展插件

根据自己的实际需求，安装[拓展插件](https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation)

```
pip install opentelemetry-instrumentation-{instrumentation}
```

### 安装exporter

安装常用的 `http` 或 `grpc` exporter

```
pip install opentelemetry-exporter-otlp-proto-http
pip install opentelemetry-exporter-otlp-proto-grpc
```

## 使用案例

### 注册应用

[查看应用创建流程]()

### 代码示例

#### GRPC Exporter

```
# -*- coding: utf-8 -*-
from opentelemetry import trace
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# 需要变动的内容
SERVICE_NAME = ""  # 你的服务的名称
TOKEN = ""  # 在监控页面申请的 TOKEN
PUSH_URL = ""  # 在监控页面申请的 Push URL，注意为grpc


def grpc_instrument():
    tracer_provider = TracerProvider(
        resource=Resource.create(
            {
                "service.name": SERVICE_NAME,
                # 建议通过环境变量设置 TOKEN 会加载环境变量获取对应的值
                #  设置环境变量，仅需要变动 SecureKey; 如: export OTEL_RESOURCE_ATTRIBUTES=bk.data.token=通过监控平台获取的 SecureKey
                # 如果设置了环境变量，可以忽略下面设置`bk.data.token`的代码
                "bk.data.token": TOKEN,
            }
        )
    )
    # 配置 grpc 上报 exporter 配置
    otlp_exporter = OTLPSpanExporter(endpoint=PUSH_URL, insecure=True)
    span_processor = BatchSpanProcessor(otlp_exporter)
    tracer_provider.add_span_processor(span_processor)
    # 注入 trace 配置
    trace.set_tracer_provider(tracer_provider)

```

#### HTTP Exporter

```
# -*- coding: utf-8 -*-

from opentelemetry import trace
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter

# 需要变动的内容
SERVICE_NAME = ""  # 你的服务的名称
TOKEN = ""  # 在监控页面申请的 TOKEN
PUSH_URL = ""  # 在监控页面申请的 Push URL，注意为http


def http_instrument():
    tracer_provider = TracerProvider(
        resource=Resource.create(
            {
                "service.name": SERVICE_NAME,
                # 建议通过环境变量设置 TOKEN 会加载环境变量获取对应的值
                #  设置环境变量，仅需要变动 SecureKey; 如: export OTEL_RESOURCE_ATTRIBUTES=bk.data.token=通过监控平台获取的 SecureKey
                # 如果设置了环境变量，可以忽略下面设置`bk.data.token`的代码
                "bk.data.token": TOKEN,
            }
        )
    )
    # 配置 http 上报 exporter 配置
    otlp_exporter = OTLPSpanExporter(endpoint=PUSH_URL)
    span_processor = BatchSpanProcessor(otlp_exporter)
    tracer_provider.add_span_processor(span_processor)
    # 注入 trace 配置
    trace.set_tracer_provider(tracer_provider)
```

#### 埋点示例

在需要上报数据的位置添加对应的 `span` 信息

```
from opentelemetry import trace
tracer = trace.get_tracer(__name__)

with tracer.start_as_current_span("foo"):
    with tracer.start_as_current_span("bar"):
        with tracer.start_as_current_span("baz"):
            print("Hello world from OpenTelemetry Python!")
```

