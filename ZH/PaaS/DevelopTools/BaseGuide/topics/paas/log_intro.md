# 日志服务概览

## 简介

日志是应用开发中非常核心的功能之一，蓝鲸 PaaS3.0 开发者中心为应用开发者提供了非常强大的日志查询服务。

开发者在应用中上报日志后，可以在『日志查询』页面通过各种条件对日志进行检索。

应用使用开发框架开发，开发框架会预设日志配置，只要按照开发框架开发文档指引，正确使用日志输出语句，当应用上线到`PaaS`平台，就能在开发者中心查看到日志。

## 如何上报应用日志

### Python 开发框架

蓝鲸开发框架中给定了默认日志配置，已开启的应用可以直接使用。

日志格式:

- 本地开发，默认使用纯文本格式输出日志内容
- 部署到预发布环境/正式环境，会自动输出为`JSON` 格式，每行一条日志，且不同`logger`对应不同的日志文件

日志级别:

- 本地开发，日志级别默认`DEBUG`
- 部署到预发布环境/正式环境，日志级别默认`ERROR`

当日志写入文件后，采集进程会实时将日志采集，解析，并录入引擎。之后，在前端就可以通过引擎查询到应用日志。

#### 示例

以应用`blueapps`的预发布环境为例，开发框架中预定义了四个`logger`

|  logger | 备注 |
| --- | --- |
|  root | 应用日志 |
|  celery | celery 日志 |
|  gunicorn | gunicorn 访问日志 |
|  component | 组件日志 |
|  mysql | mysql 日志 |

其中，开发者只需要关注`root`/`celery`


- 应用日志

```python
from django.http import HttpResponse
import logging

logger = logging.getLogger('root')

def hello(request):
    logger.info("hello world")

    try:
        1 / 0
    except:
        logger.exception("an exception, the error trace stack will be sended too")

    logger.error("an error, no trace stack")
    return HttpResponse("hello world")

```

- `celery` 日志

在通过`celery`实现 异步任务及定时任务 代码打印日志时，需要选用`celery`

> 提示：这里的`logger`是`celery`，如果选错，日志将被输出到错误的文件，有可能导致查询不到。

```python
import logging
from celery import shared_task

logger = logging.getLogger('celery')

@shared_task
def async_hello():
    logger.info("hello world")
```

## 如何查询应用日志

### 结构化日志

入口: 『应用引擎』-『日志查询』-『结构化日志』

应用在本地开发时，输出到文件中的日志，部署到预发布环境/正式环境，采集进程会将日志采集、解析为 Json 格式后录入引擎，这部分日志我们称为结构化日志。


![-w2021](../../images/docs/paas/log_search_intro.png)

日志查询需要遵循两个步骤：
1. 确定查询的时间范围
2. 通过查询条件（或者关键字）筛选

其中需要特别注意的是，**时间范围会决定查询条件的具体选项**。

例如，在 X 时间段里，所有日志都来自 prod 环境，那么在 “部署环境” 这个条件下，就只能选择 prod。

目前有 “部署环境” “日志输出流” “应用进程” “三个固定的条件可供选择，其他条件可以参考 [日志查询语法](./log_query_syntax.md) 自定义查询条件。

### 标准输出日志

入口: 『应用引擎』-『日志查询』-『标准输出日志』

应用直接输出到标准输出（stdout 或者 stderr）的日志，同样也会被采集，但是不会对字段做解析。

> 提示：目前 Elasticsearch 集群扩容中导致集群不稳定，为了不给后端太多的查询压力，暂时限制了只能查询最近一小时的标准输出日志，后续会放开这个限制。

