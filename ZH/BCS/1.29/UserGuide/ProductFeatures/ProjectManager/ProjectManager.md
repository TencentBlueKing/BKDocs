# 项目管理概述

项目是容器管理平台的一级管理入口，所有资源和操作均围绕项目进行组织和管理。

## 创建项目

### 前提条件

在创建新项目之前，请确保完成以下准备工作：
- 登入蓝鲸平台
- 确认当前用户已在权限中心被授予容器管理平台(bk_bcs_app)的**项目创建**权限

### 无项目权限时的创建流程

进入平台且没有任何项目权限时，将展示欢迎页面。点击**创建项目**快捷按钮，即可发起新项目的创建流程。

### 从项目管理页创建项目

若用户已有项目权限，可以通过以下步骤创建新项目：
- 在导航栏的的项目选择器中，展开项目列表并点击**项目管理**进入项目管理页面。
- 点击页面中的**创建项目**按钮，启动项目创建流程。

### 填写项目基本信息

请按以下要求填写项目的基本信息：
- **项目名称**：长度为2至64个字符，支持中文、英文、数字和特殊字符（如空格、下划线）。
- **项目英文名**：长度为2至32个字符，仅允许小写字母、数字和中划线，并且必须以小写字母开头。
- **项目说明**：提供详细描述，以便团队成员了解项目背景及目标。

填写完成后，点击**确认**提交，系统将创建新项目，并为创建人分配**项目查看**和**项目编辑**的自定义权限。

## 启用容器服务

### 前提条件

在启用容器服务前，请确保已完成以下步骤：
- 登入蓝鲸平台
- 确认用户已获得容器管理平台中对应项目的**项目查看**与**项目编辑**权限
- 确认用户欲关联的CMDB业务中拥有“业务运维”角色

### 关联CMDB业务并启用

进入项目后，选择并绑定与项目关联的CMDB业务。这一步骤将为后续在集群管理中创建集群和添加节点时提供必要的服务器资源。

## 加入已存在的项目

在项目管理页面或项目选择器中，默认可以查看所有项目的列表。如果未拥有相应项目权限：
- 点击项目名称时，系统将提示申请该项目的**项目查看**自定义权限。
- 点击**编辑项目**操作时，系统将提示申请该项目的**项目编辑**自定义权限。

审批通过后，用户即可凭**项目查看**权限进入项目。