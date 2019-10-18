# 开发框架 2.0 使用说明

## 1. 目录结构说明

### 1.1 项目目录结构

```bash
.
|-- blueapps                    # Python 开发框架模块
|-- blueking                    # ESB 调用模块
|-- config                      # 应用配置目录
|   |-- __init__.py               # 应用 RUN_VER（ieod/clouds/qcloud）、APP_CODE 和 SECRET_KEY 等配置
|   |-- dev.py                    # 本地开发配置（开发团队共享）
|   |- default.py                # 全局配置
|   |- prod.py                   # 生产环境配置
|   |- stag.py                   # 预发布环境配置
|-- home_application            # Django 模板应用样例
|   |-- __init__.py
|   |-- admin.py
|   |-- urls.py
|   |-- models.py
|   |-- tests.py
|   |-- views.py
|   |-- templates                 # Django 模板
|   |   |- home_application
|   |   |- contact.html          # 联系我们页面
|   |   |- home.html             # 首页
|-- mako_templates              # mako 公共模板文件
|   |-- base.mako                 # mako 模板基础文件，其他的页面可以从这里继承
|-- mako_application            # mako 模板应用样例
|   |-- __init__.py
|   |-- admin.py
|   |-- urls.py
|   |-- models.py
|   |-- tests.py
|   |-- views.py
|   |-- mako_templates            # 模板
|   |   |-- mako_application
|   |   |   |-- contact.mako          # 联系我们页面
|   |   |   |-- home.mako             # 首页
|-- static                      # 公共静态文件
|   |-- js                        # 公共 js
|   |   |-- csrftoken.js            # CSRFTOKEN
|   |   |-- settings.js             # 异常处理
|-- templates                   # 公共模板文件
|   |-- admin                     # admin 模板文件
|   |   |-- base_site.html
|   |   |-- login.html
|   |-- base.html                 # Django 模板基础文件，其他的页面可以从这里继承
|-- manage.py                   # Django 工程 manage
|-- requirements.txt            # 依赖的 python 包列表
|-- settings.py                 # Django 工程 settings
|-- urls.py                     # Django 工程主路由 URL 配置
|-- wsgi.py                     # WSGI 配置
|-- runtime.txt                 # Python 版本配置文件，默认指向 Python 3.6.2 版本
```


### 1.2 常用配置说明

- App 基本信息
在 config/\__init\__.py 可以查看 App 基本信息，请修改： APP_CODE 、SECRET_KEY （用于 App 认证）和 BK_URL (蓝鲸 SaaS 平台的 URL)。RUN_VER 是当前 App 运行的 PaaS 版本，请不要修改。

- App 运行环境
在 config/dev.py、config/stag.py、config/prod.py 中都有一个 RUN_MODE 的变量，用来标记 App 运营环境（DEVELOP：本地环境，STAGING：预发布环境，PRODUCT：正式环境），请不要修改。

- 日志级别和路径
开发框架默认配置的日志级别是 INFO，你可以在 config/default.py 修改 LOG_LEVEL 变量，会对所有运行环境生效，你也可以单独修改 config/dev.py、config/stag.py、config/prod.py 文件，详情请参考 “8. 日志使用”。
你不需要关心线上运行环境的日志路径，这些开发框架已经自动帮你配置了；本地的日志放在和项目根目录同一级的 logs 目录下，以 APP_CODE 命名的文件夹中，其中 {APP_CODE}-django.log 是应用日志，{APP_CODE}-celery.log 是 celery 日志，{APP_CODE}-component.log 是组件日志，{APP_CODE}-mysql.log 是数据库日志。

- 数据库配置
本地数据库配置请在 config/dev.py 修改 DATABASES 变量；多人合作开发建议在根目录下新建 local_settings.py 文件，并配置 DATABASES 变量，并且在版本控制中忽略 local_settings.py，这样的好处是防止多人合作开发时本地配置不一致导致代码冲突。
你不需要关心线上线上运行环境的数据库配置，不过你可以线上运行环境通过 django.settings.DATABASES 获取数据库配置。


## 2. 开发环境搭建（python）

### 2.1 安装 python（3.6）

如果系统中已经安装有 Python2 版本，可以参考 Python 版本切换了解 Python3 与 Python2 并存的处理方案


