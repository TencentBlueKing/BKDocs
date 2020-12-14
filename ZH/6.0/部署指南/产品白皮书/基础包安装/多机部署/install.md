# 标准部署

> **部署说明：** 请严格 按顺序执行 以下操作完成蓝鲸智云社区版基础包的安装，以下步骤若有报错/失败，需要根据提示修复错误后，在重新执行相同的命令(支持断点续装)。

**每一个步骤执行如果有报错，需要修复错误，保证安装成功后，才可以继续**。因为安装顺序是有依赖关系的，如果前面的平台失败扔继续往下安装，会遇到更多的报错导致整体安装失败。


修复错误所需要了解的相关命令，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

进行标准部署之前，请确保已完成 [环境准备](../../基础包安装/环境准备/get_ready.md) 操作。

```bash
# 初始化环境
./bk_install common

# 校验环境和部署的配置
./health_check/check_bk_controller.sh
```

### 部署 PaaS 

```bash
# 安装 PaaS 平台及其依赖服务，该步骤完成后，可以打开 PaaS 平台
./bk_install paas
```

### 部署 app_mgr

```bash
# 部署 SaaS 运行环境，正式环境及测试环境
./bk_install app_mgr
```

### 部署 CMDB

```bash
# 安装配置平台及其依赖服务
./bk_install cmdb
```

### 部署 JOB

```bash
# 安装作业平台后台模块及其依赖组件
./bk_install job
```

### 部署 bknodeman

```bash
# 安装节点管理后台模块、节点管理 SaaS 及其依赖组件 
./bk_install bknodeman
```

### 部署 bkmonitorv3

```bash
# 安装监控平台后台模块、监控平台 SaaS 及其依赖组件 
./bk_install bkmonitorv3
```

### 部署 bklog

```bash
# 安装日志平台后台模块、日志平台 SaaS 及其依赖组件 
./bk_install bklog
```

### 部署 fta

```bash
# 安装故障自愈后台模块及其依赖组件
./bk_install fta
```

### 部署 SaaS

依次执行下列命令部署相关 SaaS。
```bash
# 权限中心
./bk_install saas-o bk_iam

# 用户管理
./bk_install saas-o bk_user_manage

# 标准运维
./bk_install saas-o bk_sops

# 服务流程管理
./bk_install saas-o bk_itsm

# 故障自愈
./bk_install saas-o bk_fta_solutions
```

### 初始化蓝鲸业务拓扑

```bash
# 该步骤需要在完成所有部署后执行
./bkcli initdata topo
```

完成以上步骤后，可以开始使用蓝鲸智云社区版了。