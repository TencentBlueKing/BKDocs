# Dashboard 查询使用技巧

容器的基础性能数据、容器的日志（标准输出日志采集、非标准输出日志采集）、容器内运行的应用程序的自定义 Metric 在采集，清洗完成，且在数据平台生成相应结果表后，即可在 Dashboard 中查询。

> 入口地址： 【监控中心】 -> 【Dashboard】

Dashboard 含默认 和 自定义 2 种。

![-w2021](./_image/2020-11-17-10-48-07.jpg)


注意： `请勿修改默认 Dashboard，默认视图下次升级会覆盖用户修改的配置`

点击 `New Dashboard` 可以添加自定义数据仪表盘，点击 `Import Dashboard` 可以导入自定义数据仪表盘。

## 视图

默认 Dashboard 包含：

- `BCS Cluster`, 集群视图

- `BCS Node`, 集群节点视图

- `BCS Pods`, 容器 Pod 视图

### BCS Cluster

呈现集群的 CPU、内存资源的容量以及使用率。

![-w2021](./_image/2020-11-17-10-48-35.jpg)

### BCS Node

呈现节点的平均负载以及 CPU、内存使用率。

![-w2021](./_image/2020-11-17-10-49-01.jpg)

![-w2021](./_image/2020-11-17-10-49-32.jpg)

### BCS Pods

呈现 Pod 的 CPU、内存、网络资源的使用情况。

![-w2021](./_image/2020-11-17-10-50-04.jpg)

