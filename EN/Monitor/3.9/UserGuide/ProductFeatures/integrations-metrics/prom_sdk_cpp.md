# Prometheus SDK (C++) usage instructions

### Introduction

The prometheus-cpp library mainly provides Metrics-Driven Development for c/c++ services. It implements the Prometheus data model, a powerful abstraction for collecting and exposing metrics. Through pull or push methods, it provides the possibility to collect Prometheus indicators of the service.

### Compile

#### Download package

Download the release package of prometheus-cpp version. The document is demonstrated in version v1.0.0. If you want other versions, just replace v1.0.0 in the command line. The command is as follows:

```
wget https://github.com/jupp0r/prometheus-cpp/releases/download/v1.0.0/prometheus-cpp-with-submodules.tar.gz
tar -xvf prometheus-cpp-with-submodules.tar.gz
```

`Note: `prometheus-cpp-with-submodules.tar.gz distribution package contains the third-party that prometheus-cpp depends on when compiling

#### cmake compilation


`Dependencies:`

```
- camke version requirements: 3.14 and above
- gcc supports c++11, version requirement is 4.8.5 and above
```
  `Compile:`

```
cd prometheus-cpp-with-submodules
​
mkdir _build && cd _build
cmake .. -DBUILD_SHARED_LIBS=OFF -DENABLE_COMPRESSION=OFF -DENABLE_TESTING=OFF
cmake --build . --parallel 4
make install
```

### Use Cases

#### prometheus data burying case
- `counter`

``` c++
//Construct a couter object
auto& counter_family = BuildCounter()
                              .Name("api_called_total")
                              .Help("How many is the api called")
                              .Labels({{"prometheus_test", "sdk_test"}})
                              .Register(*registry);

// Add a counter(e,g: api_counter) to the built counter_family
auto& api_counter = counter_family.Add(
       {{"prometheus_test_counter", "test_counter"}, {"yet_another_label", "value"}});


// Calculate counter
api_counter.Increment();
```
- `gauge`
``` c++
//Construct a gauge object
auto& gauge_family = BuildGauge()
                           .Name("cpu_usage")
                           .Help("simulate the cpu usage metric")
                           .Labels({{"prometheus_test", "sdk_test"}})
                           .Register(*registry);

// Add a gauge (e.g: cpu_gauge) to the built gauge_family
auto& cpu_gauge = gauge_family.Add({{"prometheus_test_gauge", "test_gauge"}, {"yet_another_lable", "value"}});

// Set gauge
cpu_gauge.Set(GetRand(100)/100.0);
```

- `histogram`

``` c++
//Construct a histogram object
auto& histogram_family = BuildHistogram()
                               .Name("task_time_histogram")
                               .Help("analyze the time of task with histogram")
                               .Labels({{"prometheus_test", "sdk_test"}})
                               .Register(*registry);

// Add a histogram to the built histogram_family
auto& task_histogram = histogram_family.Add({{"prometheus_test_histogram", "test_histogram"}, {"yet_another_lable", "value"}}, Histogram::BucketBoundaries{1, 2, 3, 4, 5});

// Observe histogram
task_histogram.Observe(GetRand(5));
```

- `summary`

``` c++
//Construct a Summary object
auto& summary_family = BuildSummary()
                             .Name("task_time_summary")
                             .Help("analyze the time of task with summary")
                             .Labels({{"prometheus_test", "sdk_test"}})
                             .Register(*registry);

// Add a summary to the built summary_family
auto& task_summary = summary_family.Add({{"prometheus_test_summary", "test_summary"}, {"yet_another_lable", "value"}}, Summary::Quantiles{{0.5, 0.05}, {0.90, 0.01}, {0.99, 0.001 }});

// Observation summary
task_summary.Observe(GetRand(100));
```

#### prometheus data collection and reporting

Prometheus-cpp supports two data collection and reporting methods, namely push and pull.

##### push mode

In push mode, the user actively reports prometheus data.

Through the following 2 steps, businesses can proactively report prometheus data to the BlueKing monitoring platform.

- 1. Apply for access
For details, please see the document [Customized reporting](./custom_sdk_push.md)
After the application is approved, two important parameters will be obtained:
`BK-TOKEN`: token for data access
`GATEWAY`: the receiving end of prometheus data push
- 2. Key code implementation

``` c++
// Configure the BK-TOKEN parameters. Since the push of prometheus-cpp does not currently support custom headers (the PR that supports the secondary development of custom headers has been submitted and has not yet been incorporated into the community version), BK-TOKEN is passed in through the url parameter. to the receiving end
std::string jobname = "prometheus_test";
std::string token = "X-BK-TOKEN=" + UrlEncode("Ymtia2JrYmtia2JrYmtia67yHRya4365kYNwiveFNNw9tUA1QrP6YRZ4fgRKHVLJ");

//Create a push gateway object, where remote_ip and remote_port are the address and port of the GATEWAY and push receiving end in step 1
Gateway gateway{remote_ip, remote_port, jobname+"?"+token, labels};

//Inject the created metrics registry into the gateway
gateway.RegisterCollectable(registry);

//Report metrics
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
```Compile:
  
  `g++ -o push_client push_client.cc -std=c++11 -lprometheus-cpp-push -lprometheus-cpp-core -lcurl -lz`

##### pull mode

In pull mode, the user provides prometheus data by opening the prometheus metrics data http service port.

Through the following 2 steps, BlueKing Monitoring can collect business prometheus data to the Blue King Monitoring Platform.

- 1. Key code implementation

``` c++
// Create exposer, bind_addr is the enabled http service listening address and port, the format is IP:Port
Exposer exposer{bind_addr};

// Register the metrics uri of the http service
exposer.RegisterCollectable(registry, "/metrics");
```

- 2. Apply for access

    For details, please refer to the document [Indicator Collection](./../../Other/functions/conf/collect-tasks.md)

   `Code sample:`

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

     //Couter
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
     auto& task_summary = summary_family.Add({{"prometheus_test_summary", "test_summary"}, {"yet_another_lable", "value"}}, Summary::Quantiles{{0.5, 0.05}, {0.90, 0.01}, {0.99, 0.001 }});


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

Compile:

`g++ -o pull_server pull_server.cc -std=c++11 -lprometheus-cpp-pull -lprometheus-cpp-core -lpthread -lcurl -lz`

### Frequently Asked Questions