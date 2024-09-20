# Python 开发框架简介

Python 开发框架是集成了蓝鲸系统功能，方便开发者可以快速在蓝鲸 PaaS3.0 开发者中心上开发 SaaS 的 Python 框架。

该开发框架基于 Django 框架架构，并在此基础上进行扩展，增加蓝鲸系统的特有功能，

例如：身份验证、ESB 调用及模板渲染等功能，以便开发者可以更专注于 SaaS 的逻辑开发。


## 开发框架 2.0 使用说明
### 项目目录结构

```bash
- blueapps                    # Python开发框架模块
- blueking                    # ESB调用模块
- config                      # 应用配置目录
  - __init__.py               # 应用 RUN_VER(社区版为open)、APP_CODE 和 SECRET_KEY 等配置
  - dev.py                    # 本地开发配置(开发团队共享)
  - default.py                # 全局配置
  - prod.py                   # 生产环境配置
  - stag.py                   # 预发布环境配置
- home_application            # Django 模板应用样例
  - __init__.py
  - admin.py
  - urls.py
  - models.py
  - tests.py
  - views.py
  - templates                 # Django 模板
    - home_application
      - contact.html          # 联系我们页面
      - dev_guide.html        # 开发指引
      - index_home.html       # 首页
- mako_templates              # mako 公共模板文件
  - base.mako                 # mako 模板基础文件，其他的页面可以从这里继承
- mako_application            # mako 模板应用样例
  - __init__.py
  - admin.py
  - urls.py
  - models.py
  - tests.py
  - views.py
  - mako_templates            # 模板
    - mako_application
      - contact.html          # 联系我们页面
      - dev_guide.html        # 开发指引
      - index_home.html       # 首页
- static                      # 公共静态文件
  - js                        # 公共 js
    - csrftoken.js            # CSRFTOKEN
    - settings.js             # 异常处理
- templates                   # 公共模板文件
  - admin                     # admin 模板文件
    - base_site.html
    - login.html
  - base.html                 # Django 模板基础文件，其他的页面可以从这里继承
- manage.py                   # Django 工程 manage
- requirements.txt            # 依赖的 python 包列表
- settings.py                 # Django 工程 settings
- urls.py                     # Django 工程主路由 URL 配置
- wsgi.py                     # WSGI配置
- runtime.txt                 # Python 版本配置文件，默认指向 Python 3.6.2版本
```

### 常用配置说明

- App 基本信息

在 config/\__init\__.py 可以查看 App 基本信息，请修改：APP_CODE、SECRET_KEY (用于 App 认证)和 BK_URL(蓝鲸 SaaS 平台的 URL)。RUN_VER 是当前 App 运行的 PaaS 版本，请不要修改。

- App 运行环境

在 config/dev.py、config/stag.py、config/prod.py 中都有一个 RUN_MODE 的变量，用来标记 App 运营环境(DEVELOP：本地环境，STAGING：预发布环境，PRODUCT：正式环境)，请不要修改。

- 日志级别和路径

开发框架默认配置的日志级别是 INFO，你可以在 config/default.py 修改 LOG_LEVEL 变量，会对所有运行环境生效，你也可以单独修改 config/dev.py、config/stag.py、config/prod.py 文件。

你不需要关心线上运行环境的日志路径，这些开发框架已经自动帮你配置了；

本地的日志放在和项目根目录同一级的 logs 目录下，以 APP_CODE 命名的文件夹中，其中 {APP_CODE}-django.log 是应用日志，{APP_CODE}-celery.log 是 celery 日志，{APP_CODE}-component.log 是组件日志，{APP_CODE}-mysql.log 是数据库日志。

- 数据库配置

本地数据库配置请在 config/dev.py 修改 DATABASES 变量；多人合作开发建议在根目录下新建 local_settings.py 文件，并配置 DATABASES 变量，并且在版本控制中忽略 local_settings.py，这样的好处是防止多人合作开发时本地配置不一致导致代码冲突。


## 日志使用

- 日志相关配置方式复用 Django 的配置方式：[官方文档](https://docs.djangoproject.com/en/3.2/topics/logging/#using-logging)

```python
import logging
logger = logging.getLogger('app')       # 普通日志
logger_celery = logging.getLogger('celery')   # celery日志
logger.error('log your info here.')

# 第二种方式
from blueapps.util.logger import logger         # 普通日志
from blueapps.util.logger import logger_celery  # celery日志
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
| DatabaseError | 数据库异常  |  501 |  50110 | 更新数据库记录失败 |
| ApiNetworkError | 网络异常导致远程服务失效 | 503 | 50301 | 请求第三方接口由于网络连接问题导致失败 |
| ApiResultError | 远程服务请求结果异常 | 503 | 50302 | 请求第三方结果返回 result 结果是 false |
| ApiNotAcceptable | 远程服务返回结果格式异常 | 503 | 50303 | 第三方接口返回 xml 格式结果，但预期返回 json 格式 |

- 客户端异常

| 错误类 | 说明 | http 状态码 | 返回错误码 | 场景举例 |
|  ------ |  ----  |  -----------  |  ----------  |  --------  |
| ParamValidationError | 参数验证失败 | 400 | 40000 | 期待为整形的参数，用户提供了一个字符参数 |
| ParamRequired | 请求参数缺失 | 400 | 40001 | 期待的参数找不到 |
| RioVerifyError | 登录请求经智能网关检测失败 | 401 | 40101 | 用户登录验证 |
| BkJwtVerifyError | 登录请求经 JWT 检测失败 | 401 | 40102 | 用户登录验证 |
| AccessForbidden | 登录失败 | 403 | 40301 | 用户身份验证失败 |
| RequestForbidden | 请求拒绝 | 403 | 40320 | 用户企图操作没有权限的任务 |
| ResourceLock | 请求资源被锁定 | 403 | 40330 | 用户企图操作一个已经锁定的任务 |
| ResourceNotFound | 找不到请求的资源 | 404 | 40400 | 找不到用户请求的某个指定 ID 的 model |
| MethodError | 请求方法不支持 | 405 | 40501 | 用户发送的请求不在预期范围内 |
