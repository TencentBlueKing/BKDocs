# 旧应用迁移介绍

## 简介

应用迁移，提供了一套完整的机制，支持将应用从老版本`PaaS`平台，无缝迁移到新集群，而在这个过程中，会自动为老应用创建相关信息，申请资源，以及增加适配代码。

用户需要处理的，是在部署成功后，访问新版本环境进行验证，确认服务正常(包括: 网页/celery 定时任务/celery 异步任务/调用后台服务/涉及授权服务访问)等等，确认正常后，点击确认迁移，则桌面入口会切换为新版本服务。

## 旧应用迁移-用户须知

### 旧应用迁移所需的代码改动

由于蓝鲸开发框架以及应用部署方式的变更，为了让旧应用能成功迁移，在执行旧应用迁移时, 平台提供了 [bkapp-migrate SDK](../../sdk/bkapp_migrate/index.md) 对应用的进行 patch 处理。

平台对于应用代码的 patch 不会干涉用户代码里的业务逻辑, 仅对应用依赖、日志操作、运行时配置等文件进行兼容性处理。


`patch` 指令是用于协助修改蓝鲸开发框架代码, 使其能在 PaaS 3.0 中正常运行。

```
Usage: bkapp-migrate patch [OPTIONS] SRC

Options:
  --version [django1.11|django1.8|django2.2]
                                  [required]
  --use-celery / --no-use-celery
  --use-celery-beat / --no-use-celery-beat
  --help                          Show this message and exit.
```

例如, 如果需要 patch django1.11 版本的开发框架, 只需要执行以下指令: 
```bash
# 当安装该工具后, 会自动在当前的 python 环境下增加 `bkapp-migrate` 指令。

# patch django1.11 版本的框架, 且不使用 celery 和 celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH}
# patch django1.11 版本的框架, 使用 celery 但不使用 celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH} --use-celery
# patch django1.11 版本的框架, 使用 celery 和  celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH} --use-celery --use-celery-beat
```

- 对于 **django1.8** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```

- 对于 **django1.11** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── blueapps
│   ├── __init__.py
│   ├── conf
│   │   ├── __init__.py
│   │   └── ...
│   ├── patch
│   │   ├── __init__.py
│   │   └── ...
│   └── ...
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```


- 对于 **django2.2** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── blueapps
│   ├── __init__.py
│   ├── conf
│   │   ├── __init__.py
│   │   └── ...
│   ├── patch
│   │   ├── __init__.py
│   │   └── ...
│   └── ...
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```



### 环境变量发生变更

由于蓝鲸 PaaS 平台的更新迭代, 平台内置的环境变量也做了相应变更。

1. 新增了以下环境环境

| 变量名                | 说明                  |
| -------------------- | ---------------------------------- |
| BKPAAS_MAJOR_VERSION   | BKPAAS_MAJOR_VERSION=3 标识部署在 PaaS3.0 开发者中心     | 
| BK_PAAS2_URL       | PaaS2.0 平台访问地址, 与 PaaS2.0 的 BK_PAAS_HOST 相同，PaaS2.0中 console、login、esb 的地址都由该值拼接    | 
| BK_PAAS2_INNER_URL | PaaS2.0 平台内网访问地址, 与 PaaS2.0  的BK_PAAS_INNER_HOST相同     | 
| BK_LOGIN_URL       | 统一登录服务访问地址，等价于 BK_PAAS_HOST + "/login/"     | 
| BK_LOGIN_INNER_URL | 统一登录服务内网访问地址，等价于 BK_PAAS_INNER_HOST + "/login/"    | 
| BK_CONSOLE_URL     | 蓝鲸桌面访问地址, 等价于 BK_PAAS_INNER_HOST + "/console/"    | 
| BK_CLOUD_API_URL     | 蓝鲸桌面访问地址, 等价于 BK_PAAS_INNER_HOST + "/console/"    | 

2. 以下环境变量的 value 有变化

| 变量名               | PaaS2.0 开发者中心                   | PaaS3.0 开发者中心                                   | 说明         |
| -------------------- | ---------------------------------- | --------------------------------------- | ------------------------------------------- |
| BKPAAS_ENGINE_REGION | open                               | default                                 | 日志平台根据该值来加载配置                  |


3. 以下环境变量的 key 有变化

| PaaS2.0 开发者中心     | PaaS3.0 开发者中心                       | 说明         |
| ---------------------| --------------------------------------- | -------------|
| APP_ID               | BKPAAS_APP_ID                      | bk_app_code                   |
| APP_TOKEN            | BKPAAS_APP_SECRET                  | bk_app_secret                 |
| BK_PAAS_HOST         | BK_PAAS2_URL                   | PaaS2.0 平台访问地址，平台入口）  |
| BK_PAAS_INNER_HOST   | BK_PAAS2_INNER_URL             | PaaS2.0 平台内网访问地址         |
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


