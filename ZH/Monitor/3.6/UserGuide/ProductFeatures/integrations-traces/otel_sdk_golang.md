# Opentelemetry SDK ( Golang ) 使用说明

## 简介

OpenTelemetry Golang SDK是社区提供的一套适用于 `golang` 项目的 API 集合，捕获观测类数据，如 trace、metric、logs 等，并推送到可观测管理平台。

## 安装依赖

可以使用`go mod`进行管理

### 基础依赖

```
go get go.opentelemetry.io/otel
go get go.opentelemetry.io/otel/trace
go get go.opentelemetry.io/otel/sdk
```

### HTTP 上报依赖

```
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp
```

### GRPC 上报依赖

```
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc
```

## 使用案例

### 注册应用

蓝鲸监控作为opentelemety作为数据接收端， 通过SDK上报的基础上，需要注册对应的应用，以及获取到对应的token。上报数据需要携带token。复制 SecureKey 和推送的地址(端口为4317的 `Push URL`), 分别记为 token 和 url。

按照下面步骤进行申请: 
![](media/16613340572128.jpg)

输入应用名称
![](media/16613340699551.jpg)


选择环境及配置参数

查看生成后的 SecureKey 及 Push URL

![](media/16613341009348.jpg)



### 代码示例

#### 公共部分

```
package main

// 需要变动的内容，Token 等秘钥相关建议环境变量注入
const (
    // ServiceName: 你的服务的名称
    ServiceName = ""
    // Token: 在监控页面申请的 SecureKey
    Token = ""
    // Endpoint: 在监控页面申请的 ep，注意使用的是http还是grpc
    // 格式为域名:端口，其中域名不带有协议头
    Endpoint = ""
)
```

```
package main

import (
    "context"
    "flag"
    "fmt"
    "log"

    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/attribute"
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace"
    "go.opentelemetry.io/otel/sdk/resource"
    sdktrace "go.opentelemetry.io/otel/sdk/trace"
    semconv "go.opentelemetry.io/otel/semconv/v1.4.0"
    "go.opentelemetry.io/otel/trace"
)

var tracer = otel.Tracer("go-server")

// newResource returns a resource describing this application.
func newResource() *resource.Resource {
    return resource.NewWithAttributes(
        semconv.SchemaURL,
        semconv.ServiceNameKey.String(ServiceName),

        // 建议通过环境变量设置 Token，SDK 会加载环境变量获取对应的值
        // 设置环境变量，仅需要变动 SecureKey; 如: export OTEL_RESOURCE_ATTRIBUTES=bk.data.token=通过监控平台获取的 SecureKey
        // 如果设置了环境变量，可以忽略下面设置`bk.data.token`的代码
        attribute.Key("bk.data.token").String(Token),
    )
}

// initTrace 初始化 exporter
func initExporter(ctx context.Context) (func(context.Context) error, error) {
    client := newGrpcExporterClient()
    // 使用 grpc 或 http
    // client = newHttpExporterClient()
    exporter, err := otlptrace.New(ctx, client)
    if err != nil {
        log.Fatalf("creating OTLP trace exporter: %v", err)
        return nil, fmt.Errorf("creating OTLP trace exporter: %w", err)
    }

    tracerProvider := sdktrace.NewTracerProvider(
        sdktrace.WithBatcher(exporter),
        sdktrace.WithResource(newResource()),
    )
    otel.SetTracerProvider(tracerProvider)

    return tracerProvider.Shutdown, nil
}

func main() {
    ctx := context.Background()
    // Registers a tracer Provider globally.
    shutdown, err := initExporter(ctx)
    if err != nil {
        log.Fatal(err)
    }
    defer func() {
        if err := shutdown(ctx); err != nil {
            log.Fatal(err)
        }
    }()
    // 埋点数据
    log.Println("the answer is", add(ctx, multiply(ctx, multiply(ctx, 2, 2), 10), 2))
}

```


#### GRPC Exporter

```
package main

import (
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace"
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
)

func newGrpcExporterClient() otlptrace.Client {
    return otlptracegrpc.NewClient(
        otlptracegrpc.WithEndpoint(Endpoint),
        otlptracegrpc.WithInsecure(),
    )
}
```

