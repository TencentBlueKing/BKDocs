# 开发 Python 应用

本文将介绍如何在蓝鲸开发者中心上开发一个 Django 应用，学完整个教程后，你可以了解到：

- 蓝鲸开发者中心的基本概念：蓝鲸应用、应用部署等
- 如何使用开发框架
- 如何开发一个简单的蓝鲸应用

为了顺利完成教程，你需要：

- 了解 Python 语言的基本语法
- 了解 Django 网络框架的基本概念

> Python 新手？我们建议你先学习 Python 的基础知识后再进行应用开发。[Python 学习资料](https://www.python.org/doc/)

## 准备工作

首先，你需要通过蓝鲸开发者中心『应用开发-创建应用』页面选择 `Python 开发框架` 创建一个蓝鲸应用。

应用创建成功后，根据页面的指引将开发框架的代码克隆到本地。

## 开发环境配置

开始应用开发前，你的机器上需要安装好 Python 及蓝鲸应用所需的第三方模块。

针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

### 1. 安装 Python3

在项目构建目录（未设置则默认为根目录） `runtime.txt` 文件（跟 `requirements.txt` 在同级目录下）中定义项目使用的 Python 版本，若没有该文件项目部署到开发者中心时将使用 Python 3.10 版本。

为了保证本地开发与线上环境一致，你可以先到 [文档：自定义 Python 版本](../../topics/paas/choose_python_version.md) 里看看平台所支持的所有 Python 版本。

访问 [Python 官方下载页面](https://www.python.org/downloads/)下载你需要的 Python 版。

安装完成后，在命令行输入 **python3** 命令验证安装：

```bash
Python 3.6.8 (default, Jan  8 2020, 18:10:42)
[GCC X]
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

如果你需要同时开发多个 Python 项目，我们推荐使用 [virtualenv](https://virtualenv.pypa.io/en/stable/) 来进行环境管理。
同时也可以尝试使用 [poetry](https://github.com/python-poetry/poetry)。

### 2. 配置 MySQL 数据库

为了和应用线上环境保持一致，我们建议你在本地使用 MySQL 作为开发数据库。

访问 [MySQL 官方下载页面](http://dev.mysql.com/downloads/mysql/)，下载安装 MySQL 5.7 版本 数据库。

### 3. 安装 Python 第三方模块依赖

接下来需要安装蓝鲸应用依赖的第三方模块。首先进入你的蓝鲸应用所在的源码目录，然后执行命令：

```shell
pip install -r requirements.txt
```

该命令会安装上包括 Django、PyMySQL / mysqlclient 在内的第三方依赖模块。

## 配置环境变量

应用在开发者中心上运行时，主要通过环境变量来获取各类配置信息。

当我们在本地开发应用时，为了尽量模拟与平台一样的运行环境，至少需要设置以下这些环境变量：

- `BKPAAS_APP_ID`: bk_app_code，应用 ID，在应用的 “基本信息” 页面查看
- `BKPAAS_APP_SECRET`: bk_app_secret，在应用的 “基本信息” 页面查看
- `BKPAAS_MAJOR_VERSION`: "3", 表示部署在 PaaS3.0 开发者中心
- `BK_PAAS2_URL`: 蓝鲸桌面的地址，在环境变量页面，点击`查看内置环境变量`查看
- `BK_COMPONENT_API_URL`: 蓝鲸 ESB API 地址，在环境变量页面，点击`查看内置环境变量`查看
- `BKPAAS_LOGIN_URL`: 蓝鲸登录服务地址，在环境变量页面，点击`查看内置环境变量`查看

不同开发环境下，设置环境变量的方法各不相同。常用的有：

- [如何在 Mac 下设置环境变量](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [如何在 Windows 下设置环境变量](https://stackoverflow.com/questions/32463212/how-to-set-environment-variables-from-windows?noredirect=1&lq=1)

如果本地开发不同的 SaaS 需要配置多套环境变量，可以采用一些基于项目的环境变量设置方案。常用的有：

- [在 PyCharm 下设置环境变量](https://stackoverflow.com/questions/42708389/how-to-set-environment-variables-in-pycharm) ：在 PyCharm 中运行 SaaS，PyCharm 会根据不同的项目配置读取不同的环境变量值。
- [在 virtualenv 虚拟环境中 postactive 文件中设置环境变量](https://stackoverflow.com/questions/9554087/setting-an-environment-variable-in-virtualenv) ：这种做法需要在不同的项目使用不同的虚拟环境，每次激活虚拟环境时可以自动加载对应的环境变量值。

## 配置项目数据库连接

首先，请尝试在项目目录下执行 `python manage.py migrate` 来初始化数据库数据。这条命令可能会产生下列报错信息：

### 错误 1：2003, "Can't connect to MySQL server on '... ...'

出现这个错误的原因是 Django 不能正常连接到你的 MySQL 数据库，首先，请你确保你的数据库服务确实在运行状态。然后打开 `configs/dev.py`，找到以下这段代码：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': APP_CODE,
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    },
}
```

请将上面配置中的 `USER`、`PASSWORD`、`HOST`、`PORT` 修改为你所使用的正确配置信息，之后 Django 就可以正常连接上你的数据库了。

### 错误 2：1049, "Unknown database '... ...'"

出现这个错误的原因是因为你没有创建应用的 MySQL 数据库，请使用 mysql 客户端连接上数据库，将下面语句中的 数据库名称 换为 **应用 ID** 后，然后执行：

```sql
mysql> CREATE DATABASE `... ...` default charset utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.01 sec)
```

解决掉这些问题后，执行 `python manage.py migrate` 命令，你将会看到与下面类似的输出信息：

```bash
$ python manage.py migrate
Operations to perform:
  Synchronize unmigrated apps: staticfiles, weixin, home_application, messages
  Apply all migrations: app_control, account, sessions, admin, sites, auth, contenttypes
Synchronizing apps without migrations:
  Creating tables...
    Running deferred SQL...
  Installing custom SQL...
Running migrations:
  Rendering model states... DONE
  Applying contenttypes.0001_initial... OK
... ...
```

这代表你的数据库已经初始化成成功啦！

## 启动开发服务器

### 配置 hosts

首先，本地需要配置 hosts 文件，添加如下内容：

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名)
```

### 本地启动项目

在项目构建目录（未设置则默认为根目录）下执行如下命令：

```python
python manage.py runserver 127.0.0.1:8000
```

接着在浏览器访问 http://dev.xxx.xxx:8000/ 就可以看到项目首页啦。

## 开发第一个 Hello World 应用

- 在 config/default.py 的 INSTALLED_APPS 中加入 home_application (默认已添加)
- 在 urls.py 的 urlpatterns 加入 url(r'^', include('home_application.urls')) (默认已添加)
- 在 home_application/views.py 加入

```python
from django.http import HttpResponse


def hello(request):
    return HttpResponse('Hello World!')
```

- 修改 home_application/urls.py

```python
from django.conf.urls import url
from home_application import views

urlpatterns = [
    url(r'^$', views.hello),
]
```

再次运行项目吧，“世界就在你眼前”！

## 发布应用

### 部署应用

关于部署应用，你可以阅读 [如何部署蓝鲸应用](../../topics/paas/deploy_intro.md) 了解更多。

### 发布到应用市场

在你部署到生产环境之前，你需要：

- 在『应用配置』-『应用市场』完善你的市场信息
- 部署到生产环境

然后就能够直接在应用市场找到你的应用了。
