# bkpaas3 安装指南

`bkpaas3` 是 PaaS3.0 开发者中心的核心功能模块的 chart 包，本文档为该模块的部署指南。

## 简介

本 Chart 由以下子模块组成，每个子模块所负责的功能都有所差异：

1. **apiServer**PaaS3.0 开发者中心的主控模块，提供 API 服务，并负责和应用 K8S 集群交互
    - web：服务主进程
    - worker：后台任务进程
2. **webfe**：PaaS3.0 开发者中心的前端，通过 nginx 托管静态页面
3. **extraInitial**：平台功能初始化模块
    - npm：初始化 NPM 仓库
    - pypi：初始化 pypi 仓库
    - devops：初始化构建工具
4. **svc-mysql**：MySQL数据库增强服务, 负责创建和管理 mysql 账号和数据库。
5. **svc-rabbitmq**：RabbitMQ增强服务, 负责创建和管理 rabbitmq 的账号和 vhost。
6. **svc-bkrepo**：蓝鲸二进制仓库(bkrepo)增强服务, 负责创建和管理 bkrepo 二进制仓库的账号和Bucket。

## 准备服务依赖

开始部署前，请准备好一套 Kubernetes 集群（版本 1.12 或更高），并安装 Helm 命令行工具（3.0 或更高版本）。

> 注：如使用 BCS 容器服务部署，可用 BCS 的图形化 Helm 功能替代 Helm 命令行。

我们使用 `Ingress` 对外提供服务访问，所以请在集群中至少安装一个可用的 [Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)

### 其他服务

要正常运行开发者中心，除了准备核心的数据存储外，还需要用到一些蓝鲸体系内的其他服务，它们是：

* 蓝鲸二进制仓库服务（bkrepo）：存取应用构建源码包和应用构建工具
  + 要求版本必须为 **1.0.11** 及以上
  + 必须部署：generic registry、npm registry、pypi registry
* 蓝鲸 PaaS2.0：读取与管理应用信息
  + 要求版本必须为 **2.12.18** 及以上
* 蓝鲸 SSM：依赖其 API 接口校验用户信息
* 蓝鲸 API Gateway：需要注册网关资源到 API 网关，方便其他服务使用

除以上服务外，还有其他几个依赖服务，如不提供也不会影响程序主要功能：

* 蓝鲸文档中心：用于展示开发指南和使用说明
  + 文档中心SaaS（bk_docs_center）：版本 1.0.6 及以上
  + 文档中心离线文档包（docs-data）：版本 1.0.7 及以上
  + 目前 PaaS3.0 的文档暂未放蓝鲸官网上，若不单独部署文档中心 SaaS 则无法查看文档
* 蓝鲸用户管理（bk_user_manage）：依赖其管理用户信息
* 蓝鲸权限中心（bk_iam）：依赖其管理用户访问 PaaS3.0 开发者中心的权限
* 蓝鲸流程服务（bk_itsm）：依赖其进行用户权限申请和审批

准备好依赖服务后，下一步是编写 `values.yaml` 配置文件。

## 准备 `values.yaml`

开发者中心无法直接通过 Chart 所提供的默认 `values.yaml` 完成部署，在执行 `helm install` 安装服务前，你必须按以下步骤准备好匹配当前部署环境的 `values.yaml` 。

### 1. 配置数据加密密钥

bkpaas3 使用对称加密算法保障数据安全。要启用加密功能，你首先得创建一个独一无二的密钥。该密钥内容为 **长度为 32 的字符串（base64 编码）**，在 Linux 系统中，你可执行以下命令生成一个随机密钥：

```bash
$ tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64
```

或者调用 Python 命令：

```bash
$ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(base64.b64encode(s.encode()).decode())'
```

拿到密钥后，下一步是将其放入 `global.bkKrillEncryptSecretKey` 配置项中。

注意事项:

* 密钥一旦生成并配置好以后，不可修改，否则会导致数据异常；
* 为了你的数据安全，请不要将密钥泄露给其他人。

##### `values.yaml` 配置示例

