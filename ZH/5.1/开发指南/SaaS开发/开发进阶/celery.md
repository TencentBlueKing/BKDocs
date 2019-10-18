# celery 使用

> celery安装详见 `开发基础` -> `开发框架 2.0` -> `2.0 框架使用说明`

## 介绍

celery 是一个简单、灵活且可靠的，处理大量消息的分布式系统，并且提供维护这样一个系统的必需工具。
它是一个专注于实时处理的任务队列，同时也支持任务调度。

## 使用帮助

### 1. 打开 celery 配置

在 config/default.py 中修改配置：

```python
IS_USE_CELERY = True
```

### 2. 添加 celery 任务

在 app 底下创建 task.py 文件， 添加 @task 任务：

```python
from celery import task

@task
def mul(x, y):
    return x * y
```

如果 @task 任务函数不在 app/tasks.py 文件中， 需要在 config/default.py 中添加配置：

```python
CELERY_IMPORTS = (
    'testapp.tasks2'  
)
```

### 3. 启动异步任务服务 celery worker

在根目录执行：

```bash
python manage.py celery woker -l info
```

### 4. 启动周期性任务服务 celery beat

在根目录执行：
```bash
python manage.py celery beat -l info
```

### 5. 添加周期任务

进入后台 admin，在 DJCELERY -> Periodic_tasks表中添加一条记录。

### 6. 如何在平台部署时，自动启动 celery 进程

确认 IS_USE_CELERY = True，并在提测发布 SaaS 的时候，勾选使用 celery 任务。

### 7. 调整 celery worker 并发数

- CELERYD_CONCURRENCY 参数官方说明：[celery 官方文档](http://docs.celeryproject.org/en/v2.2.4/configuration.html#celeryd-prefetch-multiplier)

- 目前开发框架设置的 celery 并发数是 2，如需调整，有 2 种方法：

  - 1.在蓝鲸平台的 APP 环境变量新增 KEY 为 CELERYD_CONCURRENCY 的变量，并设置对应的值（调大前建议咨询平台维护同事。

  - 2.直接修改 APP 中的配置，即修改 config/default.py 文件中如下配置的默认值 2 为你想要设置的值。 `CELERYD_CONCURRENCY = os.getenv('BK_CELERYD_CONCURRENCY', 2)`
