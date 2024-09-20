# Enhanced Services: BlueKing APM

To better monitor BlueKing SaaS applications, you can access the application monitoring service of BlueKing monitoring through simple service application and configuration. This enables call chain monitoring of SaaS applications, ensuring their normal operation and providing more convenient troubleshooting methods when issues arise.

## Usage Guide

The BlueKing Python development framework has already integrated the OpenTelemetry SDK. You only need to follow these two steps to get started:

1. Modify the blueapps dependency version in requirements.txt:

```python
blueapps[opentelemetry]==4.4.5
```

2. Add the following to the INSTALLED_APPS in the config/default.py file:

```python
INSTALLED_APPS += (
    ...,
    "blueapps.opentelemetry.instrument_app",
)
ENABLE_OTEL_TRACE = True
BK_APP_OTEL_INSTRUMENT_DB_API = True # Whether to enable DB access trace (enabling this will significantly increase the number of spans)
```

For other languages and frameworks, refer to the official documentation for integration:

- OpenTelemetry SDK (Go): https://opentelemetry.io/docs/instrumentation/go/
- OpenTelemetry SDK (Java): https://github.com/open-telemetry/opentelemetry-java