# 简介

该教程将帮助你将业务的权限体系接入权限中心，通过该教程，你可以了解：
- 权限中心的基本模型和接入流程
- 使用 `python-sdk` 完成模型注册/鉴权


为了顺利完成教程，你需要：
- 了解权限中心基本模型及概念 [主要名词概念说明](../../1.12/UserGuide/Term/Term.md)
- 已部署一套可进行对接调试的权限中心
- 已经创建一个 SaaS 并获取其`bk_app_code`(应用 ID)和`bk_app_secret`(应用 TOKEN)
- 了解 Python 的基本语法(本教程基于 `python-sdk`)
- 教程中`{IAM_HOST}`指的是权限中心后台接口(注意是后台的地址, 例如`http://bkiam.service.consul:5001`, 不是前端页面的地址`http://{paas_domain}/o/bk_iam`). 本地开发环境可能无法访问到, 需要使用服务器访问, 或者由运维将后台服务地址反向代理给到本地开发访问. 通过企业版社区版 SaaS 部署的话, 可以通过`BK_IAM_V3_INNER_HOST`获取

