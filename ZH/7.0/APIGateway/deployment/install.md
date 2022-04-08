# BK-APIGateway

BK-APIGateway 是由蓝鲸 PaaS 平台开发的 API 网关服务，主要提供请求代理、请求策略控制等功能。本文档内容为如何在 Kubernetes 集群上部署 BK-APIGateway 服务。

## 准备服务依赖

开始部署前，请准备好一套 Kubernetes 集群（版本 1.12 或更高），并安装 Helm 命令行工具（3.0 或更高版本）。

> 注：如使用 BCS 容器服务部署，可用 BCS 的图形化 Helm 功能替代 Helm 命令行。

### 数据存储

以下为 BK-APIGateway 必须使用的数据存储服务：

- MySQL：用于存储关系数据，要求版本为 `5.7` 或更高；
- Redis：用于保存缓存数据，提升网关性能；
- RabbitMQ：作为任务队列使用；

> 注：你可以选择自己搭建，或者直接从云计算厂商处购买这些服务，只要能保证从集群内能正常访问即可。

下面的服务为 **非核心** 依赖，即便不提供，也不影响程序主体功能：

- Elasticsearch：用于查询访问日志，要求版本 `7.0` 或更高；

### 其他服务

要正常运行 BK-APIGateway，除了准备核心的数据存储外，还需要用到一些蓝鲸体系内的其他服务，它们是：

- 蓝鲸 SSM：依赖其 API 接口校验敏感信息
- 蓝鲸 Login：依赖其 API 接口校验用户
- 蓝鲸 PaaS2：依赖其 MySQL 数据库，读取与管理应用身份信息
  - 要求版本必须为 **2.12.18** 及以上

除以上服务外，还有其他几个依赖服务，如不提供也不会影响程序主要功能，但部分非核心功能可能会不可用：

- 蓝鲸 PaaS3：依赖其 API 接口
  - 如缺失，网关的“主动授权”等功能将无法正常使用
- 蓝鲸 BCS 容器服务（版本 1.3.25 以上）：用于简化部署
  - 如缺失，对程序功能没有任何影响

准备好依赖服务后，下一步是编写 `values.yaml` 配置文件。

## 准备 `values.yaml`

BK-APIGateway 无法直接通过 Chart 所提供的默认 `values.yaml` 完成部署，在执行 `helm install` 安装服务前，你必须按以下步骤准备好匹配当前部署环境的 `values.yaml`。

### 1. 配置镜像地址

编写配置文件的第一步，是将 `image.registry` 配置为你所使用的镜像源地址。然后，再确认每个模块所使用镜像 tag 是否正确。

##### `values.yaml` 配置示例：

```yaml
image:
  # 请保证服务相关的容器镜像已上传至该 registry 中
  registry: "mirrors.example.com/bkee/"
  pullPolicy: "IfNotPresent"
...
apigateway:
  image:
    repository: "apigateway"
    tag: "1.0.0"
dashboard: 
  image:
    repository: "apigateway-dashboard"
    tag: "1.0.0"
dashboard-fe: 
  image:
    repository: "apigateway-dashboard-fe"
    tag: "1.0.0"
api-support: ...
api-support-fe: ...
caddy: ...
bk-esb: ...
```

> 注：假如服务镜像需凭证才能拉取。请将对应密钥名称写入配置文件中，详细请查看 `global.imagePullSecrets` 配置项说明。

### 2. 配置数据加密密钥

BK-APIGateway 服务使用对称加密算法保障敏感配置与服务数据安全。要启用加密功能，你首先得创建一个独一无二的密钥。该密钥内容为 **长度为 32 的字符串（需 base64 编码）**。

在 Linux 系统中，你可执行以下命令生成一个随机密钥：

```bash
$ tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64
```

或者调用 Python 命令：

```bash
$ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(base64.b64encode(s.encode()).decode())'
```

拿到密钥后，下一步是将其放入 `encryptKey` 配置项中。

注意事项:

- 密钥一旦生成并配置好以后，不可修改，否则会导致数据异常；
- 为了你的数据安全，请不要将密钥泄露给其他人。

##### `values.yaml` 配置示例：

```yaml
encryptKey: "b3BmRmpwYWNoZH..."
```

> 注：在下一步生成加密配置项时，该密钥马上就会投入使用。

### 3. 初始化与配置数据存储

