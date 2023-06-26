# 安装包

- 文件

bk_itsm_Vx.x.x-ee.tar.gz

- 文件目录结构和功能说明

代码主要可以分为蓝鲸开发框架层 framework、流程引擎服务层 pipeline、ITSM 业务层 itsm 以及前端展示层 web。

- framework

蓝鲸基于 Django 框架的二次封装架构，主要提供 SaaS 运营在蓝鲸 PaaS 上的基础配置和服务。

config：工程各部署环境配置，如本地环境、测试环境、正式环境，以及路由配置。

blueapps：新版开发框架核心模块，包括蓝鲸统一登录、鉴权、中间件和公共函数。

- pipeline

自研的流程引擎框架，主要包含任务流程编排页面和任务流程执行服务。

conf：默认配置

core：参考 BPMN2.0 规范，定义了 Activity、网关、事件和 Data 等核心元素

models：存储结构定义和相关的方法

engine：runtime 执行逻辑和任务状态管理

log：日志持久化存储和管理

parser：前端数据结构解析

validators：数据校验，如环状结构检测和数据合法性校验

component_framework：插件框架和插件定义

variables：全局变量定义

contrib：扩展功能，如数据统计和前端 API

pipeline_web：前端数据适配层，支持前端画布生成的流程数据

pipeline_plugins：标准运维官方插件库和全局自定义变量

- itsm

基于 drf 框架封装的业务适配层，包含流程管理、单据管理、角色管理、服务管理、系统配置等功能。

component：基础模块

service：服务管理

role：角色管理

workflow：流程管理

ticket：单据管理

wiki：知识库

api： 对外开放 API

weixin：微信应用

- web

前端资源，包括 webpack 配置和静态资源。

frontend：pc 端 pc 和移动端 mobile

static：静态资源根目录

templates：页面模板根目录

- locale

国际化翻译文件

- docs

接口文档和其他帮助文档

- initial

系统初始化数据
