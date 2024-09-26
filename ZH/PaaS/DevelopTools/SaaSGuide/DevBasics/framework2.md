# 开发框架 2.0 使用说明
## 目录结构说明
### 项目目录结构

```bash
- blueking                    # ESB调用模块
- bk_framework_api        # Django 模版应用样例
- bk_framework_app       # drf 接口模版样例
- templates                   # Django 模板
    - bk_framework_app
      - contact.html          # 联系我们页面
      - dev_guide.html        # 开发指引
      - index_home.html       # 首页
- config                      # 应用配置目录
  - __init__.py               # 应用 RUN_VER、APP_CODE 和 SECRET_KEY 等配置
  - dev.py                    # 本地开发配置(开发团队共享)
  - default.py                # 全局配置
  - prod.py                   # 生产环境配置
  - stag.py                   # 预发布环境配置
- locale
  - en
  - zh-hans 
- static                      # 公共静态文件
  - account
  - djcelery
  - js                          # 公共 js
    - csrftoken.js            # CSRFTOKEN
    - settings.js             # 异常处理
  - open
  - remote
- templates                   # 公共模板文件
  - 403.html                     
  - 500.html
  - base.html                 # Django 模板基础文件，其他的页面可以从这里继承
- __init__.py
- manage.py                   # Django 工程 manage
- app_desc.yaml               # 应用描述文件
- Aptfile                         # 项目依赖的系统包
- pyproject.toml               # 代码规范统一配置文件
- requirements.txt            # 依赖的 python 包列表
- requirements_dev.txt      # 本地环境依赖的 python 包列表
- settings.py                 # Django 工程 settings
- urls.py                     # Django 工程主路由 URL 配置
- wsgi.py                     # WSGI配置
- runtime.txt                 # Python 版本配置文件，默认指向 Python 3.10.5版本
```

### 常用配置说明

- App 基本信息

在 config/\__init\__.py 可以查看 App 基本信息，请修改：APP_CODE、SECRET_KEY (用于 App 认证)和 BK_URL(蓝鲸 SaaS 平台的 URL)。RUN_VER 是当前 App 运行的 PaaS 版本，请不要修改。

- App 运行环境

在 config/dev.py、config/stag.py、config/prod.py 中都有一个 RUN_MODE 的变量，用来标记 App 运营环境(DEVELOP：本地环境，STAGING：预发布环境，PRODUCT：正式环境)，请不要修改。

- 日志级别和路径

开发框架默认配置的日志级别是 INFO，你可以在 config/default.py 修改 LOG_LEVEL 变量，会对所有运行环境生效，你也可以单独修改 config/dev.py、config/stag.py、config/prod.py 文件，详情请参考本文档的【日志使用】。

你不需要关心线上运行环境的日志路径，这些开发框架已经自动帮你配置了；

本地的日志放在和项目根目录同一级的 logs 目录下，以 APP_CODE 命名的文件夹中，其中 {APP_CODE}-django.log 是应用日志，{APP_CODE}-celery.log 是 celery 日志，{APP_CODE}-component.log 是组件日志，{APP_CODE}-mysql.log 是数据库日志。

- 数据库配置

本地数据库配置请在 config/dev.py 修改 DATABASES 变量；多人合作开发建议在根目录下新建 local_settings.py 文件，并配置 DATABASES 变量，并且在版本控制中忽略 local_settings.py，这样的好处是防止多人合作开发时本地配置不一致导致代码冲突。

## 开发环境搭建(Python)
### 安装 Python(3.10)

如果系统中已经安装有 Python2 版本，可以参考 Python 版本切换了解[Python3 与 Python2 并存的处理方案](PYTHON2_3.md)

### 安装 MySQL(5.5 以上)
### 安装 setuptools、pip 和项目依赖

```bash
pip3 install -r requirements.txt
```

### 安装 celery(需要使用后台任务的项目)

安装项目依赖时会自动安装 celery==4.4.0。目前 celery 支持 redis、rabbitmq 作为任务的消息队列，推荐使用 redis。

- mac 系统 redis 使用指南：

安装指令 `brew install redis`；

启动指令 `redis-server`；

测试 redis 服务是否正常启动，`redis-cli` 尝试连接本地的 redis 服务。

- windows 系统 redis 使用指南

