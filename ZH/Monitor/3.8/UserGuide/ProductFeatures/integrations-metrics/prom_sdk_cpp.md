# Prometheus SDK ( C++ ) 使用说明

### 简介

prometheus-cpp库主要为c/c++服务提供Metrics-Driven Development。它实现了Prometheus数据模型，这是一种用于收集和公开指标的强大抽象。通过pull或push两个方式，为服务的Prometheus指标收集提供了可能性。

### 编译

#### 下载包

下载prometheus-cpp版本的release包。文档以v1.0.0版本演示，如要其他版本，将命令行中的v1.0.0替换即可。命令如下:

```
wget https://github.com/jupp0r/prometheus-cpp/releases/download/v1.0.0/prometheus-cpp-with-submodules.tar.gz 
tar -xvf prometheus-cpp-with-submodules.tar.gz
```

`注：`prometheus-cpp-with-submodules.tar.gz发行包中包含了prometheus-cpp编译时依赖的third-party

#### cmake编译


`依赖:` 

```
- camke版本要求：3.14及以上
- gcc支持c++11，版本要求4.8.5及以上
```
 `编译:` 

```
cd prometheus-cpp-with-submodules
​
mkdir _build && cd _build
cmake .. -DBUILD_SHARED_LIBS=OFF -DENABLE_COMPRESSION=OFF -DENABLE_TESTING=OFF
cmake --build . --parallel 4
make install
```

### 使用案例

#### prometheus数据埋点案例
- `counter`

``` c++
// 构建一个couter对象
auto& counter_family = BuildCounter()
                             .Name("api_called_total")
                             .Help("How many is the api called")
                             .Labels({{"prometheus_test", "sdk_test"}})
                             .Register(*registry);

// 在构建的counter_family新增一个counter(e,g: api_counter)
auto& api_counter = counter_family.Add(
      {{"prometheus_test_counter", "test_counter"}, {"yet_another_label", "value"}});


// 计算counter
api_counter.Increment();
```
- `gauge`
``` c++
// 构建一个gauge对象
auto& gauge_family = BuildGauge()
                          .Name("cpu_usage")
                          .Help("simulate the cpu usage metric")
                          .Labels({{"prometheus_test", "sdk_test"}})
                          .Register(*registry);
						  
// 在构建的gauge_family新增一个gauge(e.g: cpu_gauge)
auto& cpu_gauge = gauge_family.Add({{"prometheus_test_gauge", "test_gauge"}, {"yet_another_lable", "value"}});

// 设置gauge
cpu_gauge.Set(GetRand(100)/100.0);
```

- `histogram`

``` c++
// 构建一个histogram对象
auto& histogram_family = BuildHistogram()
                              .Name("task_time_histogram")
                              .Help("analyze the time of task with histogram")
                              .Labels({{"prometheus_test", "sdk_test"}})
                              .Register(*registry);

// 在构建的histogram_family新增一个histogram
auto& task_histogram = histogram_family.Add({{"prometheus_test_histogram", "test_histogram"}, {"yet_another_lable", "value"}}, Histogram::BucketBoundaries{1, 2, 3, 4, 5});

// 观测histogram
task_histogram.Observe(GetRand(5));
```

- `summary`

``` c++
// 构建一个Summary对象
auto& summary_family = BuildSummary()
                            .Name("task_time_summary")
                            .Help("analyze the time of task with summary")
                            .Labels({{"prometheus_test", "sdk_test"}})
                            .Register(*registry);

// 在构建的summary_family新增一个summary
auto& task_summary = summary_family.Add({{"prometheus_test_summary", "test_summary"}, {"yet_another_lable", "value"}}, Summary::Quantiles{{0.5, 0.05}, {0.90, 0.01}, {0.99, 0.001}});

// 观测summary
task_summary.Observe(GetRand(100));
```

#### prometheus数据采集上报

Prometheus-cpp支持两种数据采集上报方式，分别是push和pull

##### push模式

push模式，使用方主动上报prometheus数据。

通过以下2个步骤，业务可以将prometheus数据主动上报的蓝鲸监控平台。

- 1、申请接入
	具体详见文档[自定义上报](./custom_sdk_push.md)
	在申请通过后，将获取两个重要参数：
	`BK-TOKEN`: 数据接入的token
	`GATEWAY`: prometheus数据push的接收端
- 2、关键代码实现

``` c++
// 配置BK-TOKEN参数，因prometheus-cpp的push暂不支持自定义header(支持自定义header的二次开发的PR已提交，暂未合入社区版本),BK-TOKEN通过url参数传入到接收端
std::string jobname = "prometheus_test";
std::string token = "X-BK-TOKEN=" + UrlEncode("Ymtia2JrYmtia2JrYmtia67yHRya4365kYNwiveFNNw9tUA1QrP6YRZ4fgRKHVLJ");

// 创建push的gateway对象，其中remote_ip，remote_port为步骤1中GATEWAY, push接收端的地址和端口
Gateway gateway{remote_ip, remote_port, jobname+"?"+token, labels};

// 将创建的metrics registry注入到gateway
gateway.RegisterCollectable(registry);

// 上报metrics
gateway.Push();
```

