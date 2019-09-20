## 说明 

本文档对应版本: 企业版 2.5

蓝鲸统一登录: 由 `open_paas/login` 提供 `统一登录服务`; 由 `用户管理` App `维护用户数据`


### MockBackend接入示例 

#### 1. 获取参考代码

蓝鲸版本包中 `open_paas/login/ee_official_login/mock`, 包含了 MockBackend 接入示例

这个示例复用了默认蓝鲸登录的页面, 但是重写了登录逻辑

使用固定的用户名密码才能登录成功:  `admin/blueking`


#### 2. 目录结构及配置说明

`open_paas/login` 下涉及的文件

```
conf/default.py            配置文件如后, 会 import ee_login.settings_login 获取登录配置

ee_login/                  自定义登录配置
├── __init__.py
└── settings_login.py      配置了 ee_official_login/mock

ee_official_login/mock     自定义登录实现, 完成了校验逻辑, 并
├── __init__.py
├── backends.py
└── views.py
```

- `conf/default.py` 代码已存在, 不需要变更
- ee_login 目录默认没有, 需要自行新建, 注意务必新建 `__init__.py`

```shell
mkdir ee_login
touch ee_login/__init__.py
touch ee_login/settings_login.py
```

- `ee_login/settings_login.py` 内容

```python
# -*- coding: utf-8 -*-
# 蓝鲸登录方式：bk_login
# 企业内部Username-password登录方式：enterprise_ldap
# 自定义登录方式：custom_login
LOGIN_TYPE = 'custom_login'

# 默认 bk_login，无需设置其他配置

###########################
# 自定义登录 custom_login   #
###########################
# 配置自定义登录请求和登录回调的响应函数, 如：CUSTOM_LOGIN_VIEW = 'ee_official_login.oauth.google.views.login'
CUSTOM_LOGIN_VIEW = 'ee_official_login.mock.views.login'
# 配置自定义验证是否登录的认证函数, 如：CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.oauth.google.backends.OauthBackend'
CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.mock.backends.MockBackend'
```

配置变更完毕后, 重启登录服务, 访问登录页, 此时将只用使用 `admin/blueking` 才能登录成功

登录过程中会打 debug 日志, 本地开发环境: `../logs/login.log` 使用蓝鲸部署脚本部署环境: `{INSTALL_ROOT}/logs/open_paas/login.log`


#### 3. 登录代码简要说明

##### 3.1 `ee_login/settings_login_mock.py`

```python
# 表示是自定义登录
LOGIN_TYPE = 'custom_login'

# 登录请求处理函数, 需要处理 1) GET跳往登录页 2) POST执行登录校验 3) 其他请求, 例如oauth回调请求
CUSTOM_LOGIN_VIEW = 'ee_official_login.mock.views.login'
# 登录认证函数
CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.mock.backends.MockBackend'
```

##### 3.2 `ee_official_login/mock/views.py`

主要处理

1. GET 跳往登录页
2. POST 执行登录校验
3. 其他请求, 例如 oauth 回调, 可以根据请求参数判断做特殊处理

这里, 可以自定义登录页面, 以及登录请求的处理逻辑


```python
def login(request):
    """
    登录处理
    """
    # 获取 ?c_url=xxx 登录成功跳转目的地址
    redirect_to = request.GET.get(REDIRECT_FIELD_NAME, '')

    # 复用bkauth的登录页面
    # POST 请求
    if request.method == "POST":
        # 获取用户名密码
        form = BkAuthenticationForm(request, data=request.POST)

        username = form.data["username"]
        password = form.data["password"]

        # 执行校验
        # will call MockBackend.authenticate
        user = authenticate(username=username, password=password)

        # 失败
        if user is None:
            logger.debug("custom_login:mock user is None, will redirect_to=%s", redirect_to)
            # 直接调用蓝鲸登录失败处理方法
            return login_failed_response(request, redirect_to, app_id=None)

        # 成功，则调用蓝鲸登录成功的处理函数，并返回响应
        logger.debug("custom_login:mock login success, will redirect_to=%s", redirect_to)
        return login_success_response(request, user, redirect_to, app_id=None)
    # GET
    else:
        # 构造前端表单需要的数据
        form = BkAuthenticationForm(request)
        current_site = get_current_site(request)
        context = {
            'form': form,
            REDIRECT_FIELD_NAME: redirect_to,
            'site': current_site,
            'site_name': current_site.name,

            # set to default; 复用account/login.html表单
            'error_message': "",
            'app_id': "",
            'is_license_ok': True,
            'reset_password_url': "",
            'login_redirect_to': "",
        }

        # 跳转登录页
        template_name = 'account/login.html'
        response = TemplateResponse(request, template_name, context)

        # 清空 bk_token
        response = set_bk_token_invalid(request, response)
        return response
```

