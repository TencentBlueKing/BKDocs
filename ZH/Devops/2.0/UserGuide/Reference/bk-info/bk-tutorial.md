# **蓝鲸使用学习材料**

腾讯蓝鲸智云，简称蓝鲸，是IEG自研自用的一套用于构建企业研发运营一体化体系的 PaaS 开发框架，提供了 aPaaS（DevOps 流水线、运行环境托管、前后台框架）和 iPaaS（持续集成、CMDB、作业平台、容器管理、计算平台、AI 等原子平台）等模块，帮助企业技术人员快速构建基础运营 PaaS。本文通过精选一系列现有的文档与视频，帮助您更高效的了解蓝鲸的能力以及使用方法。

## **蓝鲸各产品功能介绍**


|产品|功能简述|
|---|------------------------------------------------------------|
|[用户管理](../../UserManage/2.5/UserGuide/Introduce/README.md)|蓝鲸提供的企业组织架构、多用户目录等集中的用户管理解决方案|
|[权限中心](../../IAM/1.12/UserGuide/Introduce/README.md)|蓝鲸体系集中权限管理服务，细化到资源实例级别的访问权限控制|
|[配置平台](../../CMDB/3.10/UserGuide/Introduce/Overview.md)|提供主机、进程、模型等各种运维场景的配置数据服务管理，是蓝鲸体系的基石|
|[节点管理](../../NodeMan/2.2/UserGuide/Introduce/Overview.md)|批量快速地部署蓝鲸 Agent，覆盖 Linux、Windows 操作系统|
|[作业平台](../../JOB/3.7/UserGuide/Introduction/What-is-Job.md)|提供批量脚本执行、文件分发、文件拉取、定时任务等基础操作的原子平台|
|[标准运维](../../SOPS/3.28/UserGuide/Overview/README.md)|可视化的图形界面流程编排、跨系统调度利器|
|[监控平台](../../Monitor/3.8/UserGuide/Overview/README.md)|提供丰富的数据采集能力、大规模的数据处理能力，致力于满足不同场景的监控需求|
|[日志平台](../../LogSearch/4.6/UserGuide/Intro/README.md)|基于业界主流的全文检索引擎，提供多种场景化的采集、查询功能|
|[流程服务](../../ITSM/2.6/UserGuide/Introduce/README.md)|灵活自定义设计流程模块，覆盖 IT 服务中的不同管理流程或应用场景|
|[管控平台](../../GSE/2.0/UserGuide/Introduce.md)|蓝鲸体系的底层管控系统，是蓝鲸所有其他服务的基础（GseAgent）|
|[K-CI（蓝盾）](../../Devops/2.0/UserGuide/intro/README.md)|免费并开源的 CI 服务，助力自动化构建-测试-发布工作流，持续、快速、高质量地交付产品|
|[BCS（容器管理平台）](../../BCS/1.28/UserGuide/Introduction/README.md)|可扩展、灵活易用的容器管理服务平台，支持社区原生 Kubernetes 编排引擎|

**其他材料：**
官网文档：https://bk.tencent.com/docs/   <br>
[深度进阶使用（视频）](https://bk.tencent.com/s-mart/video?id=3-15)

## **蓝鲸平台的部署与维护**
蓝鲸社区版基础包安装介质分为[软件包](../../../../../DeploymentGuides/6.1/产品白皮书/基础包安装/软件包简介/src_overview.md) (src)和[部署脚本](../../../../..//DeploymentGuides/6.1/产品白皮书/部署脚本/intro.md)包 (install)。通过 rsync + ssh ，将软件包里的各模块按需分发到指定机器，通过部署脚本安装软件依赖、自动生成配置文件、初始化数据库、配置账户和权限等，最后启动进程。

社区版目前支持以下两种安装方式选择（在开始安装前，请参照[环境准备](../../../../../DeploymentGuides/6.1/产品白皮书/基础包安装/环境准备/get_ready.md)文档，准备[安装介质](../../../../../DeploymentGuides/6.1/产品白皮书/基础包安装/机器评估/evaluate.md)，配置系统环境。）

单机部署：对于首次接触蓝鲸的用户，寻找一个最快体验和评估蓝鲸的核心功能的方式，请参照[单机部署文档](../../../../../DeploymentGuides/6.1/产品白皮书/基础包安装/单机部署/install_on_single_host.md)，可以快速体验到蓝鲸基础平台的功能。

标准部署：若需完整的社区版基础包功能，请参照[标准部署文档](../../../../../DeploymentGuides/6.1/产品白皮书/基础包安装/多机部署/quick_install.md)进行安装。

[部署与维护教学视频](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10658953485571124&type=1024&vid=5285890813070525717)

## **蓝鲸SaaS开发**
SaaS 开发是“运维开发”的基础技能。基于 PaaS 平台“开发者中心”的服务，帮助运维同学低成本构建运营系统/工具。一个 SaaS 的研发由两部分组成，一部分是前端，蓝鲸提供了可拖拽的[前端魔盒MagicBox](https://magicbox.bk.tencent.com/)，可以生成前端的 UI 组件和代码；另一部分是后台，蓝鲸提供了[“开发框架”](../../../../../PaaS/DevelopTools/SaaSGuide/term.md)，集成了公共的后台模块，如登录、API 调用等。


### **视频学习：**
- [蓝鲸企业级PaaS解决方案](https://ke.qq.com/course/3030664?taid=10315536490446472)
- [Python基础、进阶](https://ke.qq.com/course/3030664?taid=10365405355720328)
- [前端开发（上）](https://ke.qq.com/course/3030664?taid=10406753005878920)、[（下）](https://ke.qq.com/course/3030664?taid=10406757300846216)
- [Django基础（一）](https://ke.qq.com/course/3030664?taid=10441460636597896)、[（二）](https://ke.qq.com/course/3030664?taid=10471383673749128)
- [SaaS开发进阶](https://ke.qq.com/course/3030664?taid=10497338161118856)
- [SaaS移动端开发](https://ke.qq.com/course/3030664?taid=10538294969253512)

## **其他资源**
[社区用户的经验分享](https://bk.tencent.com/s-mart/community/question/5067?type=article)