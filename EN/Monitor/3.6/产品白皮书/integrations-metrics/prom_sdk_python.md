# Prometheus SDK （Python）使用说明

## 写在前面

Prometheus官方提供了上报 metric 的[Python SDK](https://github.com/prometheus/client_python), 用户可以自定义 metric，然后采用 push 或 pull 的方式上报 metric 数据。

下面介绍下这两个方式的使用说明。


## 使用示例

#### 数据埋点示例

##### Counter类型
```
Registry = CollectorRegistry()

# counter 类型对象, 可以添加 label
counter = Counter("api_called_total", "How many is the api called", ["inner_ip"], registry=Registry)

# 计算 counter
counter.inc(1)
```

##### Gauge 类型
```
Registry = CollectorRegistry()

# gauge 类型对象
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", ["inner_ip"], registry=Registry)

# 设置 gauge
gauge.set(random.random())
```

##### Histogram 类型
```
Registry = CollectorRegistry()

# histogram 类型对象
histogram = Histogram(
    "task_time_histogram",
    "analyze the time of task with histogram",
    registry=Registry,
    buckets=(1, 2, 3, 4, 5, float("inf")),
)

// 观测 histogram
histogram.observe(3)
```

##### Summary 类型
```
Registry = CollectorRegistry()

# summary 类型对象
summary = Summary(
    "task_time_summary", "analyze the time of task with summary", registry=Registry
)

// 观测 summary
summary.Observe(random.randint(1, 100))
```

#### PUSH 上报方式
metric 服务主动上报到端点。

##### 注意事项
- 补充 headers，用于携带 token 信息。实现一个自定义的 handler。
- 填写上报端点，在 push_to_gateway("$endpoint", ...) 里指定。然后将自定义的 handler 传入到函数里。
- 建议上报时 Grouping 指定 instance labels，这样页面上能够以 target 维度归组。

##### 示例代码
```
# -*- coding: utf-8 -*-
import time
import random

from prometheus_client.exposition import default_handler
from prometheus_client import CollectorRegistry, Counter, Gauge, Summary, Histogram, push_to_gateway

# 需要变动的内容
JOBNAME = ""
TOKEN = ""
ADDR = ""  # host:port

Registry = CollectorRegistry()

# metric 定义
# counter 类型
counter = Counter("api_called_total", "How many is the api called", registry=Registry)

# gauge 类型
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", registry=Registry)

# histogram 类型
histogram = Histogram(
    "task_time_histogram",
    "analyze the time of task with histogram",
    registry=Registry,
    buckets=(1, 2, 3, 4, 5, float("inf")),
)

# summary 类型
summary = Summary(
    "task_time_summary", "analyze the time of task with summary", registry=Registry
)

# 定义基于监控 token 的上报 handler 方法
def bk_handler(url, method, timeout, headers, data):
    def handle():
        headers.append(("X-BK-TOKEN", TOKEN))
        print(headers)
        default_handler(url, method, timeout, headers, data)()

    return handle


# 推送到端点
def push_demo():
    while True:
        # 根据实际需求，设置不同类型 metric 的值
        counter.inc(1)
        gauge.set(random.random())
        histogram.observe(3)
        summary.observe(random.randint(1, 100))

        push_to_gateway(
            ADDR,
            job=JOBNAME,
            registry=Registry,
            grouping_key={"instance": "my.host.ip"},
            handler=bk_handler,
        )
        time.sleep(10)
```


#### PULL 上报方式
通过接口获取自定义的 metric 信息。

##### 示例代码
```
# -*- coding: utf-8 -*-
import random
import time

from prometheus_client import start_http_server, CollectorRegistry, counter, gauge, histogram, summary

PORT = 8080
HOST = "127.0.0.1"

Registry = CollectorRegistry()

# metric 定义
# counter 类型
counter = Counter("api_called_total", "How many is the api called", registry=Registry)

# gauge 类型
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", registry=Registry)

# histogram 类型
histogram = Histogram(
    "task_time_histogram",
    "analyze the time of task with histogram",
    registry=Registry,
    buckets=(1, 2, 3, 4, 5, float("inf")),
)

# summary 类型
summary = Summary(
    "task_time_summary", "analyze the time of task with summary", registry=Registry
)

def pull_demo():
    # 如果使用 web 框架，可以根据实际使用进行调整
    # 比如使用 django，可以参考[2]
    start_http_server(PORT, HOST, Registry)

    while True:
        # 根据实际需求，设置不同类型 metric 的值
        counter.inc(1)
        gauge.set(random.random())
        histogram.observe(3)
        summary.observe(random.randint(1, 100))
        time.sleep(10)
```

## 参考
1. [prometheus python sdk](https://github.com/prometheus/client_python)
2. [django prometheus](https://github.com/korfuri/django-prometheus)