```yaml
global:
  bkKrillEncryptSecretKey: "b3BmRmpwYWNoZJ..."
```

### 2. 配置蓝鲸体系内服务依赖

需要配置以下信息:
- bk_paas3 对应的 bk_app_secret，并将 `bk_paas3` 添加到 ESB 免用户认证白名单中
- 蓝鲸根域 bkDomain
- 蓝鲸工作台（bk-panel）的数据库 `open_paas` 信息
- 初始化的第三方应用(外链应用)的 code 列表
- 蓝鲸体系内其他产品访问地址

##### `values.yaml` 配置示例

```yaml
global:
  imageRegistry: "mirrors.example.com"
  bkDomain: "example.com"
  bkrepoConfig:
    # bkrepo 服务的网关地址
    endpoint: "http://bkrepo.example.com"
  
  appCode: "bk_paas3"
  appSecret: ""
  bkComponentApiUrl: "http://bkapi.example.com"
  bkApiUrlTmpl: "http://bkapi.example.com/api/{api_name}"

apiserver:
  enabled: true
  bkPaas3Url: "http://bkpaas.example.com"
  bkPaasUrl: "http://paas.example.com"
  bkCmdbUrl: "http://cmdb.example.com"
  bkJobUrl: "http://job.example.com"
  bkIamUrl: "http://bkiam.example.com"
  bkIamApiUrl: "http://bkiam-api.example.com"
  bkUserUrl: "http://bkuser.example.com"
  bkBcsUrl: "http://bcs.example.com"
  bkMonitorV3Url: "http://bkmonitor.example.com"
  bkNodemanUrl: "http://bknodeman.example.com"
  bkLogUrl: "http://bklog.example.com"
  bkRepoUrl: "http://bkrepo.example.com"
  bkCiUrl: "http://devops.example.com"
  bkCodeccUrl: "http://devops.example.com/console/codelib"
  bkTurboUrl: "http://devops.example.com/console/turbo"
  bkPipelineUrl: "http://devops.example.com/console/pipeline"
  # 蓝鲸文档中心地址，默认为官网地址，可修改为文档中心 SaaS 的地址（http://apps.example.com/bk--docs--center）
  bkDocsCenterUrl: "https://bk.tencent.com/docs"
  # 初始化的第三方应用(外链应用)的 code,多个以英文逗号分割
  initThirdAppCodes: "bk_repo,bk_usermgr,bk_iam,bk_bcs,bk_log_search,bk_monitorv3,bk_ci,bk_nodeman"

  externalDatabase:
    openPaaS:
      host: "bk-panel-mariadb"
      password: "root"
      port: 3306
      user: "bk_panel"
      name: "open_paas"

webfe:
  enabled: true
  bkApigwUrl: "http://apigw.example.com"
  bkLessCodeUrl: "http://lesscode.example.com"
  bkPaas3Url: "http://bkpaas.example.com"
  bkPaasUrl: "http://paas.example.com"
  bkLoginUrl: "http://example.com/login"
  bkDocsCenterUrl: "https://bk.tencent.com/docs"
```

### 3. 配置应用日志的 ElasticSearch 集群信息

ElasticSearch 集群信息需要与应用集群上部署的 charts 中填写的 ElasticSearch 信息保持一致

##### `values.yaml` 配置示例

```yaml
apiserver:
  elasticSearch:
    host: "elasticsearch.example.com"
    port: "9200"
    auth: "username:password"
    appIndex: "bk_paas3_app"
    ingressIndex: "bk_paas3_ingress"
```

### 4. 配置初始应用集群

为了让应用能正常部署，你必须在平台中注册至少一个 Kubernetes 集群。你需要在 `apiserver.initialCluster` 中配置一个初始化集群。

平台对 K8S 集群进行管理，包括不限于：创建或删除命名空间、创建或删除蓝鲸应用( `Deployment` / `Service` / `Ingress` 等)。

所以需要配置对应集群的相关信息，包括：

* apiserver 访问地址，访问身份和 `cluster-admin` 权限
* 应用集群访问方式以及入口域名