准备好服务所依赖的存储后，必须完成以下初始化操作：

**MySQL**

1. 创建普通用户 `bk_apigateway`；
2. 创建数据库 `bk_apigateway` 和 `bk_esb`，授予用户 `bk_apigateway` 合适的访问权限；
3. 对于已有的 PaaS2 服务数据库 `open_paas`，授予用户 `bk_apigateway` 合适的访问权限；

**Redis**

1. 使用 redis-cli 命令测试 Redis 可正常连接使用

**RabbitMQ**

1. 创建用户 `bk_apigateway`；
2. 创建 vhost `bk_apigateway`，授予用户 `bk_apigateway` 合适的权限；

参考命令：

```bash
# 创建用户
$ rabbitmqctl add_user bk_apigateway {password}

# 创建 vhost 并给 vhost 赋予权限
$ rabbitmqctl add_vhost bk_apigateway
$ rabbitmqctl set_permissions -p bk_apigateway bk_apigateway ".*" ".*" ".*"
```

以下初始化操作为可选，仅在你准备了对应服务时执行：

**Elasticsearch**

1. 与日志采集方案使用的 Elasticsearch 保持一致，确保已启用 BK-APIGateway 日志的采集，日志采集方案可咨询部署相关人员；
2. 创建用户 `bk_apigateway`；

#### 填写数据存储配置

为简化配置，快速定义多个数据，每类资源配置可使用 `default` 来定义公共配置，以 database 为例，即：

```yaml
database:
  apigw:
    host: mysql.example.com
    port: 3306
    user: bk_apigateway
    passwordEncrypted: "xxxxxx"
    name: "bk_apigateway"
  esb:
    host: mysql.example.com
    port: 3306
    user: bk_apigateway
    passwordEncrypted: "xxxxxx"
    name: "bk_esb"
```

可被缩写为：

```yaml
database:
  default:
    host: mysql.example.com
    port: 3306
    user: bk_apigateway
    passwordEncrypted: "xxxxxx"
  apigw:
    name: "bk_apigateway"
  esb:
    name: "bk_esb"
```

在填写数据存储相关配置项时，有一个重要注意事项：所有存储服务所使用的的“密码”均为加密配置，你必须提供加密后的密文密码。具体加密方式，请参考 “常见问题：如何对数据进行加密”部分。

##### `values.yaml` 配置示例：

```yaml
database:
  default:
    host: mysql.example.com
    port: 3306
    user: bk_apigateway
    # 注意：该字段需要配置加密后的值
    passwordEncrypted: akRxZEtF...
  apigw:
    name: bk_apigateway
  esb:
    name: bk_esb
  paas2:
    name: open_paas
    # 若 paas2 数据库与 default 不一致，可单独配置
    # host: paas2.example.com
    # port: 3306
    # user: bk_apigateway
    # 注意：该字段需要配置加密后的值
    # passwordEncrypted: akRxZEtF...

# `redis` 与 `rabbitmq` 部分配置请参考对应配置项详细说明。
redis:
  default:
    ....

rabbitmq:
  default:
    ...
```

### 4. 配置 PaaS2 服务依赖

为了让 BK-APIGateway 正常工作，各子服务需要使用蓝鲸 PaaS 的应用身份（包括 AppCode  和 AppSecret）进行标识。该应用身份除起到标识作用外，还会在调用蓝鲸其它服务时用于鉴权，比如访问 SSM 接口。

需创建或获取以下蓝鲸应用账号：

- `bk_apigateway`，供 API Gateway 服务使用
- `bk_apigw_test`：供 API Gateway 的“在线调试”功能使用
- `bk_paas`：供 ESB 使用，PaaS2 部署时已创建

其中，`bk_apigateway` 需要被添加到“ESB 免用户认证应用白名单”中。

> 注：正常来说，应用创建需要使用 PaaS2 的后台 Admin 管理系统才能完成。不过，用运维脚本直接操作 PaaS2 下的 esb_app_account 数据表也行。

创建并获取应用账号后，将各应用的 app secret 按照以下对应关系，配置到 `values.yaml` 中：

| 应用          | 配置                                  |
| ------------- | ------------------------------------- |
| bk_apigatway  | keys.apigatewayAppSecretEncrypted     |
| bk_apigw_test | keys.apigatewayTestAppSecretEncrypted |
| bk_paas       | keys.paas2AppSecretEncrypted          |

