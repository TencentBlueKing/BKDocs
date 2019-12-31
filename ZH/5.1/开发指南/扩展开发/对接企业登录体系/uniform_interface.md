# 蓝鲸统一登录提供的基本函数接口说明

## 用户信息相关

```python
# 获取用户类 Model（即对应用户表）
from django.contrib.auth import get_user_model
user_model = get_user_model()

# 创建新用户
user = user_model.objects.create_user(username)
# 参数 username 表示用户名
# 返回一个 user_model 类的对象

# 用户角色
from bkaccount.constants import RoleCodeEnum
RoleCodeEnum.STAFF      # 普通用户
RoleCodeEnum.SUPERUSER  # 管理员
RoleCodeEnum.DEVELOPER  # 开发者
RoleCodeEnum.OPERATOR   # 职能化用户
RoleCodeEnum.AUDITOR    # 审计员
 
# 修改用户角色
result, message = user_model.objects.modify_user_role(role_code)
# 参数 role 为角色 Code, 可选择请看 RoleCodeEnum
# 返回元组(result, message)； result 为 boolean 类型，True/False , 即表示修改成功/修改失败；message 为 string 类型, 表示修改失败后的错误信息
```

## 登录相关

```python
# 蓝鲸登录的网址链接，如：http://{paas_domain}/login/
from django.conf import settings as bk_settings
bk_settings.LOGIN_COMPLETE_URL

# 用户实际请求的 URL 在请求中的 key, 目前是'c_url'
from bkaccount.accounts import Account
account = Account()
account.REDIRECT_FIELD_NAME
# 目前 account.REDIRECT_FIELD_NAME 为 c_url
# 获取用户实际请求的 URL
redirect_to = request.GET.get(account.REDIRECT_FIELD_NAME, '')

# 获取是否登录请求来自注销
is_from_logout = bool(request.GET.get('is_from_logout') or 0)

# 获取登录请求的蓝鲸应用或平台来源
app_id = request.GET.get('app_id', '')

# 跳转企业登录的响应
response = account.login_redirect_response(request, redirect_url, is_from_logout)
# 参数 request,  类型：django.http.HttpRequest
# 参数 redirect_url, 类型：string, 表示跳转到企业登录的 URL
# 参数 is_from_logout, 类型 boolean, 表示跳转前的请求是否来自注销
# 返回类型： django.http.HttpResponse

# 登录认证失败响应
response = account.login_failed_response(request, redirect_to, app_id)
# 参数 request,  类型：django.http.HttpRequest
# 参数 redirect_to, 类型：string, 表示用户实际请求的 URL
# 参数 app_id, 类型 string, 表示登录请求的蓝鲸应用或平台来源
# 返回类型： django.http.HttpResponse

# 登录成功响应
response = account.login_success_response(request, user, redirect_to, app_id)
# 参数 request,  类型：django.http.HttpRequest
# 参数 user, 类型： user_model即用户类，表示本次登录的用户
# 参数 redirect_to, 类型：string, 表示用户实际请求的 URL
# 参数 app_id, 类型 string, 表示登录请求的蓝鲸应用或平台来源
# 返回类型： django.http.HttpResponse
```

## 通用方法

```python
# 日志
from common.log import logger
logger.exception(message)
logger.info(message)
logger.error(message)
```
