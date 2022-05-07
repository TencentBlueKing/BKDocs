# 开发框架 2.0 使用进阶

## 登录模块

### 豁免登录

目前所有的 view 访问全部强制要求登录鉴权, 用户可以豁免一些 view 的登录限制，主要用于对外提供 API。

```python
from blueapps.account.decorators import login_exempt

@login_exempt
def myview(request):
    return "hello world"
```


## User Model 获取 & 使用方式


### 获取 User Model

通过  `from blueapps.account import get_user_model` 可得到 User Model


### User 方法属性说明

- username

用户唯一标识，如 QQ 号

- nickname

用于前端展示的用户名，如 QQ 昵称

- avatar_url

用户头像 URL

- get_full_name

用于前端展示的完整用户名，如 QQ 昵称

### User 扩展属性说明

- get_property(key)

用户获取水平扩展属性

```python
from blueapps.account import get_user_model

user = get_user_model().objects.get(username=xxx)
user.get_property(key)
```

- set_property(key,value)

用户设置水平扩展属性

```python
from blueapps.account import get_user_model

user = get_user_model().objects.get(username=xxx)
user.set_property(key, value)
```

### 在模板中使用 User 作为外键

```python
from django.conf import settings
from django.db import models

class SomeModel(models.Model):
    person = models.ForeignKey(settings.AUTH_USER_MODEL, verbose_name=u"用户")
```

### Django APP 管理员设置

修改 config/default.py 的 INIT_SUPERUSER 配置，填写用户名列表，默认值是应用创建人，列表中的人员将拥有预发布环境和正式环境的管理员权限。需要注意的是，该配置需要在首次提测和上线前修改，之后的修改将不会生效。
如果不小心将唯一的管理员权限去掉了，有两种方式新增管理员：

- 通过 migrations 实现

在你的 APP 目录下，找到 migrations 文件夹，新建文件 {INDEX}_init_superuser.py：

```python
# -*- coding: utf-8 -*-
from django.db import migrations
from django.conf import settings


def load_data(apps, schema_editor):
    """
    添加用户为管理员
    """
    User = apps.get_model("account", "User")
    for name in settings.INIT_SUPERUSER:
        User.objects.update_or_create(
            username=name,
            defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
        )


class Migration(migrations.Migration):
    dependencies = [
        ('{APP}', '{APP_LAST_MIGRATION}')
    ]
    operations = [
        migrations.RunPython(load_data)
    ]
```

其中，{APP} 表示你的当前 APP，{APP_LAST_MIGRATION} 表示当前 mirgations 文件中最新一个文件名（如 “0003_auto_20180301_1732”），{INDEX} 表示最新一个文件名的前缀数字加 1（如 “0003_auto_20180301_1732” 的前缀数字是 “0003”，那么 {INDEX} 设置为 “0004”）。

- 通过 views 实现

在你的 APP 目录的 views 文件中，添加如下代码：

```python
from django.conf import settings
from django.http import HttpResponse

from blueapps.account import get_user_model


def load_data(request):
    """
    添加用户为管理员
    """
    User = get_user_model()
    for name in settings.INIT_SUPERUSER:
        User.objects.update_or_create(
            username=name,
            defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
        )
    return HttpResponse('Success')
```

然后配置一条 URL 路由规则到该 view，提测、上线后访问对应 URL 就可以初始化管理员了。


## 配置修改指引


### settings 主要配置

__注意__：不要修改 settings.py ，配置项修改请在 config 目录下的文件中进行。

其中，如果修改 config/default.py 配置项对所有的运行环境生效（正式环境、预发布环境、本地环境）；
修改 config/prod.py 配置项只会对正式环境生效；
修改 config/stag.py 配置项只会对预发布环境生效；
修改 config/dev.py 配置项只会对本地开发环境生效；
在多人开发时，为了避免 config/dev.py 中的配置互相影响，每个开发者都可以在项目根目录下新增 local_settings.py 文件，来添加各开发者不同的本地开发配置，如 DATABASES，并在提交代码时忽略 local_settings.py 文件。
    
- 自定义 Django APP

请修改 config/default.py 的 INSTALLED_APPS
    
- 自定义中间件

请修改 config/default.py 的 MIDDLEWARE
    
- 自定义数据库

如无必要请不要覆盖默认 default 数据库，正式环境和预发布环境分别修改 config/prod.py 和 config/stag.py，使用 DATABASES.update() 方法。
本地环境请修改 config/dev.py 的 DATABASES。

- 自定义日志级别

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

- 静态资源版本号更新

修改 config/default.py 的 STATIC_VERSION。

- 添加 celery 任务

把 celery 任务模块加入 config/default.py 的 CELERY_IMPORTS。

- 初始化管理员列表

请修改 config/default.py 的 INIT_SUPERUSER，列表中的人员将拥有预发布环境和正式环境的管理员权限。请在首次提测和上线前修改，之后的修改将不会生效。

-  自定义其他 Django 支持的配置

请直接在 config/default.py 添加需要的配置覆盖默认值。


### 使用 settings 配置

在 Django 应用中，可以通过导入 django.conf.settings 对象来使用设置。例如：

```python
from django.conf import settings

if settings.DEBUG:
    # Do something
```

__注意__：django.conf.settings 不是一个模块 —— 它是一个对象。所以不可以导入每个单独的设置

```python
from django.conf.settings import DEBUG  # This won't work.
```

__注意__：你的代码不应该从 config.default.py 或其他设置文件中导入。django.conf.settings 抽象出默认设置和站点特定设置的概念；它表示一个单一的接口。它还可以将代码从你的设置所在的位置解耦出来。


## 自定义 middleware(中间件)

- default.py 配置如下

```python
MIDDLEWARE += (
# 你的中间件
)
```

__注意__：django1.10 开始，中间件配置项使用 __`MIDDLEWARE`__ ，1.10 以下版本使用的 MIDDLEWARE_CLASSES 配置项会在 django2.0 后不再被支持。

- midlleware 开发

使用 MIDDLEWARE 配置项开发你的 middleware。

```python
from django.utils.deprecation import MiddlewareMixin

class MyCustomMiddleware(MiddlewareMixin):
    # 中间件支持的方法依然不变
    def process_request(request):
        ...
    def process_view(request, callback, callback_args, callback_kwargs):
        ...
    def process_template_response(request, response):
        ...
    def process_response(request, response):
        ...
    def process_exception(request, exception):
        ...
```

__注意__： 你的 middleware 类必须继承 django 的 MiddlewareMixin，同时你的 middleware 尽量不要去重写 `__call__` 和 `__init__` 方法，参考[官方文档](https://docs.djangoproject.com/en/2.2/topics/http/middleware/)。


## 公共方法

### blueapps.utils.logger

提供常用的 logger,logger_celery

```python
from blueapps.util.logger import logger         # 普通日志
from blueapps.util.logger import logger_celery  # celery日志
logger.error('log your info here.')
```

