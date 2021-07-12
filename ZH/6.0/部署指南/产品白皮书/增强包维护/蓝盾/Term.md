# 术语解释
## 名称约定

蓝盾(持续集成平台)，简称为 `bk-ci`。

部署脚本中以 `ci` 作为标识， env 文件中所有变量以 `BK_CI_` 开头。
蓝盾注册在 ESB 中的 `app_code` 为 `bk_ci`。
install.config 中 ，使用 `ci(工程名)` 表示蓝盾的组件。
systemd 服务名： `bk-ci-工程名.service`， 都位于 `bk-ci.target` 下。

## 蓝盾组件介绍

如下为蓝盾的组件，也称为“工程”（`proj`， `project`）。

工程名是蓝鲸环境中各种名称的基础。
如 `install.config` 中使用 `ci(工程名)` 来指代蓝盾的某个工程。
如 安装完成后， systemd 的服务名： `bk-ci-工程名`。
以及服务内部域名： `工程名-标签.service.consul` 。标签的定义见 env 文件里的 `BK_CI_CONSUL_DISCOVERY_TAG`，默认为 `devops`。

| 工程 | 描述 　 |
| ----------- | ------------------------------------------------------------ |
| agentless | 无编译环境。同 dockerhost ，资源配额更低。一般用于和蓝鲸及第三方系统联动。 |
| artifactory | 二进制构件仓库管理。对接各类构件服务后端。目前可使用本地存储。 |
| auth | 蓝盾权限服务。对接各种其他的权限管理服务，如蓝鲸 IAM。 |
| dispatch | 构建机调度服务。调度流水线任务。管理私有构建机。 |
| dispatch-docker | 构建机调度服务。调度流水线任务。管理公共构建机。 |
| dockerhost | 公共构建机。与本机 dockerd 通信，管理容器的生命周期。 |
| environment | 管理私有构建机。 |
| gateway | 网关。负责提供对外的入口。前端页面放在 frontend ，会一起安装。 |
| image | Docker 镜像代理。负责对接 Docker registry 拉取镜像。 |
| log | 日志服务。存储流水线执行的输出。 |
| misc | 一些管理工具。目前仅 cron 。 |
| notify | 通知服务。目前对接了蓝鲸通知。 |
| openapi | 管理对外暴露的 api 接口。用途类似 apigw 。请求 → gateway → openapi → 其他微服务 |
| plugin | 蓝盾功能扩展。 |
| process | 流水线服务。包含编排引擎，模板管理，流水线管理等。 |
| project | 项目管理服务。 |
| quality | 质量红线。为流水线提供准入准出管理。 |
| repository | 代码库管理。对接 SVN 、 GitLab 、 GitHub 等。 |
| store | 研发商店，提供插件、模板、扩展、镜像等的分享及管理。 |
| ticket | 凭证管理。集中管理各类密钥证书等。 |
| websocket | 用于实时推送状态到前端页面。 |

## 安装包结构

蓝盾的安装包是 tar.gz 形式。

顶层目录名为 “ bkci ”。其下即以工程命名的对应的目录。
除此之外，我们还有一些仅用于内部依赖使用或者安装 / 维护用途的目录：
| 文件 / 目录 | 描述 |
| -------------- | ------------------------------------------------------------ |
| agent-package/ | 存放 agent 及相关脚本。 environment 、 dispatch 、 dockerhost 、 agentless 依赖此目录。 |
| frontend/ | 前端代码。安装 gateway 时会同时安装此目录。 |
| scripts/ | 安装或使用时会用到的脚本。待提供安装脚本。 |
| support-files/ | 安装时所需的文件。 |
| VERSION | 蓝盾版本描述文件。 |

其结构大概如下所示：
```bash
# tar tf ./bkci-v1.2.*.tar.gz | grep "^[^/]*/([^/]*/){1,2}$" -E | sort
bkci/agent-package/
bkci/agent-package/config/
bkci/agent-package/jar/
bkci/agent-package/jre/
bkci/agent-package/packages/
bkci/agent-package/script/
bkci/agent-package/upgrade/
bkci/agentless/
bkci/artifactory/
bkci/auth/
bkci/dispatch/
bkci/dockerhost/
bkci/environment/
bkci/frontend/
bkci/frontend/artifactory/
bkci/frontend/codelib/
bkci/frontend/common-lib/
bkci/frontend/console/
bkci/frontend/environment/
bkci/frontend/pipeline/
bkci/frontend/quality/
bkci/frontend/store/
bkci/frontend/svg-sprites/
bkci/frontend/ticket/
bkci/gateway/
bkci/gateway/core/
bkci/image/
bkci/log/
bkci/misc/
bkci/monitoring/
bkci/notify/
bkci/openapi/
bkci/plugin/
bkci/process/
bkci/project/
bkci/quality/
bkci/repository/
bkci/scripts/
bkci/sign/
bkci/store/
bkci/support-files/
bkci/support-files/bkiam/
bkci/support-files/file/
bkci/support-files/iam/
bkci/support-files/sql/
bkci/support-files/templates/
bkci/ticket/
bkci/websocket/
```
