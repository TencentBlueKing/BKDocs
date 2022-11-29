# 安装指南

蓝鲸 PaaS3.0 开发者中心共包含 5 个子项目，每个子项目对应一份 Helm Chart。按重要程度不同，这些 Chart 被分为两类： `Core（核心模块）` 、 `Addon（附属功能模块）` ，具体如下：

1. `cores/paas-stack` 平台核心模块，仅在**平台集群**部署 ✅
2. `addons/bk-services` 平台增强服务，仅在**平台集群**部署 ✅
3. `addons/platform-log-collection` 平台日志采集，仅在**平台集群**部署 ✅
4. `addons/bkapp-log-collection` 应用日志采集，在**每一个应用集群**部署 ✅
5. `addons/bk-ingress-nginx` 应用访问入口 Ingress-Nginx， 在**每一个应用集群**部署 ✅

各 Chart 均需准备对应的配置文件 `values.yaml`，方能正常部署。

## 准备服务依赖

要部署整套蓝鲸 PaaS3.0 开发者中心服务，首先需要准备至少 1 个 Kubernetes 集群（版本 1.12 或更高），并安装 Helm 命令行工具（3.0 或更高版本）。

> 注：如使用 BCS 容器服务部署，可用 BCS 的图形化 Helm 功能替代 Helm 命令行。

各集群用途如下：

* 用于部署【平台服务】的 Kubernetes 集群，需安装好 [Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) 组件。
* 用于部署【蓝鲸应用】的 Kubernetes 集群（可共用平台服务集群）。

> 注：为了保障日志采集正常工作，推荐使用蓝鲸容器服务（简称 BCS）初始化集群。
> 缺少 Ingress controller 会导致平台服务无法访问，可通过 BCS 或者手动进行安装，推荐使用 nginx-ingress-controller 0.12.0 版本。

### 配置 Helm 仓库地址

通过 Helm 安装各子项目前，你必须先添加一个有效的 Helm repo 仓库:

```bash
# 请将 `<HELM_REPO_URL>` 替换为 Chart 所在的 Helm 仓库地址
$ helm repo add bk-paas3 `<HELM_REPO_URL>`
$ helm repo update
```

### 其他服务

蓝鲸 PaaS 平台依赖着一些蓝鲸体系内的其他服务，开始部署前，请确认以下服务已准备就绪：

* 蓝鲸 APIGateway 服务

## 开始部署各子模块

请参考以下说明文档，依次部署各子模块：

1. [安装 addons/bk-services](docs/deploy_guide_bk_services.md)
2. [安装 cores/paas-stack](docs/deploy_guide_cores.md)
3. [安装 addons/platform-log-collection](docs/deploy_guide_platform_log_collection.md)
4. [安装 addons/bkapp-log-collection](docs/deploy_guide_bkapp_log_collection.md)
5. [安装 addons/bk-ingress-nginx](docs/deploy_guide_bk_ingress_nginx.md)

注意：`addons/bk-services`模块和`cores/paas-stack`模块间通过 service name 来访问，所以这两个模块必须部署在同一个命名空间内。

成功安装完所有子模块后，你便能完整体验蓝鲸 PaaS3.0 开发者中心的所有功能了。

## 卸载

``` bash
helm uninstall bk-paas3
helm uninstall bk-services
helm uninstall plat-log-collection
helm uninstall bk-ingress-nginx
helm uninstall bkapp-log-collection
```

## 常见问题

若在部署过程中遇到任何问题，请优先查阅 [部署 FAQ](docs/deploy_faq.md)
