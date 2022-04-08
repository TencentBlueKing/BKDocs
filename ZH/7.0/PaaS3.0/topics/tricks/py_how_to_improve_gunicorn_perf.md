# Gunicorn 配置与最佳实践

## 简介

[Gunicorn](https://github.com/benoitc/gunicorn) 是蓝鲸 PaaS3.0 上 Python 应用的默认 HTTP 服务器。它拥有稳定、高效等诸多优点。
这篇文档收集了它的一些常见使用经验。

## 常见配置项优化

Gunicorn 为使用者提供了很多可配置的选项。打开应用的 `Procfile` 文件，你会看到类似 `web: gunicorn {ARGS}` 的命令，那些`{ARGS}`就是你的应用所使用的 Gunicorn 配置选项。

一份默认的配置项如下所示：

```raw
gunicorn wsgi \
    -w 4 \
    -b :$PORT \
    --access-logfile - --error-logfile - \
    --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"'
```

各配置项含义如下：

- `-w 4`：启动 4 个 worker 进程
- `-b :$PORT`：监听平台分配的端口 *（通过环境变量 PORT 获取）*
- `--access-logfile - --error-logfile -`：将访问日志与错误日志往控制台输出
- `--access-logformat '...'` 设置日志格式

一般来说，上面这份配置可以满足绝大多数应用。但有时，你也可能需要对其做一些调整，下面是一些常见情况。

### 调整 worker 配置来改善性能

Gunicorn 默认使用多进程模型来处理请求。在这个模型下，每个请求都是由一个独占的进程来处理的。如果所有请求都可以很快的处理并返回，那么这个模型可以工作的很好。

但如果应用的慢请求过多，使用该模型就可能会出现一些性能问题。

具体表现为：

- 部分 API 响应特别慢
- 静态文件不定期出现加载慢
- 在浏览器开发者工具能看到各文件加载是串行进行的，而非并行加载

#### 如何调整

首先，你需要将 Gunicorn 的进程数调大，建议修改为 **4**（蓝鲸 Python 应用默认值）。具体操作如下：

- 修改 Procfile 的 web 部分，在 gunicorn 命令后追加 `-w 4`
- 重新部署应用

如果加大进程数后，请求堵塞问题仍然没有改善，那么你可以尝试将工作模型从 prefork 切换为 gevent，后者使用协程模型，在高并发情况下性能表现更好。

具体操作如下: 

- 在 requirements.txt 里面加上 gevent 模块 *（Python2 需要指定 1.2 或更低版本）*
- 修改 Procfile 的 web 部分，在 gunicorn 命令后追加 `-k gevent`
- 重新部署应用

一个调整了 worker 配置的 Gunicorn 配置如下所示：

```raw
gunicorn wsgi \
    -w 4 \
    -k gevent \
    -b :$PORT \
    --access-logfile - --error-logfile - \
    --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"'
```

官方文档：[workers 选项说明]([Settings — Gunicorn 20.0.4 documentation](https://docs.gunicorn.org/en/stable/settings.html#workers))

### 调整请求超时时间

为了避免慢请求长时间占用 Worker 资源，Gunicorn 为每次请求设置了最多 **30 秒** 的处理时间限制。当某次请求处理时间超过 30 秒后，就会被强制中断。

出现这种情况时，用户可以从浏览器看到到该请求返回了 *502* 状态码，应用日志中也可以查询到包含关键字*"Worker Timeout"* 的错误日志。

要解决这类问题，最推荐的做法是优化应用性能，将请求响应时间降低到 30 秒以内。如果因为各种原因无法优化，你也可以把超时时间设置为 1 分钟或者更大的值。

通过增加 `--timeout {SECONDS}` 选项可以修改默认的请求超时时间。比如 `--timeout 120` 就是将请求设置为两分钟超时。

官方文档：[--timeout 选项说明](https://docs.gunicorn.org/en/stable/settings.html#timeout)