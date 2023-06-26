# 开发概述


为了满足不同企业或者用户的需求，腾讯蓝鲸智云的提供了详细的开发指南，帮助社区伙伴自主构建更适合企业的研运一体化解决方案。


教程内容基于“授人以渔”的目标，内容覆盖产品设计、开发规范、开发者工具、单产品特定功能扩展开发、开源项目参与等。

## 一、教程总览

|教程主题 |所属产品 |课程目标 |操作 |
| ------ | ------ | ------ |------ |
|产品设计规范 |公共基础 |这是蓝鲸智云统一遵守的产品设计规范，并将规范做成了腾讯蓝鲸智云产品的前端组件，学习后，不仅能掌握优秀的设计理念，更能高效地使用基础组件和业务组件进行产品研发。 |[开始学习](https://bkdesign.bk.tencent.com/design/2) |
|前端开发规范 |公共基础 |所有前端岗位的研发必须遵守的规范，主要内容有编码结构、变量命名、代码注释、文件引用、代码性能、安全、移动端等 |[开始学习](../DevSpecification/FrontendDevSpec/README.md) |
|后台开发规范 |公共基础 |所有后台岗位的研发必须遵守的规范，主要内容有编码规范、安全规范、单元测试、DB 设计与使用规范、基于蓝鲸 “ PaaS - 开发者中心” 的 Python 实践经验 |[开始学习](../DevSpecification/BackendDevStandards/README.md) |
|对接企业登录 |用户管理 | 该教程将指导开发者如何将企业内已有的用户信息和登录方式对接到蓝鲸体系。|[开始学习](../../UserManage/IntegrateGuide/对接企业登录体系) |
|消息组件自定义接入 |APIGateway |通过该教程可以添加软件的消息通知渠道。 |[开始学习](../../APIGateway/DevelopTools/CMSI.md) |
|微信组件自定义接入 |APIGateway |通过该教程可以添加软件的微信通知渠道。 |[开始学习](../../APIGateway/DevelopTools/WeChat.md) |
|API网关自助接入 |APIGateway |通过该教程可以可以将企业内已有系统的 API ，或者第三方系统的API接入到蓝鲸智云的 APIGateway ，实现 API 的统一管理。 |[开始学习](../../APIGateway/DevelopTools/README.md) |
|SaaS开发指南（V7） |PaaS 平台-开发者中心 |学习“PaaS 平台-开发者中心”的功能，使用 Django 等框架，结合已有的前端公共组件，掌握快速开发一个 SaaS 工具的技能，提升企业的办公效率。 |[开始学习](../../PaaS/DevelopTools/DevGuideV3/BaseGuide/SUMMARY.md) |
|移动端开发指南（V7） |PaaS 平台-开发者中心 |“PaaS 平台-开发者中心” 可以进行移动端的系统研发，如 H5 、小程序等，该教程提供移动端的开发指南。 |[开始学习](../../PaaS/DevelopTools/DevGuideV3/MobileGuide/Mobile_development.md) |
|SaaS开发指南（V6） |PaaS 平台-开发者中心 |学习“PaaS 平台-开发者中心”的功能，使用 Django 等框架，结合已有的前端公共组件，掌握快速开发一个 SaaS 工具的技能，提升企业的办公效率。 |[开始学习](../../PaaS/DevelopTools/DevGuideV2/SaaS_Guide/DevBasics/README.md) |
|移动端开发指南（V6） |PaaS 平台-开发者中心 |“PaaS 平台-开发者中心” 可以进行移动端的系统研发，如 H5 、小程序等，该教程提供移动端的开发指南。 |[开始学习](../../PaaS/DevelopTools/DevGuideV2/MobileGuide/Mobile_development.md) |
|标准运维插件开发 |标准运维 |标准运维插件是标准运维任务执行的最小单元，通过将 API 参数前端表单化，参数校验、逻辑封装等功能，以图形化的方式提供给用户使用。学习后，可以将第三方系统功能，封装成标准运维插件，完成更调度编排的任务。 |[开始学习](../../SOPS/DevelopTools/sops.md) |
|监控平台采集器开发 |监控平台 |监控采集器可以满足用户自定义数据上报到蓝鲸监控平台的场景。 |[开始学习](../../Monitor/DevelopTools/monitor.md) |
|蓝盾插件开发 |持续集成平台（蓝盾） |持续集成平台插件是流水线执行任务环节的最小单元，通过学习，可以为研发在 CI 过程中提供任何有价值的工具。 |[开始学习](../../Devops/1.9/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Developer) |
|计算平台插件开发 |计算平台 |该教程帮你将已经存储在计算平台的数据进行“可视化展示”、“自定义分析”等。 |[开始学习](../../BKBase/3.9/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/developer/develope_data_analysis.md) |
|权限中心接入 |权限中心 |该教程将帮助你将企业内已有的系统权限体系接入“蓝鲸智云权限中心”，实现企业内系统权限的统一管理。 |[开始学习](../../IAM/IntegrateGuide/SUMMARY.md) |
|开源共建 |公共基础 |蓝鲸智云的各产品陆续在 GitHub 的 [TencentBlueKing](https://github.com/tencentblueking) 组织下开源，可以搜索对应的项目，学习如何参与蓝鲸智云的开源项目。 |[开始学习](./ENTRY-GithubContributorGuide.md.md) |
|蓝鲸错误码 |公共基础 |学习各产品遵循的错误码规则，查找产品错误码对应的处理方案。 |[开始学习](./ENTRY-ErrorCodeIndex.md) |
|蓝鲸 API |公共基础 |所有 API 遵循 Restful 风格，查找各产品提供的 API 能力。 |[开始学习](./ENTRY-APIIndex.md) |


## 二、重点推荐

1、 SaaS 开发指南

SaaS 开发是“运维开发”的基础技能，是[“腾讯蓝鲸智云-运维开发工程师”](https://bk.tencent.com/training_exam/)认证考试的核心技能。基于 PaaS 平台“开发者中心”的服务，帮助运维同学低成本构建运营系统/工具。

一个 SaaS 的研发由两部分组成，一部分是前端，蓝鲸提供了可拖拽的[前端魔盒 MagicBox](https://magicbox.bk.tencent.com/)，可以生成前端的 UI 组件和代码；另一部分是后台，蓝鲸提供了[“开发框架”](../../PaaS/DevelopTools/DevGuideV2/SaaS_Guide/DevBasics/framework2.md)，集成了公共的后台模块，如登录、API 调用等。

点击这里，下载 “[SaaS 开发工具](./ENTRY-DevTools.md)” ，提供了 SaaS 开发必备的 IDE 、开发框架等。

2、 APIGateway

蓝鲸 API 网关（API Gateway），是一种高性能、高可用的 API 托管服务，可以帮助开发者创建、发布、维护、监控和保护 API， 以快速、低成本、低风险地对外开放蓝鲸应用或其他系统的数据或服务。

开发者通过在线配置的方式，将后端接口的信息直接注册到 API 网关并提供 API 服务。这种在线接入方式，开发者不需要编写代码，仅通过在线配置，即可将自己的接口接入 API 网关，方便快捷。


## 三、教程说明

1、教程“所属产品”的文档中，会提供更加详细的指南，包括下载资料包；
2、研发过程中需要的 IDE 、Git 类仓库等，请前往对应的官网下载，确保工具安全。