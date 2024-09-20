# bkoauth 校验蓝鲸 API 网关请求

### 为什么要校验蓝鲸 API 网关请求

1）APP 开发的接口，默认是没有任何限制的，接入到蓝鲸 API 网关后，应该限制只能由网关调用

2）其他人可以伪造网关的请求，甚至伪造 APP 和用户信息

蓝鲸 API 网关已经提供了一个解决方案， 每个网关都分配了唯一的一对公钥/私钥。APP 和用户的信息，都会以 [JWT](https://tools.ietf.org/html/rfc7519) 的格式放到 X-Bkapi-JWT 头部中，并且以网关私钥做签名，开发者需要使用对应的公钥做签名校验。

而 bkoauth 提供的装饰器，可以非常方便帮助开发者完成签名校验。

获取 API 网关公钥：

API Gateway -》 我的网关-》 基本信息 -》API 公钥(指纹) -》 复制

> 注意：请妥善保管好网关的公钥，如有泄密，请联系蓝鲸助手更换

### 添加配置

安装好 bkoauth 后， 在你的 Django 配置文件中配置 APIGW_PUBLIC_KEY 为获取的公钥：

```python
APIGW_PUBLIC_KEY = '''
-----BEGIN PUBLIC KEY-----
xxx
xxx
xxx
-----END PUBLIC KEY-----
'''
```

### 在 views 中添加装饰器

```python
from bkoauth.decorators import apigw_required
from account.decorators import login_exempt

@login_exempt
@apigw_required
def api_debug(request):
    request.jwt.app.app_code  # 获取app_code
    request.jwt.user.username  # 获取用户
```
添加 login_except 免登录验证， 因为 API Gateway 都是不带登录态信息的

添加 apigw_required，如果验证通过是 API Gateway 合法的请求，request 对象有添加一个 jwt 对象

使用 apigw_required，需要在 requirements.txt 中添加以下依赖
```bash
PyJWT==1.4.2
cryptography>=1.5.0
```
