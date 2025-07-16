# 部署方案

蓝鲸社区版，是蓝鲸智云提供面向社区用户基于 PaaS 的运维技术解决方案套件。

它永久免费，支持公有云环境、私有环境的独立搭建部署。

本文档主要介绍蓝鲸社区版的初次安装部署、日常维护、更新升级、故障排查等运维相关的内容。

关于蓝鲸各大平台、SaaS 应用的相关使用说明，请参考 [蓝鲸社区版产品白皮书](https://bk.tencent.com/docs/)。

## 安装方案

蓝鲸社区版BasicInstall介质分为软件包 (src)和部署脚本包 (install)。

安装原理：通过 `rsync + ssh` ，将软件包里的各模块按需分发到指定机器，通过部署脚本安装软件依赖、自动生成配置文件、初始化数据库、配置账户和权限等，最后启动进程。

- [软件包简介](../BasicInstall/IntroductioToSoftware/src_overview.md)

- [DeployScript简介](../DeployScript/intro.md)

## 安装环境准备

在开始安装前，请参照 [环境准备文档](../BasicInstall/EnvPreparation/get_ready.md)，准备安装介质，配置系统环境。

## 安装方式

社区版目前支持两种安装方式选择：

- **单机部署**：对于首次接触蓝鲸的用户，寻找一个最快体验和评估蓝鲸的核心功能的方式，请参照 [单机部署文档](../BasicInstall/单机部署/install_on_single_host.md)，可以快速体验到蓝鲸基础平台的功能。

- **标准部署**：若需完整的社区版基础包功能，请参照 [标准部署文档](../BasicInstall/MultiDeploy/quick_install.md) 进行安装。

## 推荐安装流程

推荐安装完基础包后，再部署安装增强包。