`代码样例`：

``` c++
#include <chrono>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <stdlib.h>
#include <time.h>

#include "prometheus/client_metric.h"
#include "prometheus/counter.h"
#include "prometheus/gauge.h"
#include "prometheus/histogram.h"
#include "prometheus/summary.h"
#include "prometheus/family.h"
#include "prometheus/gateway.h"
#include "prometheus/registry.h"

#ifdef _WIN32
#include <Winsock2.h>
#else
#include <unistd.h>
#endif

// UrlEncode

unsigned char ToHex(unsigned char x)
{
  return x > 9 ? x + 55 : x + 48;
}

std::string UrlEncode(const std::string&amp; str)
{
  std::string strTmp = "";
  size_t length = str.length();
  char ch = '0';
  for (size_t i = 0; i < length; i++)
  {
    ch = str[i];
    if(isalnum((unsigned char)ch) || (ch == '-') || (ch == '_') || (ch == '.') || (ch == '~'))
    {
      strTmp += ch;
    }
    else if (ch == ' ')
    {
      strTmp += "+";
    }
    else
    {
      strTmp += '%';
      strTmp += ToHex((unsigned char)ch >> 4);
      strTmp += ToHex((unsigned char)ch % 16);
    }
  }

  return strTmp;
}

// End UrlEncode

static std::string GetHostName() {
  char hostname[1024];

  if (::gethostname(hostname, sizeof(hostname))) {
    return {};
  }
  return hostname;
}

int GetRand(int max)
{
  srand((unsigned)time(NULL));
  return rand() % max;
}

int main(int argc, char *argv[]) {
  if (argc < 3)
  {
    std::cout << "parameter error" << std::endl;
    std::cout << "example: ./push_client <remote_ip> <remote_port>" << std::endl;
    return -1;
  }

  std::string remote_ip(argv[1]);
  std::string remote_port(argv[2]);
  std::cout << "parameter of remote_ip[" << remote_ip.c_str() << "], remote_port[" << remote_port.c_str() << "]" << std::endl;

  using namespace prometheus;

  // create a push gateway
  const auto labels = Gateway::GetInstanceLabel("");

  // carry tokon parameter in url
  std::string jobname = "prometheus_test";
  std::string token = "X-BK-TOKEN=" + UrlEncode("Ymtia2JrYmtia2JrYmtia67yHRya4365kYNwiveFNNw9tUA1QrP6YRZ4fgRKHVLJ");
  Gateway gateway{remote_ip, remote_port, jobname+"?"+token, labels};

  // create a metrics registry with component=main labels applied to all its
  // metrics
  auto registry = std::make_shared<Registry>();

  // Couter
  // add a new counter family to the registry 
  auto& counter_family = BuildCounter()
                             .Name("api_called_total")
                             .Help("How many is the api called")
                             .Labels({{"prometheus_test", "sdk_test"}})
                             .Register(*registry);

  // add a counter to the metric family
  auto& api_counter = counter_family.Add(
      {{"prometheus_test_counter", "test_counter"}, {"yet_another_label", "value"}});

  // Gauge
  // add a new gauge family to the registry
  auto& gauge_family = BuildGauge()
                          .Name("cpu_usage")
                          .Help("simulate the cpu usage metric")`
                          .Labels({{"prometheus_test", "sdk_test"}})
                          .Register(*registry);
  
  // add a gauge to the metric family
  auto& cpu_gauge = gauge_family.Add({{"prometheus_test_gauge", "test_gauge"}, {"yet_another_lable", "value"}});

  // Histogram
  // add a new histogram family to the registry
  auto& histogram_family = BuildHistogram()
                              .Name("task_time_histogram")
                              .Help("analyze the time of task with histogram")
                              .Labels({{"prometheus_test", "sdk_test"}})
                              .Register(*registry);

  // add a histogram to the metric family
  auto& task_histogram = histogram_family.Add({{"prometheus_test_histogram", "test_histogram"}, {"yet_another_lable", "value"}}, Histogram::BucketBoundaries{1, 2, 3, 4, 5});

  // Summary
  // add a new summary family to the registry
  auto& summary_family = BuildSummary()
                            .Name("task_time_summary")
                            .Help("analyze the time of task with summary")
                            .Labels({{"prometheus_test", "sdk_test"}})
                            .Register(*registry);
  
  // add a summary to the metric family
  auto& task_summary = summary_family.Add({{"prometheus_test_summary", "test_summary"}, {"yet_another_lable", "value"}}, Summary::Quantiles{{0.5, 0.05}, {0.90, 0.01}, {0.99, 0.001}});

  // ask the pusher to push the metrics to the pushgateway
  gateway.RegisterCollectable(registry);

  unsigned int totalTestCount = 0;
  unsigned int failTestCount = 0;

  for (;;) {
    std::this_thread::sleep_for(std::chrono::seconds(10));
    // increment the counter by one (api)
    api_counter.Increment();

    // set the gauge (cpu)
    cpu_gauge.Set(GetRand(100)/100.0);

    // observe the histogram
    task_histogram.Observe(GetRand(5));

    // observe the summary
    task_summary.Observe(GetRand(100));

    // push metrics
    auto returnCode = gateway.Push();
    std::cout << "returnCode is " << returnCode << std::endl;

    // statics
    if (returnCode < 0)
    {
      failTestCount++;
    }
    totalTestCount++;
    std::cout << "total count=" << totalTestCount << ", fail count=" << failTestCount << ", succ_rate=" << (totalTestCount-failTestCount) * 100.f / totalTestCount << "%" << std::endl;
  }
  return 0;
}
```

  编译:
  
 `g++ -o push_client push_client.cc -std=c++11 -lprometheus-cpp-push -lprometheus-cpp-core -lcurl -lz` 

##### pull模式

pull模式，使用方通过开启prometheus metrics数据http服务端口，提供prometheus数据

通过以下2个步骤，蓝鲸监控可以将业务的prometheus数据采集到蓝鲸监控平台

- 1、关键代码实现

``` c++
// 创建exposer，bind_addr为开启的http服务监听地址和端口，格式为IP:Port
Exposer exposer{bind_addr};

