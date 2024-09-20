# How to Customize Log Types

## Introduction

BlueKing Developer Center provides a flexible logging solution. As long as it conforms to the log collection specifications, it can be queried through the "Log Query" page.

By default, the `logging` defined by the BlueKing development framework already meets the log specifications.

## Specifications

As long as it conforms to the path + file format, the collector can automatically collect and parse the corresponding log content.

### File Path

> Path rule: `/app/logs/{A}-{B}-{C}.log`

- A: `os.environ.get("BKPAAS_LOG_NAME_PREFIX")`, preset in the environment variable, containing information such as process_type
- B: `Four-digit random number, one for each log generated`, e.g., `s5i2`
- C: `process_name`, e.g., `django`

Example:

```python
log_dir = "/app/logs/"
if not os.path.exists(log_dir):
    os.makedirs(log_dir)

log_name_prefix = os.environ.get("BKPAAS_LOG_NAME_PREFIX")
rand_str = ''.join(random.sample(string.letters + string.digits, 4))
log_name_prefix = "%s-%s" % (log_name_prefix, rand_str)

os.path.join(log_dir, '%s-django.log' % log_name_prefix)
```

### File Format

> Format rule: json

Use the language's corresponding `json logger` to directly output the log as json.

Taking `django` as an example:

- Add `python-json-logger==0.1.7` to `requirements.txt`
- Set the logging format to `%(levelname)s %(asctime)s %(pathname)s %(lineno)d %(funcName)s %(process)d %(thread)d %(message)s`
- Logging configuration

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
        # the root logger, used for the entire project's logger
        'root': {
            'handlers': ['root'],
            'level': log_level,
            'propagate': True,
        },
    }
}
```

## Difference from Standard Output (stdout/stderr)

Different from the above log landing solution, the application directly outputs the log content to stdout or stderr, which will also be directly collected, but will not be parsed by fields.

If your certain logs do not have high requirements for search and query, you can directly output to stdout or stderr, and select the corresponding conditions when querying through the "Log Output Stream".

However, if you have the need for classified indexing of log levels, response times, etc., it is recommended to follow the above guidelines and land the logs to a file.