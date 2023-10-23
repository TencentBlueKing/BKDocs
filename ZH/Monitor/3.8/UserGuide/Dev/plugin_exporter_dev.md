# 监控平台 Exporter 开发

当市面上没有找到相应的 Exporter 采集器，或者现有的 Exporter 不满足需求，可以自行修改或者重新开发一个 Exporter，也是相对比较简单的事情。

接下来简单介绍下如何开发一个 Exporter 插件。

## 基础

### Exporter 简介

**Exporter 本质上就是将收集的数据，转化为对应的文本格式，并提供 http 接口，供监控平台采集器定期采集数据**

### Exporter 基础

 **指标介绍**

Prometheus 中主要使用的四类指标类型，如下所示

- Counter (累加指标)
- Gauge (测量指标)
- Summary (概略图)
- Histogram (直方图)

最常使用的是 Gauge，Gauge 代表了采集的一个单一数据，这个数据可以增加也可以减少，比如 CPU 使用情况，内存使用量，硬盘当前的空间容量等。

Counter 一个累加指标数据，这个值随着时间只会逐渐的增加，比如程序完成的总任务数量，运行错误发生的总次数等，代表了持续增加的数据包或者传输字节累加值。

> 【**注**】：所有指标的值仅支持 float64 类型

**文本格式**

以下面得输出为例：

```bash
# metric:
sample_metric1 12.47
sample_metric2{partition="c:"} 0.44
```

**其中**：

- `#表示注释
- `sample_metric1`和`sample_metric2`表示指标名称
- `partition`表示指标得作用维度，例如磁盘分区使用率，维度就是磁盘分区，即每个磁盘分区都有一个磁盘分区使用率的值
- `xxx`表示维度的值，例如磁盘分区的 C 盘/D 盘等
- `12.47`和`0.44`表示对应指标的值


## 依赖

* Golang 语言环境

* 引入 Prometheus 的依赖库

    ```bash
    go get github.com/prometheus/client_golang/prometheus
    ```

### 开发实例

* (1)新建一个 Exporter 项目：

    一个 Exporter 只需要一个文件即可；新建一个 test_Exporter 目录和一个 test_Exporter.go 文件：

![e1](../Other/media/e1-1.png)

* (2)导入依赖模块

    ```go
    import (
    	"flag"
    	"log"
    	"net/http"
    	"github.com/prometheus/client_golang/prometheus"
    	"github.com/prometheus/client_golang/prometheus/promhttp"
    )
    ```

* (3)定义 Exporter 的版本(Version)、监听地址(listenAddress)、采集 url(metricPath)以及首页(landingPage)

    ```go
    var (
    	Version       = "1.0.0.dev"
    	listenAddress = flag.String("web.listen-address", ":9601", "Address to listen on for web interface and telemetry.")
    	metricPath    = flag.String("web.telemetry-path", "/metrics", "Path under which to expose metrics.")
    	landingPage   = []byte("<html><head><title>SYS Exporter " + Version +
    		"</title></head><body><h1>SYS Exporter " + Version + "</h1><p><a href='" + *metricPath + "'>Metrics</a></p></body></html>")
    )
    ```

* (4)定义 Exporter 结构体

    ```go
    type Exporter struct {
    	error        prometheus.Gauge
    	scrapeErrors *prometheus.CounterVec
    }
    ```

* (5)定义结构体实例化的函数 NewExporter

    ```go
    func NewExporter() *Exporter {
    	return &Exporter{
    	}
    }
    ```

* (6)Describe 函数，传递指标描述符到 channel，这个函数不用动，直接使用即可，用来生成采集指标的描述信息

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

* (7)Collect 函数将执行抓取函数并返回数据，返回的数据传递到 channel 中，并且传递的同时绑定原先的指标描述符，以及指标的类型(Guage)；需要将所有的指标获取函数在这里写入。

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

* (8)指标仅有单条数据，不带维度信息示例如下：

    ```go
    func ScrapeMem(ch chan<- prometheus.Metric) error {
    	//指标获取逻辑，此处不做具体操作，仅仅赋值进行示例
    	mem_usage := float64(60)
    	//生成采集的指标名
    	metric_name := prometheus.BuildFQName("sys", "", "mem_usage")
    	//生成NewDesc类型的数据格式，该指标无维度，[]string{}为空
    	new_desc := prometheus.NewDesc(metric_name, "Gauge metric with mem_usage", []string{}, nil)
    	//生成具体的采集信息并写入ch通道
    	metric_mes := prometheus.MustNewConstMetric(new_desc, prometheus.GaugeValue, mem_usage)
    	ch <- metric_mes
    	return nil
    }
    ```

* (9)指标有多条数据，带维度信息示例如下：

    ```go
    func ScrapeDisk(ch chan<- prometheus.Metric) error {
    	disks_mes := []interface{}{
    		map[string]interface{}{
    			"name":      "C:/",
    			"disk_size": float64(100),
    		},
    		map[string]interface{}{
    			"name":      "D:/",
    			"disk_size": float64(200),
    		},
    	}
    	for _, disk_mes := range disks_mes {
    		disk_name := disk_mes.(map[string]interface{})["name"].(string)
    		disk_size := disk_mes.(map[string]interface{})["disk_size"].(float64)
    		metric_name := prometheus.BuildFQName("sys", "", "disk_size")
    		//该例子具有disk_name的维度，须在[]string{"disk_name"}
    		new_desc := prometheus.NewDesc(metric_name, "Gauge metric with disk_size", []string{"disk_name"}, nil)
    		metric_mes := prometheus.MustNewConstMetric(new_desc, prometheus.GaugeValue, disk_size, disk_name)
    		ch <- metric_mes
    	}
    	return nil
    }

    ```


* (10)主函数

    ```go
    func main() {
    	//解析定义的监听端口等信息
    	flag.Parse()
    	//生成一个Exporter类型的对象，该Exporter需具有collect和Describe方法
    	Exporter := NewExporter()
    	//将Exporter注册入prometheus，prometheus将定期从Exporter拉取数据
    	prometheus.MustRegister(Exporter)
    	//接收http请求时，触发collect函数，采集数据
    	http.Handle(*metricPath, promhttp.Handler())
    	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    		w.Write(landingPage)
    	})
    	log.Fatal(http.ListenAndServe(*listenAddress, nil))
    }
    ```

* (11)编译 Exporter

    ```go
    go build test_Exporter.go
    ```

* (12)cmd/shell 中运行即可，访问 `http://127.0.0.1:9601/metrics` 即可验证

    ![e2](../Other/media/e2-1.png)

至此 Exporter 开发完成，其中 8，9 两步中的函数是重点，目前仅仅写了一些数据进行示例，其中的监控指标获取数据就是该部分的主要功能，需要编写对应逻辑获取指标的值。

### Exporter 编译

**监控平台 Exporter 默认只支持 64 位机器运行 Exporter。**

- Windows

 `env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o ./Exporter-windows.exe test_Exporter.go`

- Linux

 `env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./Exporter-linux test_Exporter.go`

###  封装监控平台插件

- 定义 Exporter 插件

   (1) 基本信息填写并上传 Exporter 文件

   (2) 设置参数

   (3) 定义指标和维度

   (4) 补充 logo.png 和描述文件

- 调试，验证插件的正确性

具体参考 [如何在线制作 Exporter 插件](../ProductFeatures/integrations-metric-plugins/import_exporter.md)。

还可以线下制作 Exporter 插件包，具体查看 [插件配置文件说明](./plugins_explain.md)。


