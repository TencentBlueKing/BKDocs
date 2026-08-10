# 产品公告

>**蓝鲸智云 PaaS 平台产品的发展路线图**

|类别 |当前状态 |开源状态 |开源地址 |所属蓝鲸智云主版本 |发布时间 |
|:--|:--|:--|:--|:--|:--|
|PaaS3.0 |主线版本，更新维护中 |已开源 |https://github.com/tencentblueking/blueking-paas |V7 |2022 年 |
|PaaS2.0 |停止更新，仅维护功能 |已开源 |https://github.com/tencent/bk-paas |V6 |2019 年 |
|PaaS1.0 |停止维护 |未开源 |无 |无 |2012 年 |

<br>

|模块列表 |PaaS2.0（停止更新，仅限维护） |PaaS3.0（活跃开源项目） |
|:--|:--|:--|
|esb: 蓝鲸 API 网关 |集成在主仓库（paas-ce/paas/esb) |独立成一个产品，APIGateway |
|login: 蓝鲸统一登录服务 |集成在主仓库（paas-ce/paas/login) |独立成一个产品，[统一登录用户管理](https://github.com/TencentBlueKing/bk-user) |
|paas: 蓝鲸开发者中心 |集成在主仓库（paas-ce/paas) |独立成一个产品，[PaaS-开发者中心](https://github.com/TencentBlueKing/blueking-paas) |
|paas: web 工作台 |集成在主仓库（paas-ce/paas) |独立成一个产品，将“工作台”优化为[桌面](https://github.com/TencentBlueKing/blueking-console) |
|LessCode: 蓝鲸运维开发平台 |集成在主仓库 lesscode-master 分支 |独立成一个产品，[可运维开发平台](https://github.com/TencentBlueKing/bk-lesscode) |

<br>

>**PaaS 平台各版本的功能差异有哪些？**

|功能 |PaaS2.0 |PaaS3.0 |
|:--|:--|:--|
|平台、应用集群最小规模 |平台（1 台服务器）/应用（1 台服务器）<br>可混用<br>无高可用 |平台（1 台服务器）/应用（1 台服务器）<br>可混用 |
|底层技术 |原生 docker |kubernetes |
|应用集群扩展性 |手动 |自动调用集群节点扩展 |
|应用扩展性 |手动，繁琐 |调整副本数自动扩展 |
|应用类型 |主要 web 类应用 |支持不同编程语言、复杂应用架构 |
|支持编程语言 |Python（PHP、Java 不成熟） |Python、Go、Node.JS |
|支持镜像部署 | |有 （可以支持任意编程语言） |
|支持应用源码仓库 |svn，Git |svn、Git（支持 Oauth 授权） |
|支持自定义进程启动命令 | |有 |
|支持应用多模块管理及部署 | |有 |
|在线查看进程实时日志 | |有 |
|在线停止进程 | |有 |
|支持进程间通信设置 | |有 |
|在线调整进程实例数 | |有 |
|部署限制（仅管理员可部署） | |有 |
|实时查看应用 CPU/内存 资源信息 | |有(二期，基于 BCS) |
|支持 Webconsole | |有 |
|支持访问方式 |仅子路径，特殊方式配置独立域名 |子路径 + 独立子域名 |
|支持独立域名 | |有 |
|MySQL 增强服务 |有, 只对 S-Mart 应用提供 |有 |
|Redis 增强服务 | |有 |
|RabbitMQ 增强服务 | |有 |
|bkrepo 增强服务 | |有 |