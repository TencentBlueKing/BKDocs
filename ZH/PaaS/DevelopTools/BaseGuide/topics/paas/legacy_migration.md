# 旧应用迁移介绍

## 简介

应用迁移，提供了一套完整的机制，支持将应用从老版本`PaaS`平台，无缝迁移到新集群，而在这个过程中，会自动为老应用创建相关信息，申请资源。

用户需要处理的，是在部署成功后，访问新版本环境进行验证，确认服务正常(包括: 网页/celery 定时任务/celery 异步任务/调用后台服务/涉及授权服务访问)等等，确认正常后，点击确认迁移，则桌面入口会切换为新版本服务。


## 旧应用迁移所需的代码改动

### blueapps 修改

首先确认应用使用的 Django 版本，可在代码仓库中的 `requirements.txt` 文件中查看，请按 Django 版本对照指引操作：

#### Django 2.x

Django 2.x 以上的版本推荐：不再项目仓库中维护 blueapps 内容，直接通过 pypi 包引用。

1. 删除代码仓库中的 `blueapps` 文件夹

2. 在项目的 `requirements.txt` 文件中新增 blueapps、gunicorn，并去掉 uWSGI

```
# paas3.0 requirement
blueapps==4.4.2
gunicorn==19.6.0
```

3. 在项目根目录中添加 `runtime.txt` 文件（跟 `requirements.txt` 在同级目录下），在文件中定义 Python 版本为 3.6.12

```
python-3.6.12
```

#### Django 1.11.x

1. 下载 [blueapps4.2.2](https://pypi.org/project/blueapps/4.2.2/) 的包，将下载下来的包替换代码仓库中 `blueapps` 目录下的这 3 个文件: 

```
blueapps/account/sites/open/conf.py
blueapps/conf/__init__.py
blueapps/patch/settings_open_saas.py
```

2. 在项目的 `requirements.txt` 文件中新增 gunicorn，并去掉 uWSGI

```
# uWSGI==2.0.13.1

# paas3.0 requirement
gunicorn==19.6.0
```

3. 在项目根目录中添加 `runtime.txt` 文件（跟 `requirements.txt` 在同级目录下），在文件中定义 Python 版本为 2.7.18

```
python-2.7.18
```

### blueking 修改

1. 删除您的代码仓库中的 `blueking` 文件夹

2. 从官网下载最新的 [Python 开发框架](../../../SaaSGuide/term.md) 的包

3. 将下载下来的 framework_*.tar.gz 开发框架包的的 `app_desc.yaml` 文件，`blueking`  文件夹 放到您的代码的根目录中


### 配置修改

1. 将以下内容添加 `config/__init__.py` 文件中
```
def get_env_or_raise(key):
    """Get an environment variable, if it does not exist, raise an exception"""
    value = os.environ.get(key)
    if not value:
        raise RuntimeError(
            (
                'Environment variable "{}" not found, you must set this variable to run this application.'
            ).format(key)
        )
    return value

# SaaS应用ID
APP_CODE = os.getenv("BKPAAS_APP_ID")
# SaaS安全密钥，注意请勿泄露该密钥
SECRET_KEY = os.getenv("BKPAAS_APP_SECRET")
# PAAS平台URL
BK_URL = os.getenv("BKPAAS_URL")
# ESB API 访问 URL
BK_COMPONENT_API_URL = os.getenv("BK_COMPONENT_API_URL")
```

2. 在 `config/stag.py`  `config/prod.py` 文件中确认是否有定义 Mysql、Redis 等服务的值
- DATABASES 的信息在开发框架中已经定义好了，可以直接把这两个文件中定义的 DATABASES 信息删除，或者改成以下环境变量
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', 
        'NAME': os.environ.get('MYSQL_NAME'),
        'USER': os.environ.get('MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_HOST'), 
        'PORT': os.environ.get('MYSQL_PORT'),
    }
}
```
- Redis 需要修改为通过以下环境变量
```
REDIS_HOST = os.environ.get('REDIS_HOST')
REDIS_PORT = int(os.environ.get('REDIS_PORT'))
REDIS_PASSWORD = os.environ.get('REDIS_PASSWORD')
```

3. 全文搜索用到 `BK_URL` 的地方，如有用到，按以下情况修改

- 用于调用 ESB 的 API，如  {BK_URL}/api/c/compapi ，则需要修改为使用 BK_COMPONENT_API_URL
- 用于拼接登录地址，如 BK_URL + "/login/"，则替换为环境变量 BKPAAS_LOGIN_URL
- 用于拼接桌面地址，如 BK_URL + "/console/"，则替换为环境变量 BKPAAS_CONSOLE_URL


### 参考

1. Django2.x 应用修改请参考：[https://github.com/unixhot/opsany-bastion/pull/2/files](https://github.com/unixhot/opsany-bastion/pull/2/files)

2. Django1.11.x 应用修改请仓库：[https://github.com/jiayuan929/bk-framework-v2/pull/1/files](https://github.com/jiayuan929/bk-framework-v2/pull/1/files)



## 应用迁移的注意事项

### 环境变量发生变更

由于蓝鲸 PaaS 平台的更新迭代, 平台内置的环境变量也做了相应变更。

1. 新增了以下环境环境

| 变量名                | 说明                  |
| -------------------- | ---------------------------------- |
| BKPAAS_MAJOR_VERSION   | BKPAAS_MAJOR_VERSION=3 标识部署在 PaaS3.0 开发者中心     | 
| BK_PAAS2_URL       | PaaS2.0 平台访问地址, 与 PaaS2.0 的 BK_PAAS_HOST 相同，PaaS2.0中 console、login、esb 的地址都由该值拼接    | 
| BK_LOGIN_URL       | 统一登录服务访问地址，等价于 BK_PAAS_HOST + "/login/"     | 
| BKPAAS_LOGIN_URL       | 统一登录服务访问地址，等价于 BK_PAAS_HOST + "/login/"     | 
| BKPAAS_CONSOLE_URL     | 蓝鲸桌面访问地址, 等价于 BK_PAAS_INNER_HOST + "/console/"    | 
| BK_COMPONENT_API_URL     | ESB API 访问 url   | 

1. 以下环境变量的 value 有变化

| 变量名               | PaaS2.0 开发者中心                   | PaaS3.0 开发者中心                                   | 说明         |
| -------------------- | ---------------------------------- | --------------------------------------- | ------------------------------------------- |
| BKPAAS_ENGINE_REGION | open                               | default                                 | 日志平台根据该值来加载配置                  |


3. 以下环境变量的 key 有变化

注意：PaaS2.0 中会使用 `BK_PAAS_HOST` 来作为 ESB API 的域名，在 PaaS3.0 中必须修改为：`BK_COMPONENT_API_URL`

| PaaS2.0 开发者中心     | PaaS3.0 开发者中心                       | 说明         |
| ---------------------| --------------------------------------- | -------------|
| APP_ID               | BKPAAS_APP_ID                      | bk_app_code                   |
| APP_TOKEN            | BKPAAS_APP_SECRET                  | bk_app_secret                 |
| BK_PAAS_HOST         | BK_PAAS2_URL                   | PaaS2.0 平台访问地址，平台入口）  |
| BK_PAAS_INNER_HOST   | BK_PAAS2_URL                    | PaaS2.0 平台内网访问地址         |
| DB_TYPE              | 无                                 |  数据库类型                      |
| DB_HOST              | MYSQL_HOST                         |  数据库地址                |
| DB_PORT              | MYSQL_PORT                         |  数据库端口                |
| DB_NAME              | MYSQL_USER                         |  数据库名称                |
| DB_USERNAME          | MYSQL_NAME                         |  数据库用户                |
| DB_PASSWORD          | MYSQL_PASSWORD                      | 数据库密码             |
| BK_BROKER_URL        | f'amqp://{RABBITMQ_USER}:{RABBITMQ_PASSWORD}@{RABBITMQ_HOST}:{RABBITMQ_PORT}/{RABBITMQ_VHOST}'| 使用 RabbitMQ 作为 celery 后端消息队列 |

平台内置的环境变量列表请参考 [内置环境变量说明](./builtin_configvars.md)

### 访问入口地址发生变更

在应用迁移前, 平台内部版的所有应用均使用桌面域名作为根域名, 在应用迁移后, 平台应用的访问入口发生变更, v3 平台提供了两种内置的访问地址类型, 可于 『应用引擎 - 访问入口』查看访问地址类型。
- **独立子路径**, 使用的根域名为, 以挂载的子路径区分各应用的访问入口
- **独立子域名**, 使用平台提供的根域名, 以二级域名区分各应用的访问入口

在 PaaS2.0 中 `{BK_PAAS_HOST}/o/{APPID}` 来拼接其他应用的访问地址的应用，在 PaaS3.0 中需要改成服务发现配置的方式

#### 服务发现配置（svc_discovery）


要使用该特性，开发者需要在应用根目录创建名为 `app_desc.yml` 的配置文件，然后填入符合格式要求的配置信息。基于这些配置信息，开发者可以实现自定义市场配置、增加环境变量等功能。

> PaaS3.0 S-mart 应用也是使用 `app_desc.yml` 文件来描述蓝鲸应用的配置。


应用的服务发现相关配置，开发者可通过该字段配置依赖服务等信息。

- `bk_saas`：（array[string]）应用所依赖的其他蓝鲸应用 app code 列表。该项被配置后，平台将在应用部署后，通过环境变量注入该列表内所有应用的访问地址。

举例来说，如果应用使用了下面的配置：

```yaml
svc_discovery:
    bk_saas:
        - 'bk-iam'
        - 'bk-user'
