# Monitoring platform Exporter development

When there is no corresponding Exporter collector on the market, or the existing Exporter does not meet the needs, you can modify or re-develop an Exporter yourself, which is relatively simple.

Next, we will briefly introduce how to develop an Exporter plug-in.

## Base

### Exporter Introduction

**Exporter essentially converts the collected data into the corresponding text format, and provides an http interface for the monitoring platform collector to collect data regularly**

### Exporter Basics

  **Indicator introduction**

The four main indicator types used in Prometheus are as follows

- Counter (cumulative indicator)
- Gauge (measurement index)
- Summary
- Histogram

The most commonly used is Gauge. Gauge represents a single piece of data collected. This data can be increased or decreased, such as CPU usage, memory usage, current space capacity of the hard disk, etc.

Counter is a cumulative indicator data. This value will only gradually increase over time, such as the total number of tasks completed by the program, the total number of running errors, etc., which represents the cumulative value of continuously increasing data packets or transmitted bytes.

> [**Note**]: All indicator values only support float64 type

**text format**

Take the following output as an example:

```bash
#metric:
sample_metric1 12.47
sample_metric2{partition="c:"} 0.44
```

**in**:

- `# represents a comment
- `sample_metric1` and `sample_metric2` represent the metric name
- `partition` represents the dimension of the indicator, such as disk partition usage. The dimension is the disk partition, that is, each disk partition has a disk partition usage value.
- `xxx` represents the value of the dimension, such as the C drive/D drive of the disk partition, etc.
- `12.47` and `0.44` represent the values of the corresponding indicators


## Dependencies

* Golang language environment

*Introduce Prometheus dependency libraries

     ```bash
     go get github.com/prometheus/client_golang/prometheus
     ```

### Development Example

* (1) Create a new Exporter project:

     An Exporter only requires one file; create a test_Exporter directory and a test_Exporter.go file:

![e1](../Other/media/e1-1.png)

* (2) Import dependent modules

     ```go
     import (
     "flag"
     "log"
     "net/http"
     "github.com/prometheus/client_golang/prometheus"
     "github.com/prometheus/client_golang/prometheus/promhttp"
     )
     ```

* (3) Define the Exporter’s version (Version), listening address (listenAddress), collection url (metricPath) and homepage (landingPage)

     ```go
     var (
     Version = "1.0.0.dev"
     listenAddress = flag.String("web.listen-address", ":9601", "Address to listen on for web interface and telemetry.")
     metricPath = flag.String("web.telemetry-path", "/metrics", "Path under which to expose metrics.")
     landingPage = []byte("<html><head><title>SYS Exporter " + Version +
     "</title></head><body><h1>SYS Exporter " + Version + "</h1><p><a href='" + *metricPath + "'>Metrics</a></p ></body></html>")
     )
     ```

* (4) Define the Exporter structure

     ```go
     typeExporter struct {
     error prometheus.Gauge
     scrapeErrors *prometheus.CounterVec
     }
     ```

* (5) Define the function NewExporter for structure instantiation

     ```go
     func NewExporter() *Exporter {
     return &Exporter{
     }
     }
     ```

* (6)Describe function, transfer the indicator descriptor to the channel, this function does not need to be touched, you can use it directly to generate the description information of the collected indicators

     ```go
     func (e *Exporter) Describe(ch chan<- *prometheus.Desc) {
     metricCh := make(chan prometheus.Metric)
     doneCh := make(chan struct{})

     go func() {
     for m := range metricCh {
     ch <- m.Desc()
     }
     close(doneCh)
     }()

     e.Collect(metricCh)
     close(metricCh)
     <-doneCh

     }
     ```

* (7) The Collect function will execute the capture function and return data. The returned data will be passed to the channel, and the original indicator descriptor and indicator type (Guage) will be bound at the same time; all indicator acquisition functions need to be Write here.

    ```go
    //collect函数，采集数据的入口
    func (e *Exporter) Collect(ch chan<- prometheus.Metric) {
    	var err error
    	//每个指标值的采集逻辑，在对应的采集函数中
    	if err = ScrapeMem(ch); err != nil {
    		e.scrapeErrors.WithLabelValues("Mssql_Connections per sec").Inc()
    	}
    	if err = ScrapeDisk(ch); err != nil {
    		e.scrapeErrors.WithLabelValues("localtime").Inc()
    	}
    }
    ```
* (8) The indicator only has a single piece of data, and the example without dimension information is as follows:

     ```go
     func ScrapeMem(ch chan<- prometheus.Metric) error {
     //Indicator acquisition logic, no specific operations will be performed here, only value assignment for example
     mem_usage := float64(60)
     //Generate the collected indicator name
     metric_name := prometheus.BuildFQName("sys", "", "mem_usage")
     //Generate NewDesc type data format. This indicator has no dimensions and []string{} is empty.
     new_desc := prometheus.NewDesc(metric_name, "Gauge metric with mem_usage", []string{}, nil)
     //Generate specific collection information and write it into the ch channel
     metric_mes := prometheus.MustNewConstMetric(new_desc, prometheus.GaugeValue, mem_usage)
     ch <- metric_mes
     return nil
     }
     ```

* (9) The indicator has multiple pieces of data. Examples of dimension information are as follows:

     ```go
     func ScrapeDisk(ch chan<- prometheus.Metric) error {
     disks_mes := []interface{}{
     map[string]interface{}{
     "name": "C:/",
     "disk_size": float64(100),
     },
     map[string]interface{}{
     "name": "D:/",
     "disk_size": float64(200),
     },
     }
     for _, disk_mes := range disks_mes {
     disk_name := disk_mes.(map[string]interface{})["name"].(string)
     disk_size := disk_mes.(map[string]interface{})["disk_size"].(float64)
     metric_name := prometheus.BuildFQName("sys", "", "disk_size")
     //This example has the dimension of disk_name, which must be in []string{"disk_name"}
     new_desc := prometheus.NewDesc(metric_name, "Gauge metric with disk_size", []string{"disk_name"}, nil)
     metric_mes := prometheus.MustNewConstMetric(new_desc, prometheus.GaugeValue, disk_size, disk_name)
     ch <- metric_mes
     }
     return nil
     }

     ```


* (10) Main function

     ```go
     func main() {
     //Parse the defined listening port and other information
     flag.Parse()
     //Generate an object of type Exporter. The Exporter must have collect and Describe methods.
     Exporter := NewExporter()
     //Register Exporter to prometheus, prometheus will regularly pull data from Exporter
     prometheus.MustRegister(Exporter)
     //When receiving an http request, trigger the collect function to collect data
     http.Handle(*metricPath, promhttp.Handler())
     http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
     w.Write(landingPage)
     })
     log.Fatal(http.ListenAndServe(*listenAddress, nil))
     }
     ```

* (11)Compile Exporter

     ```go
     go build test_Exporter.go
     ```

* (12) Just run it in cmd/shell, visit `http://10.0.0.1:9601/metrics` to verify

     ![e2](../Other/media/e2-1.png)

At this point, the Exporter has been developed. The functions in steps 8 and 9 are the focus. At present, only some data have been written for examples. Obtaining data for monitoring indicators is the main function of this part. Corresponding logic needs to be written to obtain the value of the indicator.

### Exporter Compilation

**Monitoring platform Exporter only supports 64-bit machines running Exporter by default. **

- Windows

  `env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o ./Exporter-windows.exe test_Exporter.go`

- Linux

  `env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./Exporter-linux test_Exporter.go`

### Package monitoring platform plug-in

- Define Exporter plugin

    (1) Fill in the basic information and upload the Exporter file

    (2) Set parameters

    (3) Define indicators and dimensions

    (4) Supplement logo.png and description files

- Debugging, verifying the correctness of the plug-in

For details, please refer to [How to make an Exporter plug-in online](../ProductFeatures/integrations-metric-plugins/import_exporter.md).

You can also create the Exporter plug-in package offline, please see [Plug-in Configuration File Description](./plugins_explain.md) for details.

