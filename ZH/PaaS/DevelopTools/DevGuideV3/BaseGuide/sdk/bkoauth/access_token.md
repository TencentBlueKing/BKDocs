# bkoauth 获取 access_token

## 什么是 access_token

蓝鲸 API 服务使用 [OAuth 2.0](https://tools.ietf.org/html/rfc6749) 协议进行用户校验，access_token 是 API 服务的调用凭证，当需要验证 APP 或者用户时都需使用 access_token。APP 开发者需要进行妥善保存。

access_token 的有效期目前是 180 天（后期可能会修改）。APP 需要根据这个时间提前去刷新 access_token。在刷新过程中，蓝鲸 API 服务保证在刷新短时间内，新老 access_token 都可用，保证 APP 平滑过渡。

为了保密 APP 的 SECRET_KEY 和用户的登录态信息，APP 需要换取 access_token 调用 API 服务。换取的 access_token 根据是否带用户信息，可以分为两类：

- **APP access_token**：可用于校验 APP 身份
- **User access_token**：可同时用于校验 APP 和用户身份

bkoauth 可以非常方便帮助开发者获取，刷新 access_token。

## 添加配置

如内部版 APP, 在你的 Django 配置文件中添加如下配置项

```bash
# 蓝鲸 SSM 平台访问地址
OAUTH_API_URL = 'http://bkssmee.xxx.com'
OAUTH_COOKIES_PARAMS = {'bk_token': 'bk_token'}
```


## 请求新 access_token

针对两种类型的 token，bkoauth 提供了不同的方式来获取它们。

### 请求 User access_token

#### get_access_token(request)

获取当前登录用户的 access_token。

参数说明：

- `request`: Django request 对象，要求用户处于登录状态（非匿名用户）。

调用示例：

```python
from bkoauth import get_access_token

access_token = get_access_token(request)
```

默认情况下，该函数会返回一个 access_token 对象。包含以下属性：

- `access_token.access_token`: access_token 字符串
- `access_token.expires`: access_token 过期时间

出错时可能会抛出以下异常：

**bkoauth.exceptions.TokenAPIError**

与服务器的交互过程中发生了异常，建议稍候重试。

### 请求 APP access_token

#### get_app_access_token()

获取 APP access_token 对象。

调用示例:

```python
from bkoauth import get_app_access_token

access_token = get_app_access_token()
```

返回值与异常请参考 `get_access_token(request)` 函数

## 获取已保存的 access_token

### 根据用户名获取 token 对象

#### get_access_token_by_user(user_id)

使用用户名获取已保存的 access_token。

参数说明:

- `user_id`: 用户 ID 或用户名

调用示例:

```python
from bkoauth import get_access_token_by_user

access_token = get_access_token_by_user(user_id)
```

默认情况下，该函数会返回一个 access_token 对象。 出错时可能会抛出以下异常：

**bkoauth.exceptions.TokenNotExist**

Token 不存在时抛出，需要先调用 `get_access_token()` 函数生成 access_token。

## 刷新 access_token

### 刷新 APP access_token

开发者无需手动刷新 APP access_token， 过期后直接用 get_app_access_token() 函数换一个新的即可。

### 刷新 User access_token

#### refresh_token(access_token)

对于 User access_token, 蓝鲸 API 网关还会返回一个 refresh_token， 用于刷新即将过期的 access_token，bkoauth 已经封装了函数，直接调用刷新 access_token 即可

参数说明：

- **access_token**: access_token 对象，请使用 `get_access_token_by_user` 函数获取

调用示例：

```python
from bkoauth import refresh_token

access_token = refresh_token(access_token)
```

默认情况下，该函数会返回一个 access_token 对象。 出错时可能会抛出以下异常：

**bkoauth.exceptions.TokenNotExist**

没有找到 access_token。

**bkoauth.exceptions.TokenAPIError**

调用服务器 API 时出现错误，建议稍后重试。
