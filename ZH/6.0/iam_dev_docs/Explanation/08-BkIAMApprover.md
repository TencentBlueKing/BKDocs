# 资源审批人`_bk_iam_approver_`说明

> 本文重点阐述`_bk_iam_approver_`的概念及开发者如何使用

## 背景

如果系统需要使用资源实例的细粒度审批人, 就需要在资源反向拉取接口中返回实例的`资源审批人`

## `_bk_iam_approver_`是什么

`_bk_iam_approver_`是权限中心对`资源审批人`的一种表达形式, 每个资源实例的审批人可以是多个

## 格式及内容

- key: `_bk_iam_approver_`
- value: `["admin", ...]`

## 示例

标准运维的任务查看为例
- 操作: `任务查看`(`action=task_view`)
- 关联资源类型 resource_type 为 `任务`(`system_id=bk_sops; id=task`)
- 在申请权限的时候, 如果指定申请`任务`为`task1`, 这时候如果配置的申请流程是实例审批人, 权限中心会回调接入系统资源反向拉取获取`_bk_iam_approver_`

## 资源反向拉取

* [资源反向拉取: 4. fetch_instance_info](../Reference/API/03-Callback/13-fetch_instance_info.md)

资源反向拉取获取一批实例属性的时候, 可能会要求接入系统返回实例的`_bk_iam_approver_`属性, 按照规范返回即可
