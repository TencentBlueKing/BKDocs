# 基础套餐详细部署

> 该文档适用于生产环境多机器分模块部署场景，如仅需体验该套餐功能，可参考 [基础套餐单机部署](../单机部署/install_on_single_host.md)

**每一个步骤执行如果有报错，需要修复错误，保证安装成功后，才可以继续**。因为安装顺序是有依赖关系的，如果前面的平台失败仍继续往下安装，会遇到更多的报错导致整体安装失败。


修复错误所需要了解的相关命令，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

进行标准部署之前，请确保已完成 [环境准备](../../基础包安装/环境准备/get_ready.md) 操作。

## 执行免密

```bash
cd /data/install
bash /data/install/configure_ssh_without_pass
```

## 初始化并检查环境

```bash
# 初始化环境
./bk_install common

# 校验环境和部署的配置
./health_check/check_bk_controller.sh
```

> 详细安装过程介绍，请查看[初始化并检查环境详解](../../基础包安装/安装详解/install_common.md)。

## 部署 PaaS 平台

```bash
# 安装 PaaS 平台及其依赖服务
./bk_install paas
```

> 详细安装过程介绍，请查看[安装 PaaS 平台详解](../../基础包安装/安装详解/install_paas.md)。

## 部署 app_mgr

```bash
# 部署 SaaS 运行环境，正式环境及测试环境
./bk_install app_mgr
```

> 详细安装过程介绍，请查看[安装 PaaS 平台详解](../../基础包安装/安装详解/install_paas.md)。

## 部署权限中心与用户管理

```bash
# 权限中心
./bk_install saas-o bk_iam
# 用户管理
./bk_install saas-o bk_user_manage
```

## 部署 CMDB

```bash
# 安装配置平台及其依赖服务
./bk_install cmdb
```

> 详细安装过程介绍，请查看[安装配置平台详解](../../基础包安装/安装详解/install_cmdb.md)。

## 部署 JOB

```bash
# 安装作业平台后台模块及其依赖组件
./bk_install job
```

> 详细安装过程介绍，请查看[安装管控平台详解](../../基础包安装/安装详解/install_gse.md)和[安装作业平台详解](../../基础包安装/安装详解/install_job.md)。

## 部署 bknodeman

- 如需使用跨云管控，请提前将节点管理的外网 IP 写入至节点管理后台服务所在机器的`/etc/blueking/env/local.env` 文件，详细请参考 [开启 proxy](../../维护手册/日常维护/open_proxy.md)。否则请忽略该步骤

- 开始部署

```bash
# 安装节点管理后台模块、节点管理 SaaS 及其依赖组件
./bk_install bknodeman
```

> 详细安装过程介绍，请查看[安装节点管理详解](../../基础包安装/安装详解/install_nodeman.md)。

## 部署标准运维及流程管理

依次执行下列命令部署相关 SaaS。

```bash
# 标准运维
./bk_install saas-o bk_sops

# 流程管理
./bk_install saas-o bk_itsm
```

## 加载蓝鲸相关维护命令

```bash
source ~/.bashrc
```

## 初始化蓝鲸业务拓扑

```bash
./bkcli initdata topo
```

## 部署 lesscode (可选)

```bash
./bk_install lesscode
```

## 检测相关服务状态

```bash
cd /data/install/
echo bkssm bkiam usermgr paas cmdb gse job consul | xargs -n 1 ./bkcli check
```

## 访问蓝鲸开始使用

可参考蓝鲸 [快速入门](../../../../快速入门/quick-start-v6.0-info.md) 以及相关 [产品白皮书](https://bk.tencent.com/docs/) 。

如需部署监控日志套餐，请参考 [监控日志套餐部署](./value_added.md) 。