下载安装地址：[https://github.com/MicrosoftArchive/redis/releases](https://github.com/MicrosoftArchive/redis/releases)

点击安装目录下的 redis-server.exe 启动 redis 服务。

- 配置项(在 config/dev.py 文件中修改消息队列配置)

```python
# Celery 消息队列设置 RabbitMQ
# BROKER_URL = 'amqp://guest:guest@localhost:5672//'

# Celery 消息队列设置 Redis
BROKER_URL = 'redis://localhost:6379/0'
```
### 配置 hosts

本地需要修改 hosts 文件，添加如下内容：

> **注意**： domain_name 应该修改为 PaaS 平台的域名

```bash
127.0.0.1 appdev.`{domain_name}`
```

### 配置本地数据库

首先在 MySQL 命令行下创建数据库：

```bash
CREATE DATABASE  `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci;
```

然后配置本地数据库账号密码，需要找到 config/dev.py 中的 DATABASES 配置项，修改 USER 和 PASSWORD。

### 初始化本地数据库

在项目根目录下执行如下命令初始化本地数据库：

```bash
python manage.py migrate
```

如果遇到错误，请先注释掉 config/default.py 的 INSTALLED_APPS 中的 APP 列表，执行命令后再去掉注释。

### 启动项目

在项目根目录下执行如下命令启动项目：

```bash
python manage.py runserver
```

接着在浏览器访问 appdev.`{domain_name}` 就可以访问到项目首页了。

![image-20190505204958140](../assets/usage-index.png)

## 新建 application
### 在根目录下执行 django-admin startapp yourappname
### 进入 yourappname 目录，新增 urls.py
### 编写逻辑代码和路由配置代码
### 把 yourappname 加入 config/default.py 的 INSTALLED_APPS 中

## 定义 model
### 在新建的 application 中 models.py 定义 model

官方文档：[Django Models](https://docs.djangoproject.com/en/3.2/topics/db/models/)

### 生成数据库变更文件

在项目根目录下执行如下命令：

```bash
python manage.py makemigrations yourappname
```

执行成功后就会生成数据库变更文件，文件位于新建 APP 的 migrations 目录中。

### 生效数据库变更

在项目根目录下执行如下命令：

```bash
python manage.py migrate yourappname
```

> **注意**：在把 yourappname 加入 config/default.py 的 INSTALLED_APPS 中之前，请先执行 python manage.py migrate 初始化数据库。

## 静态资源使用规范

- 静态文件按模块划分，分别放在 Django 工程中每个对应 APP 的 static 目录下

请将你的 Django 静态文件 xxx.js 和 xxx.css 放在 PROJECT_ROOT/APP_NAME/static/ 目录底下，建议在 static 底下在加上一层目录，取名为 APP_NAME，即最终模板文件存放路径为 PROJECT_ROOT/APP_NAME/static/APP_NAME[/js 或者/css]，这是为了避免在寻找静态文件的时候，出现覆盖的情况。

- 修改静态文件后要手动运行 python manage.py collectstatic 命令来收集静态文件到根目录的 static 文件夹中。

- settings 需要包含 STATIC_ROOT 配置。

```python
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
```

- 框架已配置全局有效的静态目录，可以将所有公共使用的静态资源放置于此。

```python
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
```

其中 BASE_DIR 是工程根目录路径。

## celery 使用

celery 是一个简单、灵活且可靠的，处理大量消息的分布式系统，并且提供维护这样一个系统的必需工具。
它是一个专注于实时处理的任务队列，同时也支持任务调度。

### 打开 Celery 配置

在 config/default.py 中修改配置：

```python
IS_USE_CELERY = True
```

### 添加 Celery 任务

在 app 底下创建 tasks.py 文件，添加 @task 任务：

```python
from celery import task

@task
def mul(x, y):
    return x * y
```

如果 @task 任务函数不在 app/tasks.py 文件中，需要在 config/default.py 中添加配置：

```python
CELERY_IMPORTS = (
    'testapp.tasks'
)
```

### 启动异步任务服务 celery worker

在根目录执行：

```bash
python manage.py celery worker -l info
```

### 启动周期性任务服务 celery beat

在根目录执行：

```bash
python manage.py celery beat -l info
```

### 添加周期任务

进入 admin，在 DJCELERY->Periodic_tasks 表中添加一条记录。

### 如何在平台部署时，自动启动 celery 进程
修改项目目录下的 app_desc.yaml 文件，添加以下配置：

```bash
module:
  processes:
    worker:
      command: python manage.py celery worker --concurrency 4 -l info
    beat:
      command: python manage.py celery beat -l info
```

之后部署应用，在“进程管理”页面内就能看到新的 worker 进程了。

如果想要关闭 celery，请根据以下步骤操作：

- 将配置文件中的 `IS_USE_CELERY` 改为 False
- 删除 app_desc.yaml 文件中 worker 与 beat 进程
- 提交代码改动后重新部署应用

### 调整 celery worker 并发数

- CELERYD_CONCURRENCY 参数官方说明：[官方文档](https://docs.celeryq.dev/en/latest/userguide/configuration.html#worker-prefetch-multiplier)

- 目前开发框架设置的 celery 并发数是 2，如需调整，有 2 种方法：

1)在蓝鲸平台的 APP 环境变量新增 KEY 为 CELERYD_CONCURRENCY 的变量，并设置对应的值(调大前建议咨询平台维护同事)。

2)直接修改 APP 中的配置，即修改 config/default.py 文件中如下配置的默认值 2 为你想要设置的值。

```python
CELERYD_CONCURRENCY = os.getenv('BK_CELERYD_CONCURRENCY', 2)
```

### 调整 celery 与 RabbitMQ 心跳包发送时间
- BROKER_HEARTBEAT 参数官方说明：[官方文档](https://docs.celeryq.dev/en/latest/userguide/configuration.html#broker-heartbeat)

- 目前开发框架设置的 BROKER_HEARTBEAT 发送时间是 60，即每 60 秒发送一个心跳包，如需调整，有以下方法：

直接修改 APP 中的配置，即在 config/default.py 文件中添加相应配置，框架默认的配置会被覆盖。

```python
# CELERY与RabbitMQ增加60秒心跳设置项
BROKER_HEARTBEAT = 60
```

## 日志使用

- 日志相关配置方式复用 Django 的配置方式：[官方文档](https://docs.djangoproject.com/en/3.2/topics/logging/)

```python
import logging
logger = logging.getLogger('app')       # 普通日志
logger_celery = logging.getLogger('celery')   # celery日志
logger.error('log your info here.')

# 第二种方式
from blueapps.utils.logger import logger         # 普通日志
from blueapps.utils.logger import logger_celery  # celery日志
logger.error('log your info here.')
```

- 日志输出路径：

本地输出路径在和项目根目录平级的 logs 目录下。

```bash
- PROJCET_ROOT
- logs
    - APP_CODE
        - APP_CODE-celery.log
        - APP_CODE-component.log
        - APP_CODE-django.log
        - APP_CODE-mysql.log
```

- 日志级别配置：

日志级别默认是 INFO，如需修改： 

1. 所有环境下的日志级别，请在 config/default.py 对应位置修改日志级别：
   ```python
   LOG_LEVEL = "DEBUG"
   # load logging settings
   LOGGING = get_logging_config_dict(locals())
   ```

2. 如果只希望针对特定环境进行日志级别设置，则在对应环境配置文件（ config/prod.py（只影响生产环境）、config/stag.py（只影响预发布环境）、config/dev.py（只影响预本地开发环境））中取消对应代码注释并修改日志级别：
   ```python
   # 自定义本地环境日志级别
   from blueapps.conf.log import set_log_level # noqa
   LOG_LEVEL = "DEBUG"
   LOGGING = set_log_level(locals())
   ```
    __注意__: 这种修改方式依赖 blueapps 版本 >= 3.3.1。

其中，不同配置的含义如下：
1. DEBUG：用于调试目的的底层系统信息
2. INFO：普通的系统信息
3. WARNING：表示出现一个较小的问题。
4. ERROR：表示出现一个较大的问题。
5. CRITICAL：表示出现一个致命的问题。

## 异常处理

为了减少代码中判断函数调用的判断逻辑，蓝鲸开发框架提出，开发者应该在异常处直接抛出异常，通过 Django 中间件特性来处理该异常。

### 使用样例

```python
from blueapps.core.exceptions import ParamValidationError
def your_view_func(request):
  form = your_form(request.POST)
  if not form.is_valid():
    raise ParamValidationError(u'参数验证失败,请确认后重试')
  # do something you want
```

> **注意**：此处只是一个简单的示例。我们强烈的建议开发者应该在任何有错误的地方直接抛出异常，而非返回错误，由上层逻辑处理。

### 异常类型介绍

蓝鲸开发框架异常类主要分为两类：客户端异常及服务端异常，分别对应由于客户端请求引起的错误和后台服务引起的错误。开发者可以根据引起错误的场景来选择需要抛出的异常。

- 异常类所在命名空间

    - blueapps.core.exceptions

- 服务端异常

| 错误类 | 说明 | http 状态码 | 返回错误码 | 场景举例 |
| ------ | ---- | ----------- | ---------- | -------- |
| DatabaseError | 数据库异常  |  501 |  0000501 | 更新数据库记录失败 |
| ApiNetworkError | 网络异常导致远程服务失效 | 503 | 0000503 | 请求第三方接口由于网络连接问题导致失败 |
| ApiResultError | 远程服务请求结果异常 | 503 | 0000513 | 请求第三方结果返回 result 结果是 false |
| ApiNotAcceptable | 远程服务返回结果格式异常 | 503 | 0000523 | 第三方接口返回 xml 格式结果，但预期返回 json 格式 |

- 客户端异常

| 错误类 | 说明 | http 状态码 | 返回错误码 | 场景举例 |
|  ------ |  ----  |  -----------  |  ----------  |  --------  |
| ParamValidationError | 参数验证失败 | 400 | 0000400 | 期待为整形的参数，用户提供了一个字符参数 |
| ParamRequired | 请求参数缺失 | 400 | 0000401 | 期待的参数找不到 |
| RioVerifyError | 登录请求经智能网关检测失败 | 401 | 0000415 | 用户登录验证 |
| BkJwtVerifyError | 登录请求经 JWT 检测失败 | 401 | 0000425| | 用户登录验证 |
| AccessForbidden | 登录失败 | 403 | 0000413 | 用户身份验证失败 |
| RequestForbidden | 请求拒绝 | 403 | 0000423 | 用户企图操作没有权限的任务 |
| ResourceLock | 请求资源被锁定 | 403 | 0000433 | 用户企图操作一个已经锁定的任务 |
| ResourceNotFound | 找不到请求的资源 | 404 | 0000404 | 找不到用户请求的某个指定 ID 的 model |
| MethodError | 请求方法不支持 | 405 | 0000405 | 用户发送的请求不在预期范围内 |