// 注册http服务的metrics uri
exposer.RegisterCollectable(registry, "/metrics");
```

- 2、申请接入

   具体详见文档[指标采集](./../../Other/functions/conf/collect-tasks.md)
	
  `代码样例：`

``` c++
#include <chrono>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <stdlib.h>
#include <time.h>

#include "prometheus/client_metric.h"
#include "prometheus/counter.h"
#include "prometheus/exposer.h"
#include "prometheus/family.h"
#include "prometheus/registry.h"
#include "prometheus/gauge.h"
#include "prometheus/histogram.h"
#include "prometheus/summary.h"

using namespace prometheus;

int GetRand(int max)
{
  srand((unsigned)time(NULL));
  return rand() % max;
}

int main(int argc, char** argv)
{
    if (argc < 3)
    {
        std::cout << "parameter error" << std::endl;
        std::cout << "example: ./pull_server <bind_ip> <bind_port>" << std::endl;
        return -1;
    }

    std::string bind_ip(argv[1]);
    std::string bind_port(argv[2]);
    std::cout << "pull server is listen on " << bind_ip.c_str() << ":" << bind_port.c_str() << std::endl;

    std::string bind_addr = bind_ip + ":" + bind_port;
    // create an http server running on bind_addr
    Exposer exposer{bind_addr};

    auto registry = std::make_shared<Registry>();
    // ask the exposer to scrape registry on incoming scrapes for "/metrics"
    exposer.RegisterCollectable(registry, "/metrics");

    // Couter
    // add a new counter family to the registry 
    auto& counter_family = BuildCounter()
                             .Name("api_called_total")
                             .Help("How many is the api called")
                             .Labels({{"prometheus_test", "sdk_test"}})
                             .Register(*registry);

    // add a counter to the metric family
    auto& api_counter = counter_family.Add(
      {{"prometheus_test_counter", "test_counter"}, {"yet_another_label", "value"}});

    // Gauge
    // add a new gauge family to the registry
    auto& gauge_family = BuildGauge()
                          .Name("cpu_usage")
                          .Help("simulate the cpu usage metric")
                          .Labels({{"prometheus_test", "sdk_test"}})
                          .Register(*registry);
  
    // add a gauge to the metric family
    auto& cpu_gauge = gauge_family.Add({{"prometheus_test_gauge", "test_gauge"}, {"yet_another_lable", "value"}});

    // Histogram
    // add a new histogram family to the registry
    auto& histogram_family = BuildHistogram()
                              .Name("task_time_histogram")
                              .Help("analyze the time of task with histogram")
                              .Labels({{"prometheus_test", "sdk_test"}})
                              .Register(*registry);

    // add a histogram to the metric family
    auto& task_histogram = histogram_family.Add({{"prometheus_test_histogram", "test_histogram"}, {"yet_another_lable", "value"}}, Histogram::BucketBoundaries{1, 2, 3, 4, 5});

    // Summary
    // add a new summary family to the registry
    auto& summary_family = BuildSummary()
                            .Name("task_time_summary")
                            .Help("analyze the time of task with summary")
                            .Labels({{"prometheus_test", "sdk_test"}})
                            .Register(*registry);
  
    // add a summary to the metric family
    auto& task_summary = summary_family.Add({{"prometheus_test_summary", "test_summary"}, {"yet_another_lable", "value"}}, Summary::Quantiles{{0.5, 0.05}, {0.90, 0.01}, {0.99, 0.001}});


    for (;;) {
        std::this_thread::sleep_for(std::chrono::seconds(10));

        // increment the counter by one (api)
        api_counter.Increment();

        // set the gauge (cpu)
        cpu_gauge.Set(GetRand(100)/100.0);

        // observe the histogram
        task_histogram.Observe(GetRand(5));

        // observe the summary
        task_summary.Observe(GetRand(100));
    }

    return 0;
}
```

编译：

`g++ -o pull_server pull_server.cc -std=c++11 -lprometheus-cpp-pull -lprometheus-cpp-core -lpthread -lcurl -lz`

### 常见问题说明

