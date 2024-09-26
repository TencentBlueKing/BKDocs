# PaaS 3.0 mobile development

## Pre-preparation

1. Apply for WeChat official account
- Official account AppID/AppSecret, [“WeChat official account → Development → Basic configuration → Official account development information”]
- For testing, you can first apply for WeChat official account test account: [https://mp.weixin.qq.com/debug/cgi-bin/sandboxinfo](https://mp.weixin.qq.com/debug/cgi-bin/sandboxinfo)
2. Apply for application external network domain name
- It is recommended to apply for https certificate at the same time, and it needs to be configured as https later
3. Configure official account
- Configure the web page authorization domain name as the application external network domain name [“WeChat official account → Settings → Official account settings → Function settings”]
- JS interface security domain name adds the application external network domain name [“WeChat official account → Settings → Official account settings → Function settings”]

## Create BlueKing application

* For basic configuration, please refer to "BlueKing Zhiyun Developer Center ——》Beginner's Guide"

## Development Configuration

### Get framework_weixin_package.tar.gz

* BlueKing Document Center > Download Resources > [Tool Download](../../../downloads/7.0/Index.md)

> Unzip framework_weixin_package.tar.gz

* Make sure the development framework version is 1.1.0 or above, the recommended version is 4.4.2.167
    - Copy the weixin directory to the project directory
    - Copy the weixin directory of static/weixin to the static directory of the project
    - Copy the weixin directory of templates/weixin to the templates directory of the project
* Modify the configuration of project/weixin/core/settings.py
    - USE_WEIXIN is True
    - WEIXIN_APP_ID is the AppID of the applied WeChat public account
    - WEIXIN_APP_SECRET AppSecret for the public account you applied for
    - WEIXIN_APP_EXTERNAL_HOST is the external domain name of the application you applied for

### Modify the project configuration file

* Modify the conf/default.py file

```python
# Middleware (MIDDLEWARE_CLASSES variable) added
    # Add to front
    'weixin.core.middlewares.WeixinProxyPatchMiddleware',
    # Just append it normally
    'weixin.core.middlewares.WeixinAuthenticationMiddleware',
    'weixin.core.middlewares.WeixinLoginMiddleware',
# INSTALLED_APPS add
    'weixin.core',
    'weixin',
# TEMPLATES （OPTIONS.context_processors）add 'weixin.core.context_processors.basic'
    TEMPLATES = [
        {
            ...
            'OPTIONS': {
                'context_processors': [
                    # the context to the templates
                    'django.contrib.auth.context_processors.auth',
                    ...
                    # => Mako context variables available on WeChat
                    'weixin.core.context_processors.basic'
                ],
            },
        },
    ]

```

* Modify the urls.py file

```python
# urlpatterns add
    url(r'^weixin/login/', include('weixin.core.urls')),
    url(r'^weixin/', include('weixin.urls')),
```

## BlueKing Application

* Deploy BlueKing Application

## Operation and Maintenance Configuration

* You need to ensure that the application server can access the WeChat API (you can only set up a proxy for the WeChat API)
    - The API protocol provided by WeChat is https
    - The domain name is api.weixin.qq.com
* Reverse proxy, point part of the path of the application's external domain name to the internal BlueKing application
    - To ensure security, only part of the path must be proxyed in the reverse direction
    - Reverse proxy for the application's formal environment: /o/{bk_app_id}/weixin/ and /o/{bk_app_id}/static/weixin/
    - Reverse proxy for the application's test environment: /t/{bk_app_id}/weixin/ and /t/{bk_app_id}/static/weixin/
    - The header must be configured with X-Forwarded-Weixin-Host as the application's external domain name, and Host as the BlueKing internal domain name
    - Nginx reverse proxy example:

```json
server {
        listen              443；
        server_name        paas.external.bking.com; # Fill in the application external domain name

        # https related configuration
        ssl                 on;
        ssl_certificate     demo.crt; # Configure the corresponding crt
        ssl_certificate_key demo.key; # Configure the corresponding key
        ssl_session_timeout  10m;
        ssl_session_cache shared:SSL:1m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; #According to this protocol configuration
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;#According to this kit configuration
        ssl_prefer_server_ciphers on;

        # Assume that bk_app_id = test_app and configure the formal environment of the application
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
        # Otherwise, no proxy is used and 404 is returned directly.
        location / {
            return 404;
        }
}
```
## Test whether it is OK

* Directly access `https://external domain name/o/{bk_app_id}/weixin/` with WeChat on your mobile phone

## Mobile terminal development instructions based on WeChat official account

> After the test is OK, the subsequent development is basically the same as the development on the PC side

* WeChat CGI requests can be `/o/{bk_app_id}/weixin/` (test environment: /o/{bk_app_id}/weixin/), if the page is rendered by Mako template, you can directly use ${WEIXIN_SITE_URL}
* WeChat local static file requests can be `/o/{bk_app_id}/static/weixin/` (test environment: /o/{bk_app_id}/static/weixin/), if the page is rendered by Mako template, you can directly use ${WEIXIN_STATIC_URL}
* For requests that do not require WeChat login authentication, you can directly add decorators to the corresponding View function weixin_login_exempt（from weixin.core.decorators import weixin_login_exempt）
* Users logged in to WeChat official accounts are stored in the BkWeixinUser model（from weixin.core.models import BkWeixinUser）, that is, the database table bk_weixin_user
* The integrated WeChat login is silent login by default, and can only obtain the user openid. Other information needs to be set to authorized login. You can configure WEIXIN_SCOPE in the weixin/core/settings.py file to snsapi_userinfo
* How to get the logged-in user in the view function: request.weixin_user is the BkWeixinUser object of the logged-in user. The specific properties of weixin_user can be viewed in BkWeixinUser in weixin/core/models.py

## Out-of-the-box BlueKing MagicBox component (mobile version)

* [Magic Box Mobile component library](https://magicbox.bk.tencent.com/#mobile/show)

## Getting started with mini program development

* Tutorial address: [https://developers.weixin.qq.com/miniprogram/dev/index.html](https://developers.weixin.qq.com/miniprogram/dev/index.html)

* Test number: [https://developers.weixin.qq.com/weloginpage](https://developers.weixin.qq.com/weloginpage)

## Mini program development

* One line of code to turn H5 into a mini program

```html
<view>
<web-view src="{{ url }}"></web-view>
</view>
```