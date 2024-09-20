# Opentelemetry SDK (Python) usage instructions


## Introduction

OpenTelemetry Python SDK is a set of APIs provided by the community and suitable for `python` projects. It captures observation data, such as trace, metric, logs, etc., and pushes it to the observable management platform.

## Install dependencies

### Install `API SDK` package

```
pip install opentelemetry-api
pip install opentelemetry-sdk
```

### Install extension plug-in

According to your actual needs, install [expansion plug-in](https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation)

```
pip install opentelemetry-instrumentation-{instrumentation}
```

### Install exporter

Install the commonly used `http` or `grpc` exporter

```
pip install opentelemetry-exporter-otlp-proto-http
pip install opentelemetry-exporter-otlp-proto-grpc
```

## Use Cases

### Register application

[View application creation process]()

### Code Example

#### GRPC Exporter

```
# -*- coding: utf-8 -*-
from opentelemetry import trace
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# What needs to be changed
SERVICE_NAME = "" # The name of your service
TOKEN = "" #TOKEN applied for on the monitoring page
PUSH_URL = "" # Push URL applied on the monitoring page, note that it is grpc


def grpc_instrument():
     tracer_provider = TracerProvider(
         resource=Resource.create(
             {
                 "service.name": SERVICE_NAME,
                 # It is recommended to set TOKEN through environment variables. The environment variables will be loaded to obtain the corresponding values.
                 # Set environment variables, only need to change SecureKey; such as: export OTEL_RESOURCE_ATTRIBUTES=bk.data.token=SecureKey obtained through the monitoring platform
                 # If environment variables are set, you can ignore the code below to set `bk.data.token`
                 "bk.data.token": TOKEN,
             }
         )
     )
     # Configure grpc to report exporter configuration
     otlp_exporter = OTLPSpanExporter(endpoint=PUSH_URL, insecure=True)
     span_processor = BatchSpanProcessor(otlp_exporter)
     tracer_provider.add_span_processor(span_processor)
     #Inject trace configuration
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

# What needs to be changed
SERVICE_NAME = "" # The name of your service
TOKEN = "" #TOKEN applied for on the monitoring page
PUSH_URL = "" # Push URL applied on the monitoring page, note that it is http


def http_instrument():
     tracer_provider = TracerProvider(
         resource=Resource.create(
             {
                 "service.name": SERVICE_NAME,
                 # It is recommended to set TOKEN through environment variables. The environment variables will be loaded to obtain the corresponding values.
                 # Set environment variables, only need to change SecureKey; such as: export OTEL_RESOURCE_ATTRIBUTES=bk.data.token=SecureKey obtained through the monitoring platform
                 # If environment variables are set, you can ignore the code below to set `bk.data.token`
                 "bk.data.token": TOKEN,
             }
         )
     )
     # Configure http reporting exporter configuration
     otlp_exporter = OTLPSpanExporter(endpoint=PUSH_URL)
     span_processor = BatchSpanProcessor(otlp_exporter)
     tracer_provider.add_span_processor(span_processor)
     #Inject trace configuration
     trace.set_tracer_provider(tracer_provider)
```

#### Example of buried points

Add the corresponding `span` information where the data needs to be reported

```
from opentelemetry import trace
tracer = trace.get_tracer(__name__)

with tracer.start_as_current_span("foo"):
     with tracer.start_as_current_span("bar"):
         with tracer.start_as_current_span("baz"):
             print("Hello world from OpenTelemetry Python!")
```