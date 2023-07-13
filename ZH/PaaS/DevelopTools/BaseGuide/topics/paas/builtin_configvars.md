# 内置环境变量说明

## 什么是内置环境变量

蓝鲸 PaaS3.0 开发者中心为每一个应用**预生成**的一些环境变量。

不同于自定义环境变量，它不需要开发者手动添加，也不能被删除。

你可以利用它们减少硬编码，让代码更加灵活优雅。

在 python 代码中，你能轻松获取到它：

```python
foo = os.environ.get('bar')
```

## 基础环境变量

> 提示：平台注入的基础环境变量均以`BKPAAS_`开头，请避免在自定义环境变量时使用此前缀。

扩展：[如何使用自定义环境变量](./custom_configvars.md)

### BKPAAS_APP_ID

bk_app_code，蓝鲸应用 ID，如 `blue-app`。


### BKPAAS_APP_SECRET

bk_app_secret，蓝鲸应用密钥，主要在调用云 API 服务时使用。在应用的 “基本信息” 页面可以查看该值。

### BKPAAS_URL

蓝鲸 PaaS3.0 平台访问 URL

### BKPAAS_ENVIRONMENT

当前应用的环境，预发布环境为 `stag`，正式环境为 `prod`


### BKPAAS_ENGINE_APP_NAME

EngineApp 名称

### BKPAAS_ENGINE_REGION

标识应用版本，默认为 default


### BKPAAS_LOG_NAME_PREFIX

日志采集使用，拼接规则：`{BKPAAS_ENGINE_REGION}-{BKPAAS_ENGINE_APP_NAME}-{process_type}`

示例：
- `default-bkapp-blue-app-stag-web`
- `default-bkapp-blue-app-prod-celery`

### BKPAAS_ENGINE_APP_DEFAULT_SUBDOMAINS

如果应用当前的访问方式为“子域名” *（可在应用内页“访问入口”处确认该配置）*，那么该变量将会包含平台为其在当前部署环境下分配的所有子域名。

多个域名将会以 `;` 符号分割，如果应用未使用独立子域名访问，该变量值为空字符串 `''`。

> 应用可以利用该字段拼接应用内静态文件完整访问地址。

示例：

- `foo.bkapps.bking.com;prod-dot-foo.bkapps.bking.com`


### BK_PAAS2_URL

蓝鲸 PaaS2.0 平台访问 URL

### BK_PAAS2_INNER_URL

蓝鲸 PaaS2.0 平台内网访问 URL

### BK_LOGIN_URL

蓝鲸统一登录服务访问 URL

### BK_LOGIN_INNER_URL

蓝鲸统一登录服务内网访问 URL

### BK_CONSOLE_URL

蓝鲸桌面访问 URL

### BK_CLOUD_API_URL

蓝鲸云API访问 URL

### BK_CLOUD_API_INNER_UR

蓝鲸云API内网访问 URL



## 增强服务相关

蓝鲸 PaaS3.0 开发者中心会将应用的增强服务信息，注入到应用的环境变量中。你可以通过它们访问已经启用过的增强服务。

### 获取方式

以 RabbitMQ 的`vhost`为例，

```python
vhost = os.environ.get('RABBITMQ_VHOST')
```

> 提示：增强服务环境变量的 Key 值，请查阅 『应用开发-增强服务』页面 。


## 其他

### PORT

应用首次部署时，默认创建的进程服务规则的目标端口号，值为`5000`。

如需了解更多，可以查看 [进程服务说明](./entry_proc_services.md)。
