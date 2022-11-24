# addons/bk-services 安装指南

`bk-services` 是 PaaS 平台的增强服务模块，本文档为该模块的部署指南。

## 简介

本 Chart 由 3 个子模块组成，每个子模块所负责的功能都有所差异：

1. **svc-mysql**：MySQL数据库增强服务, 负责创建和管理 mysql 账号和数据库。
2. **svc-rabbitmq**：RabbitMQ增强服务, 负责创建和管理 rabbitmq 的账号和 vhost。
3. **svc-bkrepo**：蓝鲸二进制仓库(bkrepo)增强服务, 负责创建和管理 bkrepo 二进制仓库的账号和Bucket。

## 准备服务依赖

开始部署前，请准备好一套 Kubernetes 集群（版本 1.12 或更高），并安装 Helm 命令行工具（3.0 或更高版本）。

> 注：如使用 BCS 容器服务部署，可用 BCS 的图形化 Helm 功能替代 Helm 命令行。

### 数据存储

以下为 bk-services 必须使用的数据存储服务：

- MySQL：用于存储关系数据，要求版本为 `5.7` 或更高；

> 注：你可以选择自己搭建，或者直接从云计算厂商处购买这些服务，只要能保证从集群内能正常访问即可。

### 服务实例

要正常运行 bk-services，除了准备核心的数据存储外，还需要提供被增强服务管理的服务实例，它们是：

- MySQL: 用于为 SaaS 提供关系型数据库, 为提高服务稳定性, 建议与平台使用 **不同的** MySQL 实例。
- RabbitMQ: 用于为 SaaS 提供消息队列, 为提高服务稳定性, 建议与平台使用 **不同的** RabbitMQ 集群。
- 蓝鲸二进制仓库服务（bkrepo）:用于为 SaaS 提供对象存储服务, 由于 bkrepo 的平台账号由 `paas-stack` 负责创建, 因此需要与平台使用 **相同的** bkrepo 实例。

> 注：你可以选择自己搭建，或者直接从云计算厂商处购买这些服务，只要能保证从集群内能正常访问即可。

准备好依赖服务后，下一步是编写 `values.yaml` 配置文件。

## 准备 `values.yaml`

bk-services 无法直接通过 Chart 所提供的默认 `values.yaml` 完成部署，在执行 `helm install` 安装服务前，你必须按以下步骤准备好匹配当前部署环境的 `values.yaml`。

### 1. 配置镜像地址

编写配置文件的第一步，是将各进程的镜像 `{*}.image.repository` 配置为你所使用的正确地址。然后，再确认每个进程所使用镜像 tag 是否正确。

##### `values.yaml` 配置示例：

```yaml
svc-mysql:
  image:
    # 请保证容器镜像已上传至该 registry 中
    repository: "mirrors.example.com/bkee/paas3-svc-rabbitmq"
    tag: "1.0.0"
    pullPolicy: Always

svc-bkrepo:
  # 其他镜像配置格式相同，已省略
  image: ...

svc-rabbitmq:
  image: ...

```

> 注：假如服务镜像需凭证才能拉取。请将对应密钥名称写入配置文件中，详细请查看 [`global.imagePullSecrets`](../addons/bk-services/README.md#global.imagePullSecrets) 配置项说明。


### 2. 配置 `bk-services` 与 `paas-stack` 通信的加密秘钥

为保证 `bk-services` 与 `paas-stack` 通信的安全性, 模块之间使用了 JSON Web Token(JWT) 作为通信消息的签名算法。为保证模块通信的安全性, 建议创建一个独一无二的密钥。该密钥无任何限制, 但建议使用长度为 32 或以上的字符串。

在 Linux 系统中，你可执行以下命令生成一个随机密钥：
```bash
$ tr -dc A-Za-z0-9 < /dev/urandom | head -c 32
```

或者调用 Python 命令：

```bash
$ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(s)'
```

拿到密钥后，下一步是将其放入 `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 配置项中。

注意事项:

- 需要保证 `bk-services` 与 `paas-stack` 配置的秘钥(同样是通过 `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 进行配置)一致，否则会导致通信失败；
- 为了你的数据安全，请不要将密钥泄露给其他人。