**注意：和数据库密码一样，上面以 “Encrypted” 结尾的字段都需要加密。**

除了配置上面的 app secret 外，BK-APIGateway 服务还需要访问 PaaS2 的数据库来查询数据，这部分配置通过 `database.paas2` 配置项完成，请确保此配置项已配置正确。

##### `values.yaml` 配置示例：

```yaml
keys:
  apigatewayAppSecretEncrypted: {ENCRYPTED_VALUE}
  apigatewayTestAppSecretEncrypted: {ENCRYPTED_VALUE}
  paas2AppSecretEncrypted: {ENCRYPTED_VALUE}
```

### 5. 配置 PaaS3 服务依赖

BK-APIGateway 服务的部分功能，需要通过调用 PaaS3 的 API 来完成，比如在主动授权页面里查询应用信息，等等。在调用 PaaS3 的接口时，为了保证安全，API Gateway 需要提供一个 PrivateToken 鉴权令牌，Token 格式为 **长度为 30 的随机字符串**。

在 Linux 系统中，PrivateToken 可使用以下命令生成：

```shell
$ tr -dc A-Za-z0-9 </dev/urandom | head -c 30
```

或者使用 Python 命令：

```shell
$ python -c 'import random, string; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(30)); print(s)'
```

取得 Token 后，将其配置在 `keys.paasPrivateToken` 中。

**注意：** 此操作流程仅适用于“先部署 BK-APIGateway，后部署 PaaS3”的部署顺序。在该流程下，Token 由部署 BK-APIGateway 时生成，
后通过在部署 PaaS3 服务时，将同一个 Token 配置为 `BK_PAAS3_PRIVATE_TOKEN_FOR_APIGW` 环境变量中完成匹配，
详情请查看 PaaS3 部署文档中的对应内容。

如果在部署 BK-APIGateway 时，PaaS3 已经生成好了 PrivateToken，那么请跳过以上的生成 Token 步骤，直接取用已有 Token 值。

##### `values.yaml` 配置示例：

```yaml
keys:
  paasPrivateToken: ...
```

### 6. 配置服务访问域名

BK-APIGateway 服务的主要访问地址，由 `bkdomain` 配置项所控制。为了简化配置，此处采用了“配置一个根域，发散多个子域”的方式。

举例来说，如果 `bkdomain` 值为 `example.com`，那么服务的每个模块的访问域名为：

- 云 API 访问域名（apigateway/bk-esb）：`bkapi.example.com`
- API 网关主站域名（dashboard-fe）：`apigw.example.com`
- API 网关主站后端接口域名（dashboard）：`apigw-backend.example.com` 
- API 帮助中心域名（api-support-fe）：`docs-apigw.example.com`
- API 帮助中心后端接口域名（api-support）：`docs-apigw-backend.example.com`

为了让服务能被正常访问，以上域名需要在 DNS 服务中被配置为“指向 Ingress Controller 所在 IP”。如果这些域名并非真实存在，那你就得用一些其他手段来确保域名被正常解析。

举例来说，对于访问 APIGateway 的本地浏览器和其他客户端，你得修改系统的 `/etc/hosts` 文件，添加对应域名的指向记录，如：

```plain
# 将 127.0.0.1 替换为 Ingress Controller 的可访问 IP
127.0.0.1 bkapi.example.com
127.0.0.1 apigw.example.com
127.0.0.1 apigw-backend.example.com
127.0.0.1 docs-apigw.example.com
127.0.0.1 docs-apigw-backend.example.com
```

除此之外，部署在集群内的各个子模块之间，也会通过这些域名来互相调用对方。若集群内无法解析这些域名，可修改集群内的 DNS 服务，添加对应解析记录，或者设置 `global.HostAliases` 配置，具体可参考：[Adding entries to Pod /etc/hosts with HostAliases](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/)

##### `values.yaml` 配置示例：

```yaml
bkdomain: example.com
```

### 7. 其他外部依赖

BK-APIGateway 服务在运行过程中，需要涉及许多其他服务。请配置以下外部依赖地址：

- 蓝鲸登录服务接口地址：`externalDependencies.bkLoginApiURL`
- SSM 服务接口地址：`externalDependencies.bkSsmApiURL`
- 蓝鲸文档中心地址：`externalDependencies.bkDocsURLPrefix`

