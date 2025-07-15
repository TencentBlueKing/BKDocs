# 社区版 6.0.4 升级指引

## 适用范围

6.0.3 - 6.0.4

## 说明

- 如无特殊说明，所述操作均在中控机执行。
- 文中所述的目录路径均以默认为主，如与实际有出入，请以升级实际路径为准。
- 本次升级仅面向涉及到的产品，未更新的产品不做阐述，请知悉。详细请见官网文档：[组件更新](../维护手册/日常维护/update.md)。

## 获取更新产品信息

本次社区版 6.0.4 更新涉及产品：PaaS 平台、节点管理、监控平台、日志平台、流程服务、故障自愈、权限中心、配置平台、标准运维、管控平台以及用户管理。如需了解本次更新详情，请查看 [版本日志](../../../../VersionLog/6.0/v6004.md)。

获取当前环境下版本：

```bash
# 获取版本
cd /data/src; grep . VERSION

# 蓝鲸各产品版本
cd /data/src; grep . */*VERSION */*/VERSION
```

## 前置准备

1.下载相关产品包。请前往 [蓝鲸官网下载页-版本列表](https://bk.tencent.com/download_version_list/) 下载。

- patch 包：[bkce_patch_6.0.3-6.0.4.tgz](https://bkopen-1252002024.file.myqcloud.com/ce/bkce_patch_6.0.3-6.0.4.tgz)

2.将相关产品包上传至服务器 /data 目录。

3.备份 install、src 目录

```bash
cp -a -r /data/install /data/install_6.0.3_$(date +%Y%m%d%H%M)
mv /data/src /data/src_6.0.3.bak
```

4.准备新版本部署脚本以及产品包

```bash
# 创建新版本产品临时存放目录
mkdir /data/tmp

# 将 patch 包解压至临时存放目录
tar xf /data/bkce_patch_6.0.3-6.0.4.tgz -C /data/tmp

# 解压 install 部署脚本包
tar xf /data/tmp/install_ce-v3.0.10.tgz -C /data/tmp/
```

5.替换 install、src。

- 替换 src 目录

    ```bash
    mv /data/tmp/src /data/
    ```

- 替换 install

    ```bash
    # 替换部署脚本
    rsync -avz --delete --exclude=".*" --exclude="install.config" --exclude="bin/0[1234]-*" /data/tmp/install/ /data/install/

    # 解压 src 下各个产品软件包
    cd /data/src/; for f in *gz;do tar xf $f; done

    # 还原不需要更新的模块
    cp -a -r /data/src_6.0.3.bak/{bkssm,python,yum,license,blueking.env,java8.tgz,backup,cert,job} /data/src
    cp -a -r /data/src_6.0.3.bak/official_saas/bk_fta_solutions_V5.2.14-ce-bkofficial.tar.gz /data/src/official_saas/
    cp -a -r /data/src_6.0.3.bak/gse_plugins/{gsecmdline-2.0.3.tgz,pluginscripts-1.0.3.tgz} /data/src/gse_plugins/
    ```

## 开始更新

开始更新前请先同步最新脚本至其他机器。

```bash
./bkcli sync common
```

### PaaS 平台

```bash
./bkcli upgrade paas
```

### 更新 paasagent

- 更新 appo 以及 appt 环境

```bash
./bkcli upgrade appo
./bkcli upgrade appt
```

### 更新 docker 镜像

- 更新 appo 机器上的 python 镜像

```bash
ssh $BK_APPO_IP
docker load < /data/src/image/python27e_1.0.tar
docker load < /data/src/image/python36e_1.0.tar
rsync -avz /data/src/image/runtool /usr/bin/
chmod +x  /usr/bin/runtool
```

- 更新 appt 机器上的 python 镜像

```bash
ssh $BK_APPT_IP
docker load < /data/src/image/python27e_1.0.tar
docker load < /data/src/image/python36e_1.0.tar
rsync -avz /data/src/image/runtool /usr/bin/
chmod +x  /usr/bin/runtool
```

### 权限中心

#### 特殊操作

**重要：** 因 6.0.3 升级至 6.0.4 权限中心 SaaS 需要先升级中间版本。所以下述操作必须操作。

- 中间版本已随 patch 包放置 src/official_saas/ 目录下。

- 将 src/official_saas 目录下的 bk_iam_V1.3.6-bkofficial.tar.gz 包放置本地。

- 部署权限中心 SaaS 中间版本（bk_iam_V1.3.6-bkofficial.tar.gz）。
  - 访问蓝鲸 PaaS 工作台 - 开发者中心 - S-mart 应用 - 找到 bk_iam，点击部署 - 上传版本 - 发布部署 - 选择 1.3.6 版本进行部署 - 部署至正式环境。

- 升级完中间版本后，全量同步所有的权限模板

```bash
source /data/install/utils.fc
ssh $BK_APPO_IP

docker exec -it $(docker ps | grep -w bk_iam | awk '{print $1}') bash 
export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"

# 脚本打印 Successful completion of template version synchronization 表示执行同步成功
/cache/.bk/env/bin/python /data/app/code/manage.py sync_templates

```

- 确认版本：**后台必须为 1.6.1，SaaS 必须为：1.3.6**。

```bash
# 后台版本
curl http://bkiam.service.consul:5001/version | jq .version
```

**注意：** 在此之前，必须将权限中心升级至指定中间版本，如未升级，请勿升级继续向下操作。

```bash
./bkcli install saas-o bk_iam==1.4.24
./bkcli upgrade bkiam
```

### 用户管理

```bash
./bkcli install saas-o bk_user_manage
./bkcli upgrade usermgr
```

### 配置平台

```bash
./bkcli upgrade cmdb
# 检查 cmdb
./bkcli check cmdb
```

### 管控平台

```bash
./bkcli upgrade gse
./bkcli check gse
```

### 节点管理

```bash
./bkcli install saas-o bk_nodeman
./bkcli upgrade bknodeman

# 更新采集器相关插件
./bkcli initdata nodeman
```

### 监控平台

```bash
./bkcli install saas-o bk_monitorv3
./bkcli upgrade bkmonitorv3
```

### 日志平台

在 6.0.4 版本里，bklog 新增了 mysql 的依赖，所以在升级前，请确保 bklog 机器上是否有 mysql 的相关命令，否则升级过程中会有相关报错。

```bash
source /data/install/utils.fc
ssh $BK_LOG_IP "yum -y install mysql-devel"
```

开始更新

```bash
./bkcli install saas-o bk_log_search
./bkcli upgrade bklog

./bkcli restart bklog grafana
```

### 故障自愈

```bash
./bkcli upgrade fta
```

### 标准运维

```bash
./bk_install saas-o bk_sops
```

### 流程服务

```bash
./bk_install saas-o bk_itsm
```

### 重装故障自愈 SaaS

```bash
./bkcli install saas-o bk_fta_solutions
```

### 删除旧镜像

- 因提供的命令是删除 appo 或者 appt 上所有的 none 镜像。执行前请确认所有的 none 镜像是否都可以删除。
- 如有自行的开发的 SaaS，需要自行重新部署后，才能进行删除。

```bash
source /data/install/utils.fc

# appo 环境
pcmd -m appo "docker image prune  -f "

# appt 环境
pcmd -m appt "docker image prune  -f "
```

### 刷新版本信息

```bash
source /data/install/tools.sh
_update_common_info
```

## 升级后操作

- 禁用 mysqld.service 服务，避免服务器重启后无法拉起蓝鲸使用的 mysql@default.service 服务

```bash
cd /data/install
./pcmd.sh -m mysql "systemctl disable mysqld.service"
```

- 请前往配置平台修改蓝鲸业务下的 gse_btsvr 服务模版

详细操作：配置平台 - 业务 (选择蓝鲸业务) - 服务模版 - 搜索 "gse_btsvr" - 点击 ID 进行编辑 - 将第一内网 IP 修改成 0.0.0.0 即可

![change_gse_btsvr_bindip](../../assets/../产品白皮书/assets/change_gse_btsvr_bindip.png)


- 升级完成后，请前往节点管理页面升级/重装 agent、Proxy 以及相关采集器插件。

- 如果之前有部署 bkci 以及 bcs 的用户，请按照该方式将相关包进行还原 (`没有部署请忽略该步骤`)

```bash
# bkci
mv /data/src_6.0.3.bak/ci/ /data/src/

# bcs
mv /data/src_6.0.3.bak/public-images-community.tar.gz /data/src/
mv /data/src_6.0.3.bak/bcs_cc-ce-1.0.28.tar.gz /data/src/
mv /data/src_6.0.3.bak/python.tar.gz /data/src/
mv /data/src_6.0.3.bak/docker-18.09.5.tgz /data/src/
mv /data/src_6.0.3.bak/etcd-v3.3.12-linux-amd64.tar.gz /data/src/
mv /data/src_6.0.3.bak/mongodb-linux-x86_64-2.4.10.tgz /data/src/
mv /data/src_6.0.3.bak/jdk8.tar.gz /data/src/
mv /data/src_6.0.3.bak/bk_bcs_app_V1.3.21.tar.gz /data/src/
mv /data/src_6.0.3.bak/bcs-prom-k8s-ce-1.1.1.tar.gz /data/src/
mv /data/src_6.0.3.bak/harbor_api_ce-1.1.1.tgz /data/src/
mv /data/src_6.0.3.bak/docker-compose /data/src/
mv /data/src_6.0.3.bak/kubeops-ce_v1.tar.gz /data/src/
mv /data/src_6.0.3.bak/cryptools /data/src/
mv /data/src_6.0.3.bak/etcd-v3.4.13-linux-amd64.tar.gz /data/src/
mv /data/src_6.0.3.bak/harbor_charts-1.0.6.tar.gz /data/src/
mv /data/src_6.0.3.bak/bcs-service.ce.1.18.10-20.11.05.2011052349.tar.gz /data/src/
mv /data/src_6.0.3.bak/harbor_server-v1.7.6.tar.gz /data/src/
mv /data/src_6.0.3.bak/bk_bcs_monitor_V1.5.4.tar.gz /data/src/
mv /data/src_6.0.3.bak/devops-ce-1.0.29.11.tgz /data/src/
mv /data/src_6.0.3.bak/bcs_web_console-ce-V1.3.21.tar.gz /data/src/
mv /data/src_6.0.3.bak/java8.tgz /data/src/
mv /data/src_6.0.3.bak/bcs-monitor-ce-1.2.12-1.el7.x86_64.rpm /data/src/
mv /data/src_6.0.3.bak/bcs-thanos-ce-1.2.12-1.el7.x86_64.rpm /data/src/
```

如升级过程有任何疑问及问题，请前往蓝鲸社区群 (495299374) 联系蓝鲸助手获取技术支持。