##### `values.yaml` 配置示例

```yaml
global:
  env:
    # 与 paas-stack 中 ApiServer 模块通信的加密秘钥，必须与 paas-stack 模块中配置的 `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 一致
    PAAS_SERVICE_JWT_CLIENTS_KEY: "b3BmRmpwYWNoZH..."
```

### 3. 初始化与配置数据存储

准备好服务所依赖的存储后，必须完成以下初始化操作：

**MySQL**

1. 创建普通用户 `bk_services`；
2. 创建数据库 `svc_mysql` 、 `svc_rabbitmq` 和 `svc_bkrepo`，授予用户 `bk_services` 读写和变更权限；

#### 填写存储配置

`bk-services` 各子模块需要连接不同的数据库，分别保存对应对应模块的相关数据。

##### `values.yaml` 配置示例：
```yaml
svc-mysql:
  env:
   # 数据库配置, 生产环境必须替换成高可用的数据库配置
    # 数据库名称, 建议值: svc_mysql
    MYSQL_NAME: "svc_mysql"
    # 数据库用户, 建议值: bk_services
    MYSQL_USER: "bk_services"
    MYSQL_PASSWORD: "xxxx"
    MYSQL_HOST: "127.0.0.1"
    MYSQL_PORT: "3306"

svc-bkrepo:
  env:
    # 数据库配置, 生产环境必须替换成高可用的数据库配置
    # 数据库名称, 建议值: svc_bkrepo
    MYSQL_NAME: "svc_bkrepo"
    # 数据库用户, 建议值: bk_services
    MYSQL_USER: "bk_services"
    MYSQL_PASSWORD: "xxxx"
    MYSQL_HOST: "127.0.0.1"
    MYSQL_PORT: "3306"

svc-rabbitmq:
  env:
    # 数据库配置, 生产环境必须替换成高可用的数据库配置
    # 数据库名称, 建议值: svc_rabbitmq
    DATABASE_NAME: "svc_rabbitmq"
    # 数据库用户, 建议值: bk_services
    DATABASE_USER: "bk_services"
    DATABASE_PASSWORD: "xxxx"
    DATABASE_HOST: "127.0.0.1"
    DATABASE_PORT: "3306"
```

### 4. 配置数据加密密钥

`bk-services` 使用对称加密算法保障数据安全。要启用加密功能，你首先得创建一个独一无二的密钥。该密钥内容为 **长度为 32 的字符串（base64 编码）**，在 Linux 系统中，你可执行以下命令生成一个随机密钥：

```bash
$ tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64
```

或者调用 Python 命令：

```bash
$ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(base64.b64encode(s.encode()).decode())'
```

拿到密钥后，下一步是将其放入 `{*}.env.BKKRILL_ENCRYPT_SECRET_KEY` 配置项中。

注意事项:

- 应当为各子模块配置不同的 BKKRILL_ENCRYPT_SECRET_KEY；
- 密钥一旦生成并配置好以后，不可修改，否则会导致数据异常；
- 为了你的数据安全，请不要将密钥泄露给其他人。

##### `values.yaml` 配置示例

```yaml
svc-mysql:
  env:
    # 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改
    BKKRILL_ENCRYPT_SECRET_KEY: "b3BmRmpwYWNoZJ..."

svc-bkrepo:
  env:
    # 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改
    BKKRILL_ENCRYPT_SECRET_KEY: "UmlRYVJMMWtueE..."

svc-rabbitmq:
  env:
    # 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改
    BKKRILL_ENCRYPT_SECRET_KEY: "aGtrT2gwSGxGaz..."