#### HTTP Exporter

```
package main

import (
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace"
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp"
)

func newHttpExporterClient() otlptrace.Client {
    return otlptracehttp.NewClient(
        otlptracehttp.WithEndpoint(Endpoint),
        otlptracehttp.WithInsecure(),
    )
}
```

#### 埋点示例

```
func add(ctx context.Context, x, y int64) int64 {
    var span trace.Span
    // 添加span
    _, span = tracer.Start(ctx, "Addition")
    defer span.End()

    return x + y
}

func multiply(ctx context.Context, x, y int64) int64 {
    var span trace.Span
    // 添加span
    _, span = tracer.Start(ctx, "Multiplication")
    defer span.End()

    return x * y
}
```

#### 完整示例

```golang
// gomod 依赖
//module github.com/TencentBlueKing/bk-collector/example/ottraces
//
//go 1.18
//
//require (
// go.opentelemetry.io/contrib/instrumentation/net/http/httptrace/otelhttptrace v0.34.0
// go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.34.0
// go.opentelemetry.io/otel v1.9.0
// go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.9.0
// go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.9.0
// go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp v1.9.0
// go.opentelemetry.io/otel/exporters/stdout/stdouttrace v1.9.0
// go.opentelemetry.io/otel/sdk v1.9.0
// go.opentelemetry.io/otel/trace v1.9.0
//)
//
//require (
// github.com/cenkalti/backoff/v4 v4.1.3 // indirect
// github.com/felixge/httpsnoop v1.0.3 // indirect
// github.com/go-logr/logr v1.2.3 // indirect
// github.com/go-logr/stdr v1.2.2 // indirect
// github.com/golang/protobuf v1.5.2 // indirect
// github.com/grpc-ecosystem/grpc-gateway/v2 v2.7.0 // indirect
// go.opentelemetry.io/otel/exporters/otlp/internal/retry v1.9.0 // indirect
// go.opentelemetry.io/otel/metric v0.31.0 // indirect
// go.opentelemetry.io/proto/otlp v0.18.0 // indirect
// golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4 // indirect
// golang.org/x/sys v0.0.0-20210510120138-977fb7262007 // indirect
// golang.org/x/text v0.3.5 // indirect
// google.golang.org/genproto v0.0.0-20211118181313-81c1377c94b1 // indirect
// google.golang.org/grpc v1.46.2 // indirect
// google.golang.org/protobuf v1.28.0 // indirect
//)

package main

import (
   "context"
   "errors"
   "flag"
   "fmt"
   "io/ioutil"
   "log"
   "math/rand"
   "net/http"
   "net/http/httptrace"
   "os"
   "os/signal"
   "syscall"
   "time"

   "go.opentelemetry.io/contrib/instrumentation/net/http/httptrace/otelhttptrace"
   "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"
   "go.opentelemetry.io/otel"
   "go.opentelemetry.io/otel/attribute"
   "go.opentelemetry.io/otel/exporters/otlp/otlptrace"
   "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
   "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp"
   stdout "go.opentelemetry.io/otel/exporters/stdout/stdouttrace"
   "go.opentelemetry.io/otel/propagation"
   "go.opentelemetry.io/otel/sdk/resource"
   sdktrace "go.opentelemetry.io/otel/sdk/trace"
   semconv "go.opentelemetry.io/otel/semconv/v1.12.0"
)

// 代码方案
type ExporterType string

const (
   ExporterStdout ExporterType = "stdout"
   ExporterHttp   ExporterType = "http"
   ExporterGrpc   ExporterType = "grpc"
)

type EnvMode string

const (
   EnvLocal EnvMode = "local"
   EnvBkop  EnvMode = "bkop"
   EnvBkte  EnvMode = "bkte"
)

var (
   Tracer = otel.Tracer("")
   Client = http.Client{}
)

func newStdoutExporter() (*stdout.Exporter, error) {
   return stdout.New(stdout.WithPrettyPrint())
}

func newHttpExporter(env string) (*otlptrace.Exporter, error) {
   return otlptracehttp.New(
      context.Background(),
      otlptracehttp.WithEndpoint(fmt.Sprintf("%s:4318", env)),
      otlptracehttp.WithInsecure(),
   )
}

func newGrpcExporter(env string) (*otlptrace.Exporter, error) {
   return otlptracegrpc.New(
      context.Background(),
      otlptracegrpc.WithEndpoint(fmt.Sprintf("%s:4317", env)),
      otlptracegrpc.WithInsecure(),
   )
}

func GetDomain(mode EnvMode) string {
   if ConfExporterHost != "" {
      return ConfExporterHost
   }

   var domain string
   switch mode {
   case EnvLocal:
      domain = "localhost"
   case EnvBkop:
      domain = "xxxx.com"
   case EnvBkte:
      domain = "yyy.com"
   default:
      panic("invalid env mode, only local/bkop/bkte supported")
   }
   return domain
}

func GetSpanExporter(et ExporterType, mode EnvMode) (sdktrace.SpanExporter, error) {
   domain := GetDomain(mode)
   switch et {
   case ExporterStdout:
      return newStdoutExporter()
   case ExporterHttp:
      return newHttpExporter(domain)
   case ExporterGrpc:
      return newGrpcExporter(domain)
   }
   return nil, errors.New("invalid exporter type")
}

func MustNewResource(token string) *resource.Resource {
   // 或者使用环境变量注入
   // export OTEL_RESOURCE_ATTRIBUTES="bk.data.token=Ymtia2JrYmtia2JrYmtiaxUtdLzrldhHtlcjc1Cwfo1u99rVk5HGe8EjT761brGtKm3H4Ran78rWl85HwzfRgw=="
   r, err := resource.Merge(
      resource.Default(),
      resource.NewWithAttributes(
         semconv.SchemaURL,
         semconv.ServiceNameKey.String("traces-demo"),
         semconv.ServiceVersionKey.String("v1.0.0"),
         attribute.String("environment", "test"),
         attribute.String("bk.data.token", token),
      ),
   )
   // TODO(Note): 这里是刻意而为之，请确保 resource.Default() 里使用的 SchemaURL 和 resource.NewWithAttributes() 里的 SchemaURL 使用的是相同版本
   // 是的，这玩意确实有可能会不一样 ┓(-´∀`-)┏
   if err != nil {
      panic(err)
   }
   return r
}

