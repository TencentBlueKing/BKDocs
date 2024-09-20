# Prometheus SDK（golang） 使用说明

## 写在前面

Prometheus官方提供了上报 metric 的[Golang SDK](https://github.com/prometheus/client_golang), 用户可以自定义metric，然后采用 push 或 pull 的方式上报 metric 数据。

下面介绍下这两个方式的使用说明。

## 使用示例

#### 数据埋点示例
##### Counter类型
```
// 创建 counter 对象
counter = prometheus.NewCounter(prometheus.CounterOpts{
    Name: "api_called_total",
    Help: "How many is the api called",
})

// 注册
registry := prometheus.NewRegistry()
registry.MustRegister(counter)

// 计算 counter
counter.Inc()
```

##### Gauge 类型
```
// 创建 gauge 对象
gauge = prometheus.NewGauge(prometheus.GaugeOpts{
    Name: "cpu_usage",
    Help: "simulate the cpu usage metric",
})

// 注册
registry := prometheus.NewRegistry()
registry.MustRegister(gauge)

// 设置 gauge
gauge.Set(rand.Float64() / 100)
```

##### Histogram 类型
```
// 创建 histogram 对象
histogram = prometheus.NewHistogram(prometheus.HistogramOpts{
    Name:    "task_time_histogram",
    Help:    "analyze the time of task with histogram",
    Buckets: []float64{1, 2, 3, 4, 5},
})

// 注册
registry := prometheus.NewRegistry()
registry.MustRegister(histogram)

// 观测histogram
histogram.Observe(3)
```

##### Summary 类型
```
// 创建 summary 对象
summary = prometheus.NewSummary(prometheus.SummaryOpts{
    Name: "task_time_summary",
    Help: "analyze the time of task with summary",
    Objectives: map[float64]float64{
        0.5:  0.05,
        0.9:  0.01,
        0.99: 0.001,
    },
})

// 注册
registry := prometheus.NewRegistry()
registry.MustRegister(histogram)

// 观测 summary
summary.Observe(rand.Float64())
```

#### PUSH 上报方式
metric 服务主动上报到端点。

##### 注意事项
- 补充 headers，用于携带 token 信息。定义 Client 行为，由于 prometheus sdk 没有提供新增或者修改 Headers 的方法，所以需要实现 Client interface。
- 填写上报端点，在 push.New("$endpoint", name) 里指定。然后需要将自定义的 client 传入到 pusher.Client($bkClient{}) 里面。
- 建议上报时 Grouping 指定 instance labels，这样页面上能够以 target 维度归组。

##### 示例代码

```
package main

import (
    "fmt"
    "log"
    "math/rand"
    "net/http"
    "time"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/push"
)

// 需要更改的内容
var (
    name = "demo"
    // TOKEN 即在 saas 侧申请的 Token
    token = ""
    // 注意和所属服务部署的云区域一致
    host = ""
)

type bkClient struct{}

// Do 用于指定 header 的 token
func (c *bkClient) Do(r *http.Request) (*http.Response, error) {
    r.Header.Set("X-BK-TOKEN", token)
    return http.DefaultClient.Do(r)
}

// 创建自定义的 metric
var (
    // counter
    counter = prometheus.NewCounter(prometheus.CounterOpts{
        Name: "api_called_total",
        Help: "How many is the api called",
    })
    // gauge
    gauge = prometheus.NewGauge(prometheus.GaugeOpts{
        Name: "cpu_usage",
        Help: "simulate the cpu usage metric",
    })
    // histogram
    histogram = prometheus.NewHistogram(prometheus.HistogramOpts{
        Name:    "task_time_histogram",
        Help:    "analyze the time of task with histogram",
        Buckets: []float64{1, 2, 3, 4, 5},
    })
    // summary
    summary = prometheus.NewSummary(prometheus.SummaryOpts{
        Name: "task_time_summary",
        Help: "analyze the time of task with summary",
        Objectives: map[float64]float64{
            0.5:  0.05,
            0.9:  0.01,
            0.99: 0.001,
        },
    })
)

func main() {
    // 创建一个pusher, 并指定 grouping instance labels
    pusher := push.New(fmt.Sprintf("%s:4318", host), name).Grouping("instance", "my.host.ip")

    // 创建自定义register，并注册多个meterics
    registry := prometheus.NewRegistry()
    registry.MustRegister(counter, gauge, histogram, summary)

    // 添加registry
    pusher.Gatherer(registry)

    // 传入自定义 Client
    pusher.Client(&amp;bkClient{})

    ticker := time.Tick(10 * time.Second)
    for {
        <-ticker

        // 添加 metric 对应的值
        counter.Inc()
        gauge.Set(rand.Float64() / 100)
		// 直方图 bucket 中小于3时，过滤到的数值为0
        histogram.Observe(3)
        summary.Observe(rand.Float64())

        // 推送数据
        if err := pusher.Push(); err != nil {
            log.Println("failed to push records to the server, error:", err)
            continue
        }
        log.Println("push records to the server successfully")
    }
}
```


#### PULL 上报方式
通过接口获取自定义的 metric 信息。


##### 示例代码
```
package main

import (
    "math/rand"
    "net/http"
    "time"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var metricAddr = ":8080"

// 创建自定义的 metric
var (
    // counter
    counter = prometheus.NewCounter(prometheus.CounterOpts{
        Name: "api_called_total",
        Help: "How many is the api called",
    })
    // gauge
    gauge = prometheus.NewGauge(prometheus.GaugeOpts{
        Name: "cpu_usage",
        Help: "simulate the cpu usage metric",
    })
    // histogram
    histogram = prometheus.NewHistogram(prometheus.HistogramOpts{
        Name:    "task_time_histogram",
        Help:    "analyze the time of task with histogram",
        Buckets: []float64{1, 2, 3, 4, 5},
    })
    // summary
    summary = prometheus.NewSummary(prometheus.SummaryOpts{
        Name: "task_time_summary",
        Help: "analyze the time of task with summary",
        Objectives: map[float64]float64{
            0.5:  0.05,
            0.9:  0.01,
            0.99: 0.001,
        },
    })
)

func main() {
    registry := prometheus.NewRegistry()
    registry.MustRegister(counter, gauge, histogram, summary)

    addValues()

    // gin 等 web 框架中可以参考对应框架加载示例
    http.Handle("/metrics", promhttp.HandlerFor(registry, promhttp.HandlerOpts{EnableOpenMetrics: true})) 
    http.ListenAndServe(metricAddr, nil)
}

// 设置不同 metric 需要的值
func addValues() {
    go func() {
        ticker := time.Tick(10 * time.Second)
        for {
            <-ticker
            // 添加 metric 对应的值
            counter.Inc()
            gauge.Set(rand.Float64() / 100)
			// 直方图 bucket 中小于3时，过滤到的数值为0
            histogram.Observe(3)
            summary.Observe(rand.Float64())
        }
    }()
}
```

## 参考

1. [prometheus golang sdk](https://github.com/prometheus/client_golang)

