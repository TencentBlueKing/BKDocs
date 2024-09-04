# 如何进行前后端分离开发

## 概述

前端以 [蓝鲸应用前端开发框架(BKUI-CLI)](../../company_tencent/vue_framework_usage.md) 为例，使用 NodeJS + Vue.js 实现，前端作为应用默认的访问入口，放到 **default** 模块中。

后端以 [蓝鲸应用开发框架](../../company_tencent/python_framework_usage.md) 为例，提供 Python + Django 的 REST API 服务，放到 **backend-api** 模块中。

前后端模块所绑定的源码仓库、增强服务都是隔离的，可以独立的开发、部署前后端模块。

## 创建前后端模块

### 创建应用

首先，我们在蓝鲸开发者中心创建一个 NodeJS 应用，并用`蓝鲸应用前端开发框架`初始化代码。创建成功后，在模块管理页面中，我们可以看到刚刚创建的 NodeJS 应用放到了默认的 **default** 模块中。

应用部署成功后，我们可以访问到一个纯前端的应用。其中，用户信息的接口是由前端模块提供的。接下来我们将创建一个后端模块来提供这个 API 服务。


### 创建后端模块

点击模块下拉框中的 `新增模块` 来创建一个后端的 Python 模块，并用`蓝鲸开发框架`初始化代码。

后端 **backend-api**  模块部署成功后，就可以访问框架默认提供的用户接口：`account/get_user_info/`。


### 用户信息修改为后端 API

修改前端模代码，改为调用后端模块的 API，实现前后端分离：

- 在  *build/stag.env.js* 文件中将 **AJAX_URL_PREFIX** 设置为后端模块的域名：`http://stag-dot-backend-api-dot-{your-appid}.bking.com`

- 在 *src/store/index.js* 中将获取用户信息的接口修改为调用后端模块的 API

**注意**：这里以修改预发布环境配置为例，您可以在 *build/dev.env.j*s 中修改本地开发的配置，在 *build/prod.env.js* 中修改正式环境的配置

![前端代码修改项](../../../images/multi_modules/modify.png)

修改完成后，可以按照前端模块中 `README.md` 文件中的步骤将前端模块在本地运行起来，或者在开发中心重新部署前端模块。

## 后端模块跨域配置
由于前后端模块是独立部署的，如果独立的域名访问的话，有会跨域的问题，部分浏览器会有阻止跨域访问的特性，导致请求失败。所以需要修改后台配置，允许进行跨域访问。
- 前端模块域名：`stag-dot-{your-appid}.bkapps.bking.com`
- 后端模块域名：`stag-dot-backend-api-dot-{your-appid}.bkapps.bking.com`

具体的配置如下：

1.`requirements.txt` 中添加 CORS 依赖包，包的版本可以参考[django-cors-headers history](https://github.com/adamchainz/django-cors-headers/blob/master/HISTORY.rst)
- Python2 建议使用 `django-cors-headers==3.0.2` 
- Python3 建议使用最新版本

2.`config/default.py` 中添加 CORS 配置

更多 CORS 配置 可以参考：[官方文档](https://github.com/adamchainz/django-cors-headers)

```bash
# 请在这里加入你的自定义 APP
INSTALLED_APPS += (
    'home_application',
    'mako_application',
    # 添加跨域配置
    'corsheaders',
)

# 自定义中间件
MIDDLEWARE = (
    # CorsMiddleware 尽量放在靠前的位置
    # 特别是在任何可以生成响应的中间件之前，例如Django的CommonMiddleware
    'corsheaders.middleware.CorsMiddleware',
) + MIDDLEWARE

# 配置 CORS 白名单列表
CORS_ORIGIN_WHITELIST = [
    'http://your-domain-1:<your-port>',
    ...
    'https://your-domain-n:<your-port>',
]

# 如果不确定需要追加的具体域名, 可以先配置以下的正则白名单, 但在生产环境下建议准确配置相关的域名
CORS_ORIGIN_REGEX_WHITELIST = [
    r"http://.*\.com",
]

# 在 response 添加 Access-Control-Allow-Credentials, 即允许跨域使用 cookies
CORS_ALLOW_CREDENTIALS = True

# 对于开启了独立子域名(新应用默认开启)的应用, 需要将 CSRF_TOKEN 写在根域名下, 否则前端项目无法获取对应的 cookies
CSRF_COOKIE_DOMAIN = ".bking.com"
```

后台模块修改完成后，在开发者中心重新部署。我们就可以正常访问应用了。

应用默认的访问地址为主模块的地址，所以我们在浏览器上访问的是前端模块的域名；前端模块访问后端模块提供的 API。
