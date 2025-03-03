# 集群管理概述

集群管理场景为用户提供了一个统一的入口，用于创建或导入公有云的Kubernetes (K8S) 集群，并支持通过Kubeconfig导入任意K8S集群。不仅支持K8S原生集群的创建，还为集群的节点管理和弹性伸缩配置提供了灵活的操作能力。通过集群管理，用户可以确保资源的高效使用，并为应用部署和运行提供稳定的资源支持。

## 主要功能

- 创建与导入集群：
    - 支持原生K8S集群的创建。
    - 支持导入公有云K8S集群，如腾讯云和谷歌云。
    - 支持通过Kubeconfig文件导入其他任意K8S集群。
- 集群节点管理：
    - 添加、删除、修改集群节点。
    - 查看节点的运行状态及资源利用率。
    - 管理节点以满足集群需求。
- 集群弹性伸缩：
    - 根据业务负载变化，自动调整集群节点的数量。
    - 设置弹性伸缩策略，确保在高峰期资源供给充足，低负载时节省资源。
- 资源配置：
    - 为应用部署提供必要的计算资源。
    - 管理和分配集群内的计算、存储和网络资源，确保应用稳定运行。
- 集群监控：
    - 提供对集群运行状态的实时监控。
    - 通过图形化界面展示集群的健康状况、节点性能等关键指标。