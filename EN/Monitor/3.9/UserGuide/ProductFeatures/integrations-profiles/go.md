# Go language access  APM Profiling function guide



### 1. Install pyroscope-go SDK


```bash
go get github.com/grafana/pyroscope-go
```

Add the following reference code to your app entry:

```go
package main

import "github.com/grafana/pyroscope-go"

func main() {
	// Some other code
	pyroscope.Start(pyroscope.Config{
		// Fill in your app name
		ApplicationName: "{YOUR_APP_NAME}",
		// Enter the data report address
		ServerAddress:   "{HTTP_PUSH_URL}/pyroscope",
		// If you want to correctly associate Trace and Profiling data, you need to be consistent with the contents of the service field in trace
		Tags: map[string]string{
    		"serviceName": {YOUR_SERVICE_NAME},
		},
		// Logging can be disabled when set to nil
		Logger:          pyroscope.StandardLogger,
		// Fill in your TOKEN
		AuthToken:       "{TOKEN}"
		// Suggestion: Only the CPU data needs to be reported
		ProfileTypes: []pyroscope.ProfileType{
			pyroscope.ProfileCPU,
		},
	})

  // Some other code
}
```
At this point, your application can report performance data to the APM service at the default frequency (once every 10 seconds), which you can query through the Profiling page.

**If you want to get through Profiling and Trace data, you can proceed with the following configuration.**

### 2. Install otelfile-go

You first need to confirm, whether had already installed Go otel SDK, if not, please refer to [otel official document](https://opentelemetry.io/docs/instrumentation/go/getting-started/) installed, And ensure that Trace data can be queried normally on the page.

```
go get github.com/grafana/otel-profiling-go
```
On top of the pyroscope code we just added, let's add some additional code.


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
	// Some other code

	// Initialize Tracer before Profiling configuration
	tp := initTracer("{YOUR_APP_NAME}", "{HTTP_PUSH_URL}/pyroscope")
	defer func() {
		if err := tp.Shutdown(context.Background()); err != nil {
			log.Printf("Error shutting down tracer provider: %v", err)
		}
	}()

	pyroscope.Start(pyroscope.Config{
		// Fill in your app name
		ApplicationName: "{YOUR_APP_NAME}",
		// Enter the data report address
		ServerAddress:   "{HTTP_PUSH_URL}/pyroscope",
		// Logging can be disabled when set to nil
		Logger: pyroscope.StandardLogger,
		// Fill in your TOKEN
		AuthToken: "{TOKEN}"
		// You are advised to report only CPU data
		ProfileTypes: []pyroscope.ProfileType{
			pyroscope.ProfileCPU,
		},
	})

	// Some other code
}

// Initialize Tracer
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
After the recompile deployment starts, the Profiling data will be tagged with the associated Trace information, and you can view the associated profiling data directly on the Trace page.