# 业务接入 Helm

本文先简单介绍什么是 Helm，然后以蓝鲸小游戏为例，介绍如何使用蓝鲸容器服务部署 Helm Release。

## 什么是 Helm
Helm 是 Kubernetes 的一个包管理工具，用来简化应用的部署和管理。可以把 Helm 比作 CentOS 的 yum 工具。

使用 Helm 可以完成以下事情：

- 管理 Kubernetes manifest files
- 管理 Helm 安装包 Charts
- 基于 Chart 的 Kubernetes 应用分发

更多可以参考 [Helm 官方文档](https://helm.sh/docs/intro/) 。

> 蓝鲸容器服务支持 Helm3 和 Helm2，其中 Helm2 使用了 `helm template` 生成 Kubernetes YAML, 但是部署没有使用 Helm Tiller，而是直接使用的 `kubectl apply`。

## Helm Chart 仓库

平台会给项目分配 Helm Chart 仓库，用于存放项目的 Chart，仓库的读写操作均需要密码；另外，所有项目只读共享一个公共仓库，用于共享公共资源，比如社区中常用开源组件的部署方案，所有项目对公共仓库享有只读权限。

![-w1628](../../assets/15680228351971.jpg)

如果用户的 Chart 需要推送到公共仓库，可以在 Harbor 页面的 `public` 项目下的 `Helm Charts` 上传。

![-w2020](../../assets/img02.png)

## 推送业务 Helm Chart 到仓库
点击 【如何推送 Helm Chart 到项目仓库】 指引，平台会为每个项目生成对应的 Chart 推送命令，可直接复制使用。

![-w1625](../../assets/15680226631931.jpg)

建议参照指引完成 Helm Chart 的推送。

![-w1632](../../assets/15680227175027.jpg)
