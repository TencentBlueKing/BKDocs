# PaaS 3.0 移动端开发

## 预先准备

1. 申请微信公众号
    - 公众号 AppID/AppSecret, 【“微信公众号 → 开发 → 基本配置 → 公众号开发信息”】
    - 测试可先申请微信公众号测试号：[https://mp.weixin.qq.com/debug/cgi-bin/sandboxinfo](https://mp.weixin.qq.com/debug/cgi-bin/sandboxinfo)
2. 申请应用外网域名
    - 建议同时申请 https 证书，后续需配置为 https
3. 配置公众号
    - 网页授权域名配置为应用外网域名【“微信公众号 → 设置 → 公众号设置 → 功能设置”】
    - JS 接口安全域名添加应用外网域名【“微信公众号 → 设置 → 公众号设置 → 功能设置”】


## 创建蓝鲸应用

* 基本配置请参考 “蓝鲸智云开发者中心——》新手指南”

## 开发配置

### 获取 framework_weixin_package.tar.gz

* 蓝鲸文档中心 > 下载资源 > [工具下载](../../../downloads/7.0/Index.md)

> framework_weixin_package.tar.gz 解压

* 确保开发框架版本为 1.1.0 及以上，推荐版本为 4.4.2.167 
    - 将 weixin 目录复制于工程目录下
    - 将 static/weixin 的 weixin 目录复制到工程 static 目录下
    - 将 templates/weixin 的 weixin 目录复制到工程 templates 目录下
* 修改工程 /weixin/core/settings.py 配置
    - USE_WEIXIN 为 True
    - WEIXIN_APP_ID 为申请的微信公众号的 AppID
    - WEIXIN_APP_SECRET 为申请的公众号的 AppSecret
    - WEIXIN_APP_EXTERNAL_HOST 为 申请的应用外网域名

### 修改工程配置文件

* 修改 conf/default.py 文件

```python
# 中间件 （MIDDLEWARE_CLASSES变量）添加
    # 添加到最前面
    'weixin.core.middlewares.WeixinProxyPatchMiddleware',
    # 正常追加到后面即可
    'weixin.core.middlewares.WeixinAuthenticationMiddleware',
    'weixin.core.middlewares.WeixinLoginMiddleware',
# INSTALLED_APPS 添加
    'weixin.core',
    'weixin',
# TEMPLATES （OPTIONS.context_processors）添加 'weixin.core.context_processors.basic'
    TEMPLATES = [
        {
            ...
            'OPTIONS': {
                'context_processors': [
                    # the context to the templates
                    'django.contrib.auth.context_processors.auth',
                    ...
                    # => 微信端可用的mako上下文变量
                    'weixin.core.context_processors.basic'
                ],
            },
        },
    ]

```

* 修改 urls.py 文件

```python
# urlpatterns 添加
    url(r'^weixin/login/', include('weixin.core.urls')),
    url(r'^weixin/', include('weixin.urls')),
```

## 蓝鲸应用

* 部署蓝鲸应用

## 运维配置

* 需要确保应用服务器能访问到微信 API （可以只设置微信 API 的代理）
    - 微信提供的 API 协议均为 https
    - 域名为 api.weixin.qq.com
* 反向代理，将应用外网域名的部分路径指向内网蓝鲸应用
    - 为了保证安全，必须只反方向代理部分路径
    - 应用正式环境反向代理：/o/{bk_app_id}/weixin/和/o/{bk_app_id}/static/weixin/
    - 应用测试环境反向代理：/t/{bk_app_id}/weixin/和/t/{bk_app_id}/static/weixin/
    - header 必需配置 X-Forwarded-Weixin-Host 为应用外网域名，Host 为蓝鲸内网域名
    - nginx 反向代理示例：

```json
server {
        listen              443；
        server_name        paas.external.bking.com; # 填写应用外网域名

        # https相关配置
        ssl                 on;
        ssl_certificate     demo.crt; # 配置对应crt
        ssl_certificate_key demo.key; # 配置对应key
        ssl_session_timeout  10m;
        ssl_session_cache shared:SSL:1m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; #按照这个协议配置
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;#按照这个套件配置
        ssl_prefer_server_ciphers on;

        # 假设bk_app_id = test_app，且配置应用的正式环境
        location ^~ /o/test_app/weixin/ {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $http_host;
            proxy_set_header X-Forwarded-Weixin-Host $http_host;
            proxy_redirect off;
            proxy_read_timeout 180;
            proxy_pass http://paas.bking.com;
        }
        location ^~ /o/test_app/static/weixin/ {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $http_host;
            proxy_set_header X-Forwarded-Weixin-Host $http_host;
            proxy_redirect off;
            proxy_read_timeout 180;
            proxy_pass http://paas.bking.com;
        }
        # 其他不做任何代理，直接返回404即可
        location / {
            return 404;
        }
}
```
## 测试是否 OK

* 直接手机微信访问  `https://外网域名/o/{bk_app_id}/weixin/`

## 基于微信公众号的移动端开发说明

> 测试 OK 后，接下来的开发与 PC 端的开发基本一致

* 微信端 CGI 请求都得以 `/o/{bk_app_id}/weixin/`（测试环境为：/o/{bk_app_id}/weixin/），若 Mako 模板渲染的页面，可直接使用 ${WEIXIN_SITE_URL}
* 微信端本地静态文件请求都得以 `/o/{bk_app_id}/static/weixin/`（测试环境为：/o/{bk_app_id}/static/weixin/），若 Mako 模板渲染的页面，可直接使用 ${WEIXIN_STATIC_URL}
* 若对于不需要微信登录认证的请求，可直接在对应的 View 函数添加装饰器 weixin_login_exempt（from weixin.core.decorators import weixin_login_exempt）
* 微信公众号登录的用户都存储在 BkWeixinUser 模型（from weixin.core.models import BkWeixinUser）中，即数据库表 bk_weixin_user
* 集成的微信登录默认是静默登录，只能获取用户 openid，其他信息需要设置为授权登录，可配置 weixin/core/settings.py 文件中的 WEIXIN_SCOPE 为 snsapi_userinfo
* view 函数中获取登录的用户方式：request.weixin_user 即为登录的用户的 BkWeixinUser 对象，具体 weixin_user 的属性等的可以查看 weixin/core/models.py 中的 BkWeixinUser

## 开箱即用的蓝鲸 MagicBox 组件（移动端版本）

* [Magic Box 移动端组件库](https://magicbox.bk.tencent.com/#mobile/show)

## 小程序开发入门

* 教程地址：[https://developers.weixin.qq.com/miniprogram/dev/index.html](https://developers.weixin.qq.com/miniprogram/dev/index.html)
* 测试号： [https://developers.weixin.qq.com/weloginpage](https://developers.weixin.qq.com/weloginpage)

## 小程序开发

* 一行代码制作将 H5 变为小程序

```html
<view>
  <web-view src="{{ url }}"></web-view>
</view>
```