### 2.2 安装 Mysql（5.5 以上）


### 2.3 安装 setuptools、pip 和项目依赖

> __注意__：安装 blueapps 需要使用蓝鲸 pypi 源，可以在 pip 配置文件中设置，也可以使用如下命令安装

```bash
pip install -r requirements.txt
```


### 2.4 安装本地开发工具

推荐使用 pycharm 进行代码开发，使用 TortoiseSVN 管理 SVN，使用 SourceTree 管理 GIT。


### 2.5 安装 celery（需要使用后台任务的项目）

安装项目依赖时会自动安装 celery==3.1.25 和 django-celery==3.2.1。目前 celery 支持 redis、rabbitmq 作为任务的消息队列，推荐使用 redis。

- mac 系统 redis 使用指南：
安装指令 `brew install redis`；
启动指令 `redis-server`；
测试 redis 服务是否正常启动，`redis-cli` 尝试连接本地的 redis 服务。

- windows 系统 redis 使用指南
下载安装地址： https://github.com/MicrosoftArchive/redis/releases。
点击安装目录下的 redis-server.exe 启动 redis 服务。

- 配置项（在 config/dev.py 文件中修改消息队列配置）

```python
# Celery 消息队列设置 RabbitMQ
# BROKER_URL = 'amqp://guest:guest@localhost:5672//'

# Celery 消息队列设置 Redis
BROKER_URL = 'redis://localhost:6379/0'
```


### 2.6 配置 hosts

本地需要修改 hosts 文件，添加如下内容：

> **注意**： domain_name 应该修改为 PaaS 平台的域名

```bash
127.0.0.1 appdev.`{domain_name}`
```


### 2.7 配置本地数据库

首先在 MySQL 命令行下创建数据库：

```bash
CREATE DATABASE  `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci;
```

然后配置本地数据库账号密码，需要找到 config/dev.py 中的 DATABASES 配置项，修改 USER 和 PASSWORD。


### 2.8 初始化本地数据库

在项目根目录下执行如下命令初始化本地数据库：

```bash
python manage.py migrate
```

如果遇到错误，请先注释掉 config/default.py 的 INSTALLED_APPS 中的 APP 列表，执行命令后再去掉注释。


### 2.9 启动项目

在项目根目录下执行如下命令启动项目：

```bash
python manage.py runserver
```
接着在浏览器访问 appdev.`{domain_name}` 就可以访问到项目首页了。

![image-20190505204958140](../ 开发进阶 /pictures/usage-index.png)


## 3. 新建 application


- 3.1 在根目录下执行 django-admin startapp yourappname


- 3.2 进入 yourappname 目录，新增 urls.py


- 3.3 编写逻辑代码和路由配置代码


- 3.4 把 yourappname 加入 config/default.py 的 INSTALLED_APPS 中


## 4. 定义 model


### 4.1 在新建的 application 中 models.py 定义 model

官方文档： [Django Models](https://docs.djangoproject.com/en/1.11/topics/db/models/)

### 4.2 生成数据库变更文件

在项目根目录下执行如下命令：

```bash
python manage.py makemigrations yourappname
```

执行成功后就会生成数据库变更文件，文件位于新建 APP 的 migrations 目录中。


### 4.3 生效数据库变更

在项目根目录下执行如下命令：

```bash
python manage.py migrate yourappname
```

__注意__：在把 yourappname 加入 config/default.py 的 INSTALLED_APPS 中之前，请先执行 python manage.py migrate 初始化数据库。


## 5. 使用模板

开发框架支持 Django、 Mako 两种模板渲染引擎，在 Django 工程下每个 App 维护自身的模板文件，以下以 APP_NAME 代表 Django APP 名称。


### 5.1 Django 模板文件使用方式（这里不讨论具体的语法）

请将你的 Django 模板文件 xxx.html 放在 `PROJECT_ROOT/APP_NAME/templates/` 目录底下，建议在 templates 底下在加上一层目录，取名为 APP_NAME，即最终模板文件存放路径为 `PROJECT_ROOT/APP_NAME/templates/APP_NAME`，这是为了避免在寻找模板文件的时候，出现覆盖的情况。
使用 Django 原生支持的 render 方法进行模板渲染。

```python
from django.shortcuts import render

