蓝鲸 PaaS 平台包含几个个子项目，具体如下：

* `bkpaas3` 平台核心模块，仅在**平台集群**部署
* `bkpaas-app-operator` 云原生应用的基础设施，在**每一个应用集群**部署
* `bkapp-log-collection` 应用日志采集，在**每一个应用集群**部署
* `bk-ingress-nginx` 应用访问入口 Ingress-Nginx， 在**每一个应用集群**部署

![-w2020](media/arch.png)