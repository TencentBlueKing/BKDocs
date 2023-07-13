## 应用描述文件

`app_desc.yaml` 是一种用来描述蓝鲸应用的配置文件。

要使用该特性，开发者需要在应用根目录创建名为 `app_desc.yaml` 的配置文件，然后填入符合格式要求的配置信息。基于这些配置信息，开发者可以实现自定义市场配置、增加环境变量等功能。

> S-mart 应用也是使用 `app_desc.yaml` 文件描述的。

## 示例配置

一个标准的 `app_desc.yaml` 配置文件示例如下：

```yml
spec_version: 2
app_version: "1.0"
app:
    region: default
    bk_app_code: "foo-app"
    bk_app_name: 默认应用名称
    market:
        category: 运维工具
        introduction: 应用简介
        description: 应用描述
        display_options:
            width: 800
            height: 600
modules:
    frontend:
        is_default: True
        source_dir: src/frontend
        language: NodeJS
        services:               # 增强服务配置仅对 Smart 应用生效
            - name: mysql
            - name: rabbitmq
        env_variables:
            - key: FOO
              value: value_of_foo
              description: 环境变量描述文件
        processes:
            web: 
                command: npm run server
                plan: 4C1G5R
                replicas: 2            # 副本数不能超过 plan 中定义的值
        scripts:
            pre_release_hook: bin/pre-release.sh  
        svc_discovery:
            bk_saas:
                - 'bk-iam'
                - 'bk-user'
```
注意：

- `app` 下的信息只对 Smart 应用生效，非 Smart 应用以产品页面上信息为准
- `app.region` 在私有化版本的取值是：default
- 模块名：由小写字母和数字以及连接符(-)组成，不能超过 16 个字符
- 只包含一个模块的普通应用，modules 相关的信息可以直接放到顶层，如

```yml
spec_version: 2
app_version: "1.0"
app:
    region: default
    bk_app_code: "foo-app"
    bk_app_name: 默认应用名称
    market:
        category: 运维工具
        introduction: 应用简介
        description: 应用描述
        display_options:
            width: 800
            height: 600
modules:
    frontend:
        is_default: True
        source_dir: src/frontend      # 没有这个项则默认为根目录
        language: NodeJS
        services:
            - name: mysql
            - name: rabbitmq
        env_variables:            # yml 文件中定义的环境变量，在产品页面上不会显示出来     
            - key: FOO
            value: value_of_foo
            description: 环境变量描述文件
        processes:               # 普通应用不填则使用 Procfile
            web: 
                command: npm run server
                plan: 4C1G5R
                replicas: 2            # 副本数不能超过 plan 中定义的值
        scripts:
            pre_release_hook: bin/pre-release.sh  
        svc_discovery:
            bk_saas:
                - 'bk-iam'
                - 'bk-user'
```

## 字段说明（基础配置）

### spec_version

（必选，integer）配置文件版本，可选值：

- `2`：当前版本
- `1`：旧版 S-mart 应用格式，**已废弃，不要使用**

### app_version

（可选，string）应用版本号，如 `1.0`。当应用通过压缩包提供源码时，必须提供该字段。`app_version` 的值，将会作为应用版本在应用“源码包管理”页面中展示。

## 字段详细说明（应用部分）

该部分配置主要用于描述应用，字段名 `app`。

其中的 `region`、`bk_app_code`、`bk_app_name` 字段，仅对 S-mart 应用有效。其他类型应用，会在配置解析阶段忽略这些字段。

剩余字段适用于所有类型应用。

> **问题：仅对 S-mart 应用有效是什么意思？**
> 
> S-mart 应用是平台支持的一类特殊应用，它们只能通过上传“S-mart 压缩包”来创建，更新同理。
> 
> 如果某字段仅对 S-mart 应用有效，这表示只有当用户实施以下动作时，平台才会解析并使用这个字段：
> 
> - 上传 S-mart 应用包，并创建新应用
> - 进入已存在的 S-mart 应用，上传新版本压缩包

### S-mart 专用字段

#### region

（可选，string）应用所属版本代号。如不提供，将在用户通过压缩包创建应用时，使用该用户的默认可用应用版本。

- 仅 S-mart 应用有效
- 应用创建后不允许修改

#### bk_app_code

（可选，string）应用 ID，由小写字母、数字、连字符(-)组成，首字母必须是字母，长度小于 **16**，不能与其他应用重复。

- 仅 S-mart 应用有效，创建时必须提供
- 创建后不允许修改

#### bk_app_name

（可选，string）应用名称，由汉字、英文字母、数字组成，长度不超过 **20**，不能与其他应用重复。

