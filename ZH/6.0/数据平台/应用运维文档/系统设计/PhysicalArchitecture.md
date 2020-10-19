# 系统物理架构

![-w2020](../media/911126d28be9266aff2f5442b3e897e5.png)
<center>服务架构</center>

1.  部署时Kafka、ES、Mysql组件建议独立部署

2.  数据清洗、分发、监控、API默认部署在数据服务模块服务器，亦可以独立部署

3.  NodeManager、Jobserver、Spark 必须打包部署

4.  Executor、FabIO建议打包部署