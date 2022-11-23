## bk-services 配置项说明

### 全局

|参数|描述|默认值 |
|---|---|---|
|<a name="global.imagePullSecrets"></a>`global.imagePullSecrets.extraSecrets` | 预先创建的镜像拉取凭证名称列表  | `[]` |
| `global.imagePullSecrets.credential.enabled` | 是否创建独享的镜像拉取凭证 | `false` |
| `global.imagePullSecrets.credential.username` | 镜像仓库凭证用户名 | `""` |
| `global.imagePullSecrets.credential.password` | 镜像拉取凭证密码 | `""` |
| `global.imagePullSecrets.credential.registry` | 镜像仓库凭证地址 | `""` |
| `global.imagePullSecrets.credential.name` | 镜像仓库凭证名 | `"custom-pull-secret"` |
| `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` | 与 paas-stack 中 ApiServer 模块通信的加密秘钥，必须与 paas-stack 模块中配置的 `global.env.PAAS_SERVICE_JWT_CLIENTS_KEY` 一致| `""` |

### MySQL

以下变量均以 `svc-mysql.` 开头。

|参数|描述|默认值 |
|---|---|---|
| `image.repository` | svc-mysql 镜像地址 | `""` |
| `image.tag` | svc-mysql 镜像 Tag | `""` |
| `env.MYSQL_NAME` | 当前服务依赖的数据库名称 | `"svc_mysql"` |
| `env.MYSQL_USER` | 当前服务依赖的数据库用户 | `"bk_services"` |
| `env.MYSQL_PASSWORD` | 当前服务依赖的数据库密码 | `"xxxx"` |
| `env.MYSQL_HOST` | 当前服务依赖的数据库名称 | `"127.0.0.1"` |
| `env.MYSQL_PORT` | 当前服务依赖的数据库名称 | `"3306"` |
| `env.BKKRILL_ENCRYPT_SECRET_KEY` | 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改。通过 from cryptography.fernet import Fernet; Fernet.generate_key() 可以生成随机 key | `"Q3NyY0V3cFpTUlVNbHp3RUZMYWtXaEdOdXp3eWZNSkc="` |
| `plan.host` | SaaS 使用的数据库实例 host | `"127.0.0.1"` |
| `plan.port` | SaaS 使用的数据库实例 port | `"3306"` |
| `plan.user` | SaaS 使用的数据库实例的管理员账号用户名，必须具有执行 `grant` 语句执行权限 | `"root"` |
| `plan.password` | SaaS 使用的数据库实例的管理员账号密码 | `"xxxx"` |
| `plan.auth_ip_list` | 内置的授权访问权限 IP 列表 | `- "%"` |

### Bk-Repo

以下变量均以 `svc-bkrepo.` 开头。

|参数|描述|默认值 |
|---|---|---|
| `image.repository` | svc-bkrepo 镜像地址 | `"mirrors.example.com/bkee/paas3-svc-bkrepo"` |
| `image.tag` | svc-bkrepo 镜像 Tag | `"1.0.0"` |
| `env.MYSQL_NAME` | 当前服务依赖的数据库名称 | `"svc_bkrepo"` |
| `env.MYSQL_USER` | 当前服务依赖的数据库用户 | `"bk_services"` |
| `env.MYSQL_PASSWORD` | 当前服务依赖的数据库密码 | `"xxxx"` |
| `env.MYSQL_HOST` | 当前服务依赖的数据库名称 | `"127.0.0.1"` |
| `env.MYSQL_PORT` | 当前服务依赖的数据库名称 | `"3306"` |
| `env.BKKRILL_ENCRYPT_SECRET_KEY` | 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改。通过 from cryptography.fernet import Fernet; Fernet.generate_key() 可以生成随机 key | `"U2ViQ1dRc0FiSU9jaFBhd0p0emhZQmhxRHpDdGdxU1k="` |
| `plan.endpoint_url` | bkrepo 服务的网关地址, 必须与 paas-stack 模块中配置的 global.bkrepoConfig.endpoint 一致 | `"http://bkrepo.example.com"` |
| `plan.username` | bk-repo 账号名, 必须与 paas-stack 模块中配置的 global.bkrepoConfig.addonsUsername 一致 | `"bksaas-addons"` |
| `plan.password` | bk-repo 账号密码, 必须与 paas-stack 模块中配置的 global.bkrepoConfig.addonsPassword 一致 | `"blueking"` |

### RabbitMQ

以下变量均以 `svc-rabbitmq.` 开头。

|参数|描述|默认值 |
|---|---|---|
| `image.repository` | svc-rabbitmq 镜像地址 | `""` |
| `image.tag` | svc-rabbitmq 镜像 Tag | `""` |
| `env.SECRET_KEY` | Django secret key | `""` |
| `env.BKKRILL_ENCRYPT_SECRET_KEY` | 数据库敏感字段加密 Key，一次性变量指定，安装成功后请勿修改。通过 from cryptography.fernet import Fernet; Fernet.generate_key() 可以生成随机 key | `"THD7-GIgbdAQWbhRgr7FsXTP8CTkRKivxxfuE9Povrk="` |
| `env.DATABASE_NAME` | 数据库名称 | `"svc_rabbitmq"` |
| `env.DATABASE_USER` | 数据库用户 | `"bk_services"` |
| `env.DATABASE_PASSWORD` | 数据库密码 | `"xxxx"` |
| `env.DATABASE_HOST` | 数据库地址 | `"127.0.0.1"` |
| `env.DATABASE_PORT` | 数据库端口 | `"3306"` |
| `env.CACHE_BACKEND` | 缓存后端 | `"database"` |
| `env.RABBITMQ_DEFAULT_CLUSTER` | 默认集群名称（如不需要自动注册，请留空） | `"default"` |
| `env.RABBITMQ_DEFAULT_CLUSTER_HOST` | 默认集群地址 | `"database"` |
| `env.RABBITMQ_DEFAULT_CLUSTER_AMQP_PORT` | 默认集群 amqp 端口 | `"5672"` |
| `env.RABBITMQ_DEFAULT_CLUSTER_API_PORT` | 默认集群 api 端口 | `"15672"` |
| `env.RABBITMQ_DEFAULT_CLUSTER_ADMIN` | 默认集群管理员用户名 | `"admin"` |
| `env.RABBITMQ_DEFAULT_CLUSTER_PASSWORD` | 默认集群管理员密码 | `""` |
| `env.PORT` | 服务监听端口 | `"8080"` |