- 仅 S-mart 应用有效，创建时必须提供
- 创建后不允许修改

### 市场配置（market）

（可选, 对于 S-Mart 应用必填，object）描述应用在蓝鲸应用市场的属性。

- `category`：（可选、string）应用类型，点击查看所有可选类型（TODO）
- `introduction`：（必选，string）应用简介
- `description`：（可选，string）应用描述文字
- `display_options`：（可选，object）显示选项，详见说明

`display_options` 字段说明，可选字段：

- `width`：（可选，integer）窗口宽度（像素）
- `height`：（可选，integer）窗口高度（像素）
- `is_win_maximize`: (可选, boolean) 是否最大化显示, 默认值 False
- `visible`: (可选, boolean) 是否在桌面展示, 默认值 True
- `open_mode`: (可选, string) 从桌面的打开方式, 默认值: "desktop", 可选值 "desktop"(从桌面打开), "new_tab"(从新标签页打开)

示例：

```yml
app:
    market:
        category: 运维工具
        introduction: 应用简介
        description: 应用描述
        display_options:
            width: 800
            height: 600
            open_mode: desktop
            is_win_maximize: False
            open_mode: True
```

### 模块信息
（必选，dict）描述应用的模块信息，格式如下
- `is_default`: (可选，bool) 是否为主模块,默认值为 False，注意一个应用`有且只有一个`主模块
- `source_dir`: （必填，string）部署目录，必须包含所有需要的代码，比如部署前置命令(pre-compile 和 post-compile）都只能操作部署目录下的文件，不填则默认为根目录
- `language`: (必填，string，可选值：Python、NodeJS)，模块的开发语言，会根据开发语言来给模块绑定默认的构建工具
- `processes`: （可选，dict）进程信息，Smart 应用必填，普通应用不填则使用 Procfile
```yml
modules:
    frontend:
        is_default: True
        source_dir: src/frontend
        language: NodeJS
    api_server:
        is_default: False
        source_dir: src/backend
        language: Python
        processes: 
            web: 
                command: npm run server
                plan: 4C1G5R
                replicas: 2            # 副本数不能超过 plan 中定义的值
```
### 增强服务（services）

（可选，array）描述应用的**默认模块**所需增强服务，类型为数组，包含多个描述增强服务的对象，格式如下：

- `name`：（必选，string）增强服务名称，私有化版本可选项为： `mysql`、`redis`、`rabbitmq`、`bkrepo`
- `shared_from`: (可选，string）共享服务实例的模块名

该字段仅支持追加，如果应用在更新配置文件时，删除了已有的增强服务，将不会造成任何影响。

**说明**： 增强服务配置仅对 Smart 应用生效
示例：

```yml
services:
    - name: mysql
      shared_from: default
    - name: redis
```

目前无法通过该字段配置默认模块以外的增强服务。

## 字段详细说明（部署部分）
### 部署命令 (processes)
（可选）字典类型, 内容为应用的进程信息，Smart 应用必填，普通应用不填则使用 Procfile。通过配置文件定义应用的部署命令后, 在部署阶段平台将以对应的命令启动进程。
**注意**: 应用代码中如果存在 Procfile 文件, 该配置将不会生效。

- `command`: (string), 部署进程的启动命令, 进程将以该指令启动。
- `plan`: (可选, string), 进程的资源配额
- `replicas`: (可选, int) 进程的副本数, 默认值为 1, 副本数不能超过 plan 中定义的值。

说明： plan: （可选）应用使用的资源配置类型，可单独针对每个进程名称配置
资源套餐的具体含义如下：
```json
{
    "4C1G5R": {
        // 最大副本数量
        'max_replicas': 5,
        // 最大资源限制
        'limits': {'cpu': '4096m', 'memory': '1024Mi'},
        // 最小资源需求
        'requests': {'cpu': '100m', 'memory': '64Mi'}
        },
    "4C2G5R": {
        // 最大副本数量
        'max_replicas': 5,
        // 最大资源限制
        'limits': {'cpu': '4096m', 'memory': '2048Mi'},
        // 最小资源需求
        'requests': {'cpu': '100m', 'memory': '64Mi'}
    },
    "4C4G5R": {
        // 最大副本数量
        'max_replicas': 5,
        // 最大资源限制
        'limits': {'cpu': '4096m', 'memory': '4096Mi'},
        // 最小资源需求
        'requests': {'cpu': '100m', 'memory': '64Mi'}
    }
}
```

### 额外脚本（scripts）
（可选）字典类型, 内容为模块构建、部署阶段需要执行的额外脚本。
- `pre_release_hook`: (可选, string), 部署前执行的钩子脚本, 例如在 release 阶段前执行 migrate 操作。

**注意**: 
1.`pre_release_hook` 的指令具有一定的限制, 例如不能以 start 开头、只能是一条命令等, 详细的介绍请看 [部署(Release)阶段钩子](../../topics/paas/release_hooks.md)。

2.部署前置命令也可以在产品页面上定义，如果在页面上定义了将会覆盖 app_desc.yaml 文件中定义的内容，请知悉。

示例:
```yaml
modules:
    api_server:
        is_default: True
        source_dir: src/backend
        language: Python
        processes: 
            web: 
                command: python manage.py runserver
                plan: 4C1G5R
                replicas: 2            # 副本数不能超过 plan 中定义的值
        scripts:
            pre_release_hook: python manage.py migrate
```

### 环境变量（env_variables）

（可选）列表类型，内容为应用环境变量。通过配置文件定义应用环境变量后，在构建阶段及部署后，应用可以通过系统接口读取这些环境变量。

**注意**：环境变量也可以在产品页面上定义，如果在页面上定义了将会覆盖 app_desc.yaml 文件中定义的内容，请知悉。

- `key`：(string) 长度大于 1，以大写字母开头，由大写字符（A-Z）、数字（0-9）与下划线（_）组成，不能使用系统保留前缀开头，不能使用系统保留名称
- `value`：(string) 环境变量值
- `description`：(可选，string) 环境变量说明
- `environment_name`: (可选，string，可选值：stag、prod) 环境变量生效的环境，不填则默认对所有环境生效

系统保留环境变量前缀：

- `IEOD_`
- `BKPAAS_`
- `KUBERNETES_`

系统保留环境变量名（部分）：

- `SLUG_URL`
- `HOME`
- `S3CMD_CONF`
- `HOSTNAME`

示例：

```yml
env_variables:
    - key: FOO
      environment_name: stag
      value: value_of_foo
      description: 环境变量描述文件
```

### 进程资源配置（package_plans）

（可选）应用使用的资源配置类型，可单独针对每个进程名称配置。该字段类型为 `object`，其中 `key` 为需要配置的进程名称，`value` 为资源套餐名称。

示例：

```yml
package_plans:
    web: Starter
```

表示 `web` 进程将使用名为 `Starter` 的资源套餐。

### 服务发现配置（svc_discovery）

（可选）应用的服务发现相关配置，开发者可通过该字段配置依赖服务等信息。

- `bk_saas`：（array[object]）应用所依赖的其他蓝鲸 SaaS 信息。该项被配置后，平台将在应用部署后，通过环境变量注入该列表内所有 SaaS 的访问地址。

举例来说，如果应用使用了下面的配置：

```yml
svc_discovery:
    bk_saas:
        - bk_app_code: 'bk-iam'
        - bk_app_code: 'bk-user'
          module_name: 'api'
```

`bk_saas` 内部 SaaS 信息包含以下字段：

- `bk_app_code`：（string）代表蓝鲸 SaaS 应用 Code
- `module_name`：（string）模块名称，可选。不提供时，表示使用应用的“主模块”

应用在部署后，可通过名为 `BKPAAS_SERVICE_ADDRESSES_BKSAAS` 的环境变量读取到 `bk-iam` 的“主模块”与 `bk-user` 应用的 api 模块的访问地址。

该环境变量值是一个经过 base64 编码过的 Json 对象，对象格式为：

```json
[
  {
    // key - 用于匹配 SaaS 信息的键
    "key": {"bk_app_code": "bk-iam", "module_name": null},
    // 访问信息，stag 代表预发布环境，prod 代表生产环境
    "value": {
	  "stag": "http://stag-dot-bk-iam.example.com",
	  "prod": "http://bk-iam.example.com"
	}
  },
  {
    "key": {"bk_app_code": "bk-user", "module_name": "api"},
	"value": {
	  "stag": "http://stag-dot-api-dot-bk-user.example.com",
	  "prod": "http://prod-dot-api-dot-bk-user.example.com",
	}
  },
]
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
>>> decoded_value
[...]
```

快捷使用：如果你没有定义任何 `module_name`，只需要应用主模块的地址。那你可以用以下代码基于结果列表构建一个字典，用它来快速拿到应用主模块的正式环境访问地址。

```python
>>> prod_only_addr = {item['key']['bk_app_code']: item['value']['prod'] for item in decoded_value}
>>> prod_only_addr
{'bk-user': ..., 'bk-iam': ...}
```
