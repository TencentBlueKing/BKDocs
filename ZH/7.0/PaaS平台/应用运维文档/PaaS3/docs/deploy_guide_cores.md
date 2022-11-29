# cores/paas-stack 安装指南

`paas-stack` 是 PaaS3.0 开发者中心的核心功能模块，本文档为该模块的部署指南。

## 简介

本 Chart 由 4 个子模块组成，每个子模块所负责的功能都有所差异：

1. **apiServer**PaaS3.0 开发者中心的主控模块，提供 API 服务
    * main：服务主进程
    * celery：后台任务进程
2. **workloads**：PaaS3.0 开发者中心的持续部署控制器，负责和应用 K8S 集群交互
    * main：服务主进程
    * celery：后台任务进程
3. **webfe**：PaaS3.0 开发者中心的前端，通过 nginx 托管静态页面
4. **extraInitial**：平台功能初始化模块
    * npm：初始化 NPM 仓库
    * pypi：初始化 pypi 仓库
    * devops：初始化构建工具

## 准备服务依赖

开始部署前，请准备好一套 Kubernetes 集群（版本 1.12 或更高），并安装 Helm 命令行工具（3.0 或更高版本）。

> 注：如使用 BCS 容器服务部署，可用 BCS 的图形化 Helm 功能替代 Helm 命令行。

### 数据存储

以下为 paas-stack 必须使用的数据存储服务：

- MySQL：用于存储关系数据，要求版本为 `5.7` 或更高；
- Redis：用于缓存数据及作为异步任务队列；

> 注：你可以选择自己搭建，或者直接从云计算厂商处购买这些服务，只要能保证从集群内能正常访问即可。

### 其他服务

要正常运行 paas-stack，除了准备核心的数据存储外，还需要用到一些蓝鲸体系内的其他服务，它们是：

- 蓝鲸二进制仓库服务（bkrepo）：存取应用构建源码包和应用构建工具
  - 要求版本必须为 **1.0.11** 及以上
  - 必须部署：generic registry、npm registry、pypi registry
- 蓝鲸 PaaS2.0：读取与管理应用信息
  - 要求版本必须为 **2.12.18** 及以上
- 蓝鲸 SSM：依赖其 API 接口校验用户信息
- 蓝鲸用户管理（bk_user_manage）：依赖其管理用户信息
- 蓝鲸权限中心（bk_iam）：依赖其管理用户访问 PaaS3.0 开发者中心的权限
- 蓝鲸流程服务（bk_itsm）：依赖其进行用户权限申请和审批

除以上服务外，还有其他几个依赖服务，如不提供也不会影响程序主要功能：

- 蓝鲸文档中心：用于展示开发指南和使用说明
  - 文档中心SaaS（bk_docs_center）：版本 1.0.7 及以上
  - 文档中心离线文档包（docs-data）：版本 1.0.7 及以上
  - 目前 PaaS3.0 的文档暂未放蓝鲸官网上，若不单独部署文档中心 SaaS 则无法查看文档

- 蓝鲸 BCS 容器服务：用于简化部署
  - bk_bcs_app：版本 1.3.25 及以上
  - 如缺失，对程序功能没有任何影响

准备好依赖服务后，下一步是编写 `values.yaml` 配置文件。

## 准备 `values.yaml`

paas-stack 无法直接通过 Chart 所提供的默认 `values.yaml` 完成部署，在执行 `helm install` 安装服务前，你必须按以下步骤准备好匹配当前部署环境的 `values.yaml`。

### 1. 配置镜像地址

编写配置文件的第一步，是将各进程的镜像 `{*}.image.repository` 配置为你所使用的正确地址。然后，再确认每个进程所使用镜像 tag 是否正确。

除各进程镜像地址外，还需配置两个额外的镜像地址：应用运行时镜像（`apiserver.env.APP_IMAGE`）、S-Mart 应用运行时镜像（`apiserver.env.SMART_APP_IMAGE`）。

##### `values.yaml` 配置示例：

```yaml
apiserver:
  image:
    # 请保证容器镜像已上传至该 registry 中
    repository: "mirrors.example.com/bkee/paas3-apiserver"
    tag: "your_tag"
    pullPolicy: Always
  
  env:
    # 应用运行时镜像
    APP_IMAGE: "mirrors.example.com/bkee/slug-app:your_tag"
    SMART_APP_IMAGE: "mirrors.example.com/bkee/slug-smart-app:your_tag"

workloads:
  # 其他镜像配置格式相同，已省略
  image: ...

webfe:
  image: ...

extraInitial:
  npm:
    image: ...
  pypi:
    image: ...
  devops:
    image: ...
```

