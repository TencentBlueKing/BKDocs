# 说明

本文档对应版本: 蓝鲸 6.0

蓝鲸统一登录: 由 `open_paas/login` 提供 `统一登录服务`; 由 `用户管理` App `维护用户数据`

## MockBackend 接入示例

### 获取参考代码

蓝鲸版本包中 `open_paas/login/ee_official_login/mock`, 包含了 MockBackend 接入示例

这个示例复用了默认蓝鲸登录的页面, 但是重写了登录逻辑

使用固定的用户名密码才能登录成功:  `admin/blueking`

### 目录结构及配置说明

`open_paas/login` 下涉及的文件

```bash
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
# 企业内部 Username-password 登录方式：enterprise_ldap
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


### 登录代码简要说明

#### `ee_login/settings_login_mock.py`

```python
# 表示是自定义登录
LOGIN_TYPE = 'custom_login'

# 登录请求处理函数, 需要处理 1) GET跳往登录页 2) POST执行登录校验 3) 其他请求, 例如oauth回调请求
CUSTOM_LOGIN_VIEW = 'ee_official_login.mock.views.login'
# 登录认证函数
CUSTOM_AUTHENTICATION_BACKEND = 'ee_official_login.mock.backends.MockBackend'
```

#### `ee_official_login/mock/views.py`

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

#### `ee_official_login/mock/backends.py`

基于 Django authentication backend, 具体可以参考 [官方文档](https://docs.djangoproject.com/en/2.2/topics/auth/customizing/)

MockBackend 中的逻辑是, 只用使用固定用户名密码才能登录成功

在 backend 中, 拿到表单的数据之后, 可以自行定义登录逻辑, 例如请求企业的第三方登录进行校验, 校验成功后获取用户数据, 构建蓝鲸用户, 并同步给 `用户管理`

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
        user = UserModel()
        user.username = username
        user.display_name = "mockadmin"
        user.email = "mockadmin@mock.com"

        # 同步用户到用户管理 sync to usermgr
        # 这里不做调用
        # ok, message = user.sync_to_usermgr()
        ok, message = True, "success"
        if not ok:
            logger.error("login success, but sync user to usermgr fail: %s", message)
            return None

        return user
```

## Google OAuth 接入示例

### 获取参考代码

蓝鲸版本包中 `ee_official_login/oauth/google`, 包含了 Google OAuth 接入示例

这个示例展示了对接 Google OAuth 的具体逻辑, 相对复杂, 需要根据请求参数处理回调

调试过程中, 可以查看日志中的 debug 信息

### 目录结构及配置说明

`open_paas/login` 下涉及的文件

```bash
conf/default.py            配置文件如后, 会import ee_login.settings_login 获取登录配置

ee_login/                  自定义登录配置
├── __init__.py
└── settings_login.py      配置了 ee_official_login/mock

ee_official_login/oauth/google  自定义登录实现, 完成了校验逻辑
├── __init__.py
├── backends.py
├── settings.py                 Google OAuth配置
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

配置变更完毕后, 重启登录服务, 访问登录页, 此时将只用使用 `admin/blueking` 才能登录成功

登录过程中会打 debug 日志, 本地开发环境: `../logs/login.log` 使用蓝鲸部署脚本部署环境: `{INSTALL_ROOT}/logs/open_paas/login.log`
