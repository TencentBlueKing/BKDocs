## 网络管理平台

### 环境准备
1. 下载 [网络管理平台](http://bk.tencent.com/download/) :
  - 解压后目录结构如下：
    ```bash
    bknetwork
    |-- bknetwork-3.6.1.tgz
    |-- install
    |   |-- bkco_install
    |   `-- third
    |       |-- control_bknetwork.rc
    |       |-- deliver_bknetwork.rc
    |       |-- globals_bknetwork.env
    |       |-- initdata_bknetwork.rc
    |       |-- install_bknetwork.rc
    |       |-- ports_bknetwork.env
    |       |-- render_bknetwork.rc
    |       |-- status_bknetwork.rc
    |       `-- upgrade_bknetwork.rc
    `-- MD5
    ```

2. 确认蓝鲸社区版的 PaaS，CMDB，JOB 已经部署完成。如无，请参考 [标准部署](../../基础包安装/多机部署/quick_install.md) 进行安装部署。

3. 解压插件包

    ```bash
    tar xf bknetwork.tgz -C /data/src/

    # 假设现 src 目录在 /data/ 下
    tar xf /data/src/bknetwork/bknetwork-3.6.1.tgz  -C  /data/src/

    # 假设现 install 目录在 /data/ 下
    rsync -a /data/src/bknetwork/install/  /data/install/
    ```

4. 根据实际情况修改中控机 `/data/install/third/globals_bknetwork.env` 网络管理域名等信息。

### 安装部署

  ```bash
  # 假设现 install 目录在 /data/ 下。
  cd /data/install

  # 开始安装
  ./bkco_install bknetwork
  ```

配置的域名访问网络管理，将网络管理平台添加到蓝鲸工作台。

  * 通过浏览器登录社区版页面，在域名后添加 `admin` 进入蓝鲸智云后台管理页面。
  * Home - 常用链接 - 增加常用链接，名称填入网络管理平台，将配置的域名填入链接，类型选择 `SaaS 链接` ，选择 Logo 后保存，即可在蓝鲸工作台中访问 SaaS 网络管理平台。