```

### 5. 填写服务实例配置

#### 填写 svc-mysql 服务实例配置

svc-mysql 子模块负责使用管理员账号为 SaaS 创建数据库和用户信息, 因此需要为 svc-mysql 分配具有执行 `grant` 语句执行权限的**特权用户(比如 root 用户)**。

##### `values.yaml` 配置示例：

```yaml
svc-mysql:
  # plan 里填的是 `svc-mysql 服务` 用于授权 mysql 账号和创建 database 用的超管账号和对应的 mysql 实例信息
  plan:
    # SaaS 使用的数据库实例
    host: "127.0.0.1"
    port: 3306
    # 管理员账号用户名，必须具有执行 `grant` 语句执行权限
    user: "root"
    password: "xxxx"
    # 内置的授权访问权限 IP 列表
    auth_ip_list:
    - "%"
```

#### 填写 svc-bkrepo 服务实例配置

svc-bkrepo 子模块负责使用管理员账号为 SaaS 创建用于存储对象的Bucket, 该账号由 `paas-stack` 模块负责创建, 需要保证该处填写的信息与 `paas-stack` 中一致。

##### `values.yaml` 配置示例：

```yaml
svc-bkrepo:
  plan:
    # bkrpeo 服务地址
    endpoint_url: "http://bkrepo.example.com"
    # bkrepo 账号用户名，必须与 paas-stack 模块中配置的 `global.bkrepoConfig.addonsUsername` 一致
    username: "bksaas-addons"
    # bkrepo 账号密码，必须与 paas-stack 模块中配置的 `global.bkrepoConfig.addonsPassword` 一致
    password: "blueking"
```

> 注: 由于 bkrepo 的平台账号由 `paas-stack` 模块负责创建, 因此需要保证该处填写的信息与 `paas-stack` 模块的部署步骤 [配置蓝鲸制品仓库（bkrepo）依赖](deploy_guide_cores.md#2-配置蓝鲸制品仓库bkrepo依赖) 中填写一致。


#### 填写 svc-rabbitmq 服务实例配置

svc-rabbitmq 子模块负责使用管理员账号为 SaaS 创建虚拟主机(vhost)和用户信息, 因此需要准备一个给 SaaS 使用的 RabbitMQ 集群，并为 svc-rabbitmq 子模块分配具有对应权限的特权用户。

##### `values.yaml` 配置示例：

```yaml
svc-rabbitmq:
  env:
    # SaaS 使用的 RabbitMQ 默认集群名称（如不需要自动注册，请留空）
    RABBITMQ_DEFAULT_CLUSTER: "default"
    # 默认集群地址
    RABBITMQ_DEFAULT_CLUSTER_HOST: "database"
    # 默认集群 amqp 端口
    RABBITMQ_DEFAULT_CLUSTER_AMQP_PORT: "5672"
    # 默认集群 api 端口
    RABBITMQ_DEFAULT_CLUSTER_API_PORT: "15672"
    # 默认集群管理员用户名
    RABBITMQ_DEFAULT_CLUSTER_ADMIN: "admin"
    # 默认集群管理员密码
    RABBITMQ_DEFAULT_CLUSTER_PASSWORD: "xxxx"
```

完成以上步骤，准备好 `values.yaml` 后，便可开始安装了。

## 安装 Chart

准备好 Values.yaml 后，你便可以开始安装蓝鲸 PaaS3.0 开发者中心 bk-services 模块了。执行以下命令，在集群内安装名为 `bk-services` 的 Helm release：

```shell
$ helm install bk-services bk-paas3/bk-services --namespace paas-system --values value.yaml
```

注意：`addons/bk-services`模块和`cores/paas-stack`模块间通过 service name 来访问，所以这两个模块必须部署在同一个命名空间内。

上述命令将在 Kubernetes 集群中部署蓝鲸 PaaS3.0 开发者中心 bk-services 模块, 并输出访问指引。

### 卸载Chart

使用以下命令卸载 `bk-services`:

```shell
$ helm uninstall bk-services
```

上述命令将移除所有与 bk-services 相关的 Kubernetes 资源，并删除 release。


## 更多配置

可以查阅 [bk-services 变量配置](../addons/bk-services/README.md) 了解更多。