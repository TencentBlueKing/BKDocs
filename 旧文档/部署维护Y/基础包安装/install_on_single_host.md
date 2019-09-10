## 单机部署

**单机部署方案是针对新老用户快速低成本的搭建一套精简的蓝鲸智云社区版推出的。**

### 一. 按照主机配置灵活选择单机蓝鲸社区版的配置

- 最低配置满足 **CPU≥1核 内存≥4G** 可安装PaaS平台，配置平台，作业平台，以及安装 gse_agent 用的 SaaS ：节点管理，可满足资源管理、批量分发文件、执行作业等简单的运维常见场景。

  > 由于没有部署 BKDATA ，因此配置平台上不会有主机“实时状态”和“快照数据”（请参考 [配置平台白皮书](https://docs.bk.tencent.com/cmdb/) 说明）

- 最低配置满足：**CPU≥2核 内存≥16GB**，在单台主机中可安装所有蓝鲸基础平台和官方 SaaS，从 **社区版V4.1.11** 版本开始，支持 **完整蓝鲸基础包的单机部署**。

  > 单机性能限制及安全风险大，目前按照该最低配置可以成功部署完整社区版V5.0.4及以下版本的基础包，但整体的性能会受到较多限制，另社区版V5.1暂时不支持单机部署
  >
  > 部署 SaaS 的正式环境（APPO）和测试环境（APPT）不能安装到同一台主机上，因此单机部署默认只安装 APPO 用于支持官方 SaaS 的运行，缺少测试环境将导致用户自开发应用将无法提测到测试环境，如有自开发应用需求，建议增加一台主机，参考维护手册：[单机部署增加一台APPT](/9.维护手册/日常维护/maintain.md#add_appt)

### 二. 单机部署方案选择

用户主机资源充足可选方案一进行部署，主机资源紧张可选方案二，通过腾讯云实验室免费提供的主机资源，在线快速体验搭建和使用蓝鲸社区版（目前仅支持社区版V4.1，并且有使用时长限制）。

#### 方案一：用户自行提供主机

* 从官网 [下载安装包](http://bk.tencent.com/download/)。

* 环境准备：

  * 按照安装 [环境准备](/4.基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

  * 将安装包解压到 `/data` 目录下：
    ```bash
    tar xf bkce_src-5.0.3.tar.gz  -C /data
    ```  

  * 获取机器的 MAC 地址， [下载证书文件](http://bk.tencent.com/download/#ssl) 并解压到 `src/cert` 目录下：
    ```bash
    tar xf ssl_certificates.tar.gz -C /data/src/cert
    ```

  * 配置参数：
    * install.config 通过安装脚本生成：
    ```bash
    ./install_minibk -y
    ```
    * globals.env 重点关注 **域名** 和 **GSE 外网IP** 相关的配置，详情参考[安装环境准备章节-配置参数](/4.基础包安装/环境准备/get_ready.md#configs)的内容。
    * ports.env 端口信息如有冲突可自行修改。

    > 注：Admin 用户名和密码只在部署完成前生效，部署完成后修改，请到 工作台 - 账户管理 修改，修改完成后请同步更新到 globals.env 中

* 执行安装：不同配置主机请参考对应安装命令：

  - 最低配置满足 **CPU≥1核 内存≥4G**，执行
  ```bash
  $ cd /data/install
  $ ./bk_install paas && ./bk_install cmdb && ./bk_install job && ./bk_install app_mgr && ./bkcec install saas-o bk_nodeman
  # 只安装 PaaS 平台，配置平台，作业平台、SaaS-节点管理
  ```

  - 最低配置满足：**CPU≥2核 内存≥16GB**，执行
  ```bash
  $ cd /data/install
  $ ./bk_install paas && ./bk_install cmdb && ./bk_install job && ./bk_install app_mgr && ./bk_install bkdata && ./bk_install fta && ./bkcec install gse_agent && ./bkcec install saas-o
  # 安装蓝鲸所有基础平台和官方 SaaS
  # 由于组件之间的依赖关系，安装必须按照上述顺序进行
  ```  

  - 安装过程中遇到失败的情况，请根据 [部署维护常见问题]() 定位排查解决，解决方法无效或者找不到对应解决方法，请按官网底部联系方式联系我们，解决报错后再重新运行失败时的安装指令。

* 访问蓝鲸：

  * 根据 `install/globals.env` 里配置的 PaaS 域名(PAAS_FQDN)、账号(PAAS_ADMIN_USER)、密码(PAAS_ADMIN_PASS)信息，登录访问(若域名没设置 DNS 解析，需配置本机 hosts )。

  * 域名信息：
  ```bash
  export BK_DOMAIN="xxx.com"
  export PAAS_FQDN="paas.$BK_DOMAIN"
  export CMDB_FQDN="cmdb.$BK_DOMAIN"
  export JOB_FQDN="job.$BK_DOMAIN"
  ```

  * 账号信息：
  ```bash
  export PAAS_ADMIN_USER=admin
  export PAAS_ADMIN_PASS="xxx"
  ```

* 日常维护
  * 日常维护和运维单机部署和标准部署是一致的，请参考 [维护文档](/9.维护手册/mantain_readme.md)。

* 使用蓝鲸
  * 请参考蓝鲸各产品白皮书：https://docs.bk.tencent.com/product_white_paper/introduction/。

#### 方案二：在线体验快速部署

为降低用户了解蓝鲸的门槛，蓝鲸智云联合腾讯云推出免费在线部署蓝鲸社区版的体验服务。

点击访问 [蓝鲸智云社区版V4.1单机部署体验](https://cloud.tencent.com/developer/labs/lab/10386)。

> 目前仅支持社区版V4.1，更新版本敬请期待
