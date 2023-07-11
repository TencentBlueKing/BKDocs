# 基础套餐详细部署

**每一个步骤执行如果有报错，需要修复错误，保证安装成功后，才可以继续**。因为安装顺序是有依赖关系的，如果前面的平台失败仍继续往下安装，会遇到更多的报错导致整体安装失败。

修复错误所需要了解的相关命令，请参考 [维护文档](../../MaintenanceManual/DailyMaintenance/maintain.md)。

进行标准部署之前，请确保已完成 [环境准备](../../BasicInstall/EnvPreparation/get_ready.md) 操作。

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
[初始化环境-常见报错](https://bk.tencent.com/s-mart/community/question/5540?type=answer)

[校验环境和部署的配置-常见报错](https://bk.tencent.com/s-mart/community/question/5668?type=answer)

> 详细安装过程介绍，请查看[初始化并检查环境详解](../../BasicInstall/DetailInstall/install_common.md)。

## 部署 PaaS 平台

```bash
# 安装 PaaS 平台及其依赖服务
./bk_install paas
```

[部署 paas-常见报错](https://bk.tencent.com/s-mart/community/question/5559?type=answer)

> 详细安装过程介绍，请查看[安装 PaaS 平台详解](../../BasicInstall/DetailInstall/install_paas.md)。

## 部署 app_mgr

```bash
# 部署 SaaS 运行环境，正式环境及测试环境
./bk_install app_mgr
```
[部署 app_mgr-常见报错](https://bk.tencent.com/s-mart/community/question/5713?type=answer)

> 详细安装过程介绍，请查看[安装 PaaS 平台详解](../../BasicInstall/DetailInstall/install_paas.md)。

### 部署 API 网关

```bash
./bk_install apigw
```

## 部署权限中心与用户管理

```bash
# 权限中心
./bk_install saas-o bk_iam
# 用户管理
./bk_install saas-o bk_user_manage
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)

### 部署 bkiam_search_engine

1. 获取权限中心的 app_token，并将获取到的 app_token 做为 bkiam_search_engine 的 secret

    ```bash
   echo BK_IAM_SAAS_APP_SECRET=$(mysql --login-path=mysql-default -e "use open_paas; select * from paas_app where code='bk_iam'\G"| awk '/auth_token/{print $2}') >> /data/install/bin/03-userdef/bkiam_search_engine.env
   ```

2. 渲染 bkiam_search_engine 变量

    ```bash
   ./bkcli install bkenv
   ./bkcli sync common
   ```

3. 开始部署

    ```bash
   ./bk_install bkiam_search_engine
   ```

## 部署 paas_plugin

```bash
./bk_install paas_plugin
```

## 部署 CMDB

```bash
# 安装配置平台及其依赖服务
./bk_install cmdb
```

> 详细安装过程介绍，请查看[安装配置平台详解](../../BasicInstall/DetailInstall/install_cmdb.md)。

## 部署 JOB

```bash
# 安装作业平台后台模块及其依赖组件
./bk_install job
```

[部署 job-常见报错](https://bk.tencent.com/s-mart/community/question/5538?type=answer)

> 详细安装过程介绍，请查看[安装管控平台详解](../../BasicInstall/DetailInstall/install_gse.md)和[安装作业平台详解](../../BasicInstall/DetailInstall/install_job.md)。

## 部署 bknodeman

- 如需使用跨云管控，请提前将节点管理的外网 IP 写入至节点管理后台服务所在机器的`/etc/blueking/env/local.env` 文件，详细请参考 [开启 proxy](../../MaintenanceManual/DailyMaintenance/open_proxy.md)。否则请忽略该步骤

- 开始部署

```bash
# 安装节点管理后台模块、节点管理 SaaS 及其依赖组件
./bk_install bknodeman
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)

> 详细安装过程介绍，请查看[安装节点管理详解](../../BasicInstall/DetailInstall/install_nodeman.md)。

## 部署标准运维及流程管理

依次执行下列命令部署相关 SaaS。

```bash
# 标准运维
./bk_install saas-o bk_sops

# 流程管理
./bk_install saas-o bk_itsm
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)

## 加载蓝鲸相关维护命令

```bash
source ~/.bashrc
```

## 初始化蓝鲸业务拓扑

```bash
./bkcli initdata topo
```

[初始化拓扑-常见报错](https://bk.tencent.com/s-mart/community/question/5417?type=answer)

## 检测相关服务状态

```bash
cd /data/install/
echo bkssm bkiam usermgr paas cmdb gse job consul | xargs -n 1 ./bkcli check
```
## 访问蓝鲸开始使用

可参考蓝鲸 [快速入门](../../../../../QuickStart/6.0/quick-start-v6.0-info.md) 以及相关 [产品白皮书](https://bk.tencent.com/docs/) 。