> 注：假如服务镜像需凭证才能拉取。请将对应密钥名称写入配置文件中，详细请查看 [`global.imagePullSecrets`](../cores/paas-stack/README.md#global.imagePullSecrets) 配置项说明。

### 2. 配置蓝鲸制品仓库（bkrepo）依赖

PaaS 平台在部署应用时，会从蓝鲸制品仓库下载一些必须工具，这包括应用镜像、应用构建 buildpack 包，各编程语言二进制源码包，等等。因此平台在初始化安装时，需要以**管理员身份**访问 bkrepo 服务，上传这些工具包。

此外，PaaS 平台还有另外两部分功能会依赖 bkrepo：

1. “蓝鲸制品库”增强服务，供平台应用自助上传、下载文件
2. 供“蓝鲸低代码平台（LessCode）”存储应用源码包

综上所述，完整的 bkrepo 配置共需 4 份不同账号信息。其中：
- 管理员账号密码：可以从 bkrepo 的 Helm NOTES 获取”初始用户名/密码“
- 其他三个账号，是在部署 apiServer 时主动去 bkrepo 上创建账号密码。**注意：目前只会创建账号密码，不会修改密码**


##### `values.yaml` 配置示例：

```yaml
global:
  bkrepoConfig:
    # bkrepo 服务的网关地址
    endpoint: http://bkrepo.example.com
    # 管理员权限，账号密码可以从 bkrepo 的 Helm NOTES 的 ”初始用户名/密码“ 获取
    adminUsername: admin
    adminPassword: blueking

    # svc-bkrepo 增强服务项目使用的 bkrepo 用户名/密码
    # 必须与增强服务（bk-services）中 `svc-bkrepo.plan.username` 配置项的值一样
    addonsUsername: bksaas-addons
    # 必须与增强服务（bk-services）中 `svc-bkrepo.plan.password` 配置项的值一样
    addonsPassword: blueking

    # 平台使用的 bkrepo 项目名称（要求以字母或者下划线开头，长度不超过32位）
    bkpaas3Project: bkpaas
    # 平台使用的 bkrepo 用户名/密码（可填写任意字符）
    bkpaas3Username: bkpaas3
    bkpaas3Password: blueking
    # lesscode 增强服务项目使用的 bkrepo 用户名/密码（可填写任意字符）
    lesscodeUsername: bklesscode
    lesscodePassword: blueking
```

### 3. 配置增强服务（bk-services）依赖

为保证与增强服务通信的安全性, 模块之间使用了 JSON Web Token(JWT) 作为通信消息的签名算法。

将在部署增强服务模块（bk-services）时生成的 `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 配置项的值填入即可。

##### `values.yaml` 配置示例：

```yaml
global:
  env:
    # 与增强服务的通信加密秘钥，必须与增强服务（bk-services）`global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 配置项值一样, 任意普通字符串
    PAAS_SERVICE_JWT_CLIENTS_KEY: "b3BmRmpwYWNoZH..."
```

### 4. 配置服务访问域名

为了简化配置，平台自身和依赖服务的访问地址都由通用根域 `sharedDomain` 根据默认的规则拼接而成。

拼接处的访问地址包括以下几部分（以 sharedDomain 值为 example.com）

1. PaaS3.0 开发者中心访问地址
- BK_PAAS3_URL: "http://bkpaas.example.com"

2. BK-APIGateway 服务相关地址
- BK_APIGW_URL: "http://apigw.example.com"
- BK_APIGW_DOC_URL: "http://docs-apigw.example.com"
- BK_API_URL_TMPL: "http://bkapi.example.com/api/{api_name}

3. 依赖其他服务的访问地址
- BK_PAAS2_URL: "http://paas.example.com"
- BK_LOGIN_URL: "http://paas.example.com/login"
- BK_COMPONENT_API_URL: "http://paas.example.com"
- BK_SSM_URL: "http://bkssm.example.com"
- BK_IAM_V3_INNER_HOST: "http://bkiam.example.com"
- BK_CC_HOST: "http://cmbd.example.com"
- BK_JOB_HOST: "http://job.example.com"
- BK_LESSCODE_URL: "http://lesscode.example.com"

**说明：** 如果想单独修改某个服务的访问地址，可以参考 [访问地址拼接问题](deploy_faq.md#访问地址拼接问题) 修改。

##### `values.yaml` 配置示例：

```yaml
global:
  # 通用根域，用于拼接平台自身和依赖服务的访问地址
  sharedDomain: "my.example.com"
```

### 5. 配置蓝鲸 API Gateway 服务依赖

PaaS 平台在初始化时，会访问蓝鲸 API Gateway 管理端，将自身接口资源注册到名为“bkpaas3（PaaS3.0开发者中心）”的网关中。为了让资源能正常同步，需要：

1. 配置正确的蓝鲸 API Gateway 域名。
- 默认由 `sharedDomain` 自动拼接生成，也可以参考 [访问地址拼接问题](deploy_faq.md#访问地址拼接问题) 修改。

2. 添加同步资源时所需的蓝鲸应用账号（bk_app_code 和 bk_app_secret)。
- 创建 1 个蓝鲸应用账号（bk_app_code）：`bk_paas3`，并将其添加到 ESB 免用户认证白名单中。
  - 可以使用 PaaS2.0 的 Admin 管理系统添加，或者用脚本直接操作 ESB 的 AppAccount 数据表。

3. 配置与 API Gateway 之间通信的 API 鉴权令牌 `BK_PAAS3_PRIVATE_TOKEN_FOR_APIGW`， 将在部署 BK-APIGateway 服务时生成的 `keys.paasPrivateToken` 配置项的值填入即可。

##### `values.yaml` 配置示例：

```yaml
apiserver:
  env:
    BK_APP_CODE: bk_paas3
    BK_APP_SECRET: "5b4f4ed9-..."
    # 与 APIGW 通信的鉴权令牌, 必须与 API Gateway 的 `keys.paasPrivateToken` 配置项值一样
    BK_PAAS3_PRIVATE_TOKEN_FOR_APIGW: "aHn8GHVyN..."
```

### 6. 配置数据加密密钥

paas-stack 使用对称加密算法保障数据安全。要启用加密功能，你首先得创建一个独一无二的密钥。该密钥内容为 **长度为 32 的字符串（base64 编码）**，在 Linux 系统中，你可执行以下命令生成一个随机密钥：

```bash
$ tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64
```

或者调用 Python 命令：

```bash
$ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(base64.b64encode(s.encode()).decode())'
```

拿到密钥后，下一步是将其放入 `apiserver.env.BKKRILL_ENCRYPT_SECRET_KEY` 配置项中。

注意事项:

- 密钥一旦生成并配置好以后，不可修改，否则会导致数据异常；
- 为了你的数据安全，请不要将密钥泄露给其他人。

##### `values.yaml` 配置示例

```yaml
apiserver:
  env:
    BKKRILL_ENCRYPT_SECRET_KEY: "b3BmRmpwYWNoZJ..."
```

### 7. 初始化与配置数据存储

准备好服务所依赖的存储后，必须完成以下初始化操作：

**MySQL**

1. 创建普通用户 `bk_paas3`；
2. 创建数据库 `paas3_apiserver` 和 `paas3_workloads`，授予用户 `bk_paas3` 读写和变更权限；
3. 对于已有的 PaaS2.0 服务数据库 `open_paas`，授予用户 `bk_paas3` 读写权限；

**Redis**

1. 使用 redis-cli 命令测试 Redis 可正常连接使用

#### 填写 apiServer 存储配置

apiServer 子模块需要同时访问 `paas3_apiserver` 与 PaaS2.0 数据库 `open_paas`。除此之外，apiServer 还需使用 Redis 保存缓存数据及作为 Celery 后端队列。

##### `values.yaml` 配置示例：

```yaml
apiserver:
  env:
    # apiServer 自身使用的数据库
    PAAS3_MYSQL_NAME: paas3_apiserver
    PAAS3_MYSQL_USER: bk_paas3
    PAAS3_MYSQL_PASSWORD: "xxxx"
    PAAS3_MYSQL_HOST: "127.0.0.1"
    PAAS3_MYSQL_PORT: "3306"

    # PaaS 2 的 open_paas 数据库
    OPEN_PAAS_MYSQL_NAME: open_paas
    OPEN_PAAS_MYSQL_USER: bk_paas3
    OPEN_PAAS_MYSQL_PASSWORD: "xxxx"
    OPEN_PAAS_MYSQL_HOST: "127.0.0.1"
    OPEN_PAAS_MYSQL_PORT: "3306"
    
    # apiServer 用于缓存、任务队列等存储，需要和 workloads.env.STREAM_CHANNEL_REDIS_URL 保持一致
    REDIS_URL: "redis://:password@127.0.0.1:6379/10"
```

#### 填写 workloads 存储配置

workloads 子模块需要连接 `paas3_workloads` 数据库，来保存应用相关数据。

同 apiServer 一样，workloads 使用 redis 也有两个不同用途：

1. 用作应用部署时的日志传输管道。为保证功能正常，该值 **必须与 apiServer 的 `env.REDIS_URL` 保持一致**
2. 用作 celery 的后端队列，必须与 apiServer 的 `env.CELERY_BROKER_URL` 使用 **不同数据库**，否则不同进程的任务会发生冲突

##### `values.yaml` 配置示例：

```yaml
workloads:
  env: 
    ENGINE_MYSQL_NAME: paas3_workloads
    ENGINE_MYSQL_USER: bk_paas3
    ENGINE_MYSQL_PASSWORD: "xxxx"
    ENGINE_MYSQL_HOST: "127.0.0.1"
    ENGINE_MYSQL_PORT: "3306"

    # 需要和 apiserver.env.REDIS_URL 保持一致
    STREAM_CHANNEL_REDIS_URL: "redis://:password@127.0.0.1:6379/10"
    # 用于 workloads 模块的后台任务队列，请尽量和 STREAM_CHANNEL_REDIS_URL 区分
    CELERY_BROKER_URL: "redis://:password@127.0.0.1:6379/11"
    # 用于 workloads 模块的后台任务队列存储，可与上面的 CELERY_BROKER_URL 设置为相同的值
    CELERY_RESULT_BACKEND: "redis://:password@127.0.0.1:6379/11"
```

### 8. 配置初始应用集群

为了让应用能正常部署，你必须在平台中注册至少一个 Kubernetes 集群。你需要在 `workloads.initialCluster` 中配置一个初始化集群，部署完成后也可以在 PaaS3.0 开发者中心后台管理系统修改配置信息。

如果你并不了解如何配置，请参考 [`初始化集群配置`](configure_initial_cluster.md)  文档了解更多，尤其注意里面的身份校验方式（“客户端证书”或“Bearer Token”）只需选择一种即可。

#### `values.yaml` 配置示例

```yaml
workloads:
  initialCluster:
    # 集群访问入口相关配置
    ingressConfig:
      sub_path_domain: "apps-subpath.example.com"
      enable_https_by_default: false
      frontend_ingress_ip: "127.0.0.1"
    caData: "LS0tLS1CRU..."
    certData: "LS0tLS1CRU..."
    keyData: "LS0tLS1CRU..."
    annotations:
      bcsClusterID: "BCS-K8S-10000"
      bcsProjectID: "5c4b4c1..."
    apiServers:
      - host: "https://127.0.0.1:6553"
```

完成以上步骤，准备好 `values.yaml` 后，便可开始安装了。


## 后置步骤

在成功安装各子项目后，为了正常使用蓝鲸 PaaS 平台的各项功能，你还需要完成以下任务。

### 下载 heroku 提供的运行依赖

下载蓝鲸提供的构建工具及 heroku 提供的运行时工具，并上传到 bkreop 指定仓库中统一目录： `${your-bkrepo-project}/runtimes/${stack}` ，按语言和镜像区分子目录，公开访问，存放 Heroku 提供的运行时依赖，使用 docker 启动镜像 paas3-buildpack-toolkit，请补充以下命令缺少的参数：
```bash
docker run \
  --rm \
  --network host \
  -e "BKREPO_USERNAME=${bkrepoConfig.bkpaas3Username}" \
  -e "BKREPO_PASSWORD=${bkrepoConfig.bkpaas3Password}" \
  -e "BKREPO_ENDPOINT=${bkrepoConfig.endpoint}" \
  -e "BKREPO_PROJECT=${bkrepoConfig.bkpaas3Project}" \
  -ti \
  --entrypoint bash \
  ${your-docker-registry}/paas3-buildpack-toolkit:${image-tag} \
  runtimes-download.sh
```

> 注意事项:
> * 该步骤会从腾讯云对象存储 [https://bkpaas-runtimes-1252002024.cos.ap-shanghai.myqcloud.com](https://bkpaas-runtimes-1252002024.cos.ap-shanghai.myqcloud.com) 上下载文件
> * 如果部署环境上没有外网的话，可以将离线下载好的文件放到本地目录 `vendor`（注意挂载到容器），在可访问到 bkrepo 的机器上执行：
> ```
> docker run \
>   --rm \
>   --network host \
>   -e "BKREPO_USERNAME=${bkrepoConfig.bkpaas3Username}" \
>   -e "BKREPO_PASSWORD=${bkrepoConfig.bkpaas3Password}" \
>   -e "BKREPO_ENDPOINT=${bkrepoConfig.endpoint}" \
>   -e "BKREPO_PROJECT=${bkrepoConfig.bkpaas3Project}" \
>   -v ${your-vendor-dir}:/data/vendor \
>   ${your-docker-registry}/paas3-buildpack-toolkit:${image-tag} \
>   paas-devops upload -r --allow-overwrite true vendor runtimes/heroku-18/vendor/
> ```

**说明**：bkrepo 相关变量的值，可以从 `values.yaml` 文件中的 `global.bkrepoConfig` 配置项获取。


## 安装 Chart

准备好 Values.yaml 后，你便可以开始安装蓝鲸 PaaS 平台了。执行以下命令，在集群内安装名为 `bk-paas3` 的 Helm release：

```shell
$ helm install bk-paas3 bk-paas3/paas-stack --namespace paas-system --values value.yaml
```
注意：`addons/bk-services`模块和`cores/paas-stack`模块间通过 service name 来访问，所以这两个模块必须部署在同一个命名空间内。

上述命令将在 Kubernetes 集群中部署蓝鲸 PaaS 服务, 并输出访问指引。


### 保证 bk-apigateway 服务能够访问 PaaS3.0 开发者中心的域名

目前 bk-apigateway 和 PaaS3.0 开发者中心间的通信是走外网域名，因此需要保证 bk-apigateway 服务能访问 PaaS3.0 开发者中心的域名。

若集群内无法解析 PaaS3.0 开发者中心的域名，可修改集群内的 DNS 服务，或在 bk-apigateway 服务的 `global.HostAliases` 配置项中添加配置。

### 卸载Chart

使用以下命令卸载 `bk-paas3`:

```shell
$ helm uninstall bk-paas3
```

上述命令将移除所有与 bk-paas3 相关的 Kubernetes 资源，并删除 release。

## 更多配置

可以查阅 [paas-stack 变量配置](../cores/paas-stack/README.md) 了解更多。


## 参考资料

### 手动上传 Python 依赖包到 bkrepo 服务

平台使用蓝鲸 bkrepo 服务存放应用依赖包, 为了让平台能正常部署 Python 应用, 需要将所有 Python 依赖包上传至 bkrepo 提供的私有 PyPI 仓库中。

> 注意事项   
> * 该步骤已集成至 paas-stack 的部署流程，具体配置请参考 extraInitial.pypi
> * 待上传的 Python SDK 包已归档至镜像 paas3-init-pypi
> * 容器的默认启动指令已设置成自动生成 Python SDK 至 bkrepo

部署完成后，也可以通过下面的命令手动执行：

```bash
# 手动上传 Python SDK 至 bkrepo
docker run -it --rm -e "BKREPO_USERNAME=${your-bkrepo-username}" -e "BKREPO_PASSWORD=${your-bkrepo-password}" -e "BKREPO_ENDPOINT=${your-bkrepo-endpoint}" -e "BKREPO_PROJECT=${your-bkrepo-project}" ${your-docker-registry}/paas3-init-pypi:${image-tag}
```

### 手动上传 NPM 依赖包到 bkrepo 服务
平台使用蓝鲸 bkrepo 服务存放应用依赖包, 为了让平台能正常部署 NodeJS 应用, 你需要将所有 NodeJS 依赖包上传至 bkrepo 提供的私有 NPM 仓库中。

> 注意事项:   
> * 该步骤已集成至 paas-stack 的部署流程，具体配置请参考 extraInitial.npm
> * 待上传的 NodeJS SDK 包已归档至镜像 paas3-init-npm
> * 容器的默认启动指令已设置成自动生成 NodeJS SDK 至 bkrepo

部署完成后，也可以通过下面的命令手动执行：

```bash
# 手动上传 NodeJS SDK 至 bkrepo
docker run -it --rm -e "BKREPO_USERNAME=${your-bkrepo-username}" -e "BKREPO_PASSWORD=${your-bkrepo-password}" -e "BKREPO_ENDPOINT=${your-bkrepo-endpoint}" -e "BKREPO_PROJECT=${your-bkrepo-project}" ${your-docker-registry}/paas3-init-npm:${image-tag}
```
