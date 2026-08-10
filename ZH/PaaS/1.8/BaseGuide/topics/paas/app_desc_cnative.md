和普通应用一样，开发者可以使用 `app_desc.yaml` 来描述云原生应用。`specVersion: 3` 版本是平台设计的最新规范，它的配置字段更接近云原生应用模型（BkApp），其格式使用驼峰命名。

> 虽然云原生应用向后兼容了 `spec_version: 2` 版本，但其无法完全使用云原生特性，所以建议开发者使用 `specVersion: 3`。S-mart 应用必须配置 `app_desc.yaml` 文件。

## 配置示例

`app_desc.yaml` 配置示例如下：

```yml
specVersion: 3
appVersion: "1.0.0"
app:
  region: default
  bkAppCode: "op-tool"
  bkAppName: 运维小工具
  market:
    category: 运维工具
    introduction: 应用简介
    description: 应用描述
    displayOptions:
      width: 800
      height: 600
modules:
  - name: api
    isDefault: true
    sourceDir: src/backend
    language: Python
    spec:
      processes:
        - name: web
          procCommand: python manage.py runserver
          replicas: 2
          resQuotaPlan: 4C1G
          services:
            - name: web
              protocol: TCP
              exposedType:
                name: bk/http
              targetPort: 5000
              port: 80
      configuration:
        env:
          - name: FOO
            value: value_of_foo
            description: 环境变量描述文件
      hooks:
        preRelease:
          procCommand: python manage.py migrate --no-input
      addons:
        - name: mysql
        - name: rabbitmq
      svcDiscovery:
        bkSaaS:
          - bkAppCode: bk-iam
          - bkAppCode: bk-user
            moduleName: api
      envOverlay: ...
```

## 基础配置

### specVersion

（必选，integer）配置文件版本，可选值：

- `3`：当前版本

### appVersion