##### `values.yaml` 配置示例：

```yaml
externalDependencies:
  bkLoginApiURL: ...
  bkSsmApiURL: ...
  bkDocsURLPrefix: ...
```

> 注意：若集群内无法解析 bkLoginApiURL、bkSsmApiURL 配置的域名，可修改集群内的 DNS 服务，或设置 `global.HostAliases` 配置。

### 8. 处理 ESB 专用配置

ESB 专用配置，主要用于启用接入 ESB 的 CC、JOB 等组件系统。可先跳过此部分配置，若需使用 ESB 中 CC、JOB 等系统的组件，按需添加对应系统的配置。

> 注意：如果希望通过 PaaS2/ESB 的域名访问组件，请求也全部转发到此新版 BK-ESB，请参考“常见问题：如何切换 ESB 访问流量”，进行切换。

#### 配置 ESB 对接系统地址

ESB 作为服务总线，对接了许多蓝鲸体系下的其他子系统。要通过 ESB 访问这些系统的组件，你必须通过 `externalDependencies.*` 配置各子系统的真实接口地址。

有关各子系统的详细说明，请查看文章尾部的“配置说明”表格。

##### `values.yaml` 配置示例：

```yaml
bk-esb:
  externalDependencies:
    bkCmdbV3URL: ...
    bkJobURL: ...
    bkUsermgrURL: ...
    ...
```

> 注意：若集群内无法解析配置的地址，可修改集群内的 DNS 服务，或设置 `global.HostAliases` 配置。

可将项目内的脚本 generate_esb_external_dependencies_conf.sh 拷贝到 PaaS2 的 ESB 项目下，执行以下指令，获取 ESB 的外部依赖地址。
- 注意事项：若获取的地址为 consul 域名，需替换为集群内可访问的域名
```
workon open_paas-esb

chmod +x generate_esb_external_dependencies_conf.sh
bash generate_esb_external_dependencies_conf.sh 2>/dev/null
```

#### 配置组件系统证书

若访问 JOB、GSE 系统的组件，需配置这两个系统的证书。
证书文件由蓝鲸官方提供，可使用以下命令，将证书文件转换为配置所需的文本内容：

```shell
$ cat <THE_CERT> | base64 -w 0
```

##### `values.yaml` 配置示例：

```yaml
bk-esb:
  certs:
    - name: job_esb_api_client.crt
      base64Encoded: ...
    - name: job_esb_api_client.key
      base64Encoded: ...
    ...
```

完成 `values.yaml` 的所有准备工作后，接下来就可以进行安装了。

### 安装Chart

填写 Values.yaml 后，要安装 BK-APIGateway，你必须先添加一个有效的 Helm repo 仓库。

```shell
# 请将 `<HELM_REPO_URL>` 替换为本 Chart 所在的 Helm 仓库地址
$ helm repo add bkee <HELM_REPO_URL>
```

添加仓库成功后，执行以下命令，在集群内安装名为 `bk-apigateway` 的 Helm release（使用默认项目配置）：

```shell
# 使用 --wait 参数，因服务成功启动后，需注册默认网关
$ helm install bk-apigateway bkee/bk-apigateway --wait -f values.yaml
```

> 注意：使用 BCS 部署时，请勾选 **Helm命令行参数** 中的 `wait`，确保网关注册成功。

上述命令将使用默认配置在 Kubernetes 集群中部署 bk-apigateway, 并输出访问指引。

### 卸载Chart

使用以下命令卸载`bk-apigateway`:

```shell
$ helm uninstall bk-apigateway
```

上述命令将移除所有与 bk-apigateway 相关的 Kubernetes 组件，并删除 release。

## 配置说明
BK-APIGateway 配置包含基础配置及各模块配置，有以下几个部分
- dashboard-fe: 网关管理前端模块配置
- dashboard: 网关管理后端模块配置
- api-support-fe: API 帮助中心前端模块配置
- api-support: API 帮助中心后端模块配置
- apigateway: 网关 API 服务模块配置
- bk-esb: BK-ESB 服务模块配置
- caddy: 内部文件服务

> 注意：在以下表格中，“是否加密” 一栏为 “Y” 的配置为敏感配置，需要用 BK-APIGateway 工具加密，参考 “常见问题 - 如何对数据进行加密”


