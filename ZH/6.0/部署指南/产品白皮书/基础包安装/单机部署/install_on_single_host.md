# 单机部署

单机部署方案是针对新老用户快速低成本的搭建一套精简版的蓝鲸社区版推出的。

从社区版 4.1.11 版本开始，支持完整版本蓝鲸的单机部署体验，前提要求是，单机 CPU 不低于 2 核，可用内存不低于 16GB。
若机器性能没满足要求，只能部署精简版的蓝鲸平台。

精简版蓝鲸平台满足简单的运维场景需求，包含：PaaS 平台，配置平台，作业平台，以及安装  Agent 用的 节点管理 SaaS。

## 部署方式

- [腾讯云实验室](https://cloud.tencent.com/developer/labs/lab/10386)，目前实验室的仍为 5.1 版本。

- 自行提供主机

## 自行提供主机

按照安装 [环境准备](../../基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

* 环境准备
  - 准备一台 CentOS 7.5 及以上操作系统的机器(物理机和虚拟机均可)。

  - 按照安装 [环境准备](../../基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

  - 配置好 YUM 源，包含 EPEL 仓库(可以通过 `yum info nginx` 测试下)。

  - 从 [官网下载](http://bk.tencent.com/download/) 完整包，并解压到 /data/ 下。

    ```bash
    tar xf bkce_src-6.0.x.tgz  -C /data
    ```

  - 获取机器的 MAC 地址后，下载 [证书文件](https://bk.tencent.com/download_ssl/)，解压到 src/cert 目录下

    ```bash
    install -d -m 755 /data/src/cert
    tar xf ssl_certificates.tar.gz -C /data/src/cert
    ```

* 配置参数

  - install.config 这个文件安装脚本会自动生成，无需自行配置。

  - globals.env 重点关注域名和 GSE 外网 IP 相关的配置，详情参考 [环境准备-配置文件](../环境准备/get_ready.md#配置文件) 一节。

* 执行安装

  如果部署全部组件，请执行：

  ```bash
  cd /data/install
  ./install_minibk -y
  ```

  如果按需部署，假设只需要 PaaS，CMDB，JOB 平台，请执行：

  ```bash
  cd /data/install
  ./install_minibk
  ./bk_install paas && ./bk_install cmdb && ./bk_install job
  ```

  安装过程中遇到失败的情况，请先定位排查解决后，再重新运行失败时的安装指令。

## 访问蓝鲸

根据 `install/bin/04-final/global.env`、`install/bin/04-final/usermgr.env` 里配置的 PaaS 域名(BK_PAAS_PUBLIC_ADDR)、账号 (BK_PAAS_ADMIN_USERNAME)、密码(BK_PAAS_ADMIN_PASSWORD)信息，登录访问(若域名没设置 DNS 解析，需配置本机 hosts)。

* 域名信息

  ```bash
  # 蓝鲸的根域名
  BK_DOMAIN=bktencent.com
  # 访问PaaS平台的域名
  BK_PAAS_PUBLIC_ADDR=paas.bktencent.com:80
  # 访问CMDB的域名
  BK_CMDB_PUBLIC_ADDR=cmdb.bktencent.com:80
  # 访问Job平台的域名
  BK_JOB_PUBLIC_ADDR=job.bktencent.com:80
  BK_JOB_API_PUBLIC_ADDR=jobapi.bktencent.com:80
  # 访问节点管理下载插件包的URL
  BK_NODEMAN_PUBLIC_DOWNLOAD_URL=nodeman.bktencent.com:80
  ```

* 账号信息

  ```bash
  BK_PAAS_ADMIN_PASSWORD=xxxxx
  BK_PAAS_ADMIN_USERNAME=admin
  ```

日常维护和运维，单机部署和多机是一致的，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

## 使用蓝鲸

请参考蓝鲸各 [产品白皮书](https://bk.tencent.com/docs/)。