```

应用在部署后，可通过名为 `BKPAAS_SERVICE_ADDRESSES_BKSAAS` 的环境变量读取到 `bk-iam` 与 `bk-user` 应用的访问地址。

该环境变量值是一个经过 base64 编码过的 Json 对象，对象格式为：

```json
{
    // {bk_app_code}: {address}
    "bk-iam": "http://bk-iam.example.com",
    "bk-user": "http://bkapps.example.com/bk-user/"
}
```

> 注意：开发者配置在 `bk_saas` 依赖应用列表里的应用，不论其是否已在平台上部署，平台都会往环境变量中写入该依赖应用的访问地址，该地址由平台根据规则生成，可能要过一段时间后才能正常提供服务。因此，开发者需要在编写业务代码时，处理好依赖应用服务不可用的情况。

**附录：如何通过 python 获取并解析 `BKPAAS_SERVICE_ADDRESSES_BKSAAS` 的值**

```python
# 仅适用于 Python3
>>> import json
>>> import base64
>>> import os
>>> value = os.environ['BKPAAS_SERVICE_ADDRESSES_BKSAAS']
>>> decoded_value = json.loads(base64.b64decode(value).decode('utf-8'))
>>> decode_value
{'bk-iam': ...}
```


### 其他问题说明
1. PaaS2.0 处理了 django migrate 等操作，PaaS3.0 可通过生成 [post-compile](./build_hooks.md) 处理；
2. PaaS2.0 通过 Nginx 自动代理了应用的静态资源文件，PaaS3.0 不支持该功能，需要相关的 Smart 应用加入 whitenoise 中间件重新出包；
3. S-mart 应用上传时可能会在加密和非加密版本中切换，导致构建失败，slug-pilot 禁用 virtualenv 缓存即可；

