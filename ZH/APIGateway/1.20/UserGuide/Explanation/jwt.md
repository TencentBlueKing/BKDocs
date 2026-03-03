[toc]


## 背景

后端服务接入网关时，接口可能开启了`应用认证`/`用户认证`, 此时调用方需要传认证 header 头`X-Bkapi-Authorization`, 网关认证通过后，会生成一个`X-Bkapi-JWT`头给到后端服务，里面包含了认证结果信息，这是一个 jwt token

![image.png](./media/jwt-01.png)

- 为什么要解析 JWT 呢？
- 后端服务怎么获取并解析呢？

## 为什么要解析 JWT

1. 可以判断这个请求是否来自于网关，如果不是，直接拒绝
2. 解析 JWT 之后可以获取 用户/用户是否认证，应用/应用是否认证信息，用于业务逻辑

## 获取 X-Bkapi-JWT

后端服务从请求的 header 头中获取 `X-Bkapi-JWT`

注意：请求经过网关，才会有这个头; 如果没有这个头，意味着请求没有经过网关

## X-Bkapi-JWT 格式

```
"X-Bkapi-Jwt": "eyJpYXQiOjE3MDE4MzQ1NDYsInR5cCI6IkpXVCIsImFsZyI6IlJTNTEyIiwia2lkIjoiaHR0cGJpbiJ9.eyJleHAiOjE3MDE4MzYwNDYsIm5iZiI6MTcwMTgzNDI0NiwiaXNzIjoiQVBJR1ciLCJhcHAiOnsidmVyaWZpZWQiOnRydWUsImFwcF9jb2RlIjoiYXBpZ3ctYXBpLXRlc3QiLCJleGlzdHMiOnRydWUsInZlcnNpb24iOjEsInZhbGlkX2Vycm9yX21lc3NhZ2UiOiIiLCJ2YWxpZF9zZWNyZXQiOnRydWUsInZhbGlkX3NpZ25hdHVyZSI6ZmFsc2V9LCJ1c2VyIjp7InZlcmlmaWVkIjpmYWxzZSwidXNlcm5hbWUiOiIiLCJ2ZXJzaW9uIjoxLCJ2YWxpZF9lcnJvcl9tZXNzYWdlIjoidXNlciBhdXRoZW50aWNhdGlvbiBmYWlsZWQsIHBsZWFzZSBwcm92aWRlIGEgdmFsaWQgdXNlciBpZGVudGl0eSwgc3VjaCBhcyBia191c2VybmFtZSwgYmtfdGlja2V0LCBhY2Nlc3NfdG9rZW4iLCJzZWFyY2hlZF9ydHgiOiIiLCJzb3VyY2VfdHlwZSI6IiJ9fQ.G8yDU6CIwxezr1WZg8bhrbMWtpw6DP5oxrrCo1ctP8CWCax7dTh6D2h0ad9rETR40ViowTaiuOWLE4GztgwxSyw3BZ6oZ0Tai7qg4-Z90Qw6wKPcm7e-fVt0gRTwwJVR8axG3kJdi256auoTJjilxPa76Vorm-6j-cL2P5o0HEvNJbiLNdMO-44u1ISsTR3HgLHbhb3bcDBw8iKF3xl9iB93Vqsujpt8hbFcf2Et9RVZII9CVxOuw-nR6GTpVsOXxoZtPV6ISQQEFMrbq7TubC-VOxVoeoi-Qq0Eo1ritD9pMN8FdDG89occEWq0LFz7h-3-C8j_hnOI4pcH_iWkFg"
```

使用 jwt 库解析后

jwt Header

```json
{
  "iat": 1701834546, # 签发时间
  "kid": "httpbin",  # 网关名称
  "alg": "RS512",    # 加密算法
  "typ": "JWT"
}
```

jwt Payload

```
{
  "exp": 1701836046,              # 过期时间
  "nbf": 1701834246,
  "iss": "APIGW",
  "app": {                        # 应用信息
    "verified": true,               # 应用认证是否通过
    "app_code": "apigw-api-test",   # 应用 bk_app_code
    ......
  },
  "user": {                      # 用户信息
    "verified": true,             # 用户认证是否通过
    "username": "tom",                # 用户的 username
    ......
  }
}
```

## 如何解析

步骤：

1. 获取公钥
2. 使用 jwt 库解析

### 获取公钥

网关公钥，在网关管理端 - 基本信息中可以查到，可以复制并配置到项目配置文件中

或者，通过 API 接口查询获取 public_key (注意获取后自行放到存储/缓存/内存中，避免实时拉取)

```bash
# curl -X GET 'https://bkapi.example.com/api/bk-apigateway/prod/api/v1/apis/{gateway_name}/public_key/' \
  -H 'X-Bkapi-Authorization: {"bk_app_code": "my-app", "bk_app_secret": "secret"}

{
    "data": {
        "issuer": "",
        "public_key": "your public key"
    }
}
```

或者，使用网关 apigw-manager, 可以阅读 [apigw-manager 文档](https://github.com/TencentBlueKing/bkpaas-python-sdk/tree/master/sdks/apigw-manager) 中关于获取 public_key

### 解析

不同语言使用的库不一样

golang 使用  [golang-jwt](https://github.com/golang-jwt/jwt)

```golang
var (
	ErrUnauthorized = errors.New("jwtauth: token is unauthorized")

	ErrExpired    = errors.New("jwtauth: token is expired")
	ErrNBFInvalid = errors.New("jwtauth: token nbf validation failed")
	ErrIATInvalid = errors.New("jwtauth: token iat validation failed")
)

func parseBKJWTToken(tokenString string, publicKey []byte) (jwt.MapClaims, error) {
	keyFunc := func(token *jwt.Token) (interface{}, error) {
		pubKey, err := jwt.ParseRSAPublicKeyFromPEM(publicKey)
		if err != nil {
			return pubKey, fmt.Errorf("jwt parse fail, err=%w", err)
		}
		return pubKey, nil
	}

	claims := jwt.MapClaims{}
	token, err := jwt.ParseWithClaims(tokenString, claims, keyFunc)
	if err != nil {
		if verr, ok := err.(*jwt.ValidationError); ok {
			switch {
			case verr.Errors&jwt.ValidationErrorExpired > 0:
				return nil, ErrExpired
			case verr.Errors&jwt.ValidationErrorIssuedAt > 0:
				return nil, ErrIATInvalid
			case verr.Errors&jwt.ValidationErrorNotValidYet > 0:
				return nil, ErrNBFInvalid
			}
		}
		return nil, err
	}

	if !token.Valid {
		return nil, ErrUnauthorized
	}

	return claims, nil
}
```

python 使用标准库

```python
import jwt

def decode_jwt(jwt_token, public_key):
    try:
        return jwt.decode(jwt_token, public_key, options={"verify_iss": False})
    except Exception:  # pylint: disable=broad-except
        logger.exception("decode jwt fail, jwt: %s", content)
        return None
```

### 从 payload 获取数据并判断

获取调用方的 bk_app_code:

```python
app = jwt_payload.get("app", {})
if not app.get("verified", False):
    raise exceptions.AuthenticationFailed("app is not verified")

# 兼容多版本 (企业版/TE 版/社区版) 以及兼容 APIGW/ESB
app_code = app.get("bk_app_code", "") or app.get("app_code", "")
```

获取合法的 bk_username:

```python
user = jwt_payload.get("user", {})
if not user.get("verified", False):
    # username 不可信任，没经过校验 (相当于调用方可以随便填)
username = user.get("bk_username", "") or user.get("username", "")
```
