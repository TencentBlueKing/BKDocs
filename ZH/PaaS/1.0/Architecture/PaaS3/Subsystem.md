# 子系统结构和功能

1. Webfe

PaaS3.0 开发者中心前端模块，是一个基于 Vue.js 构建的单页面应用。

![-w2020](media/webfe.png)

2. ApiServer

API Server 提供 REST API，是 PaaS3.0 开发者中心的主要后端服务。包括了以下子模块：

- SourceCtl: 应用源码管理
- Service: 增强服务模块，为应用提供 Mysql、对象存储等服务
- Market: 应用市场服务，可以将应用发布到桌面
- Logging: 应用日志模块

![-w2020](media/apiserver.png)

3. Service Providers

基于 REST API 的增服务 Provider，用于远程注册增服务，申请、绑定、销毁增强服务实例。

![-w2020](media/service.png)