def index (request):
    return render (request, 'APP_NAME/index.html', {})
```

render 函数接受三个参数：
* 第一个参数 request 对象。
* 第二个参数 模板路径，从 APP templates 目录开始写起，此处对应的完整路径为 PROJECT_ROOT/APP_NAME/templates/APP_NAME/index.html，注意不要在前面加 '/'，否则会被识别为绝对路径，找不到对应的模板。
* 第三个参数 传入的模板上下文，用于替换模板中的变量。

> 为什么 templates 目录底下还需要再加一层以 APP_NAME 命名的目录？
> 假设 settings INSTALLED_APPS = ('app1', 'app2')，工程目录如下
> ```
> PROJCET_ROOT
> |__ app1
> |__ __ templates
> |__ __ __ index.html
> ...
> |__ app2
> |__ __ templates
> |__ __ __ index.html
> ```
>
> 当我们在 app2.views 里使用 `render (request, 'index.html', {})` 语句进行渲染时，Django 框架默认以 INSTALLED_APPS 安装次序进行模板文件查找，这时候会匹配到 `app1/templates/index.html` 文件进行渲染，导致得到非预期的结果。所以推荐  `PROJECT_ROOT/APP_NAME/templates/APP_NAME` 这样的目录设计
>


### 5.2  Mako 模板文件使用方式

Mako 模板文件使用方式大致与 Django 模板文件相同，唯一的区别就是是 Mako 模板文件放在 PROJECT_ROOT/APP_NAME/mako_templates/ 目录底下，同样建议在 mako 底下在加上一层目录，取名为 APP_NAME，最终模板文件存放路径为 PROJECT_ROOT/APP_NAME/mako_templates/APP_NAME。

__注意__：出于安全原因，强烈建议用户使用 Django 模板替代 Mako 进行渲染，防止 XSS 攻击。

### 5.3 Template-Context 平台框架提供的模板变量

这里列举的模板变量，不需要用户在 render 模板时传入，可直接在模板文件中访问到，直接使用。

```python
context = {
    'STATIC_URL': settings.STATIC_URL,                    # 本地静态文件访问
    'APP_PATH': request.get_full_path (),                  # 当前页面，主要为了 login_required 做跳转用
    'RUN_MODE': settings.RUN_MODE,                        # 运行模式
    'APP_CODE': settings.APP_CODE,                        # 在蓝鲸系统中注册的  "应用编码"
    'SITE_URL': settings.SITE_URL,                        # URL 前缀
    'REMOTE_STATIC_URL': settings.REMOTE_STATIC_URL,      # 远程静态资源 url
    'STATIC_VERSION': settings.STATIC_VERSION,            # 静态资源版本号，用于指示浏览器更新缓存
    'BK_URL': settings.BK_URL,                            # 蓝鲸平台 URL
    'USERNAME': username,                                 # 用户名
    'NICKNAME': nickname,                                 # 用户昵称
    'AVATAR_URL': avatar_url,                             # 用户头像
}
```

## 6. 静态资源使用规范

- 静态文件按模块划分，分别放在 Django 工程中每个对应 APP 的 static 目录下
请将你的 Django 静态文件 xxx.js 和 xxx.css 放在 PROJECT_ROOT/APP_NAME/static/ 目录底下，建议在 static 底下在加上一层目录，取名为 APP_NAME，即最终模板文件存放路径为 PROJECT_ROOT/APP_NAME/static/APP_NAME [/js 或者 /css]，这是为了避免在寻找静态文件的时候，出现覆盖的情况。

- 修改静态文件后要手动运行 python manage.py collectstatic 命令来收集静态文件到根目录的 static 文件夹中。

- settings 需要包含 STATIC_ROOT 配置。

```python
STATIC_ROOT = os.path.join (BASE_DIR, 'staticfiles')

- 框架已配置全局有效的静态目录，可以将所有公共使用的静态资源放置于此。

```python
STATICFILES_DIRS = (os.path.join (BASE_DIR, 'static'),
)
```

其中 BASE_DIR 是工程根目录路径。

## 7. 日志使用

- 日志相关配置方式复用 Django 的配置方式

   https://docs.djangoproject.com/en/1.11/topics/logging/#using-logging