下面具体来介绍如何配置 apiserver 的访问身份和如何配置 `cluster-admin` 权限。

> 注：如果使用的是 BCS 集群，推荐参考 4.1 小节，普通集群可参考 4.2 小节。

#### 4.1 通过 bcs api 访问集群

你可以通过 bcs api + token 来访问集群

##### 4.1.1 填写引用集群的访问地址

`apiServers.host` 为 bcs cluster apiserver 访问地址，形如 `https://bcs.example.com/clusters/${cluster_id}`

##### 4.1.2 获取具有 cluster-admin 权限的 bcs API 密钥

可以使用 `平台级 Token（推荐）` 或 `个人密钥` 来配置 PaaS 以访问 BCS 集群

**1. 申请平台级 Token**

联系 BCS 系统管理员，为 PaaSv3 分配平台级别的 bcs Token `client_id: bk_paas3`

注意：该密钥需要拥有访问 bcs-cluster 以及 bcs-project-manager 的权限。

**2. 申请个人密钥**

通过访问 BCS 产品首页 -> 用户名（下拉菜单） -> API 密钥，申请并查看个人密钥，需要注意的是：你必须拥有要配置的集群的全部权限。

##### 4.1.3 `values.yaml` 配置示例

```yaml
apiserver:
  initialCluster:
    # 如果想在安装时直接配置，请修改 enabled: true
    enabled: true
    # 集群访问入口相关配置
    ingressConfig:
      sub_path_domain: "apps.example.com"
      enable_https_by_default: false
      # 集群前置代理 IP，将用于展示给用户配置独立域名解析
      # 如若没有，在非生产环境可暂时填写 NodeIP
      frontend_ingress_ip: "127.0.0.1"
    # bcs API 密钥的值，将作为访问 bcs api 的凭证
    tokenValue: "eyJhbGciOiJSUzI1NiIsImtp..."
    annotations:
      # 使用 bcs 集群则必须配置以下注解信息      
      bcsClusterID: "BCS-K8S-00000"
      bcsProjectID: "037f75ec8771f011eb3f07a057784486"
    apiServers:
      - host: "https://bcs.example.com/clusters/BCS-K8S-00000"
```

#### 4.2 直连集群 ApiServer

##### 4.2.1 获取 ApiServer 访问证书

1. BCS 集群

如果你的应用集群是通过 BCS 服务生成且托管的集群，那么你可以在 Master 节点的 `/etc/kubernetes/ssl/` 中找到已签发的证书。

其中 `ca.pem` 、 `apiserver.pem` 、 `apiserver-key.pem` 就对应了初始化配置中的 `caData` 、 `certData` 、 `keyData` ，将其中内容进行 `base64` 编码，填入 `values.yaml` 中。

2. 自建集群

如果你的应用集群**仅是通过 BCS 服务托管而非生成的**，你需要通过 `cat $HOME/.kube/config` 查看访问证书，并仿照上一小节，将证书内容编码并正确填写。

> 注：如不使用“客户端证书”方式校验，可不填写 `certData` 与 `keyData` 字段。

##### 4.2.2 选择集群身份校验方式

当前，你可以使用两种不同的身份校验方式：`客户端证书` 或 `BearerToken`。

###### 客户端证书

如需使用“客户端证书”方式完成身份校验，请配置 `certData`、`keyData` 两个字段（均需 base64 编码），并确保该证书签发的身份在 K8S RBAC 权限体系中拥有 `cluster-admin` 的身份，否则可使用参考下面的命令手动绑定。

```bash
# 以用户名 kube-apiserver 为例
kubectl create clusterrolebinding apiserver --clusterrole=cluster-admin --user kube-apiserver
```

###### Bearer Token

使用 `BearerToken` 完成身份校验，你首先需要拿到一个有效的 Token。获取集群 token 最常见的方式，是创建一个属于 `cluster-admin` 角色的 ServiceAccount 账号，然后使用该账号的 token。