##### 3.3 `ee_official_login/mock/backends.py`

基于 django authentication backend, 具体可以参考 [官方文档](https://docs.djangoproject.com/en/1.8/topics/auth/customizing/)

MockBakcned 中的逻辑是, 只用使用固定用户名密码才能登录成功

在backend中, 拿到表单的数据之后, 可以自行定义登录逻辑, 例如请求企业的第三方登录进行校验, 校验成功后获取用户数据, 构建蓝鲸用户, 并同步给 `用户管理`

需要自定义的逻辑

1. 获取表单数据
2. 自定义校验逻辑, 可以调用第三方服务进行校验
3. 校验失败, `logger.debug` 并 `return None`
4. 校验成功, 获取用户数据; 如果第 2 步校验接口有返回用户数据, 可以直接使用, 如果没有, 需要请求第三方服务获取用户信息
5. 构建蓝鲸用户 User
6. 同步用户数据到 `用户管理`; `user.sync_to_usermgr()` 将会调用接口, 新增或更新用户数据, `username` 为用户唯一标识

```python
class MockBackend(ModelBackend):
    """
    mock认证服务

    username == "admin" 且 password == "blueking" 时认证通过

    注意: 打logger.debug用于调试, 可以在日志路径下login.log查看到对应日志
    """
    def authenticate(self, username=None, password=None):
        if not (username == "admin" and password == "blueking"):
            logger.debug("MockBackend authenticate fail, username/password should be admin/blueking")
            return None

        # 获取 User 类
        UserModel = get_user_model()
        # 初始化User对象 -> bkauth/models.py:User -> 从userinfo获取对应字段进行初始化
        user = UserModel(username,
                         display_name="mockadmin",
                         email="mockadmin@mock.com",
                         )

        # 同步用户到用户管理 sync to usermgr
        # 这里不做调用
        # ok, message = user.sync_to_usermgr()
        ok, message = True, "success"
        if not ok:
            logger.error("login success, but sync user to usermgr fail: %s", message)
            return None

        return user
```


### Google OAuth 接入示例 


#### 1. 获取参考代码

蓝鲸版本包中 `ee_official_login/oauth/google`, 包含了 Google OAuth 接入示例

这个示例展示了对接 Google OAuth 的具体逻辑, 相对复杂, 需要根据请求参数处理回调

调试过程中, 可以查看日志中的 debug 信息

#### 2. 目录结构及配置说明

`open_paas/login` 下涉及的文件

```
conf/default.py            配置文件如后, 会import ee_login.settings_login 获取登录配置

ee_login/                  自定义登录配置
├── __init__.py
└── settings_login.py      配置了 ee_official_login/mock

ee_official_login/oauth/google  自定义登录实现, 完成了校验逻辑
├── __init__.py
├── backends.py
├── settings.py                 google OAuth配置
├── utils.py
└── views.py
```

- `conf/default.py` 代码已存在, 不需要变更
- ee_login 目录默认没有, 需要自行新建, 注意务必新建 `__init__.py`

```shell
mkdir ee_login
touch ee_login/__init__.py
touch ee_login/settings_login.py
```

- `ee_login/settings_login.py` 内容

```python
# -*- coding: utf-8 -*-
# 蓝鲸登录方式：bk_login
# 企业内部Username-password登录方式：enterprise_ldap
# 自定义登录方式：custom_login
LOGIN_TYPE = 'custom_login'

# 默认 bk_login，无需设置其他配置

###########################
# 自定义登录 custom_login   #
###########################
# 配置自定义登录请求和登录回调的响应函数, 如：CUSTOM_LOGIN_VIEW = 'ee_official_login.oauth.google.views.login'
CUSTOM_LOGIN_VIEW = 'ee_official_login.oauth.google.views.login'
# 配置自定义验证是否登录的认证函数, 如：CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.oauth.google.backends.OauthBackend'
CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.oauth.google.backends.OauthBackend'
```

配置变更完毕后, 重启登录服务, 访问登录页, 此时将只用使用`admin/blueking`才能登录成功

登录过程中会打 debug 日志, 本地开发环境: `../logs/login.log` 使用蓝鲸部署脚本部署环境: `{INSTALL_ROOT}/logs/open_paas/login.log`





## 说明

本文档对应版本: 企业版 2.4 及社区版

蓝鲸统一登录: 由 `open_paas/login` 提供 `统一登录服务` 并且 `维护用户数据`


### 开发步骤

> 对于自定义登录模块，我们需要编写一个企业内部统一登录认证票据的类和一个登录跳转等逻辑处理函数，可参考 open_paas/login/ee_official_login/oauth/google 模块

### 1. 获取参考代码 

参考代码在蓝鲸版本包里的 open_paas/login/ee_official_login，包含了google oauth 对接蓝鲸登录样例

### 2. 编写企业内部统一登录认证票据的类 

> 该类主要是对企业内部统一登录认证票据进行认证，并获取相关用户信息，生成和设置蓝鲸用户
> 该类需继承于 Django 内置的 ModelBackend，并实现自定义认证方法 authenticate

##### 2.1 自定义认证方法 authenticate 实现逻辑

1. 输入参数为企业认证票据（可自定义，可多个参数）
2. 根据企业认证票据，调用企业内部登录 API 进行认证，并获取用户信息
3. 根据用户信息，获取或生成蓝鲸用户类的对象，并根据需要设置蓝鲸用户相关信息和角色
4. 返回参数为蓝鲸用户类的对象

##### 2.2 接入 Google 登录

- 参考代码【open_paas/login/ee_official_login/oauth/google/backends.py】

```python
# -*- coding: utf-8 -*-
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model

from common.log import logger
from .utils import get_access_token, get_scope_data


class OauthBackend(ModelBackend):
    """
    自定义认证方法
    """
    def authenticate(self, code=None):
        # Google登录验证
        try:
            # 调用接口验证 CODE，并获取 access_token
            access_token = get_access_token(code)
            if not access_token:
                return None
            # 通过 access_token 获取用户信息
            userinfo = get_scope_data(access_token)
            if not userinfo:
                return None
            username = userinfo.get('username')
            # 验证通过，获取 User 对象
            user_model = get_user_model()
            try:
                user = user_model.objects.get(username=username)
            except user_model.DoesNotExist:
                # 创建User对象
                user = user_model.objects.create_user(username)
                # 获取用户信息，只在第一次创建时设置，已经存在不更新
                chname = userinfo.get('chname', '')
                phone = userinfo.get('phone', '')
                email = userinfo.get('email', '')
                user.chname = chname
                user.phone = phone
                user.email = email
                user.save()
                # note: 可根据需要设置用户角色, user_model.objects.modify_user_role(...)
            # note: 可根据需要每次都更新用户信息等，或每次都更新用户角色等
            return user
        except Exception:
            logger.exception("Google login backend validation error!")
        return None
```

### 3. 编写登录跳转等登录处理逻辑函数 

> 该函数需要处理 5 种情况：
>     1. 企业登录票据不存在
>     2. 登录请求来自注销
>     3. 企业登录票据存在（企业登录成功后回调或票据本身已存在）
>     4. 企业登录票据无效
>     5. 企业登录票据认证成功

##### 3.1 登录处理逻辑函数 login 实现逻辑

1. 输出参数：request, 为 Django 内置的 http 请求对象
2. 获取用户初始请求的 URL 和用户初始请求的应用，以及蓝鲸登录请求的来源
3. 获取企业用户认证票据，可以是从 GET 参数，也可以是 Cookies 中
4. 若无企业登录票据或登录请求来源于注销，则重定向到企业登录
5. 若存在企业登录票据，则调用之前编写的自定义企业认证进行验证
6. 若企业登录票据无效，则清除企业登录票据（cookies 则需要清除），并重定向蓝鲸登录
7. 若企业登录票据有效，则重定向到用户初始请求

##### 3.2 接入 Google 登录

- 参考代码【open_paas/login/ee_official_login/oauth/google/views.py】

```python
# -*- coding: utf-8 -*-
import urlparse

from django.contrib.auth import authenticate

from bkaccount.accounts import Account
from .utils import gen_oauth_login_url


def login(request):
    """
    登录处理
    """
    account = Account()
    # 获取用户实际请求的 URL, 目前 account.REDIRECT_FIELD_NAME = 'c_url'
    redirect_to = request.GET.get(account.REDIRECT_FIELD_NAME, '')
    # 获取用户实际访问的蓝鲸应用
    app_id = request.GET.get('app_id', '')

    # 来自注销
    is_from_logout = bool(request.GET.get('is_from_logout') or 0)

    # google 登录回调后会自动添加 code 参数
    code = request.GET.get('code')
    # 若没有code参数，则表示需要跳转到 google 登录
    if code is None or is_from_logout:
        # 生成跳转到 google 登录的链接
        google_oauth_login_url, state = gen_oauth_login_url({
            'app_id': app_id,
            account.REDIRECT_FIELD_NAME: redirect_to
        })
        # 将state 设置于 session，Oauth2.0 特有的，防止 csrf 攻击的
        request.session['state'] = state
        # 直接调用蓝鲸登录重定向方法
        response = account.login_redirect_response(request, google_oauth_login_url, is_from_logout)
        return response

    # 已经有企业认证票据参数（如 code 参数），表示企业登录后的回调或企业认证票据还存在
    # oauth2.0 特有处理逻辑，防止 csrf 攻击
    # 处理 state 参数
    state = request.GET.get('state', '')
    state_dict = dict(urlparse.parse_qsl(state))
    app_id = state_dict.get('app_id')
    redirect_to = state_dict.get(account.REDIRECT_FIELD_NAME, '')
    state_from_session = request.session.get('state')
    # 校验 state，防止 csrf 攻击
    if state != state_from_session:
        return account.login_failed_response(request, redirect_to, app_id)

    # 验证用户登录是否 OK
    user = authenticate(code=code)
    if user is None:
        # 直接调用蓝鲸登录失败处理方法
        return account.login_failed_response(request, redirect_to, app_id)
    # 成功，则调用蓝鲸登录成功的处理函数，并返回响应
    return account.login_success_response(request, user, redirect_to, app_id)
```

### 4. 设置自定义登录 

##### 4.1 检查是否有自定义接入企业登录模块 ee_login

1. 检查 open_paas/login/ 是否有 ee_login 模块
2. 若无，则添加 ee_login 模块
    - 创建 ee_login 目录
    - 在 ee_login 目录下添加空文件 __init__.py
    - 在 ee_login 目录下添加文件 settings_login.py，文件内容如下

```python
# -*- coding: utf-8 -*-
# 蓝鲸登录方式：bk_login
# 企业内部 Username-password 登录方式：enterprise_ldap
# 自定义登录方式：custom_login
LOGIN_TYPE = 'bk_login'

# 默认 bk_login，无需设置其他配置

##################################################
# 企业内部 Username-password 登录 enterprise_ldap    #
# 该方式需要自行搭建对接蓝鲸登录和企业内部登录的中间服务   #
#################################################
# 对接企业内部登录的服务 URL
# 对应验证 API URL: ACCESS_LOGIN_SERVICE_URL+'validate_user/' 对应获取用户信息 API URL: ACCESS_LOGIN_SERVICE_URL+'get_user_info/'
ACCESS_LOGIN_SERVICE_URL = ''  # 例如： http://127.0.0.1:12306/
# 接口鉴权用的secret key，自行约定，保证接口能调用成功即可
ACCESS_LOGIN_SERVICE_API_SECRET_KEY = ''
# 请求接口默认超时时间，单位毫秒(ms)，默认 1.5s
ACCESS_LOGIN_SERVICE_API_REQUEST_TIMEOUT = 1500


###########################
# 自定义登录 custom_login   #
###########################
# 配置自定义登录请求和登录回调的响应函数, 如：CUSTOM_LOGIN_VIEW = 'ee_official_login.oauth.google.views.login'
CUSTOM_LOGIN_VIEW = ''
# 配置自定义验证是否登录的认证函数, 如：CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.oauth.google.backends.OauthBackend'
CUSTOM_AUTHENTICATION_BACKEND = ''
```

##### 4.2 添加已开发完成的接入企业登录模块 xxxx（包含企业内部统一登录认证票据的类和登录等逻辑处理函数）
将已开发完成的接入企业登录模块 xxxx 添加到 open_paas/login/ee_login 下

##### 4.3 修改自定义企业登录配置文件
修改 open_pass/login/ee_login/settings_login.py
1. 将 LOGIN_TYPE 改为 custom_login
2. 将 CUSTOM_LOGIN_VIEW 修改为 登录等逻辑处理函数路径，如：ee_login.xxxx.views.login
3. 将 CUSTOM_AUTHENTICATION_BACKEND 修改为 企业内部统一登录认证票据的类路径，如：ee_login.xxxx.backends.XxxBackend

##### 4.4 重启服务
更新或添加 ee_login，重启 open_paas 服务

