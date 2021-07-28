# 鉴权

## 1. 使用 python sdk 进行鉴权

[iam-python-sdk: is_allowed](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#12-is_allowed)

```python
from iam import IAM, Request, Subject, Action, Resource


SYSTEM_ID = "demo"
APP_CODE = "demo"
APP_SECRET = "c2cfbc92-28a2-420c-b567-cf7dc33cf29f"
BK_IAM_HOST = "http://{IAM_HOST}"
BK_PAAS_HOST = ''


class Permission(object):
    def __init__(self):
        self._iam = IAM(APP_CODE, APP_SECRET, BK_IAM_HOST, BK_PAAS_HOST)

    def _make_request_without_resources(self, username, action_id):
        request = Request(
            SYSTEM_ID,
            Subject("user", username),
            Action(action_id),
            None,
            None,
        )
        return request

    def _make_request_with_resources(self, username, action_id, resources):
        request = Request(
            SYSTEM_ID,
            Subject("user", username),
            Action(action_id),
            resources,
            None,
        )
        return request

    def allowed_access_developer_center(self, username):
        """
        访问开发者中心权限
        """
        request = self._make_request_without_resources(username, "access_developer_center")
        return self._iam.is_allowed(request)

    def allowed_develop_app(self, username, app_code):
        """
        app开发权限
        """
        r = Resource(SYSTEM_ID, 'app', app_code, {})
        resources = [r]
        request = self._make_request_with_resources(username, "develop_app", resources)
        return self._iam.is_allowed(request)
```

判定权限的地方

```python
Permission().allowed_access_developer_center(request.user.username)

Permission().allowed_develop_app(request.user.username, app_code)
```

## 2. 使用 API 进行鉴权

访问开发者中心权限

```bash
curl -XPOST 'http://{IAM_HOST}/api/v1/policy/auth' \
-H 'X-Bk-App-Code: demo' \
-H 'X-Bk-App-Secret: c2cfbc92-28a2-420c-b567-cf7dc33cf29f' \
-H 'Content-Type: application/json' \
-d '{
	"system": "demo",
	"subject": {
		"type": "user",
		"id": "tom"
	},
	"action": {
		"id": "access_developer_center"
	},
	"resources": []
}'

# response
{
    "code": 0,
    "message": "ok",
    "data": {
        "allowed": true
    }
}
```

APP 开发权限

```bash
curl -XPOST 'http://{IAM_HOST}/api/v1/policy/auth' \
-H 'X-Bk-App-Code: demo' \
-H 'X-Bk-App-Secret: c2cfbc92-28a2-420c-b567-cf7dc33cf29f' \
-H 'Content-Type: application/json' \
-d '{
    "system": "demo",
    "subject": {
        "type": "user",
        "id": "tom"
    },
    "action": {
        "id": "develop_app"
    },
    "resources": [{
        "system": "demo",
        "type": "app",
        "id": "test_app_1"
    }]
}'

# response
{
    "code": 0,
    "message": "ok",
    "data": {
        "allowed": false
    }
}
```
