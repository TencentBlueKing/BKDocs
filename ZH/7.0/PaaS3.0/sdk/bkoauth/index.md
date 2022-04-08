# bkoauth 文档

蓝鲸 API 服务使用 OAuth 2.0 协议进行用户校验，而 bkoauth 是为开发者提供的 OAuth 工具集。

## 功能

bkoauth 可以帮助开发者完成以下功能：

- 获取与更新用户鉴权令牌 access_token
- 在用户登录时自动续期 access_token

此外，bkoauth 还提供了若干其他工具，方便开发者将应用 API 托管至 API Gateway。

## 安装

使用 pip 命令来安装 SDK 包：

```shell
pip install bkoauth
```

## 配置

首先，把 bkoauth 添加到 INSTALL_APPS；开发框架 blueapps 默认已添加，不要重复添加

```python
INSTALLED_APPS = (
    ...
    'bkoauth'  # 把 bkoauth 添加到项目配置项 INSTALL_APPS 中
)
```

然后，执行 migrate 命令同步数据库改动：

```shell
python manage.py migrate bkoauth
```

## 文档

- [获取 access_token](access_token.md)
- [校验蓝鲸 API 网关请求](apigw.md)
- [模块所有可配置项列表](ref_configurations.md)