func initTracer(et ExporterType, mode EnvMode, token string) (*sdktrace.TracerProvider, error) {
   exporter, err := GetSpanExporter(et, mode)
   if err != nil {
      return nil, err
   }

   tp := sdktrace.NewTracerProvider(
      sdktrace.WithBatcher(exporter),
      sdktrace.WithResource(MustNewResource(token)),
   )

   otel.SetTracerProvider(tp)
   otel.SetTextMapPropagator(propagation.NewCompositeTextMapPropagator(propagation.TraceContext{}, propagation.Baggage{}))
   return tp, nil
}

func SleepRandom() {
   time.Sleep(time.Duration(rand.Int31n(1000)) * time.Millisecond)
}

type HttpSrv struct {
   s    *http.Server
   mux  http.Handler
   addr string
}

func GetAgeFromLocalCache(w http.ResponseWriter, req *http.Request) {
   username := req.URL.Query().Get("username")
   b := getAge(req.Context(), username, "getAgeFromLocalCache", "local")
   n := rand.Int31n(2)
   switch n {
   case 1:
      b = queryAgeWithTraces(req.Context(), fmt.Sprintf("http://%s/age_cache?username=%s", ConfDownstreamAddr, username), "server")
   }

   w.Write(b)
}

func GetAgeFromCacheServer(w http.ResponseWriter, req *http.Request) {
   username := req.URL.Query().Get("username")
   b := getAge(req.Context(), username, "getAgeFromCacheServer", "remote")
   w.Write(b)
}

func getAge(ctx context.Context, username, spanName, from string) []byte {
   ctx, span := Tracer.Start(ctx, spanName)
   if span != nil {
      defer span.End()
   }
   // pretend to query from somewhere
   SleepRandom()
   return []byte(fmt.Sprintf(`{"username":"%s", "age":%d, "from":"%s"}`, username, rand.Int31n(80), from))
}

func (srv *HttpSrv) Start() error {
   srv.s = &amp;http.Server{
      Addr:    srv.addr,
      Handler: srv.mux,
   }
   return srv.s.ListenAndServe()
}

