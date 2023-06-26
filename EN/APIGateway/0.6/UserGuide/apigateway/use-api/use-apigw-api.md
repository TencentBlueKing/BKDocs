# 调用网关 API

本文将引导您调用一个已经存在的网关 API，该网关 API 需要认证应用、认证用户、校验应用访问权限。

## 概述

本文的主要操作步骤如下：
- 申请蓝鲸应用账号
- 申请网关 API 访问权限
- 确定用户认证方案
- 调用网关 API

访问 API 帮助中心，点击导航菜单**网关 API 文档**，可搜索并查看网关 API 的文档，
了解网关 API 认证配置、调用地址、请求参数及其它说明。

![](../../assets/apigateway/use-api/api-doc.png)

## 申请蓝鲸应用账号

访问网关 API，需要一个蓝鲸应用账号，可使用已有的应用账号，或创建一个新的应用。

访问`蓝鲸开发者中心`，点击导航菜单**应用开发**，搜索并进入使用的蓝鲸应用。

![](../../assets/apigateway/use-api/app-list.png)

在应用管理页，展开左侧菜单**基本设置**，点击**基本信息**。鉴权信息中的`bk_app_code`和`bk_app_secret`，即为访问网关 API 所需的蓝鲸应用账号。

![](../../assets/apigateway/use-api/app-basic-info.png)

## 申请网关 API 访问权限

参考上一步，进入蓝鲸应用管理页。在应用管理页，展开左侧菜单**云 API 管理**，点击**云 API 权限**，进入云 API 权限管理页。

在网关列表中，筛选出待申请权限的网关，点击网关名，然后，在右侧页面选中需访问的网关 API，点击**批量申请**。
在**申请记录**中，可查看申请单详情。待权限审批通过后，即可访问网关 API。

![](../../assets/apigateway/use-api/apply-api-permissions.png)

## 确定用户认证方案

用户认证，用于确认当前操作者的用户真实身份，一般通过用户登录态验证。

- 登录态: 用户登录态，用户登录后，存储在浏览器 Cookies 中，登录态有效期一般不超过 24 小时

*注意：若网关 API 需认证用户，而调用者无法提供用户登录态，可联系网关管理员，咨询是否可申请免用户认证应用白名单*

## 调用网关 API

调用网关 API，可使用网关 SDK，或其它工具。

### 利用网关 SDK 访问网关 API

访问 API 帮助中心，点击菜单**网关 API SDK**，可搜索网关的 SDK。若网关未提供 SDK，可联系网关管理员生成网关 SDK。
网关 SDK 的使用说明，参考 API 帮助中心，菜单**网关 API SDK** 下的 **SDK 说明**。

![](../../assets/apigateway/use-api/sdk-usage.png)

### 使用工具访问网关 API

请求参数：
- 请求协议：请求方法及请求地址，可在网关 API 文档中查看
- 认证信息：应用信息(`bk_app_code + bk_app_secret`)、用户信息(`用户登录态`)，通过请求头`X-Bkapi-Authorization`传递，值为 JSON 格式字符串。
- 网关 API 参数：可在网关 API 文档中查看

curl 调用示例：
```powershell
curl 'http://bkapi.example.com/prod/users/' \
    -d '{"bk_biz_id": 1}' \
    -H 'X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_token": "z"}'
```

python 调用示例：
```python
import json
import requests

requests.post(
    "http://bkapi.example.com/prod/users/",
    json={"bk_biz_id": 1},
    headers={
        "X-Bkapi-Authorization": json.dumps({
            "bk_app_code": "x",
            "bk_app_secret": "y",
            "bk_token": "z"
        })
    },
)
```
