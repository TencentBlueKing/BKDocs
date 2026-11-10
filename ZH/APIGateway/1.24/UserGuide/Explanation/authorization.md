[toc]

## 认证

### 概念

- **应用认证**: 蓝鲸 PaaS 平台会给每个应用分配一个唯一的`bk_app_code`, 以及对应的`bk_app_secret`用于应用身份认证; 如果 API 启用了`应用认证`, 那么调用方需要在请求头中提供合法的`bk_app_code/bk_app_secret`, 网关会校验应用是否合法
- **用户认证**: 蓝鲸统一登录，会给每个登录的用户分配唯一的登录态`bk_token`(在 cookie 中), 用于用户身份认证; 如果 API 启用了 `用户认证`, 那么调用方需要在请求头中提供合法的`bk_token`, 网关会校验用户是否合法
- **校验访问权限**: 某些 API 开启了`校验访问权限`, 则需要应用开发者到蓝鲸开发者中心申请 **应用调用该 API**的权限，审批通过后，这个蓝鲸应用才能调用这个 API, 否则会返回无权限; 注意：`校验访问权限`要求该 API 开启 `应用认证`, 网关需要拿`应用认证`通过后的`bk_app_code`进行权限校验
- **access_token**: 蓝鲸的 bkauth(旧版本的 ssm) 等服务，提供了`access_token`签发，支持签发 `应用身份access_token`(代表一个已认证应用) 以及 `应用+用户身份 access_token` (代表一个已认证应用 + 已认证用户); 在无用户登录态/定时任务/脚本等调用网关 API 的场景，可以使用`access_token`替代 `bk_app_code/bk_app_secret/bk_token`

### 认证 Header 头

```
X-Bkapi-Authorization: {}
```


示例：

```
# 调用目标 API 开启: 应用认证+用户认证
X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}

# 调用目标 API 开启: 应用认证
X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y"}

# 调用目标 API 开启: 用户认证
X-Bkapi-Authorization: {"bk_token": "z"}

# 使用access_token
X-Bkapi-Authorization: {"access_token": "z"}

# 使用 jwt + access_toen,主要用于解决：用户 -> apigwA -> 后端 -> apigwB 中后端访问apigwB用户认证问题
X-Bkapi-Authorization: {"jwt":"xxxx", "access_token": "z"}

```

`curl` 请求示例：

```
curl 'http://bkapi.example.com/prod/users/'
    -H 'X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}'
```

## 常见问题

### 1. 如果同时传递了 bk_app_code+bk_app_secret+bk_token+access_token，哪里的会生效？

> 禁止这样混用，access_token 只能单独使用；并且不要使用来历不明的 access_token/复用其他平台生成的 access_token

示例： `X-Bkapi-Authorization: {"bk_app_code": "app1", "bk_app_secret": "xxx", "bk_token": "yyy", "access_token": "zzz"`,  bk_token 对应的用户是`user1`,  access_token 签发的`app_code=app2`/`bk_username=user2`

此时，签发这个`access_token = zzz` 的应用 **app2** 以及签发时传入的用户 **user2** 生效，而不是请求头中的 **app1 ** 这个应用 + 请求头中`bk_token`对应这个用户 **user1** 生效；

所以此时，可能出现

1. 报错：应用`app2`无权限（因为生效的是 app2）
2. 返回的数据是`user2`的数据（因为生效的是 user2）
