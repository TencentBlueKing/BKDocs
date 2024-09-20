# Prometheus SDK (Python) usage instructions

## written in front

Prometheus officially provides [Python SDK](https://github.com/prometheus/client_python) for reporting metric. Users can customize the metric and then report the metric data by push or pull.

Instructions for using these two methods are introduced below.


## Usage example

#### Example of data burying point

##### Counter type
```
Registry = CollectorRegistry()

# counter type object, you can add label
counter = Counter("api_called_total", "How many is the api called", ["inner_ip"], registry=Registry)

# Calculate counter
counter.inc(1)
```

##### Gauge type
```
Registry = CollectorRegistry()

# gauge type object
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", ["inner_ip"], registry=Registry)

# Set gauge
gauge.set(random.random())
```

##### Histogram type
```
Registry = CollectorRegistry()

# Histogram type object
histogram = Histogram(
     "task_time_histogram",
     "analyze the time of task with histogram",
     registry=Registry,
     buckets=(1, 2, 3, 4, 5, float("inf")),
)

// Observe histogram
histogram.observe(3)
```

##### Summary type
```
Registry = CollectorRegistry()

# summary type object
summary = Summary(
     "task_time_summary", "analyze the time of task with summary", registry=Registry
)

// Observation summary
summary.Observe(random.randint(1, 100))
```

#### PUSH reporting method
The metric service actively reports to the endpoint.

##### Precautions
- Added headers to carry token information. Implement a custom handler.
- Fill in the reporting endpoint and specify it in push_to_gateway("$endpoint", ...). Then pass the custom handler into the function.
- It is recommended to specify instance labels for Grouping when reporting, so that the page can be grouped by the target dimension.

##### Sample code
```
# -*- coding: utf-8 -*-
import time
import random

from prometheus_client.exposition import default_handler
from prometheus_client import CollectorRegistry, Counter, Gauge, Summary, Histogram, push_to_gateway

# What needs to be changed
JOBNAME = ""
TOKEN = ""
ADDR = "" # host:port

Registry = CollectorRegistry()

# metric definition
# counter type
counter = Counter("api_called_total", "How many is the api called", registry=Registry)

# gauge type
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", registry=Registry)

# histogram type
histogram = Histogram(
     "task_time_histogram",
     "analyze the time of task with histogram",
     registry=Registry,
     buckets=(1, 2, 3, 4, 5, float("inf")),
)

# summary type
summary = Summary(
     "task_time_summary", "analyze the time of task with summary", registry=Registry
)

#Define the reporting handler method based on monitoring token
def bk_handler(url, method, timeout, headers, data):
     def handle():
         headers.append(("X-BK-TOKEN", TOKEN))
         print(headers)
         default_handler(url, method, timeout, headers, data)()

     return handle


# Push to endpoint
def push_demo():
     while True:
         # Set the values of different types of metric according to actual needs
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


#### PULL reporting method
Obtain customized metric information through the interface.

##### Sample code
```
# -*- coding: utf-8 -*-
import random
import time

from prometheus_client import start_http_server, CollectorRegistry, counter, gauge, histogram, summary

PORT=8080
HOST = "10.0.0.1"

Registry = CollectorRegistry()

# metric definition
# counter type
counter = Counter("api_called_total", "How many is the api called", registry=Registry)

# gauge type
gauge = Gauge("cpu_usage", "simulate the cpu usage metric", registry=Registry)

# histogram type
histogram = Histogram(
     "task_time_histogram",
     "analyze the time of task with histogram",
     registry=Registry,
     buckets=(1, 2, 3, 4, 5, float("inf")),
)

# summary type
summary = Summary(
     "task_time_summary", "analyze the time of task with summary", registry=Registry
)

def pull_demo():
     # If you use a web framework, you can adjust it according to actual use.
     # For example, if you use django, please refer to [2]
     start_http_server(PORT, HOST, Registry)

     while True:
         # Set the values of different types of metric according to actual needs
         counter.inc(1)
         gauge.set(random.random())
         histogram.observe(3)
         summary.observe(random.randint(1, 100))
         time.sleep(10)
```

## refer to
1. [prometheus python sdk](https://github.com/prometheus/client_python)
2. [django prometheus](https://github.com/korfuri/django-prometheus)