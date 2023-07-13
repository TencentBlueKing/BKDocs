# API 文档

平台所有 API 均已接入蓝鲸统一网关 API Gateway ，访问 `http://<BK_PAAS_HOST>/esb/api_docs/system/`  查看文档。

## 鉴权方式
DataAPI 目前支持两种认证方式，需要将认证信息添加至请求参数。

### 用户模式

用户模式即传递能证明用户身份的认证信息，传参方式请遵循 ESB 组件调用说明

- 用户模式参数样例：

```json
{
  "bk_app_code": "xxxx",
  "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "bkdata_authentication_method": "user",
  "bk_username": "jeeeeee",
  "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA"
}
```

### 授权码模式
授权码模式，目前只支持数据查询和数据订阅。具体申请方式请查看 [《授权管理》](../user-guide/auth-management/token.md) 指南。

- 授权码模式的参数样例：

```json
{
    "bk_app_code": "xxxx",
    "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "bkdata_authentication_method": "token",
    "bkdata_data_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

## 如何调用 DataAPI

目前 DataAPI 未在 ESB SDK 中封装，无法使用 ESB 客户端请求接口，可以通过 HTTP 请求样例直接请求接口。

- GET 请求样例

```python
def send_request():
     response = requests.get(
        url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/meta/projects/1/",
        params={
            "bk_app_code": "xxxx",
            "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            "bkdata_authentication_method": "user",
            "bk_username": "jeeeeee",
            "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA"
        }
    )
    print('Response HTTP Status Code: {status_code}'.format(status_code=response.status_code))
    print('Response HTTP Response Body: {content}'.format(content=response.content))
```

- POST 请求样例，PUT、DELETE 类似

```python
def send_request():
     response = requests.post(
        url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/meta/projects/",
        headers={
            "Content-Type": "application/json; charset=utf-8",
        },
        data=json.dumps({
            "bk_app_code": "xxxx",
            "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            "bkdata_authentication_method": "user",
            "bk_username": "jeeeeee",
            "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA",

            "project_name": "测试项目",
            "description": "test"
        })
    )
    print('Response HTTP Status Code: {status_code}'.format(status_code=response.status_code))
    print('Response HTTP Response Body: {content}'.format(content=response.content))

```

## 调用 API 查询数据

为了保障数据安全，查询数据接口目前仅支持授权码模式，第三方平台如果期望使用用户模式，请联系平台助手添加白名单。

- 具体调用样例

```python
# Install the Python Requests library:
# `pip install requests`

import requests
import json

def send_request():
    # Request Duplicate (2)
    # POST http://<BK_PAAS_HOST>/api/c/compapi/data/v3/dataquery/query/

    try:
        response = requests.post(
            url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/dataquery/query",
            headers={
                "Content-Type": "application/json; charset=utf-8",
            },
            data=json.dumps({
                "bkdata_authentication_method": "token",
                "bkdata_data_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                "bk_app_code": "xxxx",
                "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                "sql": "select dteventtimestamp as ts,count from 111_jeee_set_login where thedate=20160920  AND cc_set='303' AND biz_id='111' limit 1",
                "prefer_storage": ""
            })
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')
```
