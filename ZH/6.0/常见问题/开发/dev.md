# 开发常见问题

## 开发环境与配置类

### pip install 安装某个包时，提示包未找到

可能是仓库源配置问题。建议使用腾讯云提供的 PYPI 源: `mirrors.cloud.tencent.com/pypi/simple/`

## 用户与鉴权相关

### 如何模拟登录蓝鲸框架，需要哪些值

只要确保 cookie 中的 bk_ticket 和 bk_uid 一样，就可以复用同样的登录态

## SaaS 开发框架相关

### 如何判断开发框架当前加载的是那个配置文件？能否自己指定

1\. 三种配置文件分别对应：本地开发时，加载 dev；预发布环境下，加载 stag；正式环境下，加载 prod。

2\. 不能指定，因为框架写死通过运行环境加载。

### 如何确认当前框架所在的运行环境

可以使用 `RUN_MODE` 变量，它被定义在 `dev.py / stag.py / prod.py` 文件的开头位置。
```python
from django.conf import settings
settings.RUN_MODE
```

### 蓝鲸框架在哪里添加全局配置

可以在 `conf` 目录下的 `default.py` 文件里添加自定义全局配置。

## SaaS 开发相关

### 应用内如何获取请求客户端 IP 地址

请求在到达到应用前，会经过多层负载均衡服务。如果应用直接拿请求 IP 作为客户端 IP，通常是有问题的，因为这个 IP 是负载均衡器 IP，而非真实客户端 IP。想要获取真实 IP，需要解析请求头信息里的 `X-Forwarded-For` 字段。

`X-Forwarded-For` 头信息里包含的是以 , 连接的 IP 地址列表，如 `8.8.8.8,4,4,4,4`。第一个 `8.8.8.8` 就是客户端 IP。

下面是一段在 Django 框架内获取客户端 IP 的代码样例：
```python
def get_client_ip(request):
    """Get real client IP address from request
    """
    # Try "x-forwarded-for" header
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        return x_forwarded_for.split(',')[0].strip()
    return request.META.get('REMOTE_ADDR')
```

### django 如何对通过接口请求的数据进行 gzip 压缩

1\. 添加 `django.middleware.gzip.GZipMiddleware` 中间件。

2\. 在视图文件中添加 `from django.views.decorators.gzip import gzip_page`。

3\. 给视图函数添加上 `@gzip_page` 装饰器，返回的数据将会被压缩。

### 本地访问前端，{{ SITE_URL }} Django 模版语法未生效

查检本地环境 dev.py 内是否有 `SITE_URL='xxx'` 的定义，如没有，请在本地环境 dev.py 里添加 `SITE_URL='xxx'` 变量即可。
