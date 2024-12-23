# 事件查询

容器管理平台会对项目下所管理的集群事件进行采集并持久化存储，方便用户后续的查询与分析。用户可以通过多种方式筛选和查询事件日志，便于快速定位特定的集群事件。

### 前提条件

在进行事件查询之前，请确保已完成以下准备工作：
- 登录蓝鲸平台
- 确认当前用户在权限中心已被授予容器管理平台（bk_bcs_app）中相应项目的**项目查看**权限

## 查询条件

用户可以根据以下条件进行筛选，查找事件信息：

- **集群**：选择特定集群进行事件查询。
- **命名空间**：选择或跨命名空间查询事件。
- **日期**：通过日期选择器，筛选特定时间范围内的事件。
- **搜索框**：支持以下条件的搜索：
  - **组件**：根据组件名称筛选事件。
  - **资源类型**：选择事件涉及的资源类型。
  - **事件级别**：按事件的严重程度筛选，如Normal、Warning等。
  - **资源名称**：输入特定资源名称关键字进行筛选。

## 查询结果

查询结果以分页列表形式展示，并包含以下关键信息：

- **时间**：事件发生的时间。
- **组件**：触发事件的组件名称。
- **资源名称**：关联事件的具体资源。
- **事件级别**：事件的严重程度。
- **事件内容**：事件的详细描述。