```python
import logging
logger = logging.getLogger ('app')       # 普通日志
logger_celery = logging.getLogger ('celery')   # celery 日志
logger.error ('log your info here.')

# 第二种方式
from blueapps.util.logger import logger         # 普通日志
from blueapps.util.logger import logger_celery  # celery 日志
logger.error ('log your info here.')
```

- 日志输出路径：

本地输出路径在和项目根目录平级的 logs 目录下。
```bash
.
|- PROJCET_ROOT
|- logs
    |- APP_CODE
        |- APP_CODE-celery.log
        |- APP_CODE-component.log
        |- APP_CODE-django.log
        |- APP_CODE-mysql.log
```

- 日志级别配置：

日志级别默认是 INFO，如需修改，请在 config/default.py 或者 config/prod.py（只影响生产环境）、config/stag.py（只影响预发布环境）、config/dev.py（只影响预本地开发环境）中添加如下代码。

```python
import logging
logger = logging.getLogger ('app')
logger.setsetLevel ('DEBUG')
logger.setsetLevel ('INFO')
logger.setsetLevel ('WARNING')
logger.setsetLevel ('ERROR')
logger.setsetLevel ('CRITICAL')
logger_celery = logging.getLogger ('celery')
logger_celery.setsetLevel ('DEBUG')
logger_celery.setsetLevel ('INFO')
logger_celery.setsetLevel ('WARNING')
logger_celery.setsetLevel ('ERROR')
logger_celery.setsetLevel ('CRITICAL')
```


## 8. 异常处理

为了减少代码中判断函数调用的判断逻辑，蓝鲸开发框架提出，开发者应该在异常处直接抛出异常，通过 Django 中间件特性来处理该异常。


### 8.1 使用样例

```python
from blueapps.core.exceptions import ArgsMissing
def your_view_func (request):
  form = your_form (request.POST)
  if not form.is_valid ():
    raise ArgsValidateFailed (u' 参数验证失败，请确认后重试 ')
  # do something you want
```

__注意__：此处只是一个简单的示例。我们强烈的建议开发者应该在任何有错误的地方直接抛出异常，而非返回错误，由上层逻辑处理。


### 8.2 异常类型介绍

蓝鲸开发框架异常类主要分为两类：客户端异常及服务端异常，分别对应由于客户端请求引起的错误和后台服务引起的错误。开发者可以根据引起错误的场景来选择需要抛出的异常。

- 异常类所在命名空间

	- blueapps.core.exceptions

- 服务端异常

| 错误类 | 说明 | http 状态码 | 返回错误码 | 场景举例 |
| ------ | ---- | ----------- | ---------- | -------- |
| DatabaseError | 数据库异常  |  501 |  50110 | 更新数据库记录失败 |
| ApiNetworkError | 网络异常导致远程服务失效 | 503 | 50301 | 请求第三方接口由于网络连接问题导致失败 |
| ApiResultError | 远程服务请求结果异常 | 503 | 50302 | 请求第三方结果返回 result 结果是 false |
| ApiNotAcceptable | 远程服务返回结果格式异常 | 503 | 50303 | 第三方接口返回 xml 格式结果，但预期返回 json 格式 |

- 客户端异常

| 错误类 | 说明 | http 状态码 | 返回错误码 | 场景举例 |
|  ------ |  ----  |  -----------  |  ----------  |  --------  |
| ResourceNotFound | 找不到请求的资源  |  404 |  40400 | 找不到用户请求的某个指定 ID 的 model |
| ArgsValidateFailed | 参数验证失败 | 400 | 40000 | 期待为整形的参数，用户提供了一个字符参数 |
| ArgsMissing | 请求参数缺失 | 400 | 40001 | 期待的参数找不到 |
| AccessForbidden | 登陆失败 | 403 | 40301 | 用户身份验证失败 |
| RequestForbidden | 请求拒绝 | 403 | 40320 | 用户企图操作没有权限的任务 |
| ResourceLock | 请求资源被锁定 | 403 | 40330 | 用户企图操作一个已经锁定的任务 |
| MethodError | 请求方法不支持 | 405 | 40501 | 用户发送的请求不在预期范围内 |