以下为可配置的参数列表以及默认值


| 参数                                    | 类型 | 是否加密 | 默认值                        | 描述                                                |
| --------------------------------------- | ---- | -------- | ----------------------------- | --------------------------------------------------- |
| image.registry                          | str  |          | mirrors.example.com           | 镜像源地址                                          |
| image.pullPolicy                        | str  |          | IfNotPresent                  | 镜像拉取策略                                        |
| replicaCount                            | int  |          | 2                             | 默认进程副本数                                      |
| nameOverride                            | str  |          |                               | 覆盖默认名称                                        |
| bkdomain                                | str  |          | example.com                   | 主要域名后缀及 Cookies 域名                         |
| debug                                   | bool |          | false                         | 是否开启调试                                        |
| encryptKey                              | str  |          |                               | 加密密钥，敏感                                      |
| managers                                | list |          | ["admin"]                     | 网关管理员                                          |
| keys.apigatewayAppSecretEncrypted       | str  | Y        |                               | bk_apigateway 应用密钥                              |
| keys.apigatewayTestAppSecretEncrypted   | str  | Y        |                               | bk_apigw_test 在线调试应用密钥                      |
| keys.paas2AppSecretEncrypted            | str  | Y        |                               | bk_paas 应用密钥                                    |
| keys.paasPrivateToken                   | str  |          |                               | PaaS3 认证 token                                    |
| database.default.host                   | str  |          | mysql.example.com             | 默认的数据库地址                                    |
| database.default.port                   | int  |          | 3306                          | 默认的数据库端口                                    |
| database.default.user                   | str  |          | bk_apigateway                 | 默认的数据库用户                                    |
| database.default.passwordEncrypted      | str  | Y        |                               | 默认的数据库密码                                    |
| database.apigw.name                     | str  |          | bk_apigateway                 | 新版 apigateway 数据库                              |
| database.esb.name                       | str  |          | bk_esb                        | 新版 esb 数据库名称，不可复用旧 esb 数据库          |
| database.paas2.name                     | str  |          | open_paas                     | paas2 数据库名称                                    |
| redis.default.host                      | str  |          | redis.example.com             | 默认的 Redis 地址                                   |
| redis.default.port                      | int  |          | 6379                          | 默认的 Redis 端口                                   |
| redis.default.passwordEncrypted         | str  | Y        |                               | 默认的 Redis 密码                                   |
| redis.default.db                        | int  |          | 0                             | 默认的 Redis 实例                                   |
| rabbitmq.default.vhost                  | str  |          | bk_apigateway                 | 默认 RabbitMQ vhost                                 |
| rabbitmq.default.host                   | str  |          | rabbitmq.example.com          | 默认 RabbitMQ 地址                                  |
| rabbitmq.default.port                   | int  |          | 5672                          | 默认 RabbitMQ 端口                                  |
| rabbitmq.default.user                   | str  |          | bk_apigateway                 | 默认 RabbitMQ 用户                                  |
| rabbitmq.default.passwordEncrypted      | str  | Y        |                               | 默认 RabbitMQ 密码                                  |
| elasticsearch.default.host              | str  |          | elasticsearch.example.com     | 默认 Elasticsearch 地址                             |
| elasticsearch.default.port              | int  |          | 9200                          | 默认 Elasticsearch 端口                             |
| elasticsearch.default.user              | str  |          | bk_apigateway                 | 默认 Elasticsearch 用户                             |
| elasticsearch.default.passwordEncrypted | str  | Y        |                               | 默认 Elasticsearch 密码                             |
| externalDependencies.bkLoginApiURL      | str  |          | http://bk-login.example.com   | 蓝鲸登录服务接口地址                                |
| externalDependencies.bkSsmApiURL        | str  |          | http://bk-ssm-api.example.com | SSM 服务接口地址                                    |
| externalDependencies.bkDocsURLPrefix    | str  |          | http://bk-docs.example.com    | 蓝鲸文档中心地址                                    |
| apigateway.enabled                      | bool |          | true                          | 是否启用网关 API 服务                               |
| apigateway.image.repository             | str  |          | apigateway                    | 网关 API 服务镜像地址                               |
| apigateway.image.tag                    | str  |          |                               | 网关 API 服务镜像标签                               |
| apigateway.ingress.name                 | str  |          | bkapi                         | 网关 API ingress 名称，与 bkdomain 合成域名         |
| dashboard.enabled                       | bool |          | true                          | 是否启用网关管理                                    |
| dashboard.image.repository              | str  |          | apigateway-dashboard          | 网关管理镜像名称                                    |
| dashboard.image.tag                     | str  |          |                               | 网关管理镜像标签                                    |
| dashboard.ingress.name                  | str  |          | apigw-backend                 | 网关管理 ingress 名称，与 bkdomain 合成域名         |
| dashboard-fe.enabled                    | bool |          | true                          | 是否启用网关管理前端                                |
| dashboard-fe.image.repository           | str  |          | apigateway-dashboard-fe       | 网关管理前端镜像名称                                |
| dashboard-fe.image.tag                  | str  |          |                               | 网关管理前端镜像标签                                |
| dashboard-fe.ingress.name               | str  |          | apigw                         | 网关管理前端 ingress 名称，与 bkdomain 合成域名     |
| api-support.enabled                     | bool |          | true                          | 是否启用API 帮助中心                                |
| api-support.image.repository            | str  |          | apigateway-api-support        | API 帮助中心镜像地址                                |
| api-support.image.tag                   | str  |          |                               | API 帮助中心镜像标签                                |
| api-support.ingress.name                | str  |          | docs-apigw-backend            | API 帮助中心 ingress 名称，与 bkdomain 合成域名     |
| api-support-fe.enabled                  | bool |          | true                          | 是否启用API 帮助中心前端                            |
| api-support-fe.image.repository         | str  |          | apigateway-api-support-fe     | API 帮助中心前端镜像地址                            |
| api-support-fe.image.tag                | str  |          |                               | API 帮助中心前端镜像标签                            |
| api-support-fe.ingress.name             | str  |          | docs-apigw                    | API 帮助中心前端 ingress 名称，与 bkdomain 合成域名 |
| caddy.enabled                           | bool |          | true                          | 是否启用 BK-ESB 配置组件                            |
| caddy.image.repository                  | str  |          | apigateway-caddy              | BK-ESB 配置组件镜像名称                             |
| caddy.image.tag                         | str  |          |                               | BK-ESB 配置组件镜像标签                             |
| bk-esb.enabled                          | bool |          | true                          | 是否启用 BK-ESB                                     |
| bk-esb.image.repository                 | str  |          | apigateway-esb                | BK-ESB 镜像名称                                     |
| bk-esb.image.tag                        | str  |          |                               | BK-ESB 镜像标签                                     |
| bk-esb.ingress.name                     | str  |          | bkapi                         | BK-ESB ingress 名称，与 bkdomain 合成域名           |

