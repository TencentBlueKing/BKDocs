# 使用 Access Token 访问 PaaS3.0

## 简介

PaaS3.0 支持使用 access token 访问，用户可以在更多 **非浏览器** 的场景下管理 V3 应用，例如可以在 github CI 里调用应用部署接口，完成 CI 流程。

## 获取 access token

首先我们需要获取 access token。

在登录 PaaS3.0 的状态下，访问 {BKPAAS_URL}/backend/api/accounts/oauth/token，会得到类似内容返回。

```json
{"message": "ok", "code": 0, "data": {"access_token": "******t0VQ5v2ZuT0rXhz741******", "user_id": "user1", "expires_in": 43199, "user_type": "rtx", "refresh_token": "******aZVNBDbveMcwSkZS******"}, "request_id": "******207663458389ce10db8b******"}
```

access_token 从对应字段中获取即可。目前 access_token 有效时长为 `30天`。

> 注意：由于 access_token 代表了用户在 PaaS V3 中的身份，请在获取后妥善保存。


## 调用 PaaS3.0

拿到 access_token 之后，我们需要调用 apiGateway，并传递 access_token。

调用示例：

Python:
```python
import requests

headers = {'X-BKAPI-AUTHORIZATION': '{"access_token": "this_is_your_own_access_token"}'}
list_app_url = "{BK_CLOUD_API_URL}/api/paasv3/prod/bkapps/applications/lists/detailed"

# 获取 App 详细信息列表
print requests.get(list_app_url, headers=headers).json()
```

Bash:
```bash
curl --header "X-BKAPI-AUTHORIZATION: {\"access_token\": \"RLjqb3t0VQ5v2ZuT0rXhz7413rKSr3\"}" {BKPAAS_URL}/api/paasv3/prod/bkapps/applications/lists/detailed
```