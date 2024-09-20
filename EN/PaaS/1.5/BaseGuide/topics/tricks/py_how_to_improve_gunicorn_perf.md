# Gunicorn Configuration and Best Practices

## Introduction

[Gunicorn](https://github.com/benoitc/gunicorn) is the default HTTP server for Python applications on the BlueKing Developer Center. It boasts many advantages such as stability and efficiency.
This document collects some common usage experiences with it.

## Common Configuration Optimization

Gunicorn provides many configurable options for users. Open your application's `Procfile` or `app_desc.yaml` file, and you will see commands like `web: gunicorn {ARGS}`; those `{ARGS}` are the Gunicorn configuration options used by your application.

A default configuration is shown below:

```raw
gunicorn wsgi \
    -w 4 \
    -b :$PORT \
    --access-logfile - --error-logfile - \
    --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"'
```

The meanings of the configuration items are as follows:

- `-w 4`: Start 4 worker processes
- `-b :$PORT`: Listen to the port assigned by the platform (obtained through the environment variable PORT)
- `--access-logfile - --error-logfile -`: Output access logs and error logs to the console
- `--access-logformat '...'`: Set the log format

Generally, the above configuration can meet the needs of most applications. However, sometimes you may need to make some adjustments, and the following are some common situations.

### Adjusting Worker Configuration to Improve Performance

Gunicorn uses a multi-process model by default to handle requests. In this model, each request is handled by an exclusive process. If all requests can be processed and returned quickly, then this model works well.

However, if your application has too many slow requests, using this model may lead to performance issues.

Specific symptoms include:

- Some API responses are particularly slow
- Static files load slowly from time to time
- In the browser developer tools, it can be seen that the loading of various files is serial rather than parallel

#### How to Adjust

First, you need to increase the number of Gunicorn processes, which is recommended to be changed to **4** (the default value for BlueKing Python applications). The specific operations are as follows:

- Modify the web section of the Procfile, appending `-w 4` after the gunicorn command
- Redeploy the application

If increasing the number of processes does not improve the request blocking problem, you can try switching the worker model from prefork to gevent, which uses a coroutine model and performs better under high concurrency.

The specific operations are as follows:

- Add the gevent module to requirements.txt (for Python2, specify version 1.2 or lower)
- Modify the web section of the Procfile, appending `-k gevent` after the gunicorn command
- Redeploy the application

A Gunicorn configuration that has been adjusted for worker configuration is shown below:

```raw
gunicorn wsgi \
    -w 4 \
    -k gevent \
    -b :$PORT \
    --access-logfile - --error-logfile - \
    --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"'
```

Official documentation: [workers option description]([Settings — Gunicorn 20.0.4 documentation](https://docs.gunicorn.org/en/stable/settings.html#workers))

### Adjusting Request Timeout

To prevent slow requests from occupying Worker resources for a long time, Gunicorn sets a maximum processing time limit of **30 seconds** for each request. When a request exceeds 30 seconds, it will be forcibly interrupted.

When this happens, users can see the request return a _502_ status code in the browser, and error logs containing the keyword *"Worker Timeout"* can be found in the application logs.

The most recommended way to solve this problem is to optimize application performance to reduce the request response time to within 30 seconds. If it cannot be optimized for various reasons, you can also set the timeout to 1 minute or a larger value.

The default request timeout can be modified by adding the `--timeout {SECONDS}` option. For example, `--timeout 120` sets the request timeout to two minutes.

Official documentation: [--timeout option description](https://docs.gunicorn.org/en/stable/settings.html#timeout)