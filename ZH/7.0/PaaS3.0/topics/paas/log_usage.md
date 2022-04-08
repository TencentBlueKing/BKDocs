# 如何自定义日志类型

## 简介

蓝鲸 PaaS3.0 开发者中心提供了一种灵活的日志解决方案，只需要符合日志采集规范，即可通过 "日志查询" 页面查询。

默认地，蓝鲸开发框架定义的 `logging` 已经符合了日志规范。

## 规范

只要同时符合路径+文件格式，采集器就能自动采集并解析得到相应日志内容。

### 文件路径

> 路径规则: `/app/logs/{A}-{B}-{C}.log`

- A: `os.environ.get("BKPAAS_LOG_NAME_PREFIX")`，环境变量中预设，带有`process_type`等信息
- B: `四位随机数, 每个日志生成一个`， e.g. `s5i2`
- C: `process_name`，例如`django`

例子：

```python
log_dir = "/app/logs/"
if not os.path.exists(log_dir):
    os.makedirs(log_dir)

log_name_prefix = os.environ.get("BKPAAS_LOG_NAME_PREFIX")
rand_str = ''.join(random.sample(string.letters + string.digits, 4))
log_name_prefix = "%s-%s" % (log_name_prefix, rand_str)

os.path.join(log_dir, '%s-django.log' % log_name_prefix)
```

### 文件格式

> 格式规则: json

使用语言相应的 `json logger`, 直接将日志输出为 json。

以`django`为例：

- requirements.txt 中添加 `python-json-logger==0.1.7`
- logging format 设置为 `%(levelname)s %(asctime)s %(pathname)s %(lineno)d %(funcName)s %(process)d %(thread)d %(message)s`
- logging 配置

```python
log_class = 'logging.handlers.RotatingFileHandler'

logging_format = {
        '()': 'pythonjsonlogger.jsonlogger.JsonFormatter',
        'fmt': '%(levelname)s %(asctime)s %(pathname)s %(lineno)d %(funcName)s %(process)d %(thread)d %(message)s'
}


LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': logging_format,
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'handlers': {
        'root': {
            'class': log_class,
            'formatter': 'verbose',
            'filename': os.path.join(log_dir, '%s-django.log' % log_name_prefix),
            'maxBytes': 1024 * 1024 * 10,
            'backupCount': 5
        },
    },
    'loggers': {
        # the root logger ,用于整个project的logger
        'root': {
            'handlers': ['root'],
            'level': log_level,
            'propagate': True,
        },
    }
}
```

## 和标准输出(stdout\stderr)的区别

与上述的日志落地方案不同，应用直接将日志内容打到 stdout 或者 stderr 同样会被直接采集，但是不会被按字段解析。

如果你的某种日志对于检索查询没有太高的要求，可以直接输出到 stdout 或 stderr，查询时通过 ”日志输出流“ 选择相应的条件。

但如果对日志等级、响应时间等内容有分类索引的需求，建议依照上述指引，将日志落地到文件。
