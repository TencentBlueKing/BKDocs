# 基础套餐

> 阅读前请确认好您的部署目的
>
> 该文档适用于生产环境多机器分模块部署场景

基础套餐包含：PaaS 平台、配置平台、作业平台、权限中心、用户管理、节点管理、标准运维、流程服务、管控平台

## 一、安装环境准备

在开始安装前，请参照 [环境准备文档](../EnvPreparation/get_ready.md)，准备安装介质，配置系统环境。

### 1.1 准备机器

1. 建议操作系统： CentOS 7.6
2. 建议机器配置
   - 生产环境：建议 8 核 32 G，硬盘 100G 以上（可根据实际情况适当调整配置）
      - 机器数量：3 台（假设 ip 分别为：10.0.0.1，10.0.0.2，10.0.0.3）
3. 选择一台为中控机（假设为 10.0.0.1）进行安装部署操作，使用 root 账号登录。

### 1.2 获取证书

- 通过 `ifconfig` 或者 `ip addr` 命令分别获取 3 台机器第一个内网网卡 MAC 地址
- 前往蓝鲸官网证书生成页面（[https://bk.tencent.com/download_ssl/](https://bk.tencent.com/download_ssl/)），根据提示在输入框中填入英文分号分隔的三个 MAC 地址，生成并下载证书
- 上传证书包至中控机 `/data`
  - 证书包包名：ssl_certificates.tar.gz

### 1.3 下载安装包

- 下载链接：请前往官网下载 [bkce-src-6.2.1.tgz](https://bk.tencent.com/s-mart/downloads?type=versionList&version=binary) 软件包

### 1.4 解压相关资源包

1. 解压套餐包（包含蓝鲸相关产品，如 PaaS、CMDB、JOB 等；蓝鲸依赖的 rpm 包，SaaS 镜像，定制 Python 解释器；部署脚本）

   ```bash
   cd /data
   tar xf bkce-src-6.2.1.tgz
   ```

2. 解压各个产品软件包

   ```bash
   cd /data/src/; for f in *gz;do tar xf $f; done
   ```

3. 解压证书包

    ```bash
   install -d -m 755 /data/src/cert
   tar xf /data/ssl_certificates.tar.gz -C /data/src/cert/
   chmod 644 /data/src/cert/*
   ```

4. 拷贝 rpm 包文件夹到/opt/目录

    ```bash
    cp -a /data/src/yum /opt
    ```

### 1.5 配置 install.config

**说明：**

- 当含多个内网 IP 时，默认使用  /sbin/ifconfig 输出中的第一个内网 IP。
- 部署需要使用标准私有地址，若企业环境使用非标准私有地址，请参考 [环境准备-非标准私有地址处理方法](../EnvPreparation/get_ready.md#非标准私有地址处理方法)

- 如果已经按照 [环境准备](../EnvPreparation/get_ready.md) 篇章准备了 install.config 文件，可忽略该步骤。

```bash
# 请根据实际机器的 IP 进行替换第一列的示例 IP 地址，确保三个 IP 之间能互相通信
cat << EOF >/data/install/install.config
[basic]
10.0.0.1 iam,ssm,usermgr,gse,redis,consul,es7,apigw
10.0.0.2 consul,mongodb,rabbitmq,appo,iam_search_engine,redis_cluster
10.0.0.3 paas,cmdb,job,mysql,nginx,zk(config),appt,consul,nodeman(nodeman),auth,etcd
EOF
```

### 1.6 执行免密

```bash
cd /data/install
bash /data/install/configure_ssh_without_pass
```

### 1.7 自定义配置（可选）

以下操作只需要在中控机上执行

- 部署前自定义域名以及安装目录

   \$BK_DOMAIN：需要更新的根域名。

   \$INSTALL_PATH：自定义安装目录。

   ```bash
   # 执行前请使用实际的二级域名 (如：bktencent.com) 和安装目录进行替换
   BK_DOMAIN=bktencent.com
   INSTALL_PATH=/data/bkce

   cd /data/install 
   ./configure -d $BK_DOMAIN -p $INSTALL_PATH
   ```

- 部署前自定义 admin  登录密码

    **请使用实际的自定义密码替换 BlueKing，以及使用实际的部署脚本路径替换默认的脚本路径 `/data/install`。**

    ```bash
    cat > /data/install/bin/03-userdef/usermgr.env << EOF
    BK_PAAS_ADMIN_PASSWORD=BlueKing@2023
    EOF
    ```


## 开始部署

### 初始化并检查环境

```bash
# 初始化环境
./bk_install common

# 校验环境和部署的配置
./health_check/check_bk_controller.sh
```

### 部署 PaaS 平台

```bash
# 安装 PaaS 平台及其依赖服务
./bk_install paas
```

PaaS 平台部署完成后，可以访问蓝鲸的 PaaS 平台。如部署时域名未经解析，可参考 [三、访问蓝鲸](./quick_install.md#三、访问蓝鲸) 。

### 部署 app_mgr

```bash
# 部署 SaaS 运行环境，正式环境及测试环境
./bk_install app_mgr
```

### 部署 API 网关

```bash
./bk_install apigw
```

### 部署权限中心与用户管理

```bash
# 权限中心
./bk_install saas-o bk_iam
# 用户管理
./bk_install saas-o bk_user_manage
```

### 部署 bkiam_search_engine

```bash
./bk_install bkiam_search_engine
```

### 部署 paas_plugin

```bash
./bk_install paas_plugin
```

### 部署 CMDB

```bash
# 安装配置平台及其依赖服务
./bk_install cmdb
```

### 部署 JOB

**注意：** 社区版 6.2.x 后的版本全新部署默认为轻量化版本，如需在生产环境下使用，请切换成完整版进行部署或者在部署完成后按照 [作业平台运行模式切换](../../MaintenanceManual/DailyMaintenance/job_run_mode.md) 进行切换。

```bash
# 安装作业平台后台模块及其依赖组件
./bk_install job
```

### 部署 bknodeman

```bash
# 安装节点管理后台模块、节点管理 SaaS 及其依赖组件
./bk_install bknodeman
```

### 部署标准运维及流程服务

依次执行下列命令部署相关 SaaS。

```bash
# 标准运维
./bk_install saas-o bk_sops

# 流程管理
./bk_install saas-o bk_itsm
```

### 加载蓝鲸相关维护命令

```bash
source ~/.bashrc
```

### 初始化蓝鲸业务拓扑

```bash
./bkcli initdata topo
```

### 部署 API 自动化测试工具 (可选)

1. 同步安装目录文件到指定机器

   ```bash
   ./bkcli sync bkapi
   ```

2. 部署 API 自动化测试工具

   ```bash
   ./bkcli install bkapi
   ```

3. 运行 API 自动化测试工具

   ```bash
   # 默认检查所有模块的 API
   ./bkcli check bkapi
   ```

4. 如何检查单模块 API

    目前支持的模块 bk_cmdb, bk_job, bk_gse, bk_itsm, bk_monitorv3, bk_paas, bk_sops, bk_user_manage

    ```bash
    # 以 JOB 为例
    # 执行完成后，如果需要查看单模块的 API 报告，可以在主域名后面加上模块名称，如 bkapi_check.bktencent.com/bk_job
    ./bkcli check bkapi bk_job
    ```

## 三、访问蓝鲸

### 3.1 配置本地 hosts

> 下面介绍的操作均可能覆盖现有 hosts ，进行操作前请先确认是否需要备份。

查询模块所分布在机器的方式：

```bash
# 如果 nginx/nodeman 不在同一机器上，请将 nodeman 的域名单独解析至对应的机器上
grep -E "nginx|nodeman" /data/install/install.config
```

1. Windows 配置

   用文本编辑器（如`Notepad++`）打开文件：

   `C:\Windows\System32\drivers\etc\hosts`

   将以下内容复制到上述文件内，并将以下 IP 需更换为本机浏览器可以访问的 IP，然后保存。

   **注意：** 文档描述的均为主机对应的内网 IP，故需将内网 IP 更换为本机浏览器可以访问的公网 IP 进行 Host 绑定。

   ```bash
   10.0.0.3 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com bkapi_check.bktencent.com apigw.bktencent.com bkapi.bktencent.com nodeman.bktencent.com
   ```

   > 注意：如果遇到无法保存，请右键文件 hosts 并找到“属性” -> “安全”，然后选择你登录的用户名，最后点击编辑，勾选“写入”即可。

2. Linux / Mac OS 配置

   将以下内容复制到 `/etc/hosts` 中，并将以下 IP 更换为本机浏览器可以访问的公网 IP 进行 Host 绑定，然后保存。

   ```bash
   10.0.0.3 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com bkapi_check.bktencent.com apigw.bktencent.com bkapi.bktencent.com nodeman.bktencent.com
   ```

### 3.2 获取管理员账户名密码

   在任意一台机器上，执行以下命令，获取管理员账号和密码。

   ```bash
   grep -E "BK_PAAS_ADMIN_USERNAME|BK_PAAS_ADMIN_PASSWORD" /data/install/bin/04-final/usermgr.env
   ```

### 3.3 访问蓝鲸开始使用

> 默认蓝鲸工作台入口：[http://paas.bktencent.com](http://paas.bktencent.com)

- 可参考蓝鲸 [快速入门](../../../../QuickStart/6.0/quick-start-v6.0-base.md) 以及相关 [产品白皮书](https://bk.tencent.com/docs/)

- 进阶选项：[监控日志套餐部署](./value_added.md)
