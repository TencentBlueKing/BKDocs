# BCS 容器网络方案集成

面对复杂业务应用需求，BCS 针对业务的 **网络支持是按照插件化** 方式进行设计，方便业务在不同环境下能对接不同的网络实现，完成具体的定制。

在网络标准选择上，BCS 建议采用 CNI 网络，以方便容器网络能获得最佳的扩展能力。如果启用 BCS 相关的 [SaaS 服务](https://github.com/Tencent/bk-bcs-saas)，集群的相关安装与配置可以通过 SaaS 来完成，如果只是启用 BCS 后台服务，相关配置请参照以下指引。

* [BCS Kubernetes 网络实践](../StorageSolution/kubernetes.md)
