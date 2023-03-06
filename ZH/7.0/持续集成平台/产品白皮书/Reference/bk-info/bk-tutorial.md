# **蓝鲸使用学习材料**

腾讯蓝鲸智云，简称蓝鲸，是IEG自研自用的一套用于构建企业研发运营一体化体系的 PaaS 开发框架，提供了 aPaaS（DevOps 流水线、运行环境托管、前后台框架）和 iPaaS（持续集成、CMDB、作业平台、容器管理、计算平台、AI 等原子平台）等模块，帮助企业技术人员快速构建基础运营 PaaS。本文通过精选一系列现有的文档与视频，帮助您更高效的了解蓝鲸的能力以及使用方法。

## **蓝鲸功能介绍与使用**

|服务名称|简介|功能介绍|操作入门|最佳实践|
|:-|:-|:-|:-|:-|
|PaaS平台|开放的平台，又称蓝鲸 PaaS。|[文档](https://bk.tencent.com/docs/document/6.0/148/6675?r=1)|[蓝鲸基础](https://bk.tencent.com/docs/document/6.0/142/8600)|[十分钟掌握PaaS平台使用](https://bk.tencent.com/s-mart/video?id=3-4-6)|
|权限中心|集中权限管理服务，支持基于蓝鲸开发框架的SaaS和企业第三方系统的权限控制接入，以及支持细粒度的权限管理。|[文档](https://bk.tencent.com/docs/document/6.0/131/7337)|同上|[权限中心入门](https://bk.tencent.com/s-mart/video?id=3-4-11)|
|用户管理|企业组织架构、多用户目录等集中的用户管理解决方案，为企业统一登录提供认证源服务|[文档](https://bk.tencent.com/docs/document/6.0/146/7330)|同上|[用户管理入门](https://bk.tencent.com/s-mart/video?id=3-4-10)<br/><br>[企业用户的权限管理实践](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10600778153546804&type=1024&vid=5285890812656571159)|
|标准运维|通过可视化的图形界面进行任务流程编排和执行的系统，是腾讯蓝鲸产品体系中一款轻量级的调度编排类 SaaS 产品。|[文档](https://bk.tencent.com/docs/document/6.0/140/6256)|同上|[标准运维入门](https://bk.tencent.com/s-mart/video?id=3-4-12)<br/><br>[助力企业快速实现跨系统调度](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10600778153546804&type=1024&vid=5285890812656571159)|
|配置平台CMDB|面向应用的 CMDB，为应用提供了各种运维场景的配置数据服务。通过提供配置管理服务，以数据和模型相结合映射应用间的关系，保证数据的准确和一致性；并以整合的思路推进，最终面向应用消费，发挥配置服务的价值。|[文档](https://bk.tencent.com/docs/document/6.0/152/6962)|同上|[配置平台（CMDB）入门](https://bk.tencent.com/s-mart/video?id=3-4-7)<br/><br>[快速上手配置平台业务管理实践](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10476971426272308&type=1024&vid=5285890811384581657)|
|作业平台JOB|基于蓝鲸智云管控平台 Agent 管道之上，提供基础操作的原子平台；具备上万台并发处理能力，除了支持脚本执行、文件拉取 / 分发、定时任务等一系列基础运维场景以外，还支持通过流程调度能力将零碎的单个任务组装成一个自动化作业流程；而每个任务都可做为一个原子节点，提供给上层或周边系统/平台使用，实现跨系统调度自动化。|[文档](https://bk.tencent.com/docs/document/6.0/125/5748)|同上|[作业平台（JOB）入门](https://bk.tencent.com/s-mart/video?id=3-4-9)<br/><br>[JOB作业形态的设计思路与实践](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10503149251941428&type=1024&vid=5285890811648452257)|
|节点管理|帮助企业批量快速安装蓝鲸 Agent 的 SaaS 应用，支持对常见的 Linux、Windows、AIX （仅限企业版）操作系统进行自动化部署，提供了跨云管理的安装部署方案，帮助企业轻松应对多云区域的 IaaS 设备管控。|[文档](https://bk.tencent.com/docs/document/6.0/157/7017)|同上|[节点管理入门](https://bk.tencent.com/s-mart/video?id=3-4-8)<br><br>[跨云主机管理实践](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10488408924181556&type=1024&vid=5285890811485540879)|
|流程服务ITSM|基于蓝鲸智云体系的上层 SaaS 应用。通过可自定义设计的流程模块，覆盖 IT 服务中的不同管理活动或应用场景。|[文档](https://bk.tencent.com/docs/document/6.0/145/6623)|同上|[企业服务的流程化解决方案](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10611073190155316&type=1024&vid=5285890812747520862)|
|监控平台|监控平台产品，除了具有丰富的数据采集能力，大规模的数据处理能力，简单易用，还提供更多的平台扩展能力。依托于蓝鲸 PaaS，有别于传统的 CS 结构，在整个蓝鲸生态中可以形成监控的闭环能力。|[文档](https://bk.tencent.com/docs/document/6.0/134/6143)|[监控、日志&故障自愈](https://bk.tencent.com/docs/document/6.0/142/8599)|[监控平台入门](https://bk.tencent.com/s-mart/video?id=3-4-13)<br/><br>[监控的四步核心玩法](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10532075856679988&type=1024&vid=5285890812038449507)|
|日志平台|解决分布式架构下日志收集、查询困难的一款日志产品，基于业界主流的全文检索引擎，通过蓝鲸智云的专属 Agent 进行日志采集，提供多种场景化的采集、查询功能。|[文档](https://bk.tencent.com/docs/document/6.0/126/7310)|同上|[企业的日志解决方案](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10573689794810932&type=1024&vid=5285890812342691699)|
|故障自愈|“故障自动化处理”解决方案，提升企业的服务可用性和降低故障处理的人力投入，实现故障自愈从“人工处理”到“无人值守”的变革!|[文档](https://bk.tencent.com/docs/document/6.0/133/7369)|同上||
|容器管理平台BCS|高度可扩展、灵活易用的容器管理服务平台，支持社区原生 Kubernetes 编排引擎。|[文档](https://bk.tencent.com/docs/document/6.0/144/6523?r=1)|[容器管理平台](https://bk.tencent.com/docs/document/6.0/142/6568)|[助力企业实现容器化的实践](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10650552529540148&type=1024&vid=5285890812975359660)|

**其他材料：**
官网文档：https://bk.tencent.com/docs/   <br>
[深度进阶使用（视频）](https://bk.tencent.com/s-mart/video?id=3-15)

## **蓝鲸平台的部署与维护**
蓝鲸社区版基础包安装介质分为[软件包](https://bk.tencent.com/docs/document/6.0/127/7552) (src)和[部署脚本](https://bk.tencent.com/docs/document/6.0/127/7555)包 (install)。通过 rsync + ssh ，将软件包里的各模块按需分发到指定机器，通过部署脚本安装软件依赖、自动生成配置文件、初始化数据库、配置账户和权限等，最后启动进程。

社区版目前支持以下两种安装方式选择（在开始安装前，请参照[环境准备](https://bk.tencent.com/docs/document/6.0/127/7543)文档，准备[安装介质](https://bk.tencent.com/docs/document/6.0/127/7550)，配置系统环境。）

单机部署：对于首次接触蓝鲸的用户，寻找一个最快体验和评估蓝鲸的核心功能的方式，请参照[单机部署文档](https://bk.tencent.com/docs/document/6.0/127/7551?r=1)，可以快速体验到蓝鲸基础平台的功能。

标准部署：若需完整的社区版基础包功能，请参照[标准部署文档](https://bk.tencent.com/docs/document/6.0/127/7549?r=1)进行安装。

[部署与维护教学视频](https://ke.qq.com/webcourse/index.html#cid=3101748&term_id=103224098&taid=10658953485571124&type=1024&vid=5285890813070525717)

## **蓝鲸SaaS开发**
SaaS 开发是“运维开发”的基础技能。基于 PaaS 平台“开发者中心”的服务，帮助运维同学低成本构建运营系统/工具。一个 SaaS 的研发由两部分组成，一部分是前端，蓝鲸提供了可拖拽的[前端魔盒MagicBox](https://magicbox.bk.tencent.com/)，可以生成前端的 UI 组件和代码；另一部分是后台，蓝鲸提供了[“开发框架”](https://bk.tencent.com/docs/document/6.0/130/5949?r=1)，集成了公共的后台模块，如登录、API 调用等。

文档：https://bk.tencent.com/docs/document/6.0/130/5871

### **视频学习：**
- [蓝鲸企业级PaaS解决方案](https://ke.qq.com/course/3030664?taid=10315536490446472)
- [Python基础、进阶](https://ke.qq.com/course/3030664?taid=10365405355720328)
- [前端开发（上）](https://ke.qq.com/course/3030664?taid=10406753005878920)、[（下）](https://ke.qq.com/course/3030664?taid=10406757300846216)
- [Django基础（一）](https://ke.qq.com/course/3030664?taid=10441460636597896)、[（二）](https://ke.qq.com/course/3030664?taid=10471383673749128)
- [SaaS开发进阶](https://ke.qq.com/course/3030664?taid=10497338161118856)
- [SaaS移动端开发](https://ke.qq.com/course/3030664?taid=10538294969253512)

## **其他资源**
[社区用户的经验分享](https://bk.tencent.com/s-mart/community/question/5067?type=article)