ESB 专用配置

| 参数                                                 | 类型 | 是否加密 | 默认值                                      | 描述                                          |
| ---------------------------------------------------- | ---- | -------- | ------------------------------------------- | --------------------------------------------- |
| bk-esb.certs                                         | list |          |                                             | esb 证书                                      |
| bk-esb.certs.[].name                                 | str  |          |                                             | 证书文件名                                    |
| bk-esb.certs.[].base64Encoded                        | str  |          |                                             | 证书文件内容的 base64 编码                    |
| bk-esb.externalDependencies.bkUsermgrURL             | str  |          | http://bk-usermgr.example.com               | BK-ESB 组件系统 BK-USERMGR 地址               |
| bk-esb.externalDependencies.bkCmdbV3URL              | str  |          | http://bk-cmdb-v3.example.com               | BK-ESB 组件系统 BK-CMDB-V3 地址               |
| bk-esb.externalDependencies.bkJobURL                 | str  |          | http://bk-job.example.com                   | BK-ESB 组件系统 JOB 地址                      |
| bk-esb.externalDependencies.bkGseURL                 | str  |          | http://bk-gse.example.com                   | BK-ESB 组件系统 GSE 地址                      |
| bk-esb.externalDependencies.bkGseProcHost            | str  |          | gse-proc                                    | BK-ESB 组件系统 GSE Proc 服务 Host            |
| bk-esb.externalDependencies.bkGseProcPort            | str  |          | 80                                          | BK-ESB 组件系统 GSE Proc 服务 Port            |
| bk-esb.externalDependencies.bkGseCacheapiHost        | str  |          | gse-cacheapi                                | BK-ESB 组件系统 GSE Cacheapi 服务 Host        |
| bk-esb.externalDependencies.bkGseCacheapiPort        | str  |          | 80                                          | BK-ESB 组件系统 GSE Cacheapi 服务 Port        |
| bk-esb.externalDependencies.bkGsePmsURL              | str  |          | http://bk-gse-pms.example.com               | BK-ESB 组件系统 GSE PMS 地址                  |
| bk-esb.externalDependencies.bkGseConfigURL           | str  |          | http://bk-gse-config.example.com            | BK-ESB 组件系统 GSE Config 地址               |
| bk-esb.externalDependencies.bkDataV3StorekitapiURL   | str  |          | http://bk-data-v3-storekitapi.example.com   | BK-ESB 组件系统 BK-DATA-V3 Storekitapi 地址   |
| bk-esb.externalDependencies.bkDataV3ModelapiURL      | str  |          | http://bk-data-v3-modelapi.example.com      | BK-ESB 组件系统 BK-DATA-V3 Modelapi 地址      |
| bk-esb.externalDependencies.bkDataV3MetaapiURL       | str  |          | http://bk-data-v3-metaapi.example.com       | BK-ESB 组件系统 BK-DATA-V3 Metaapi 地址       |
| bk-esb.externalDependencies.bkDataV3DataqueryapiURL  | str  |          | http://bk-data-v3-dataqueryapi.example.com  | BK-ESB 组件系统 BK-DATA-V3 Dataqueryapi 地址  |
| bk-esb.externalDependencies.bkDataV3DatamanageapiURL | str  |          | http://bk-data-v3-datamanageapi.example.com | BK-ESB 组件系统 BK-DATA-V3 Datamanageapi 地址 |
| bk-esb.externalDependencies.bkDataV3DataflowapiURL   | str  |          | http://bk-data-v3-dataflowapi.example.com   | BK-ESB 组件系统 BK-DATA-V3 Dataflowapi 地址   |
| bk-esb.externalDependencies.bkDataV3DatacubeapiURL   | str  |          | http://bk-data-v3-datacubeapi.example.com   | BK-ESB 组件系统 BK-DATA-V3 Datacubeapi 地址   |
| bk-esb.externalDependencies.bkDataV3DatabusapiURL    | str  |          | http://bk-data-v3-databusapi.example.com    | BK-ESB 组件系统 BK-DATA-V3 Databusapi 地址    |
| bk-esb.externalDependencies.bkDataV3BksqlURL         | str  |          | http://bk-data-v3-bksql.example.com         | BK-ESB 组件系统 BK-DATA-V3 Bksql 地址         |
| bk-esb.externalDependencies.bkDataV3AuthapiURL       | str  |          | http://bk-data-v3-authapi.example.com       | BK-ESB 组件系统 BK-DATA-V3 Authapi 地址       |
| bk-esb.externalDependencies.bkDataV3AlgorithmapiURL  | str  |          | http://bk-data-v3-algorithmapi.example.com  | BK-ESB 组件系统 BK-DATA-V3 Algorithmapi 地址  |
| bk-esb.externalDependencies.bkDataV3AccessapiURL     | str  |          | http://bk-data-v3-accessapi.example.com     | BK-ESB 组件系统 BK-DATA-V3 Accessapi 地址     |
| bk-esb.externalDependencies.bkDataV3DatalabapiURL    | str  |          | http://bk-data-v3-datalabapi.example.com    | BK-ESB 组件系统 BK-DATA-V3 Datalabapi 地址    |
| bk-esb.externalDependencies.bkDataV3AiopsapiURL      | str  |          | http://bk-data-v3-aiopsapi.example.com      | BK-ESB 组件系统 BK-DATA-V3 Aiopsapi 地址      |
| bk-esb.externalDependencies.bkDataURL                | str  |          | http://bk-data.example.com                  | BK-ESB 组件系统 BK-DATA 地址                  |
| bk-esb.externalDependencies.bkDataProcessorapiURL    | str  |          | http://bk-data-processorapi.example.com     | BK-ESB 组件系统 BK-DATA Processorapi 地址     |
| bk-esb.externalDependencies.bkDataModelflowURL       | str  |          | http://bk-data-modelflow.example.com        | BK-ESB 组件系统 BK-DATA Modelflow 地址        |
| bk-esb.externalDependencies.bkDataBksqlURL           | str  |          | http://bk-data-bksql.example.com            | BK-ESB 组件系统 BK-DATA Bksql 地址            |
| bk-esb.externalDependencies.bkFtaURL                 | str  |          | http://bk-fta.example.com                   | BK-ESB 组件系统 BK-FTA 地址                   |
| bk-esb.externalDependencies.bkDevopsURL              | str  |          | http://bk-devops.example.com                | BK-ESB 组件系统 BK-DEVOPS 地址                |
| bk-esb.externalDependencies.bkCicdkitURL             | str  |          | http://bk-cicdkit.example.com               | BK-ESB 组件系统 BK-CICDKIT 地址               |
| bk-esb.externalDependencies.bkMonitorV3URL           | str  |          | http://bk-monitor-v3.example.com            | BK-ESB 组件系统 BK-MONITOR-V3 地址            |
| bk-esb.externalDependencies.bkMonitorURL             | str  |          | http://bk-monitor.example.com               | BK-ESB 组件系统 BK-MONITOR 地址               |
| bk-esb.externalDependencies.bkLogURL                 | str  |          | http://bk-log.example.com                   | BK-ESB 组件系统 BK-LOG 地址                   |
| bk-esb.externalDependencies.bkNodemanURL             | str  |          | http://bk-nodeman.example.com               | BK-ESB 组件系统 BK-NODEMAN 地址               |
| bk-esb.externalDependencies.bkBscpApiURL             | str  |          | http://bk-bscp-api.example.com              | BK-ESB 组件系统 BK-BSCP 地址                  |


