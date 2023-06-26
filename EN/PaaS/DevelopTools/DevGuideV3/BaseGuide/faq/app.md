# 线上应用相关

### 为什么我的应用特别慢？

应用请求响应慢有很多原因，其中最常见的是应用的 web 进程资源不够用。如果你是 Python 应用，可以参考下面的资料：

[Python 应用如何改善 gunicorn 进程性能问题](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

同时建议开发者开启 APM 增强服务，可以比较清晰地观测到请求链路耗时，更精确地定位到问题

### Gunicorn worker 日志中出现了 WORKER TIMEOUT
这个问题主要原因是 Gunicorn worker 是以同步的方式处理 类似 DB 连接或者访问第三方 API 等 IO 操作，如果出现了 IO 阻塞未响应，worker 也会被阻塞。需要依照以下几个步骤解决该问题：

排查请求中可能存在的阻塞逻辑，去除阻塞逻辑，或者尽量将阻塞逻辑放到 Celery 后台完成
如果阻塞逻辑短时间无法优化，可以考虑使用 gevent 模块，让 Gunicorn 能够异步处理请求，具体请阅读

[Python 应用如何改善 gunicorn 进程性能问题](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

### HTTPS 网页中引入HTTP资源，提示报错： Mixed Content？

HTTPS页面里动态的引入HTTP资源，比如引入一个js文件，会被直接block掉。在HTTPS页面里通过AJAX的方式请求HTTP资源，也会被直接block掉。

页面中加入`<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">`，会自动将http的不安全请求升级为https。

### Celery Worker 进程被不断 kill -9 信号杀死，后台任务不执行怎么办？

[celery worker OOM 修复方法](../topics/tricks/fix_celery_worker_oom.md)

### 应用请求超时报错，状态码为 502 怎么办？

蓝鲸应用的访问链路可以用如下的线路图简述: 浏览器 -> 应用路由层（nginx） -> app web server（gunicorn 等）。 请求响应为 502 状态码通常代表 应用路由层 无法从后端 web server 正常拿到响应。

造成这种现象的原因有很多, 最常见的就是 **由于请求处理时间过长, 超过了 web server 自身设定的阈值后被强制中断, 最终导致 nginx 无法获得正常响应**。

因此, 解决该问题的推荐做法是优化应用性能, 从根源上提高处理效率, 避免单次请求处理时间过长。

除此之外, 还可以通过增大 web server 自身设置的超时时间, 让请求不至于被主动断开。但需要了解的是, 慢请求过多也有可能会引发过多的资源消耗，导致服务最终同样不可用。

参考：[如何调整 gunicorn 请求超时时间](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

如果增大超时时间还是不能解决问题, 则需要考虑是否是其他原因。比如该请求是否占用了过多内存, 引发 OOM 导致请求被强制结束等。

