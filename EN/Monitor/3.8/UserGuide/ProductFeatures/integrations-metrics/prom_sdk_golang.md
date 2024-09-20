# Prometheus SDK (golang) usage instructions

## written in front

Prometheus officially provides [Golang SDK](https://github.com/prometheus/client_golang) for reporting metric. Users can customize the metric and then report the metric data by push or pull.

Instructions for using these two methods are introduced below.

## Usage example

#### Example of data burying point
##### Counter type
```
// Create counter object
counter = prometheus.NewCounter(prometheus.CounterOpts{
     Name: "api_called_total",
     Help: "How many is the api called",
})

// register
registry := prometheus.NewRegistry()
registry.MustRegister(counter)

// Calculate counter
counter.Inc()
```

##### Gauge type
```
//Create gauge object
gauge = prometheus.NewGauge(prometheus.GaugeOpts{
     Name: "cpu_usage",
     Help: "simulate the cpu usage metric",
})

// register
registry := prometheus.NewRegistry()
registry.MustRegister(gauge)

// Set gauge
gauge.Set(rand.Float64() / 100)
```

##### Histogram type
```
//Create histogram object
histogram = prometheus.NewHistogram(prometheus.HistogramOpts{
     Name: "task_time_histogram",
     Help: "analyze the time of task with histogram",
     Buckets: []float64{1, 2, 3, 4, 5},
})

// register
registry := prometheus.NewRegistry()
registry.MustRegister(histogram)

// Observe histogram
histogram.Observe(3)
```

##### Summary type
```
// Create summary object
summary = prometheus.NewSummary(prometheus.SummaryOpts{
     Name: "task_time_summary",
     Help: "analyze the time of task with summary",
     Objectives: map[float64]float64{
         0.5: 0.05,
         0.9: 0.01,
         0.99: 0.001,
     },
})

// register
registry := prometheus.NewRegistry()
registry.MustRegister(histogram)

// Observation summary
summary.Observe(rand.Float64())
```

#### PUSH reporting method
The metric service actively reports to the endpoint.

##### Precautions
- Added headers to carry token information. Define Client behavior. Since prometheus sdk does not provide a method to add or modify Headers, you need to implement the Client interface.
- Fill in the reporting endpoint and specify it in push.New("$endpoint", name). Then you need to pass the customized client into pusher.Client($bkClient{}).
- It is recommended to specify instance labels for Grouping when reporting, so that the page can be grouped by the target dimension.

##### Sample code

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

// What needs to be changed
var (
     name = "demo"
     // TOKEN is the Token applied for on the saas side
     token = ""
     // Note that it is consistent with the cloud region where the service is deployed.
     host = ""
)

type bkClient struct{}

// Do token used to specify header
func (c *bkClient) Do(r *http.Request) (*http.Response, error) {
     r.Header.Set("X-BK-TOKEN", token)
     return http.DefaultClient.Do(r)
}

//Create custom metric
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
         Name: "task_time_histogram",
         Help: "analyze the time of task with histogram",
         Buckets: []float64{1, 2, 3, 4, 5},
     })
     // summary
     summary = prometheus.NewSummary(prometheus.SummaryOpts{
         Name: "task_time_summary",
         Help: "analyze the time of task with summary",
         Objectives: map[float64]float64{
             0.5: 0.05,
             0.9: 0.01,
             0.99: 0.001,
         },
     })
)

func main() {
     //Create a pusher and specify grouping instance labels
     pusher := push.New(fmt.Sprintf("%s:4318", host), name).Grouping("instance", "my.host.ip")

     //Create a custom register and register multiple metrics
     registry := prometheus.NewRegistry()
     registry.MustRegister(counter, gauge, histogram, summary)

     //Add registry
     pusher.Gatherer(registry)

     // Pass in custom Client
     pusher.Client(&amp;bkClient{})

     ticker := time.Tick(10 * time.Second)
     for {
         <-ticker

         //Add the value corresponding to metric
         counter.Inc()
         gauge.Set(rand.Float64() / 100)
// When the histogram bucket is less than 3, the filtered value is 0
         histogram.Observe(3)
         summary.Observe(rand.Float64())

         // Push data
         if err := pusher.Push(); err != nil {
             log.Println("failed to push records to the server, error:", err)
             continue
         }
         log.Println("push records to the server successfully")
     }
}
```


#### PULL reporting method
Obtain customized metric information through the interface.


##### Sample code
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

//Create custom metric
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
         Name: "task_time_histogram",
         Help: "analyze the time of task with histogram",
         Buckets: []float64{1, 2, 3, 4, 5},
     })
     // summary
     summary = prometheus.NewSummary(prometheus.SummaryOpts{
         Name: "task_time_summary",
         Help: "analyze the time of task with summary",
         Objectives: map[float64]float64{
             0.5: 0.05,
             0.9: 0.01,
             0.99: 0.001,
         },
     })
)

func main() {
     registry := prometheus.NewRegistry()
     registry.MustRegister(counter, gauge, histogram, summary)

     addValues()

     // In web frameworks such as gin, you can refer to the corresponding framework loading examples.
     http.Handle("/metrics", promhttp.HandlerFor(registry, promhttp.HandlerOpts{EnableOpenMetrics: true}))
     http.ListenAndServe(metricAddr, nil)
}

//Set the values required for different metrics
func addValues() {
     go func() {
         ticker := time.Tick(10 * time.Second)
         for {
             <-ticker
             //Add the value corresponding to metric
             counter.Inc()
             gauge.Set(rand.Float64() / 100)
// When the histogram bucket is less than 3, the filtered value is 0
             histogram.Observe(3)
             summary.Observe(rand.Float64())
         }
     }()
}
```

## refer to

1. [prometheus golang sdk](https://github.com/prometheus/client_golang)