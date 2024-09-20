# 调用组件 API

本文将引导您调用一个已经存在的组件 API，假定该组件 API 需要认证应用、认证用户、校验应用访问权限。

调用网关 API 请参考[调用网关 API](../../apigateway/use-api/use-apigw-api.md)

## 概述

本文的主要操作步骤如下：
- 申请蓝鲸应用账号
- 申请组件 API 访问权限
- 确定用户认证方案
- 调用组件 API

访问 `API 帮助中心`，点击导航菜单**组件 API 文档**，可搜索并查看组件 API 的文档，了解组件 API 调用地址、请求参数及其它说明。

![](../../assets/component/use-api/api-doc.png)

## 申请蓝鲸应用账号

访问组件 API，需要一个蓝鲸应用账号，可使用已有的应用账号，或创建一个新的应用，获取`bk_app_code`和`bk_app_secret`，作为应用账号信息。

创建应用及获取应用账号详情请参考[获取蓝鲸应用账号](../../apigateway/use-api/bk-app.md)

## 申请组件 API 访问权限

访问`蓝鲸开发者中心`，在蓝鲸应用的管理页，展开左侧菜单**云 API 管理**，点击**云 API 权限**，进入云 API 权限管理页，切换到**组件 API**页。

在系统列表中，筛选出待申请权限的组件系统，点击系统名，然后，在右侧页面选中需访问的组件 API，点击**批量申请**。
在申请记录中，可查看申请单详情。待权限审批通过后，即可访问组件 API。

![](../../assets/component/use-api/apply-api-permissions.png)

## 确定用户认证方案

用户认证，用于确认当前操作者的用户真实身份，一般通过用户登录态验证，具体请参考[获取蓝鲸用户身份](../../apigateway/use-api/bk-user.md)。

- 登录态: 用户登录态，用户登录后，存储在浏览器 Cookies 中，登录态有效期一般不超过 24 小时

> 注意：若无法提供用户登录态，可提供需求背景、bk_app_code、组件 API 列表等信息，联系组件 API 管理员，
> 申请组件 API 的免用户认证权限。此时，请求组件 API 时，可提供参数 bk_username 指定当前用户（此方式存在越权风险，蓝鲸应用需做好用户权限管理）。

## 调用组件 API

调用组件 API，可使用组件 SDK，或其它合适的工具。

### 利用组件 SDK 访问组件 API

访问 `API 帮助中心`，点击菜单**组件 API SDK**
- 在**SDK 列表**页，可查看或下载当前提供的最新版本组件 SDK
- 在**SDK 说明**页，可查看如何使用组件 SDK

![](../../assets/component/use-api/sdk-usage.png)

### 使用工具访问组件 API

请求参数：
- 请求协议：请求方法及请求地址，可在组件 API 文档中查看
- 认证信息：应用信息(`bk_app_code + bk_app_secret`)、用户信息(`用户登录态`)，通过请求头 `X-Bkapi-Authorization` 传递，值为 JSON 格式字符串。
- 组件 API 参数：可在组件 API 文档中查看

curl 调用示例:
```powershell
curl 'http://bkapi.example.com/demo/users/' \
    -d '{"bk_biz_id": 1}' \
    -H 'X-Bkapi-Authorization: {"bk_app_code": "x", "bk_app_secret": "y", "bk_ticket": "z"}'
```

python 调用示例：
```python
import json
import requests

requests.post(
    "http://bkapi.example.com/demo/users/",
    json={"bk_biz_id": 1},
    headers={
        "X-Bkapi-Authorization": json.dumps({
            "bk_app_code": "x",
            "bk_app_secret": "y",
            "bk_ticket": "z"
        })
    },
)
```