### 如何修改配置项

在安装 Chart 时，你可以通过 `--set key=value[,key=value]` 的方式，在命令参数里修改各配置项。例如:

```shell
$ helm install bk-apigateway bkee/bk-apigateway --wait \
  --set bkdomain="example.com"
```

此外，你也可以把所有配置项写在 YAML 文件（常被称为 Helm values 文件）里，通过 `-f` 指定该文件来使用特定配置项：

```shell
$ helm install bk-apigateway bkee/bk-apigateway --wait -f values.yaml
```

执行 `helm show values`，你可以查看 Chart 的所有默认配置：
```shell
# 查看默认配置
$ helm show values bkee/bk-apigateway

# 保存默认配置到文件 values.yaml
$ helm show values bkee/bk-apigateway > values.yaml
```

## 常见问题

### 1. 如何对数据进行加密

确定 `encryptKey` 后，就可通过 apigateway 镜像对敏感配置值（比如数据库密码等）进行加密。

第一步，设置环境变量：

```shell
# 将 {} 替换为你在“1. 配置镜像地址”所使用的完整 apigateway 服务镜像地址
# 大致等同于：image.registry + apigateway.image.repository + apigateway.image.tag
# 例如：mirrors.example.com/bkee/apigateway:1.0.0
$ export APIGATEWAY_IMAGE={}

# 将 {} 替换为你在“2. 配置数据加密密钥”生成的数据加密密钥
# 格式应为 base64 编码过的长度为 32 的随机字符串
$ export ENCRYPT_KEY={}
```

为了方便，为加密命令设置一个命令别名：

```shell
$ alias bk_encrypt="docker run --rm -ti ${APIGATEWAY_IMAGE} apigateway encrypt --data-type password --key ${ENCRYPT_KEY} --input"
```

执行加密命令，获取密文：

```shell
$ bk_encrypt "some_password"
# ... 输出密文
```

### 2. 如何切换 ESB 访问流量
可以通过 paas2 的 Nginx 将 paas2 esb 请求切换到新版 bk-esb 中，但需要保证 bk-esb 的域名在 paas2 Nginx 服务器能合法解析（bk-esb 的域名可在安装后通过 helm note 提供）。

将 paas2 esb 请求切换到新版 bk-esb，在 paas2 机器上执行以下指令：
```shell
# 请将 `<bkapi_domain>` 替换为 bk-esb 服务的域名
$ consul kv put "bkcfg/fqdn/bk-esb" "<bkapi_domain>"

# 重新渲染 Nginx 配置
$ systemctl restart consul-template
```

如需切换回 paas2 esb，执行以下操作即可：
```shell
$ consul kv delete "bkcfg/fqdn/bk-esb"

# 重新渲染 Nginx 配置
$ systemctl restart consul-template
```
