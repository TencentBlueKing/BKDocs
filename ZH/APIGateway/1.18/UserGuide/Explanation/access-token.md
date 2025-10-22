## 背景

目前不同环境的网关可能开启了不同的认证，接口如果开启了`用户认证`, 那么调用方在调用时需要提供`用户身份`, 具体见 [认证](./authorization.md)

- 用户登录态票据：bk_token
- access_token: 应用使用用户登录态生成的票据

某些场景下，调用方拿不到用户的登录态 (定时任务/脚本), 或者调用方是一个平台系统的后台，此时调用网关的接口如果开启了`用户认证`

解决方案：使用 `access_token` 服务生成 `access_token`

当前 access_token 由 bkssm 提供接口

PS: 蓝鲸 bkauth 未来将会承接内外部版 access_token 逻辑，届时将会全版本统一 (即，使用方不需要针对内外部版本做差异化开发)

## 1. 生成 access_token

> POST /api/v1/auth/access-tokens

### 功能描述

生成 `access_token`

注意：
- 系统调用接口生成`access_token`后，应该自行保存/缓存，多实例/多进程等进行共享。理论上，`同一个系统同一个用户`全局只会生成一次`access_token`
- 防止系统多个实例/多个进程同时发起生成`同一个用户`的`access_token`, 如果没有共享，那么后一次生成会刷掉前一次生成的`access_token`, 导致校验失败。

### 请求参数


#### header 参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| X-Bk-App-Code |  字符串  | 是   | 应用 ID |
| X-Bk-App-Secret |  字符串   | 是   | 应用 Token |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| grant_type |  字符串  | 是   | 授权类型，当前支持 authorization_code 登录态授权和 client_credentials 客户端授权两种 |
| id_provider |  字符串   | 是   | token 提供方，当 grant_type=authorization_code 时，值为 bk_login; 当 grant_type=client_credentials 时值为 client |
| bk_token |  字符串   | 否   | 当 grant_type=authorization_code 时必填 |

### 请求参数示例

使用登录态`bk_token`换取`access_token`

```json
{
  "grant_type": "authorization_code",
  "id_provider": "bk_login",
  "bk_token": "BhtTaCXsk2MFijI9q_zZ8aWMZz8F6K-QlsdP0IgGrdQ"
}
```

无登录态，使用`client_credentials`

```json
{
	"grant_type": "client_credentials",
	"id_provider": "client"
}
```

### 返回结果示例

```json
{
  "code": 0,
  "data": {
    "access_token": "SWU8C6djjzySI85wln1LADTZRkNAR1",
    "expires_in": 43200,
    "identity": {
      "user_type": "bkuser",
      "username": "admin"
    },
    "refresh_token": "GUmzehUfNLVa2JXtTrOag3e1YsTTdv"
  },
  "message": "string"
}
```

### 返回结果参数说明

#### code

- `0` 表示成功
- 非`0` 表示失败
  - 1901400 请求参数非法
  - 1901401 无权限调用此 API
  - 1901500 系统错误

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| access_token   | 字符串     | 生成的 access_token |
| expires_in   | 整数     |  过期时间，单位秒 |
| identity   | 对象     | token 对应的对象 |
| refresh_token   | 字符串     | 用户刷新的 refresh_token |

#### data.identity

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| user_type   | 字符串     | 用户类型 |
| username   | 字符串     | 用户名 |

## 2. 刷新 access_token

> POST /api/v1/auth/access-tokens/refresh

### 功能描述

刷新 access_token

注意：
- 一个`refresh_token`在其有效期内 (默认 30 天), 可以执行刷新`access_token`的动作
- 刷新后，原有的`access_token`将会失效
- 刷新后`refresh_token`本身不会更新，也不会续期
- 如果一个`refresh_token`已失效，那么只能重新生成`access_token`

### 请求参数

#### header 参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| X-Bk-App-Code |  字符串  | 是   | 应用 ID |
| X-Bk-App-Secret |  字符串   | 是   | 应用 Token |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| refresh_token |  字符串  | 是   | 用户刷新的 access_token |

### 请求参数示例

```python
{
  "refresh_token": "GUmzehUfNLVa2JXtTrOag3e1YsTTdv"
}
```

### 返回结果示例

```python
{
  "code": 0,
  "data": {
    "access_token": "SWU8C6djjzySI85wln1LADTZRkNAR1",
    "expires_in": 43200,
    "identity": {
      "user_type": "bkuser",
      "username": "admin"
    },
    "refresh_token": "GUmzehUfNLVa2JXtTrOag3e1YsTTdv"
  },
  "message": "string"
}
```

### 返回结果参数说明

#### code

- `0` 表示成功
- 非`0` 表示失败
  - 1901400 请求参数非法
  - 1901401 无权限调用此 API
  - 1901403 RefreshToken 非法或已过期
  - 1901500 系统错误

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| access_token   | 字符串     | 刷新后的 access_token|
| expires_in   | 整数     |  过期时间，单位秒 |
| identity   | 对象     | token 对应的对象 |
|  refresh_token  | 字符串    | 本次刷新的 refresh_token, 注意 refresh_token 不会更新/也不会续期，只能在有效期内进行刷新动作 |

#### data.identity

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| user_type   | 字符串     | 用户类型 |
| username   | 字符串     | 用户名 |
