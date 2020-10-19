# 企业内部系统接入蓝鲸登录

## 登录态共享

蓝鲸登录态: 基于一级域名共享 cookie 的方式

- 登录服务 与 接入系统 必须处于同一个一级域名下, 假设登录服务 `http://paas.bking.com/login/`, 对应接入的服务必须使用同一个一级域名, 访问地址类似 `http://{system_name}.bking.com`

- 登录成功后, 登录服务会往一级域名下 `.bking.com` 写入 cookie `bk_token`

- 第三方平台/对接系统等, 用户访问时, 尝试从一级域名 `.bking.com` 取 `bk_token`

    - 如果没有取到, 则主动跳转蓝鲸统一登录服务

    - 如果取到了, 需要调用登录服务接口, 校验 `bk_token` 的有效性, 如果有效, 可以调用登录接口获取相关的用户信息; 用户信息中 `username` 为唯一标识

## 登录相关逻辑和接口

假设蓝鲸智云部署后, PaaS 平台的访问地址是 `http://paas.bking.com`

### 从 cookie 中获取 `bk_token`

应用从 http 请求 cookie 中可以获取 `bk_token`

Django 为例

```python
bk_token = request.COOKIES.get('bk_token', '')
```

### 跳转登录页面

前端直接跳转到登录页面: `http://paas.bking.com/login?c_url={login_success_redirect_url}`

- `c_url` 用于登录成功后, 跳往的目标页面

- `{login_success_redirect_url}` 是一个 `urlencode` 后的地址, 假设期望的目标地址是 `http://mysystem.bking.com/index.html`, `c_url` 值需要经过 `urlencode` 即 `http%3a%2f%2fmysystem.bking.com%2findex.html`

### 校验 `bk_token` 是否合法

即校验登录态

- url: `http://paas.bking.com/login/accounts/is_login/`

- method: `GET`

- params: `bk_token`

- 示例: `http://paas.bking.com/login/accounts/is_login/?bk_token=u4pDIp0yjOAuHXxL0ldjt_y7UB4PkfGTT7C9YlMM4Y4`

- 接口返回: 校验成功

```json
{
    "message": "User authentication succeeded",
    "code": "00",
    "data":
    {
        "username": "admin"
    },
    "result": true
}
```

- 接口返回: 校验失败

```json
{
    "message": "auth fail reason",
    "code": "1200",
    "data": {},
    "result": false
}
```

### 获取用户信息

- url: `http://paas.bking.com/login/accounts/get_user/`

- method: `GET`

- params: `bk_token`

- 示例: `http://paas.bking.com/login/accounts/get_user/?bk_token=u4pDIp0yjOAuHXxL0ldjt_y7UB4PkfGTT7C9YlMM4Y4`

- 接口返回: 获取成功

```json
{
    "message": "Get user information succeeded",
    "code": "00",
    "data":
    {
        "username": "admin",
        "qq": "",
        "role": "1",
        "language": "zh-cn",
        "phone": "12345678910",
        "wx_userid": "",
        "email": "mockadmin@mock.com",
        "chname": "mockadmin",
        "time_zone": "Asia/Shanghai"
    },
    "result": true
}
```

- 接口返回: 获取失败

```json
{
    "message": "get userinfo fail reason",
    "code": "1200",
    "data": {},
    "result": false
}
```
