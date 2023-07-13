# SaaS 开发相关

### 基于蓝鲸SaaS开发框架进行前后台分离开发实践

[如何进行前后端分离开发](../topics/paas/multi_modules/separate_front_end_dev.md)

### 应用内如何获取请求客户端`IP`地址

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

### `django`如何对通过接口请求的数据进行`gzip`压缩

1. 添加`django.middleware.gzip.GZipMiddleware`中间件。
2. 在视图文件中添加`from django.views.decorators.gzip import gzip_page`。
3. 给视图函数添加上`@gzip_page`装饰器，返回的数据将会被压缩。

### 本地访问前端，{{ SITE_URL }} Django 模版语法未生效

查检本地环境dev.py内是否有SITE_URL='xxx'的定义，如没有，请在本地环境dev.py里添加SITE_URL='xxx' 变量即可。

