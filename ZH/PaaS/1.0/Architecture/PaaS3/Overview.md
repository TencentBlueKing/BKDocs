# 环境要求
* Kubernetes：`1.12` 或更高版本
* Helm：`v3.0.0` 或更高版本

# 数据存储
| 名称           |    备注               |
|-------------------|------------------------|
| **MySQL**         | 用于存储关系数据，要求版本为 5.7 或更高 |
| **Redis**         | 用于保存缓存数据和后台任务的消息队列 |
| **bkrepo**        | 用于保存应用部署中间结果、缓存信息；用作 pypi、npm 镜像源；和给 SaaS 提供对象存储增强服务 |
| **RabbitMQ**      | 用于给 SaaS 提供 RabbitMQ 增强服务 |
| **Sentry**      | 非核心依赖，用于上报程序异常信息 |
| **ElasticSearch**      | 非核心依赖，用于存储 SaaS 的日志  |

# 系统功能

| 进程名称           |    功能                 |
|-------------------|------------------------|
| bkpaas3-webfe-web | PaaS 项目的前端，通过 Nginx 托管静态页面 |
| bkpaas3-apiserver-web | PaaS 主控模块，提供 API 服务，并负责和后端 K8S 交互 |
| bkpaas3-apiserver-worker | apiserver 后台任务进程 |
| bkpaas3-apiserver-deleting-instances | 清理已解除绑定的增强服务实例,每半小时执行一次 |
| bkpaas3-apiserver-update-pending-status | 更新长久未结束的部署任务状态，每半个小时执行一次 |
| bkpaas3-apiserver-migrate-db  | 初始化 apiserver 模块 DB，并创建 bkreop 仓库和 bucket |
| bkpaas3-apiserver-init-data | 初始化数据 |
| bkpaas3-apiserver-init-devops | 初始化运行时 |
| bkpaas3-apiserver-init-npm | 初始化应用开发 NPM 包，可不开启 |
| bkpaas3-apiserver-init-pypi | 初始化应用开发 Pypi 包，可不开启 |
| bkpaas3-svc-bkrepo-web | bkrepo 增强服务主进程 |
| bkpaas3-svc-bkrepo-migrate-db | 初始化 svc-bkrepo 模块 DB |
| bkpaas3-svc-mysql-web | MySQL 增强服务主进程 |
| bkpaas3-svc-mysql-migrate-db | 初始化 svc-mysql 模块 DB |
| bkpaas3-svc-mysql-deleting-instances | 清理已删除的 MySQL 增强服务实例，每半个小时执行一次 |
| bkpaas3-svc-rabbitmq-web | RabbitMQ 增强服务主进程 |
| bkpaas3-svc-rabbitmq-migrate-db | 初始化 svc-rabbitmq 模块 DB |
| bkpaas3-svc-rabbitmq-deleting-instances 	| 清理已删除的 RabbitMQ 增强服务实例，每半个小时执行一次 |
