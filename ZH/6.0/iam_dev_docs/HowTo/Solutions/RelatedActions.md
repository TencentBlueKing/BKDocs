# 依赖操作权限方案

## 背景

用户在申请操作 A 权限时，操作 A 依赖于操作 B，IAM 在创建申请单时会同时帮用户申请操作 B 的权限

比如: 用户申请 编辑主机 权限的前提是用户需要有 查看主机 权限，那么 查看主机 就是 编辑主机 的依赖权限，用户在申请 编辑主机 时，IAM 会同时帮用户申请 查看主机 的权限

## 接入系统注册操作的依赖操作

详细见[注册操作 API](../../Reference/API/02-Model/13-Action.md)的`related_actions`字段

## 依赖操作产生权限的规则

- 申请操作: 用户在权限中心申请后勾选操作
- 依赖操作: 接入系统注册操作时填写的`related_actions`

限制:

- 用户申请操作权限中包含属性(实例+属性或单属性)的条件时不会产生依赖操作权限
- 产生依赖操作的同时，不会产生依赖操作的依赖操作权限，即只会有一层依赖操作产生，不会递归创建依赖操作权限
- 依赖操作不能关联多个资源类型

规则:

### 1. 申请操作与依赖操作关联资源类型相同

例 1:

- 申请操作: edit_host 关联的资源类型 host
- 依赖操作: view_host 关联的资源类型 host
    - view_host 的 host 有 biz-set-module-host 实例视图

- 用户申请了 edit_host 的拓扑权限 /biz,1/set,2，该拓扑满足 view_host 的实例视图的前缀匹配，会产生/biz,1/set,2 的 view_host 权限
- 用户申请了 edit_host 的实例权限 /biz,2/host,1，由于 view_host 没有 biz-host 前缀的实例视图，不会产生 view_host 的依赖权限
- 用户申请了 edit_host 的任意权限，产生 view_host 的任意权限

### 2. 依赖操作不关联资源类型

例 1:

- 申请操作: edit_job 关联的资源类型 job
- 依赖操作: create_job 不关联资源类型

用户申请了 edit_job 的权限，无论是什么权限，都会产生 create_job 权限

### 3. 申请操作与依赖操作关联的资源类型不同

例 1:

- 申请操作: edit_host 关联的资源类型 host
- 依赖操作: view_biz 关联资源类型 biz
    - view_biz 的 biz 有 biz 实例视图

- 用户申请了 edit_host 的拓扑权限 /biz,1/set,2，该拓扑满足 view_biz 的实例视图的前缀匹配，会产生/biz,1 的 view_biz 权限
- 用户申请了 edit_host 的拓扑权限 /set,1/host,2，该拓扑不满足满足 view_biz 的实例视图的前缀匹配，不会产生 view_biz 权限
- 用户申请了 edit_host 的任意权限，不会产生 view_biz 的权限

### 4. 申请操作不关联资源类型

例 1:

- 申请操作: create_host 未关联资源类型
- 依赖操作: view_biz 关联资源类型 biz
    - view_biz 的 biz 有 biz 实例视图

- 用户申请了 create_host 的权限，不会创建 view_biz 权限

例 2:

- 申请操作: create_host 未关联资源类型
- 依赖操作: create_biz 未关联资源类型

- 用户申请了 create_host 的权限，产生 view_biz 权限

### 5. 申请操作关联多个资源类型

例 1:

- 申请操作: execute_job 关联资源类型 job host
- 依赖操作: view_job 关联资源类型 job
    - view_job 的 job 有 biz-job 的实例视图

- 用户申请 execute_job 的权限其中 job 的拓扑满足 view_job 的 job 的实例视图前缀，产生对应的 view_job 权限
- 用户申请 execute_job 的权限其中 job 是任意，产生 view_job 的任意权限

例 2:

- 申请操作: execute_job 关联资源类型 job host
- 依赖操作: view_biz 关联资源类型 biz
    - view_biz 的 biz 有 biz 的实例视图

- 用户申请 execute_job 的权限其中 job 与 host 的拓扑同时满足 view_biz 的 biz 的实例视图前缀，产生对应的 view_biz 权限
- 用户申请 execute_job 的权限是任意，不产生 view_biz 权限