`appVersion` 表示当前应用的[语义化版本](https://semver.org/)，会同步展示在应用“源码包管理”页面。

## 应用配置（app）

该部分配置主要用于描述应用，字段名 `app`。它只对 S-mart 应用生效，非 S-mart 应用以产品页面上信息为准。

### S-mart 专用字段

`region`、`bkAppCode`、`bkAppName` 字段，仅对 S-mart 应用有效。其他类型应用，会在配置解析阶段忽略这些字段。`region` 在私有化版本的取值是：`default`, 内部版的取值是：`ieod`。

### 市场配置（market）

描述应用在蓝鲸应用市场的属性：

- `introduction`: (必填，string) 应用简介
- `introductionEn`: (可选，string) 英文简介。不设置时，默认为应用简介
- `description`: (可选，string) 应用描述
- `descriptionEn`: (可选，string) 英文描述
- `category`: (可选、string) 应用分类
- `displayOptions`: (可选，object) 显示选项，详见说明

`displayOptions` 字段说明，可选字段：

- `width`: (可选，integer) 窗口宽度（像素）
- `height`: (可选，integer) 窗口高度（像素）
- `isMaximized`: (可选, boolean) 是否最大化显示, 默认值 False
- `visible`: (可选, boolean) 是否在桌面展示, 默认值 True
- `openMode`: (可选, string) 从桌面的打开方式, 默认值: "desktop", 可选值 "desktop"(从桌面打开), "new_tab"(从新标签页打开)

## 模块配置（modules）

modules 是描述应用模块的配置字段，类型为数组结构：

- `name`: (必填，string) 模块名。由小写字母和数字以及连接符(-)组成，不能超过 16 个字符
- `isDefault`: (可选，boolean) 是否为主模块，默认值为 False。注意一个应用有且只有一个主模块
- `language`: (必填，string) 模块的主要开发语言，可选值 `Python`、`NodeJS`、`Go`。平台会根据该字段绑定默认的构建工具
- `sourceDir`: (可选，string) 源码目录，包含所有需要的代码，比如部署前置命令（pre-compile 和 post-compile）都只能操作部署目录下的文件，不填则默认为根目录
- `spec`: (必填，object) 模块规约。其中，`processes` 定义进程信息(必填)，`configuration` 定义环境变量(可选)，`hooks` 定义钩子命令(可选)，`addons` 定义依赖的增强服务(可选)，`svcDiscovery` 定义 SaaS 服务发现(可选)，`envOverlay` 分环境重写配置(可选)

### 进程信息（spec.processes）

进程信息定义字段，类型为数组结构：

- `name`: (必填，string) 进程名。由小写字母和数字组成的字符串
- `procCommand`: (必填，string) 启动进程的脚本命令
- `services`: (可选，object) 进程服务配置。用于为 SaaS 应用的进程配置网络服务，它可以向集群内暴露网络服务，以支持进程间的访问；同时也可以向集群外暴露网络服务，以满足集群外部访问需求。不配置，表示进程不提供网络服务
- `replicas`: (可选，integer) 进程副本数。默认为 1，当前版本支持的最大值为 5
- `resQuotaPlan`: (可选，string) 资源限额套餐。可选值 `default`, `4C1G`, `4C2G`, `4C4G`，默认值为 `default`
- `probes`: (可选，object) 探针

`services` 字段配置示例:

```yml
spec:
  processes:
    - name: web
      services:
        - name: web
          protocol: TCP
          exposedType:
            name: bk/http
          targetPort: 5000
          port: 80
        - name: metrics
          protocol: TCP
          targetPort: 5001
          port: 5001
```

- `name`: (string) 服务名
- `targetPort`: (integer) 服务实际转发到的目标容器端口。允许设置成字符串`${PORT}`, 表示使用平台默认端口 5000
- `protocol`: (可选, string) 4 层服务协议，可选值 TCP/ UDP, 默认 TCP
- `exposedType`:（可选, object）向集群外暴露服务的类型。不设置或者指定为 null 时，表示不对集群外暴露服务，仅集群内访问
- `port`: (可选, integer) 是从集群内访问服务的端口, 默认与 targetPort 取值相同。设置 exposedType 字段时，集群外的访问端口由具体的暴露方案(约定)生成

启用 `exposedType` 字段，表示当前服务提供对集群外访问。字段说明：
- `name`: (string) 暴露服务的类型名, 命名规则{实现方案}/{应用层协议}。目前仅支持 `bk/http`, 表示使用平台内置的 DomainGroupMapping 方案，即访问入口。后续会支持其他类型选项，如 `bk/grpc`， `apisix/http` 等。

> `port` 字段与访问地址的说明：以上面的配置为例，假设集群内进程的域名是 `example.local`, 外部域名是 `example.com`。 `web` service 设置了 `exposedType`, 因此集群内的访问地址是 `example.local:5000`, 集群外的访问地址是 `example.com:80`(由 `bk/http` 方案生成)。`metrics` service 没有设置 `exposedType`，因此只能从集群内访问，访问地址是 `example.local:5001`

> 特别说明：当前不支持 router 配置，因此每个模块下，只能有一个名为 `bk/http` 类型的 service，即访问入口

`probes` 字段配置示例:

```yml
probes:
  liveness:
    httpGet:
      port: 5000
      path: "/"
    initialDelaySeconds: 30
    timeoutSeconds: 10
    periodSeconds: 10
    successThreshold: 1
    failureThreshold: 3
  readiness:
    tcpSocket:
      port: 5000
  startup:
    exec:
      command:
        - "/bin/bash"
        - "-c"
        - "echo ready"
```

- `liveness/readiness/startup`: 分别表示存活，就绪，启动探针，三者可共存
- `httpGet/tcpSocketTCP/exec`: 分别表示不同的探针配置，三者互斥
- `httpGet`: HTTP 探针配置
  - `port`: 探测端口
  - `path`: 请求路径
- `tcpSocketTCP`: TCP 探针配置
  - `port`: 探测端口
- `exec`: 命令探针配置
  - `command`: 命令行数组
- `initialDelaySeconds`: (可选，integer) 容器启动后等待时间。默认 0 s
- `timeoutSeconds`: (可选，integer) 探针执行超时时间。默认 1 s
- `periodSeconds`: (可选，integer) 探针执行间隔时间。默认 10 s
- `successThreshold`: (可选，integer) 连续几次检测成功后，判定容器是健康的。默认 1 次
- `failureThreshold`: (可选，integer) 连续几次检测成功后，判定容器是健康的。默认 3 次

### 环境变量（spec.configuration）

环境变量定义字段 `spec.configuration.env`， 类型为数组结构：

- `name`: (必填，string) 环境变量名，长度大于 1，以大写字母开头，由大写字符（A-Z）、数字（0-9）与下划线（\_）组成，不能使用系统保留前缀开头，不能使用系统保留名称
- `value`: (必填，string) 环境变量值

**特别说明**:

- 系统保留环境变量前缀: `IEOD_`, `BKPAAS_`, `KUBERNETES_`
- 系统保留环境变量名（部分）: `SLUG_URL`, `HOME`, `S3CMD_CONF`, `HOSTNAME`

> 在 `spec.configuration.env` 字段定义的环境变量，会在 SaaS 的所有部署环境下生效。如果想针对某个特定环境设置环境变量，可使用后面介绍的 `envOverlay.envVaribles` 字段。

### 钩子命令（spec.hooks）

钩子命令定义字段，允许开发者在应用生命周期内的某些特定阶段完成指定操作。蓝鲸 SaaS 模型目前仅支持一种钩子命令：`spec.hooks.preRelease`

- `procCommand`: (必填，string) 脚本命令

### 增强服务（spec.addons）

增强服务定义字段，类型为数组结构。蓝鲸 SaaS 应用可以根据自身的需求，选择性地启用增强服务

- `name`: (必填，string) 增强服务的服务名
- `specs`: (可选，数组 object) 增强服务的规格配置。未进行设置时，将采用推荐配置进行资源分配
  - `name`: (必填，string) 规格名。如 version
  - `value`: (必填，string) 规格值。如 5.7
- `sharedFromModule`: (可选，string) 应用的模块名。设置后，会共享模块对应的增强服务，与 `specs` 互斥

目前 `name` 和 `specs` 都必须是平台提供的有效值，否则会绑定或者分配失败

### 服务发现（spec.svcDiscovery）

SaaS 服务发现定义字段 `spec.svcDiscovery.bkSaaS`，类型为数组结构：

- `bkAppCode`:(必填，string) 蓝鲸应用的 Code
- `moduleName`:(可选，string) 应用的模块名称，不设置时表示“主模块“(isDefault 为 True 的模块)

> 如果只需要获取应用的主访问地址，不关注具体模块，建议不指定 moduleName 字段。

应用在部署后，可通过名为 `BKPAAS_SERVICE_ADDRESSES_BKSAAS` 的环境变量读取到相应的访问地址，值是一个经过 base64 编码过的 Json 对象，因此读取时需要解码。解码后的结构如：

```json
[
  {
    // key - 用于匹配 SaaS 信息的键
    "key": { "bk_app_code": "bk-iam", "module_name": null },
    // 访问信息，stag 代表预发布环境，prod 代表生产环境
    "value": {
      "stag": "http://stag-dot-bk-iam.example.com",
      "prod": "http://bk-iam.example.com"
    }
  },
  {
    "key": { "bk_app_code": "bk-user", "module_name": "api" },
    "value": {
      "stag": "http://stag-dot-api-dot-bk-user.example.com",
      "prod": "http://prod-dot-api-dot-bk-user.example.com"
    }
  }
]
```

### 域名解析（spec.domainResolution）

应用可使用 `spec.domainResolution` 字段来配置与“域名解析”相关的网络配置项，其中包括指定 DNS 服务器、向 /etc/hosts 中追加域名解析规则等。

#### DNS 服务器（nameservers）

应用可使用 `nameservers` 字段来添加额外的 DNS 服务器。示例配置如下：

```yml
spec:
  domainResolution:
    nameservers:
      - "8.8.8.8"
      - "114.114.114.114"
```

字段说明：
- `nameservers`: (必填，array[string]) DNS 服务器地址列表，最多支持 2 条内容

> 此处定义的主机列表，将和集群默认的 DNS 服务器列表合并去重后，共同生效。

#### 域名解析规则（hostAliases）

应用可通过 `hostAliases` 字段来添加额外的域名解析规则（效果等同于向 /etc/hosts 文件中追加条目）。示例配置如下：

```yml
spec:
  domainResolution:
    hostAliases:
      - ip: "127.0.0.1"
        hostnames:
        - "foo.local"
        - "bar.local"
```

字段说明：
- `ip`: (必填，string) 解析目标 IP 地址
- `hostnames`: (必填，array[string]) 待解析的域名列表

### 分环境重写（spec.envOverlay）

每个蓝鲸 SaaS 拥有两个不同的部署环境：预发布（stag）和生产（prod）。如果需要针对某个环境进行一些差异化的设置，可以使用 `spec.envOverlay` 字段。目前支持三个字段：`replicas`，`envVaribles`，`resQuotas`

`spec.envOverlay.replicas` 主要用来设置进程在特定环境下的副本数。通常，预发布环境配置较少的副本数，以减少资源占用，示例如下：

```yml
spec:
  envOverlay:
    replicas:
      - envName: stag
        process: web
        count: 1
```

字段说明：

- `envName`: (必填，string) 生效环境名。可选值： `stag` / `prod`
- `process`: (必填，string) 进程名
- `count`: (必填，integer) 副本数

`spec.envOverlay.envVaribles` 主要定义那些仅针对某个环境生效的环境变量。数组类型，优先级高于 `configuration.env` 字段。示例如下：

```yml
spec:
  envOverlay:
    envVariables:
      - envName: stag
        name: ENV_ONLY_FOR_STAG
        value: foo
```

字段说明：

- `envName`: (必填，string) 生效环境名。可选值： `stag` / `prod`
- `name`: (必填，string) 环境变量名
- `value`: (必填，string) 环境变量值

`spec.envOverlay.resQuotas` 主要用来设置进程在某个环境下的资源配额方案。数组类型, 示例如下：

```yml
spec:
  envOverlay:
    resQuotas:
      - envName: stag
        process: web
        plan: 4C2G
```

字段说明：

- `envName`: (必填，string) 生效环境名。可选值： `stag` / `prod`
- `process`: (必填，string) 进程名
- `plan`: (必填，string) 资源套餐名称。可选值 `default`, `4C1G`, `4C2G`, `4C4G`

### 可观测服务配置（observability）

`spec.observability` 字段用于配置应用的可观测服务

#### 自定义 metrics 配置

`spec.observability.monitoring.metrics` 支持配置自定义 metrics

```yml
spec:
  processes:
    - name: web
      services:
        - name: metrics
          protocol: TCP
          port: 5000
          targetPort: 5000
  observability:
    monitoring:
      metrics:
        - process: web
          serviceName: metrics
          path: /
          params:
            key1: value1
            key2: value2
```

- `process`: (string) 关联的进程名
- `serviceName`: (string) 关联的 service 名
- `path`: (string) 请求 metric 接口的路径
- `params`: (可选, dict) 请求 metric 接口需要附带的额外参数


**附录：如何通过 python 获取并解析 `BKPAAS_SERVICE_ADDRESSES_BKSAAS` 的值**

```python
# 仅适用于 Python3
>>> import json
>>> import base64
>>> import os
>>> value = os.environ['BKPAAS_SERVICE_ADDRESSES_BKSAAS']
>>> decoded_value = json.loads(base64.b64decode(value).decode('utf-8'))
>>> decoded_value
[...]
```

快捷使用：如果你没有定义任何 `moduleName`，只需要应用主模块的地址。那你可以用以下代码基于结果列表构建一个字典，用它来快速拿到应用主模块的正式环境访问地址。

```python
>>> prod_only_addr = {item['key']['bk_app_code']: item['value']['prod'] for item in decoded_value}
>>> prod_only_addr
{'bk-user': ..., 'bk-iam': ...}
```

## 应用描述文件位置说明

S-mart 应用的描述文件 `app_desc.yaml` 必须放置在代码的根目录下，示例目录结构如下：

- 单模块应用：
```
├── app_desc.yml
├── urls.py
└── requirements.txt
```

- 多模块应用：
```
├── app_desc.yml
└── src
    ├── backend
    |   └── requirements.txt
    └── frontend
        └── package.json
```

对于非 S-mart 应用，系统将优先从代码仓库的`根目录`读取 app_desc.yaml 文件，若未找到，则会从`构建目录`中读取。