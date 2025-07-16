# 基础套餐安装指引

> 阅读前请确认好您的部署目的。
> 
> 该文档适用于生产环境多机器分模块部署场景，如仅需体验该套餐功能，可参考 [单机部署](../单机部署/install_on_single_host.md)

基础套餐包含：PaaS 平台、配置平台、作业平台、权限中心、用户管理、节点管理、标准运维、流程服务。

## 一、前期准备

在开始安装前，请参照 [环境准备](../环境准备/get_ready.md) 文档，配置系统环境。

### 1.1 准备机器

1. 建议操作系统： CentOS 7.6 及以上
2. 建议机器配置
   - 生产环境：建议 4 核 32 G，硬盘 100G 以上（可根据实际情况适当调整配置）
      - 机器数量：3 台（假设 ip 分别为：10.0.0.1，10.0.0.2，10.0.0.3）
3. 选择一台为中控机（假设为 10.0.0.1）进行安装部署操作，使用 root 账号登录。

### 1.2 获取证书

- 通过 `ifconfig` 或者 `ip addr` 命令分别获取 3 台机器第一个内网网卡 MAC 地址
  
- 前往蓝鲸官网证书生成页面（[https://bk.tencent.com/download_ssl/](https://bk.tencent.com/download_ssl/)），根据提示在输入框中填入英文分号分隔的三个 MAC 地址，生成并下载证书

- 上传证书包至中控机 `/data`
  - 证书包包名：ssl_certificates.tar.gz

### 1.3 下载安装包

- 请前往 [蓝鲸官网下载页](https://bk.tencent.com/download/) 下载基础套餐包

### 1.4 解压相关资源包

1. 解压套餐包（包含蓝鲸相关产品，如 PaaS、CMDB、JOB 等；蓝鲸依赖的 rpm 包，SaaS 镜像，定制 Python 解释器；部署脚本）

   ```bash
   cd /data
   tar xf bkce_basic_suite-6.0.5.tgz
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

### 1.5 生成并配置 install.config

**说明：**

- gse 与 redis 需要部署在同一台机器上。
- 当含多个内网 IP 时，默认使用  /sbin/ifconfig 输出中的第一个内网 IP。
- 部署需要使用标准私有地址，若企业环境使用非标准私有地址，请参考 [环境准备-非标准私有地址处理方法](../环境准备/get_ready.md#非标准私有地址处理方法)

```bash
# 请根据实际机器的 IP 进行替换第一列的示例 IP 地址，确保三个 IP 之间能互相通信
cat << EOF >/data/install/install.config
10.0.0.1 iam,ssm,usermgr,gse,license,redis,consul,mysql,lesscode
10.0.0.2 nginx,consul,mongodb,rabbitmq,appo
10.0.0.3 paas,cmdb,job,zk(config),appt,consul,nodeman(nodeman)

EOF
```

### 1.6 执行免密

```bash
cd /data/install
bash /data/install/configure_ssh_without_pass
```

## 二、开始部署

### 初始化并检查环境

```bash
# 初始化环境
./bk_install common

# 校验环境和部署的配置
./health_check/check_bk_controller.sh
```
[初始化环境-常见报错](https://bk.tencent.com/s-mart/community/question/5540?type=answer)

[校验环境和部署的配置-常见报错](https://bk.tencent.com/s-mart/community/question/5668?type=answer)

### 部署 PaaS 平台

```bash
# 安装 PaaS 平台及其依赖服务
./bk_install paas
```
PaaS 平台部署完成后，可以访问蓝鲸的 PaaS 平台。配置域名访问，请参考 [访问蓝鲸](./quick_install.md#三、访问蓝鲸) 。

[部署 paas-常见报错](https://bk.tencent.com/s-mart/community/question/5559?type=answer)

### 部署 app_mgr

```bash
# 部署 SaaS 运行环境，正式环境及测试环境
./bk_install app_mgr
```
[部署 app_mgr-常见报错](https://bk.tencent.com/s-mart/community/question/5713?type=answer)
### 部署权限中心与用户管理

```bash
# 权限中心
./bk_install saas-o bk_iam
# 用户管理
./bk_install saas-o bk_user_manage
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)

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
[部署 job-常见报错](https://bk.tencent.com/s-mart/community/question/5538?type=answer)
### 部署 bknodeman

- 如需使用跨云管控，请提前将节点管理的外网 IP 写入至节点管理后台服务所在机器的`/etc/blueking/env/local.env` 文件，详细请参考 [开启 proxy](../../维护手册/日常维护/open_proxy.md)。否则请忽略该步骤

- 开始部署

```bash
# 安装节点管理后台模块、节点管理 SaaS 及其依赖组件
./bk_install bknodeman
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)

### 部署标准运维及流程管理

依次执行下列命令部署相关 SaaS。

```bash
# 标准运维
./bk_install saas-o bk_sops

# 流程管理
./bk_install saas-o bk_itsm
```
[部署 saas-常见报错](https://bk.tencent.com/s-mart/community/question/5669?type=answer)
### 加载蓝鲸相关维护命令

```bash
source ~/.bashrc
```

### 初始化蓝鲸业务拓扑

```bash
./bkcli initdata topo
```
[初始化拓扑-常见报错](https://bk.tencent.com/s-mart/community/question/5417?type=answer)
### 部署 lesscode (可选)

```bash
./bk_install lesscode
```
[部署 lesscode-常见报错](https://bk.tencent.com/s-mart/community/question/6238?type=answer)
### 检测相关服务状态

```bash
cd /data/install/
echo bkssm bkiam usermgr paas cmdb gse job consul | xargs -n 1 ./bkcli check
```

## 三、访问蓝鲸

### 3.1 配置本地 hosts

> 下面介绍的操作均可能覆盖现有 hosts ，进行操作前请先确认是否需要备份。

1. Windows 配置

用文本编辑器（如 `Notepad++`）打开文件：

```bash
C:\Windows\System32\drivers\etc\hosts
```

将以下内容复制到上述文件内，并将以下 IP 需更换为本机浏览器可以访问的 IP，然后保存。如无部署 lesscode，可去掉 `lesscode.bktencent.com` 再进行绑定

```bash
10.0.0.2 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com lesscode.bktencent.com
10.0.0.3 nodeman.bktencent.com
```

**注意：** 10.0.0.2 为 nginx 模块所在的机器，10.0.0.3 为 nodeman 模块所在的机器。IP 需更换为本机浏览器可以访问的 IP。

查询模块所分布在机器的方式：

```bash
grep -E "nginx|nodeman" /data/install/install.config
```

> 注意：如果遇到无法保存，请右键文件 hosts 并找到“属性” -> “安全”，然后选择你登录的用户名，最后点击编辑，勾选“写入”即可。

2. Linux / Mac OS 配置

将以下内容复制到 `/etc/hosts` 中，并将以下 IP 需更换为本机浏览器可以访问的 IP，然后保存。

```bash
10.0.0.2 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com lesscode.bktencent.com
10.0.0.3 nodeman.bktencent.com
```

### 3.2 获取管理员账户名密码

在任意一台机器上，执行以下命令，获取管理员账号和密码。

```bash
grep -E "BK_PAAS_ADMIN_USERNAME|BK_PAAS_ADMIN_PASSWORD" /data/install/bin/04-final/usermgr.env
```

### 3.3 访问蓝鲸开始使用

> 默认蓝鲸工作台入口：http://paas.bktencent.com

可参考蓝鲸 [快速入门](../../../../快速入门/quick-start-v6.0-info.md) 以及相关 [产品白皮书](https://bk.tencent.com/docs/)

进阶选项：[监控日志套餐部署](./value_added.md)


[【社区版 6.0.3 问题汇总 】](https://bk.tencent.com/s-mart/community/question/2120)

[【部署后无法访问—常见报错】](https://bk.tencent.com/s-mart/community/question/6807?type=answer)