举个例子，下面的 YAML 资源会在集群的 `kube-system` 命名空间中创建一个名为 `admin-user` 的具有 `cluster-admin` 权限的 ServiceAccount 对象：

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

之后执行以下命令就可获取 Token：

```console
# 读取 token 所在 Secret 名称
$ TOKENNAME=`kubectl -n kube-system get serviceaccount/admin-user -o jsonpath='{.secrets[0].name}'`

# 读取并打印 Token（base64 解码过的）
$ kubectl -n kube-system get secret $TOKENNAME -o jsonpath='{.data.token}'| base64 --decode
eyJhbGciOiJSUzI1NiIsImtp...
```

最后将该 Token 填入 bkpaas3 模块的 `apiserver.initialCluster.tokenValue` 配置项中即可完成身份校验配置。

##### 4.2.3 填写引用集群的访问地址

`apiServers.host` 为 K8S ApiServer 访问地址，形如 https://some-api-server-host:port

可以参考[通过 REST API 访问集群](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#directly-accessing-the-rest-api)获取集群的访问地址。

##### 4.2.4 `values.yaml` 配置示例

```yaml
apiserver:
  initialCluster:
    # 如果想在安装时直接配置，请修改 enabled: true
    enabled: true
    # 集群访问入口相关配置
    ingressConfig:
      sub_path_domain: "apps.example.com"
      enable_https_by_default: false
      # 集群前置代理 IP，将用于展示给用户配置独立域名解析
      # 如若没有，在非生产环境可暂时填写 NodeIP
      frontend_ingress_ip: "127.0.0.1"
    caData: "LS0tLS1CRU..."
    tokenValue: "eyJhbGciOiJSUzI1NiIsImtp..."
    apiServers:
      - host: "https://127.0.0.1:6553"
```

**注意**： 该配置只会在初次部署( `helm install` ）时生效，安装完成后的若需持续更新集群配置，请通过 `${PAAS_DOMAIN}/backend/admin42/platform/clusters/manage/` 进行管理，同时修改数据后，请重启 apiserver 模块的 `web` & `worker` 进程。

完成以上步骤，准备好 `values.yaml` 后，便可继续 `bkpaas3` 安装了。

## 安装 Chart

填写 Values.yaml 后，还必须先添加一个有效的 Helm repo 仓库。

```shell
# 请将 `<HELM_REPO_URL>` 替换为本 Chart 所在的 Helm 仓库地址
$ helm repo add bkee <HELM_REPO_URL>
```

添加仓库成功后，执行以下命令，在集群内安装名为 `bkpaas3` 的 Helm release：

```shell
$ helm install bkpaas3 bkee/bkpaas3 --values value.yaml
```

上述命令将在 Kubernetes 集群中部署蓝鲸 PaaS 服务, 并输出访问指引。

## 后置步骤

安装完成后，还需要执行 helm notes 中输出的 `kubectl run ...` 命令，才能正常部署应用。

该命令会从腾讯云对象存储 [https://bkpaas-runtimes-1252002024.file.myqcloud.com](https://bkpaas-runtimes-1252002024.file.myqcloud.com) 下载蓝鲸提供的构建工具及 heroku 提供的运行时工具，并上传到 bkreop 指定仓库中统一目录。

### 配置平台增强服务

“增强服务” 是 PaaS 平台为 SaaS 提供的 MySQL 数据库等增强功能，你需要参考以下步骤，完成配置。

第 1 步：获取“可供 SaaS 访问的”服务实例地址

视部署条件不同，该步骤有两种一样的操作方式。

假如 SaaS 与平台集群共享了同一套 Kubernets 集群，你可通过执行 `kubectl get svc` 命令，直接获取各服务的 Service 地址（注意：仅支持同集群内访问）

当 SaaS 和平台部署在不同 Kubernetes 集群时，上面的 Service 就无法发挥作用了。你可以使用默认安装的 nodePort 类型 Service 地址：

* 对平台集群执行命令 `kubectl get svc xxxx -o jsonpath='{.spec.ports[0].nodePort}'`，获取增强服务对外暴露的 Service 的 NodePort 端口
* 假设端口号为 32199，节点 IP 为 10.0.0.1，则服务访问地址为 10.0.0.1:32199
* 如果是 rabbitmq，会有两个端口需要注意，一个是 5672 对应的 AMQP 端口，一个是 15672 对应的 API 端口

第 2 步：修改 MySQL 增强服务配置

在PaaS3.0开发者中心-平台管理-增强服务管理-方案管理 （${bkPaas3Url}/backend/admin42/platform/clusters/manage/）页面修改 `	
default-mysql` 的方案配置信息。

第 3 步：修改 RabbitMQ 增强服务配置

首先你需要修改 rabbitmq 的相关 values 配置

```yaml
svc-rabbitmq:
  env:
  # 默认集群地址
  - name: "RABBITMQ_DEFAULT_CLUSTER_HOST"
    value: "10.0.0.1"
  # 默认集群 amqp 端口
  - name: "RABBITMQ_DEFAULT_CLUSTER_AMQP_PORT"
    value: "32199"
  # 默认集群 api 端口
  - name: "RABBITMQ_DEFAULT_CLUSTER_API_PORT"
    value: "32666"
  # 默认集群管理员用户名
  - name: "RABBITMQ_DEFAULT_CLUSTER_ADMIN"
    value: "请填入 .Values.rabbitmq.auth.username 对应值"
  # 默认集群管理员用户名
  - name: "RABBITMQ_DEFAULT_CLUSTER_PASSWORD"
    value: "请填入 .Values.rabbitmq.auth.username 对应值"
```

然后重新 `helm upgrade` 更新 `bkpaas3` 。

> 注意：本 helm 的提供的 MySQL 与 RabbitMQ 等增强服务，仅供快速验证，无高可用配置，请勿在生产环境使用。

## 卸载Chart

使用以下命令卸载 `bkpaas3` :

```bash
# 卸载资源
helm uninstall bkpaas3

# 已安装的 mariadb & redis & rabbitmq 等内建资源并不会被删除，防止没有开启持久化期间产生的数据被销毁
# 如果确认已不再需要相关内容，可执行以下命令手动删除
kubectl delete deploy,job,sts,cronjob,pod,svc,ingress,secret,cm,sa,role,rolebinding -l app.kubernetes.io/instance=bkpaas3
```

上述命令将移除所有与 bkpaas3 相关的 Kubernetes 资源，并删除 release。

## 配置案例

### 1. 自定义镜像地址

我们会在每次发布新版时，会同步更新 Chart 中的镜像版本，所以如果你只是想使用最新版本的官方镜像，可以跳过此节，不用关注镜像的填写。

如果你想使用官方其他版本或者自己构建的镜像，也可以在 values.yaml 中修改，配置示例：

```yaml
global:
  imageRegistry: ""
  imagePullSecrets: []
```

### 2. 配置蓝鲸制品仓库（bkrepo）依赖

PaaS 平台在部署应用时，会从蓝鲸制品仓库下载一些必须工具，这包括应用镜像、应用构建 buildpack 包，各编程语言二进制源码包，等等。因此平台在初始化安装时，需要以**管理员身份**访问 bkrepo 服务，上传这些工具包。

此外，PaaS 平台还有另外两部分功能会依赖 bkrepo：

1. “蓝鲸制品库”增强服务，供平台应用自助上传、下载文件
2. 供“蓝鲸低代码平台（LessCode）”存储应用源码包

综上所述，完整的 bkrepo 配置共需 4 份不同账号信息。其中：
* 管理员账号密码：可以从 bkrepo 的 Helm NOTES 获取”初始用户名/密码“
* 其他三个账号，是在部署 apiServer 时主动去 bkrepo 上创建账号密码。**注意：目前只会创建账号密码，不会修改密码**

##### `values.yaml` 配置示例：

```yaml
global:
  bkrepoConfig:
    # bkrepo 服务的网关地址
    endpoint: http://bkrepo.example.com
    # bkrepo Docker Registry Addr
    dockerRegistryAddr: "docker.example.com:80"
    # 管理员权限，账号密码可以从 bkrepo 的 Helm NOTES 的 ”初始用户名/密码“ 获取
    adminUsername: admin
    adminPassword: blueking

    # svc-bkrepo 增强服务项目使用的 bkrepo 用户名/密码
    # 必须与增强服务中 `svc-bkrepo.plan.username` 配置项的值一样
    addonsUsername: bksaas-addons
    # 必须与增强服务中 `svc-bkrepo.plan.password` 配置项的值一样
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

### 3. 初始化与配置内建数据存储

默认地，我们为 **快速功能验证** 提供了一套内建的数据存储，包括 `mariadb` 和 `redis` ，你可以在 `bkpaas3` 的 `values.yaml` 看到具体配置：

```yaml
mariadb:
  enabled: true
  commonAnnotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-weight": "-1"
    "helm.sh/hook-delete-policy": hook-failed,before-hook-creation
  architecture: standalone
  auth:
    rootPassword: "root"
    username: "bkpaas"
    password: "root"
  primary:
    # 默认我们未开启持久化，如有需求可以参考:
    # - https://kubernetes.io/docs/user-guide/persistent-volumes/
    # - https://github.com/bitnami/charts/blob/master/bitnami/mariadb/values.yaml#L360
    persistence:
      enabled: false
  initdbScriptsConfigMap: "paas-mariadb-init"

redis:
  enabled: true
  commonAnnotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-weight": "-1"
    "helm.sh/hook-delete-policy": hook-failed,before-hook-creation
  sentinel:
    enabled: true
  auth:
    password: ""
  master:
    persistence:
      enabled: false

rabbitmq:
  enabled: true
  auth:
    username: admin
    password: blueking
    erlangCookie: blueking
  service:
    type: NodePort
    port: 5672
    managerPort: 15672
  persistence:
    enabled: false
```

我们并不保证该存储的高可用性，所以在生产环境中**不推荐**你使用它，请使用更可靠的外部数据存储。

### 5. 蓝鲸日志采集配置

用于将标准输出日志采集到蓝鲸日志平台。默认未开启，如需开启请将 `bkLogConfig.enabled` 设置为 true。

##### `values.yaml` 配置示例：
```yaml
apiserver:
  ## 蓝鲸日志采集配置
  bkLogConfig:
    enabled: false
    dataId: 1
svc-bkrepo:
  ## 蓝鲸日志采集配置
  bkLogConfig:
    enabled: false
    dataId: 1
svc-rabbitmq:
  ## 蓝鲸日志采集配置
  bkLogConfig:
    enabled: false
    dataId: 1
svc-mysql:
  ## 蓝鲸日志采集配置
  bkLogConfig:
    enabled: false
    dataId: 1
```

### 6. 蓝鲸 Oauth 服务

开启蓝鲸 Oauth 服务后，蓝鲸应用的 bk_app_secret 信息将由 bk-oauth 服务纳管，不再同步到 bk_app_secret 信息到 open-paas 数据库中
##### `values.yaml` 配置示例：
```yaml
global:
  ## 蓝鲸 Oauth 服务
  bkAuth:
    enabled: false
```

### 7. 容器监控 Service Monitor

默认未开启，如需开启请将 `serviceMonitor.enabled` 设置为 true。目前只有 apiserver 模块暴露了 metric。

##### `values.yaml` 配置示例：
```yaml
apiserver:
  serviceMonitor:
    enabled: true
```

更多配置的案例请参考: 蓝鲸文档中心 > PaaS 平台 > 应用运维 > PaaS3.0 应用运维 > 安装指南。

## 版本发布规范

1. 页面 footer 的版本号由 `Chart.AppVersion` 渲染
- 需要保证 webfe 子 chart 的 AppVersion 与最外层的 AppVersion 一致

2. [要求] appVersion 同项目交包 git tag 版本一致
- 如果有代码改动，同时更新 image tag 和 appVersion
- 只改 charts 、不改镜像时，不需要更新 appVersion