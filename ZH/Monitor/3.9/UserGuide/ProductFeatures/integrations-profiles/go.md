# Go 语言接入蓝鲸 APM Profiling 功能指引



### 1. 安装 pyroscope-go SDK


```bash
go get github.com/grafana/pyroscope-go
```

在你的应用入口添加以下参考代码：

```go
package main

import "github.com/grafana/pyroscope-go"

func main() {
	// 其他代码
	pyroscope.Start(pyroscope.Config{
		// 填写你的应用名称
		ApplicationName: "{YOUR_APP_NAME}",
		// 填写数据上报地址
		ServerAddress:   "{HTTP_PUSH_URL}/pyroscope",
		// 如果想正确关联 Trace 与 Profiling 数据，需要和 trace 中的 service 字段内容保持一致 
		Tags: map[string]string{
    		"serviceName": {YOUR_SERVICE_NAME},
		},
		// 设置为 nil 时可以禁用日志
		Logger:          pyroscope.StandardLogger,
		// 填写你的 TOKEN
		AuthToken:       "{TOKEN}"
		// 建议：当前只需要上报 CPU 数据
		ProfileTypes: []pyroscope.ProfileType{
			pyroscope.ProfileCPU,
		},
	})

  // 其他代码
}
```
此时你的应用已经可以按照默认的频率（10s一次）将性能数据上报到 APM 服务中了，你可以通过 Profiling 页面查询它们。

**如果你想打通 Profiling 和 Trace 数据，可以继续进行下面的配置。**

### 2. 安装 otelfiling-go

首先需要确认，是否已经安装过了 Go otel SDK，如果还没有请先参考 [otel 官方文档](https://opentelemetry.io/docs/instrumentation/go/getting-started/) 安装，并确保 Trace 数据在页面能够正常查询。

```
go get github.com/grafana/otel-profiling-go
```
在刚才添加的 pyroscope 代码之上，我们再额外添加一些代码。


```
package main

import (
	...
	"github.com/grafana/pyroscope-go"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/stdout/stdouttrace"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/sdk/trace"
	
	"github.com/pyroscope-io/otel-profiling-go"
	...
)

func main() {
	// 其他代码

	// 在 Profiling 配置前，初始化 Tracer
	tp := initTracer("{YOUR_APP_NAME}", "{HTTP_PUSH_URL}/pyroscope")
	defer func() {
		if err := tp.Shutdown(context.Background()); err != nil {
			log.Printf("Error shutting down tracer provider: %v", err)
		}
	}()

	pyroscope.Start(pyroscope.Config{
		// 填写你的应用名称
		ApplicationName: "{YOUR_APP_NAME}",
		// 填写数据上报地址
		ServerAddress:   "{HTTP_PUSH_URL}/pyroscope",
		// 设置为 nil 时可以禁用日志
		Logger: pyroscope.StandardLogger,
		// 填写你的 TOKEN
		AuthToken: "{TOKEN}"
		// 建议当前只上报 CPU 数据
		ProfileTypes: []pyroscope.ProfileType{
			pyroscope.ProfileCPU,
		},
	})

	// 其他代码
}

// 初始化 Tracer
func initTracer(appName, pyroscopeEndpoint string) *trace.TracerProvider {
	exporter, err := stdouttrace.New(stdouttrace.WithPrettyPrint())
	if err != nil {
		log.Fatal(err)
	}
	tp := trace.NewTracerProvider(
		trace.WithSampler(trace.AlwaysSample()),
		trace.WithBatcher(exporter),
	)
	otel.SetTracerProvider(otelpyroscope.NewTracerProvider(tp,
		otelpyroscope.WithAppName(appName),
		otelpyroscope.WithRootSpanOnly(true),
		otelpyroscope.WithAddSpanName(true),
	))
	otel.SetTextMapPropagator(propagation.NewCompositeTextMapPropagator(
		propagation.TraceContext{},
		propagation.Baggage{},
	))
	return tp
}
```
重新编译部署启动后，Profiling 数据将被标记上关联的 Trace 信息，你可以在 Trace 页面直接查看关联上的性能分析数据。