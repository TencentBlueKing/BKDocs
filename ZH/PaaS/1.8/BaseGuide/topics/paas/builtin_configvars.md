# 内置环境变量说明

### 什么是内置环境变量

内置环境变量是蓝鲸开发者中心为每个应用**预生成**的一组环境变量。

与自定义环境变量不同，内置环境变量不需要开发者手动添加，且无法被删除。这使得您可以利用这些变量减少硬编码，从而使代码更灵活和优雅。

在 Python 代码中，您可以轻松获取这些环境变量：

```python
foo = os.environ.get("BKPAAS_XXX")
```

**注意**：环境变量的优先级（由高到低）为：平台内置环境变量 > 应用中自定义环境变量。

## 基础环境变量

> 提示：平台注入的基础环境变量均以`BKPAAS_`开头，请避免在自定义环境变量时使用此前缀。

扩展：[如何使用自定义环境变量](./custom_configvars.md)

### BKPAAS_APP_ID

蓝鲸应用 ID，如 `blue-app`。

> 注：蓝鲸 PaaS 平台里的 `app id`、`app code` 是同一个东西的不同叫法，它们指的都是应用的唯一标示。在旧版平台中，一般叫 `app code`，新版里则统称为 `app id`。


### BKPAAS_APP_SECRET

蓝鲸应用密钥，主要在调用云 API 服务时使用。在应用的 “基本信息” 页面可以查看该值。

### BKPAAS_APP_MODULE_NAME

应用当前模块名称，如 `default`。

### BKPAAS_ENVIRONMENT

当前应用的环境，预发布环境为 `stag`，正式环境为 `prod`。

### BKPAAS_MAJOR_VERSION

应用当前运行的开发者中心版本，值为 3。

### BKPAAS_ENGINE_REGION

标识应用版本，值为 `default`。

### BKPAAS_URL

蓝鲸 PaaS 平台访问 URL。

### BKPAAS_ENGINE_APP_NAME

每个应用在具体环境中的部署标识符，包含应用 ID、模块名和环境等信息。拼接规则如下：

- 主模块：bkapp-{appID}-{BKPAAS_ENVIRONMENT}。
- 非主模块：bkapp-{appID}-m-{moduleName}-{BKPAAS_ENVIRONMENT}。

示例：

- `bkapp-blueapps-stag`
- `bkapp-blueapps-m-api-prod`

### BKPAAS_DEFAULT_PREALLOCATED_URLS

包含应用模块各环境的访问地址。此处的地址为平台基于配置和算法生成的“预分配”内置地址，和用户实际访问应用时使用的真实地址不一定完全一致
（比如用户可能使用后配置的自定义访问地址访问）。

示例：

```text
{"stag": "http://stag-dot-api-dot-bk-user.example.com", "prod": "http://prod-dot-api-dot-bk-user.example.com"}
```

该值为一个 JSON 对象字符串，键代表各环境名称，值为访问地址。开发者可使用各语言 JSON 库将其解析后使用。

附：Python 代码示例

```python
>>> import json, os
>>> value = os.environ['BKPAAS_DEFAULT_PREALLOCATED_URLS']
>>> urls = json.loads(value.decode('utf-8'))

# 获取预发布环境访问地址
>>> urls['stag']
# 获取生产环境访问地址
>>> urls['prod']
```

### BKPAAS_BK_CRYPTO_TYPE

加密数据库内容的推荐算法，有两种可选值：

- **`SHANGMI`**：对应 `SM4CTR` 算法。
- **`CLASSIC`**：对应 `Fernet` 算法。

### BKPAAS_BK_DOMAIN

蓝鲸根域，用于获取登录票据、国际化语言等 cookie 信息。

### BKPAAS_LOGIN_URL

蓝鲸统一登录访问地址。

### BKPAAS_SHARED_RES_URL

蓝鲸产品 title/footer/name/logo 等资源自定义配置的路径。

### BK_API_URL_TMPL

网关 API 访问地址模板，形如：http://bkapi.example.com/api/{api_name}。

### BK_COMPONENT_API_URL

组件 API 访问地址，形如：http://bkapi.example.com。

### BK_PAAS2_URL

PaaS2.0 开发者中心地址，部分老版本的开发框架会使用该变量拼接蓝鲸统一登录服务访问地址。

### BK_DOCS_URL_PREFIX

蓝鲸文档中心地址。

### BKPAAS_CONSOLE_URL

蓝鲸桌面访问地址。

### BKPAAS_CC_URL

蓝鲸配置平台访问地址。

### BKPAAS_JOB_URL

蓝鲸作业平台访问地址。

### BKPAAS_IAM_URL

蓝鲸权限中心访问地址。

### BKPAAS_USER_URL

蓝鲸用户管理访问地址。

### BKPAAS_MONITORV3_URL

蓝鲸监控平台访问地址。

### BKPAAS_LOG_URL

蓝鲸日志平台访问地址。

### BKPAAS_REPO_URL

蓝鲸制品库访问地址。

### BKPAAS_CI_URL

蓝鲸持续集成平台（蓝盾）访问地址。

### [不推荐使用]BKPAAS_ENGINE_APP_DEFAULT_SUBDOMAINS

如果应用当前的访问方式为“子域名” _（可在应用内页“访问入口”处确认该配置）_，那么该变量将会包含平台为其在当前部署环境下分配的所有子域名。
多个域名将会以 `;` 符号分割，如果应用未使用独立子域名访问，该变量值为空字符串 `''`。应用可以利用该字段拼接应用内静态文件完整访问地址。

示例：

- `foo.bkapps.example.com;prod-dot-foo.bkapps.example.com`

> 说明：若应用的访问方式为子路径（大多数社区版都是这种情况）时，没有 `BKPAAS_ENGINE_APP_DEFAULT_SUBDOMAINS` 这个环境变量，为兼容各个版本的差异性，建议使用 `BKPAAS_DEFAULT_PREALLOCATED_URLS` 来获取应用的访问地址。

### [不推荐使用]BKPAAS_SUB_PATH

应用访问子路径，拼接规则：`/{BKPAAS_ENGINE_REGION}-{BKPAAS_ENGINE_APP_NAME}/`。

示例：

- `/ieod-bkapp-blueapps-stag/`
- `/tencent-bkapp-anotherapp-prod/`

> 说明：部分存量应用会使用 `BKPAAS_SUB_PATH` 获取应用的路径前缀，建议修改为从 HTTP 请求头 `HTTP_X_SCRIPT_NAME` 中获取。

## 增强服务相关

蓝鲸 PaaS 平台会将应用的增强服务信息，注入到应用的环境变量中。你可以通过它们访问已经启用过的增强服务。

### 获取方式

以 RabbitMQ 的`vhost`为例，

```python
vhost = os.environ.get('RABBITMQ_VHOST')
```

> 提示：增强服务环境变量的 Key 值，请查阅 『增强服务』-『实例详情』页面 。

## 其他

### PORT

应用首次部署时，默认创建的进程服务规则的目标端口号，值为`5000`。

如需了解更多，可以查看 [进程服务说明](./entry_proc_services.md)。
