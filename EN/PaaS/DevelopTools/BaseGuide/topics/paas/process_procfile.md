# 应用进程与 Procfile

## 什么是应用进程

应用进程是一个计算单元合集，它可以由一个或多个**相同的**计算单元组合而成。

每一个计算单元相当于一个 Docker 容器，可以执行开发者指定的命令。

### 应用进程的特性

因为拥有多个计算单元，所以**应用进程**拥有很多很酷的特性：
- 可完全由开发者管理。在 『应用引擎-进程管理』 控制进程的启停 & 查看进程实时日志。
- 负载均衡。当计算单元的数量大于 1 时，进程的请求将会被均分到各个单元。
- 容灾和自拉起。多个计算单元相对地独立运行，某个单元崩溃不影响其他单元，并会被尝试重新拉起。
- 资源可伸缩。平台提供多种进程资源方案，可以轻松扩缩容。

### 使用应用进程的优势

你可以将较为复杂的系统，拆分成多个应用进程，就像是你在本地启动的多个进程，分别负责系统的不同部分。

比如，有一个叫做`blueapps`的蓝鲸应用，带有 Celery 后台周期任务，你可以将它拆分成 Web & Worker & Beat 三个应用进程。

相较于原来“大一统”的蓝鲸应用，这样的拆分具有明显的优势：
- **进程可以独立启停**。例如，当你不需要 Beat 或 Worker 进程的时候，可以直接在『应用引擎-进程管理』页面停止掉它，而完全不会影响 Web 进程。
- **开发者可以自由修改每个进程的启动方式**。例如，当你遇到了并发瓶颈时，你可以手动调整参数，使 Gunicorn 启动更多的进程，扩大服务承载能力。

总的来说，应用进程给予了应用一定的微服务能力，在满足应用多组件需求的同时，保持统一的管理入口。

说到这里，你一定充满了好奇，该怎样定义和创建这些应用进程呢？

目前可通过 **Procfile** 或者 **app_desc.yaml** 来定义


## 如何定义应用进程

目前蓝鲸平台支持以下 2 种方式定义进程：

### 1. Procfile

Procfile，即 Process File，顾名思义，是用来定义应用进程的文件入口，放在蓝鲸应用的根目录下。

让我们看看`blueapps`的 Procfile 的示例：

```yaml
web: gunicorn bluesapps.wsgi -b :$PORT --log-file -
```

它是一个 yaml 文件，其中 `web` 和为进程的标识，即 `process_type`。后面紧跟的都是具体的进程命令，即一行可执行的 bash 命令。

如果 `blueapps` 应用之前有过部署，可以跳转到‘应用引擎-进程管理’页面，查看和管理这两个进程的运行情况。

### 2. app_desc.yaml

app_desc.yaml 是一种用来描述蓝鲸应用的配置文件。目前最新版的 Python 开发框架已经采用 app_desc.yaml 来定义进程。

我看下如何在 app_desc.yaml 文件中定义进程：
```yaml
module:
  language: Python
  processes:
    web:
      command: gunicorn bluesapps.wsgi -b :$PORT --log-file -
```

app_desc.yaml 的更多配置信息可参考：[应用描述文件](./app_desc.md)。


## 创建新的应用进程

还是这个 `blueapps` 应用，倘若现在需求变得复杂，单纯的 Web 已经不能满足，你需要添加 Celery 来完成后台任务。

创建新的应用进程很简单，你可以在 Procfile 内容末尾添加上：

```yaml
worker: python manage.py celery worker -l info
beat: python manage.py celery beat -l info
```


或在 app_desc.yaml 中添加如下内容：
```yaml
module:
  language: Python
  processes:
    web:
      command: gunicorn bluesapps.wsgi -b :$PORT --log-file -
    worker:
      command: python manage.py celery worker -l info
    beat:
      command: python manage.py celery beat -l info
```

这里我们使用的是

非常重要地，对于同一个蓝鲸应用而言，`process_type` 是这个进程的唯一标识， 不能够存在 `process_type` 相同的进程。

> 注意：process_type 只能是字母、数字、连接符(-)，建议全部使用小写字母。

添加完成后，提交代码，跳到『应用引擎-部署管理』页面做一次部署操作，参看 [如何发布部署](./deploy_intro.md) 了解更多。

当部署成功之后，再回到『应用引擎-进程管理』，进程列表中应该就会出“崭新的” `celery` 和 `beat` 进程。

### 删除进程

删除进程非常容易，和上面添加的操作一样，只需要在 Procfile 或 app_desc.yaml 中删掉对应的那一行，然后 重新提交 & 部署 即可。

## 扩容进程

随着应用访问量或者任务量逐渐增大，你会发现原来的进程无法负载更多了，这时你就会想到扩容进程。

在蓝鲸 PaaS3.0 开发者中心，我们提供了简便的扩容方式。

在『应用引擎-进程管理』中，你会发现每个进程的操作里有一个小小的 🔧 符号，默认的，它允许你将进程的副本数扩展到 **5** 个。

![-w2021](../../images/docs/scale_process.png)

如果你还有更多的计算资源需求，请在企业微信联系 **BK 助手**。

> 注意：请注意，进程调整表明了你对进程的期望，如果你停止了某个进程，重新部署是不会自动拉起该进程的。

## 特殊的 web 进程

你一定注意到了，我们总是在提及 web 进程。因为对于任何应用，你一定需要一个访问它的入口，而 web 进程就是负责对外提供访问的。

### web 的含义

平台会读取 Procfile 或 app_desc.yaml 中定义的所有进程，而 `process_type` 值为 `web` 的进程，会被默认设置为应用的“访问主入口”，提供对外访问的能力。

如果你想修改这个默认行为，可以阅读 [进程服务说明](./entry_proc_services.md) 了解更多。