# celery worker OOM 修复方法

一般来说，导致 Celery OOM 的情况有两种，此文将引导用户进行合适的参数调优。


## 进程过多

Celery 默认是进程池模型，同时进程数量与机器核数相同，但是在容器中，机器核数是母机的核数，如果不加限制会导致容器整体的内存超限而导致 OOM。因此需要在对应的 worker 启动命令指定进程数：

```bash
celery worker -c 2 ...
```

[详细描述](https://docs.celeryproject.org/en/v4.1.0/reference/celery.bin.worker.html#cmdoption-celery-worker-c) 

在 PaaS  上可以自由设置容器实例数，因此不建议使用进程模型，可以选择 gevent 或 eventlet 的模型（需要在 requirements.txt 中指定对应依赖）：

```bash
celery worker -P gevent ...
```
[详细描述](https://docs.celeryproject.org/en/v4.1.0/reference/celery.bin.worker.html#cmdoption-celery-worker-p)

使用了蓝鲸开发框架的应用，可以通过设置环境变量 `CELERYD_CONCURRENCY` 来指定。



## 内存泄露

在一些情况下，程序逻辑有问题，导致单个进程的内存不断增加，最后导致 OOM。除了修复程序逻辑外，可以预先设置一些防御性的配置，通过重启 worker 来释放内存，以下配置与 Celery 版本有关，选择合适版本的配置。

- 设置单个 worker 可以执行的最大任务数：
  - 3.1版本：[CELERYD_MAX_TASKS_PER_CHILD](https://docs.celeryproject.org/en/3.1/configuration.html#celeryd-max-tasks-per-child)
  - 4.0+ 版本：[worker_max_tasks_per_child](https://docs.celeryproject.org/en/v4.1.0/userguide/configuration.html#worker-max-tasks-per-child)
- 设置单个 worker 最大内存:
  - 3.1版本不支持;
  - 4.0+ 版本：[worker_max_memory_per_child](http://docs.celeryproject.org/en/latest/userguide/configuration.html#worker-max-memory-per-child)