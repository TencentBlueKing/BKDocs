# 单机部署

单机部署方案是针对新老用户快速低成本的搭建一套精简版的蓝鲸社区版推出的。

从社区版 4.1.11 版本开始，支持完整版本蓝鲸的单机部署体验，前提要求是，单机 CPU 不低于 2 核，可用内存不低于 16GB。
若机器性能没满足要求，只能部署精简版的蓝鲸平台。

精简版蓝鲸平台满足简单的运维场景需求，包含：PaaS 平台，配置平台，作业平台，以及安装  Agent 用的 节点管理 SaaS。

## 部署方式

- [腾讯云实验室](https://cloud.tencent.com/developer/labs/lab/10386)

- 自行提供主机


## 自行提供主机

按照安装 [环境准备](../../基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

* 环境准备
  - 准备一台 CentOS 7 以上操作系统的机器（物理机和虚拟机均可）。

  - 按照安装 [环境准备](../../基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

  - 配置好 YUM 源，包含 EPEL 仓库（可以通过 `yum info nginx` 测试下）。

  - 从 [官网下载](http://bk.tencent.com/download/) 完整包，并解压到 /data/ 下。

    ```bash
    $ tar xf bkce_src-5.0.3.tar.gz  -C /data
    ```

  - 获取机器的 MAC 地址后，下载 [证书文件](https://bk.tencent.com/download_ssl/)，解压到 src/cert 目录下
    ```bash
    $ tar xf ssl_certificates.tar.gz -C /data/src/cert
    ```
* 配置参数

  - install.config 这个文件安装脚本会自动生成，无需自行配置。

  - globals.env 重点关注域名和 GSE 外网 IP 相关的配置，详情参考 [环境准备-配置文件](../../基础包安装/环境准备/get_ready.md#configs) 一节。

  - ports.env 一般不用修改。

* 执行安装

  如果部署全部组件，请执行：
  ```bash
  $ cd /data/install
  $ ./install_minibk -y
  ```

  如果按需部署，假设只需要 PaaS，CMDB，JOB 平台，请执行：
  ```bash
  $ cd /data/install
  $ ./install_minibk
  $ ./bk_install paas && ./bk_install cmdb && ./bk_install job
  ```

  安装过程中遇到失败的情况，请先定位排查解决后，再重新运行失败时的安装指令。

## 访问蓝鲸

根据 `install/globals.env` 里配置的 PaaS 域名(PAAS_FQDN)、账号 (PAAS_ADMIN_USER)、密码(PAAS_ADMIN_PASS)信息，登录访问(若域名没设置 DNS 解析，需配置本机 hosts)。

* 域名信息

  ```bash
  export BK_DOMAIN="xxx.com"
  export PAAS_FQDN="paas.$BK_DOMAIN"
  export CMDB_FQDN="cmdb.$BK_DOMAIN"
  export JOB_FQDN="job.$BK_DOMAIN"
  ```

* 账号信息

  ```bash
  export PAAS_ADMIN_USER=admin
  export PAAS_ADMIN_PASS="xxx"
  ```

日常维护和运维，单机部署和多机是一致的，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

## 使用蓝鲸

请参考蓝鲸各 [产品白皮书](https://bk.tencent.com/docs/)。
