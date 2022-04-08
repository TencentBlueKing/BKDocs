## paas-stack 配置项说明

### 全局

| 参数                                                                         | 描述                                                                               | 默认值               | 示例                                                                                                                                                                                   |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <a name="global.imagePullSecrets"></a>`global.imagePullSecrets.extraSecrets` | 预先创建的镜像拉取凭证名称列表                                                     | []                   |                                                                                                                                                                                        |
| `global.imagePullSecrets.credential.enabled`                                 | 是否创建独享的镜像拉取凭证                                                         | false                |                                                                                                                                                                                        |
| `global.imagePullSecrets.credential.username`                                | 镜像仓库凭证用户名                                                                 | ""                   | "username"                                                                                                                                                                             |
| `global.imagePullSecrets.credential.password`                                | 镜像拉取凭证密码                                                                   | ""                   | "password"                                                                                                                                                                             |
| `global.imagePullSecrets.credential.registry`                                | 镜像仓库凭证地址                                                                   | ""                   | "mirrors.blueking.com"                                                                                                                                                                 |
| `global.imagePullSecrets.credential.name`                                    | 镜像仓库凭证名                                                                     | "custom-pull-secret" |                                                                                                                                                                                        |
| `global.bkrepoConfig.bkpaas3Username`                                        | bkpaas3 使用的 bkrepo 用户名                                                       | "bkpaas3"            |                                                                                                                                                                                        |
| `global.bkrepoConfig.bkpaas3Password`                                        | bkpaas3 使用的 bkrepo 密码                                                         | "blueking"           |                                                                                                                                                                                        |
| `global.bkrepoConfig.bkpaas3Project`                                         | bkpaas3 使用的 bkrepo 项目名称                                                     | "bkpaas"             |                                                                                                                                                                                        |
| `global.bkrepoConfig.addonsUsername`                                         | svc-bkrepo 增强服务项目使用的 bkrepo 用户名                                        | "bksaas-addons"      |                                                                                                                                                                                        |
| `global.bkrepoConfig.addonsPassword`                                         | svc-bkrepo 增强服务项目使用的 bkrepo 密码                                          | "blueking"           |                                                                                                                                                                                        |
| `global.bkrepoConfig.lesscodeUsername`                                       | lesscode 增强服务项目使用的 bkrepo 用户名                                          | "bklesscode"         |                                                                                                                                                                                        |
| `global.bkrepoConfig.lesscodePassword`                                       | lesscode 增强服务项目使用的 bkrepo 密码                                            | "blueking"           |                                                                                                                                                                                        |
| `global.bkrepoConfig.endpoint`                                               | bkrepo 服务的网关地址                                                              | ""                   | "http://bkrepo.com"                                                                                                                                                                    |
| `global.sharedDomain`                                                        | 全局共享域名，当模块内进程域名未指定时生效。默认将使用该域名拼接所有产品访问域名。 | "bktencent.com"      |                                                                                                                                                                                        |
| `global.hostAliases`                                                         | 全局 hosts 配置                                                                    | []                   | 填写原生 k8s 内容，请参考 [Adding entries to Pod /etc/hosts with HostAliases](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |

### ApiServer

以下参数均以 `apiServer.` 开头，描述中已省略。

| 参数               | 描述                                              | 默认值   | 示例                                   |
| ------------------ | ------------------------------------------------- | -------- | -------------------------------------- |
| `replicaCount`     | 缺省副本数设置，当 `processes` 变量中未定义时采用 | 1        |                                        |
| `image.tag`        | 镜像 tag                                          | ""       | "1.0.0"                                |
| `image.repository` | 镜像地址                                          | ""       | "mirrors.example.com/bkee/paas3-apiserver" |
| `image.pullPolicy` | 镜像拉取策略                                      | "Always" |                                        |
| `enabled`          | 是否开启                                          | true     |                                        |

#### 环境变量配置

以下参数均以 `apiServer.env.` 开头，描述中已省略。

| 参数                                   | 描述                                                                                                                                                                                    | 默认值                           | 示例                                                        |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- | ----------------------------------------------------------- |
| `BK_APP_CODE`                          | 应用 Code                                                                                                                                                                               | "bk_paas3"                       |                                                             |
| `BK_APP_SECRET`                        | 应用 Secret                                                                                                                                                                             | ""                               | "abcd-efgh-ijkl-mnop"                                       |
| `DJANGO_LOG_LEVEL`                     | 日志等级                                                                                                                                                                                | "INFO"                           |                                                             |
| `PAAS3_MYSQL_NAME`                     | apiServer DB 库名                                                                                                                                                                       | "paas3_apiserver"                |                                                             |
| `PAAS3_MYSQL_USER`                     | apiServer DB 用户                                                                                                                                                                       | "paas3_apiserver"                |                                                             |
| `PAAS3_MYSQL_PASSWORD`                 | apiServer DB 密码                                                                                                                                                                       | "blueking"                       |                                                             |
| `PAAS3_MYSQL_HOST`                     | apiServer DB 地址                                                                                                                                                                       | "127.0.0.1"                      |                                                             |
| `PAAS3_MYSQL_PORT`                     | apiServer DB 端口                                                                                                                                                                       | "3306"                           |                                                             |
| `OPEN_PAAS_MYSQL_NAME`                 | PaaS 2.0 DB 库名                                                                                                                                                                        | "open_paas"                      |                                                             |
| `OPEN_PAAS_MYSQL_USER`                 | PaaS 2.0 DB 用户                                                                                                                                                                        | "open_paas"                      |                                                             |
| `OPEN_PAAS_MYSQL_PASSWORD`             | PaaS 2.0 DB 密码                                                                                                                                                                        | "blueking"                       |                                                             |
| `OPEN_PAAS_MYSQL_HOST`                 | PaaS 2.0 DB 地址                                                                                                                                                                        | "127.0.0.1"                      |                                                             |
| `OPEN_PAAS_MYSQL_PORT`                 | PaaS 2.0 DB 端口                                                                                                                                                                        | "3306"                           |                                                             |
| `REDIS_URL`                            | Redis存储，用于后台任务、缓存等用途，需要和 engine 项目变量 `STREAM_CHANNEL_REDIS_URL` 保持一致                                                                                         | ""                               | "redis://paas-v3:blueking@127.0.0.1:6379/0"                 |
| `LOG_ELASTICSEARCH_HOST`               | 日志查询使用的 ES7 访问地址                                                                                                                                                             | ""                               | "elasticsearch.example.com"                                 |
| `LOG_ELASTICSEARCH_PORT`               | 日志查询使用的 ES7 访问端口                                                                                                                                                             | ""                               | "9200"                                                      |
| `LOG_ELASTICSEARCH_AUTH`               | ES7 访问凭证                                                                                                                                                                            | ""                               | "username:password"                                         |
| `SENTRY_DSN`                           | 错误监测 Sentry DSN，用于平台排障                                                                                                                                                       | ""                               | "http://some-user:some-password@sentry.example.com:80/1766" |
| `BKKRILL_ENCRYPT_SECRET_KEY`           | 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改。通过 `tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64` 可以生成随机 key                                                | ""                               | "SUhDS0pxT1J4dmwycnV1RDV4NDdpaVRVellWN0p0d1o="              |
| `APP_IMAGE`                            | 应用镜像地址, 需公开访问                                                                                                                                                                | ""                               | "slug-pilot:app"                                            |
| `SMART_APP_IMAGE`                      | Smart 应用镜像地址, 需公开访问                                                                                                                                                          | ""                               | "slug-pilot:smart"                                          |
| `BUILDPACK_PYTHON_PIP_INDEX_URL`       | Pypi 默认源地址                                                                                                                                                                         | "https://pypi.python.org/simple" |                                                             |
| `BUILDPACK_PYTHON_PIP_EXTRA_INDEX_URL` | Pypi 额外私有源地址                                                                                                                                                                     | ""                               | "https://pypi.blueking.com/simple"                          |
| `BUILDPACK_NODEJS_NPM_REGISTRY`        | NPM 默认源地址                                                                                                                                                                          | "https://registry.npmjs.org"     |                                                             |
| `BK_PAAS3_PRIVATE_TOKEN_FOR_APIGW`     | APIGW 调用 PaaS3.0 APIServer 系统级接口的 token 请填写长度介于[30, 64]之间的, 由26位字母(大小写敏感)组成的字符串, 需要与 APIGW 项目中的 `BK_PAAS3_PRIVATE_TOKEN_FOR_APIGW` 变量保持一致 | ""                               | "vd2y8wgHgoUVFegCjh0XIPI8cA46bz"                            |

### Engine

以下参数均以 `engine.` 开头，描述中已省略。

| 参数               | 描述                                            | 默认值   | 示例                                |
| ------------------ | ----------------------------------------------- | -------- | ----------------------------------- |
| `enabled`          | 是否开启                                        | true     |                                     |
| `replicaCount`     | 缺省副本数设置，当 processes 变量中未定义时采用 | 1        |                                     |
| `image.repository` | 镜像地址                                        | ""       | "mirrors.example.com/bkee/paas3-engine" |
| `image.tag`        | 镜像 tag                                        | ""       | "1.0.0"                             |
| `image.pullPolicy` | 镜像拉取策略                                    | "Always" |                                     |

#### 初始化集群配置

以下参数均以 `engine.initialCluster.` 开头，以下描述中已省略。

**注意：initialCluster 仅是为了加速初次安装验证，仅会在 post-install hook 中执行，默认未开启，请修改 `enabled` 字段开启。
安装完成后的若需持续更新集群配置，请通过 `${PAAS_DOMAIN}/backend/admin42/platform/clusters/manage/` 进行管理**

| 参数                                    | 描述                                                                                                                                     | 默认值 | 示例                                   |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ------ | -------------------------------------- |
| `enabled`                               | 是否开启初始化集群配置                                                                                                                   | false  |                                        |
| `ingressConfig.sub_path_domain`         | 应用子路径对外访问地址，渲染后形如 "apps.blueking.com/some-app-code"                                                                     | ""     | "apps.blueking.com"                    |
| `ingressConfig.enable_https_by_default` | 是否默认开启应用 https 访问                                                                                                              | false  |                                        |
| `ingressConfig.frontend_ingress_ip`     | 集群前置代理 IP，将用于展示给用户配置独立域名解析, 可以查看 [如何配置集群前置代理 IP](../../docs/configure_ingress_front_ip.md) 了解更多 | ""     | "1.1.1.1"                              |
| `caData`                                | base64编码，数字证书认证机构                                                                                                             | ""     | "ZXhhbXBsZQo="                         |
| `certData`                              | base64编码，客户端证书（仅校验方式为“客户端证书”时使用）                                                                                 | ""     | "ZXhhbXBsZQo="                         |
| `keyData`                               | base64编码，客户端密钥（仅校验方式为“客户端证书”时使用）                                                                                 | ""     | "ZXhhbXBsZQo="                         |
| `tokenValue`                            | 用于校验的集群身份 Token（仅校验方式为 “Bearer Token ”时使用）                                                                           | ""     | "ZXhhbXBsZQo="                         |
| `annotations.bcsClusterID`              | BCS Cluster ID                                                                                                                           | ""     | "BCS-K8S-4000X"                        |
| `annotations.bcsProjectID`              | BCS Project ID                                                                                                                           | ""     | "your-bcs-project-id"                  |
| `apiServers[0].host`                    | 应用集群 k8s ApiServer 访问地址                                                                                                          | ""     | "https://your-api-servers-domain:port" |

#### 环境变量配置

以下参数均以 `engine.env.` 开头，描述中已省略。

| 参数                       | 描述                                                                        | 默认值                                                      | 示例                                        |
| -------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------- |
| `DJANGO_LOG_LEVEL`         | 日志等级                                                                    | "INFO"                                                      |                                             |
| `ENGINE_MYSQL_NAME`        | engine DB 库名                                                              | "paas3_engine"                                              |                                             |
| `ENGINE_MYSQL_USER`        | engine DB 用户                                                              | "paas3_engine"                                              |                                             |
| `ENGINE_MYSQL_PASSWORD`    | engine DB 密码                                                              | "blueking"                                                  |                                             |
| `ENGINE_MYSQL_HOST`        | engine DB 地址                                                              | "127.0.0.1"                                                 |                                             |
| `ENGINE_MYSQL_PORT`        | engine DB 端口                                                              | "3306"                                                      |                                             |
| `STREAM_CHANNEL_REDIS_URL` | Redis存储，用于部署日志推送，需要和 apiServer 项目变量 `REDIS_URL` 保持一致 | ""                                                          | "redis://paas-v3:blueking@127.0.0.1:6379/0" |
| `CELERY_BROKER_URL`        | Redis 存储，用于后台任务相关，**不能**和 apiServer `REDIS_URL` 共用         | ""                                                          | "redis://paas-v3:blueking@127.0.0.1:6379/1" |
| `CELERY_RESULT_BACKEND`    | Redis 存储，用于后台任务相关，**不能**和 apiServer `REDIS_URL` 共用         | ""                                                          | "redis://paas-v3:blueking@127.0.0.1:6379/1" |
| `SENTRY_DSN`               | 错误监测 Sentry DSN，用于平台排障                                           | "http://some-user:some-password@sentry.example.com:80/1766" |                                             |

### Webfe

以下参数均以 `webfe.` 开头，描述中已省略。

| 参数               | 描述                                            | 默认值   | 示例                               |
| ------------------ | ----------------------------------------------- | -------- | ---------------------------------- |
| `enabled`          | 是否开启                                        | true     |                                    |
| `replicaCount`     | 缺省副本数设置，当 processes 变量中未定义时采用 | 1        |                                    |
| `image.repository` | 镜像地址                                        | ""       | "mirrors.example.com/bkee/paas3-webfe" |
| `image.tag`        | 镜像 tag                                        | ""       | "1.0.0"                            |
| `image.pullPolicy` | 镜像拉取策略                                    | "Always" |                                    |

### extraInitial

以下参数以 `extraInitial.` 开头, 描述中已省略。

| 参数                      | 描述                                                                                                                 | 默认值                       | 示例                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- | ---------------------------- | --------------------------------------------- |
| `npm.enabled`             | 是否在部署后自动执行『后置步骤』-『上传 NPM 依赖包到 bkrepo 服务』                                                   | false                        |                                               |
| `npm.position`            | 触发『上传 NPM 依赖包到 bkrepo 服务』的位置                                                                          | "post-install, post-upgrade" |                                               |
| `npm.image.repository`    | 镜像地址                                                                                                             | ""                           | "mirrors.example.com/bkpaas/init-npm"         |
| `npm.image.tag`           | 镜像 tag                                                                                                             | ""                           | "1.0.0"                                       |
| `npm.image.pullPolicy`    | 镜像拉取策略                                                                                                         | "Always"                     |                                               |
| `pypi.enabled`            | 是否在部署后自动执行『后置步骤』-『上传 Python 依赖包到 bkrepo 服务』                                                | false                        |                                               |
| `pypi.position`           | 触发『上传 Python 依赖包到 bkrepo 服务』的位置                                                                       | "post-install, post-upgrade" |                                               |
| `pypi.image.repository`   | 镜像地址                                                                                                             | ""                           | "mirrors.example.com/bkpaas/init-pypi"        |
| `pypi.image.tag`          | 镜像 tag                                                                                                             | ""                           | "1.0.0"                                       |
| `pypi.image.pullPolicy`   | 镜像拉取策略                                                                                                         | "Always"                     |                                               |
| `devops.enabled`          | 是否在部署后自动执行「初始化构建工具的后续步骤」，需要保证 bkpaas3Username/bkpaas3Password/bkpaas3Project 的配置有效 | true                         |                                               |
| `devops.position`         | 表示 helm hook 触发的钩子位置. 支持所有 helm hook                                                                    | "post-install,post-upgrade"  |
| `devops.image.repository` | 镜像地址                                                                                                             | ""                           | "mirrors.example.com/paas3-buildpack-toolkit" |
| `devops.image.tag`        | 镜像 tag                                                                                                             | ""                           | "1.0.0"                                       |
| `devops.image.pullPolicy` | 镜像拉取策略                                                                                                         | "Always"                     |                                               |