func (srv *HttpSrv) Close() error {
   return srv.s.Close()
}

func NewUpstreamServerWithTraces() *HttpSrv {
   mux := http.NewServeMux()
   mux.Handle("/age", otelhttp.NewHandler(http.HandlerFunc(GetAgeFromLocalCache), "UpstreamAge"))
   return &amp;HttpSrv{
      mux:  mux,
      addr: ConfUpstreamAddr,
   }
}

func NewDownstreamServerWithTraces() *HttpSrv {
   mux := http.NewServeMux()
   mux.Handle("/age_cache", otelhttp.NewHandler(http.HandlerFunc(GetAgeFromCacheServer), "DownstreamAge"))
   return &amp;HttpSrv{
      mux:  mux,
      addr: ConfDownstreamAddr,
   }
}

func queryAgeWithTraces(ctx context.Context, url, from string) []byte {
   ctx, span := Tracer.Start(ctx, "queryAgeWithTraces-"+from)
   if span != nil {
      defer span.End()
   }

   ctx = httptrace.WithClientTrace(ctx, otelhttptrace.NewClientTrace(ctx))
   req, _ := http.NewRequestWithContext(ctx, "GET", url, nil)

   res, err := Client.Do(req)
   if err != nil {
      log.Fatal(err)
   }

   body, err := ioutil.ReadAll(res.Body)
   if err != nil {
      log.Fatal(err)
   }
   _ = res.Body.Close()

   return body
}

func LoopQueryAgeWithTraces(stop chan struct{}) {
   ticker := time.NewTicker(3 * time.Second)
   count := 0
   for {
      select {
      case <-ticker.C:
         b := queryAgeWithTraces(context.Background(), fmt.Sprintf("http://%s/age?username=blueking-%d", ConfUpstreamAddr, count), "client")
         log.Println(string(b))
         count++
      case <-stop:
         return
      }
   }
}

var (
   ConfEnv            string
   ConfExporter       string
   ConfToken          string
   ConfUpstreamAddr   string
   ConfDownstreamAddr string
   ConfExporterHost   string
)

func init() {
   flag.StringVar(&amp;ConfEnv, "env", "local", "env used to switch report environment, optional: local/bkop/bkte")
   flag.StringVar(&amp;ConfExporter, "exporter", "stdout", "exporter represents the standard exporter type, optional: stdout/http/grpc")
   flag.StringVar(&amp;ConfToken, "token", "Ymtia2JrYmtia2JrYmtiaxUtdLzrldhHtlcjc1Cwfo1u99rVk5HGe8EjT761brGtKm3H4Ran78rWl85HwzfRgw==", "authentication token")
   flag.StringVar(&amp;ConfUpstreamAddr, "upstream", "localhost:56089", "upstream server address for testing")
   flag.StringVar(&amp;ConfDownstreamAddr, "downstream", "localhost:56099", "downstream server address for testing")
   flag.StringVar(&amp;ConfExporterHost, "exporter-host", "", "specify the custom exporter host")
   flag.Parse()
}

func main() {
   tp, err := initTracer(ExporterType(ConfExporter), EnvMode(ConfEnv), ConfToken)
   if err != nil {
      log.Fatal(err)
   }

   Tracer = tp.Tracer("traces-demo/v1")
   Client = http.Client{Transport: otelhttp.NewTransport(http.DefaultTransport)}

   defer func() {
      if err := tp.Shutdown(context.Background()); err != nil {
         log.Printf("Error shutting down tracer provider: %v\n", err)
      }
   }()

   upSrv := NewUpstreamServerWithTraces()
   go func() {
      if err := upSrv.Start(); err != nil {
         log.Fatal(err)
      }
   }()
   downSrv := NewDownstreamServerWithTraces()
   go func() {
      if err := downSrv.Start(); err != nil {
         log.Fatal(err)
      }
   }()

   stop := make(chan struct{}, 1)
   go LoopQueryAgeWithTraces(stop)

   sigCh := make(chan os.Signal, 1)
   signal.Notify(sigCh, syscall.SIGTERM, syscall.SIGINT)

   <-sigCh
   stop <- struct{}{}
}
```

