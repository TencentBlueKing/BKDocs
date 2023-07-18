# 组件更新

## 概述

### 更新注意事项

1. Python 工程涉及到安装新的 requirement.txt 的中涉及的依赖 pip 包，如果更新过程中报错，可能由于某些系统 devel 包不匹配导致，这时需要根据实际情况，修复该问题后，重新执行更新指令。

2. 部分模块的 support-files/sql/ 目录下有更新 sql 文件的，需要注意 sql 是否正常执行，如果中途报错，需要解决 sql 变更的问题再继续。

3. 部分模块 support-files/bkiam/ 目录下有更新 json 文件的，需要注意 bkiam migration 是否执行成功，如果中途报错，需要解决权限模型注册的问题再继续。

### 后台组件更新的通用步骤如下

以 CMDB 为例：

1. 获取 CMDB 更新包。
2. 在中控机备份原有 src/cmdb 目录，然后删除 src/cmdb，并解压最新版本到 src 目录下。删除原来的目录是为了保证 src/cmdb 不残留无用的文件。
3. 如果有自定义修改的配置模板/第三方扩展代码目录，可以同时同步到 src/cmdb/ 下。
4. 运行 `./bkcli upgrade cmdb`
5. 将 src/*/VERSION 的版本号刷新到 MySQL 库中存储版本信息的表中：`source ./tools.sh; _update_common_info`

### SaaS 的更新通用步骤有两种方式

1. 页面更新：登录 PaaS 平台 -> 开发者中心 -> S-mart 应用 -> 找到待更新的 SaaS 应用名 -> 上传版本 -> 发布部署 -> 选择对应的环境和版本 -> 部署

2. 后台命令行更新，其中 app_code 请替换为具体对应的 SaaS，比如更新标准运维，使用 bk_sops：

   1. 上传 SaaS 包到中控机的 /data/src/official_saas/ 目录

   2. 更新正式环境运行命令 `cd /data/install && ./bkcli install saas-o app_code`

   3. 更新测试环境运行命令 `cd /data/install && ./bkcli install saas-t app_code`

### PaaS 更新

PaaS 更新需要注意处理第三方扩展代码目录。如：改造过企业内部统一登录。则需要将原来的数据拷贝回原来的目录下

```bash
./bkcli upgrade paas 
```

### PaaS Agent 更新

PaaS Agent 分为 appo 和 appt，更新场景主要包括三个方面：

1. src/image/ 的更新。SaaS 所用的基础镜像更新，比较简单，直接使用 `docker load` 加载新的镜像即可。

2. paas_agent 目录的二进制和脚本更新，直接使用 rsync 同步 paas_agent/ 目录到安装目录下的 paas_agent/ 然后重启进程即可

3. openresty 的配置模板更新，需要更新 /etc/consul-template/templates/ 下的模版配置文件

### CMDB 更新

原则上 CMDB 不停机更新需要滚动更新，包括 cmdb-api、cmdb-web、cmdb-auth 三个模块的需要先从 Nginx 上剔除，然后更新对应模块。

```bash
./bkcli upgrade cmdb
```

### GSE 更新

gse 分为 server 端和 client 端的更新。 Server 端更新和常规通用更新一样。Client 端更新有点特殊，（注意拿到 gse 的更新包后，不要删除原始的 tgz 包。）分两步：

#### server 端更新

```bash
./bkcli upgrade gse
```

#### client 端更新

1. 打包 client 包，`-o` 指定生成 gse_client 包的目录。

   ```bash
   /data/install/bin/pack_gse_client_with_plugin.sh -c /data/bkce/cert \
     -f /data/src/gse_xxx.tgz -p /data/src/gse_plugins/ -o /tmp/gse
   ```

2. 将生成的 client 包拷贝到节点管理后台机器的 http 下载服务目录下

   ```bash
   chown blueking.blueking /tmp/gse/*.tgz
   rsync -v /tmp/gse/*.tgz $BK_NODEMAN_IP:$BK_HOME/public/bknodeman/download/
   ```

### Job 更新

Job 是前后端分离的部署架构，前后端分开更新，分别使用 `bin/release_job_frontend.sh` 和 `bin/release_job_backend.sh`，但经过 `upgrade.sh` 脚本封装后，可以直接使用常规通用的来实现更新。

```bash
./bkcli upgrade job
```

### 节点管理更新

节点管理分前后台，SaaS 的 app_code 为 `bk_nodeman`，后台的模块是 `bknodeman`。它们公用一个 bk_nodeman 的数据库，而数据库的 schema 更新维护是在 SaaS 中完成，权限模型的更新也由 SaaS 控制。所以如果有更新，每次先更新 SaaS，然后更新后台。

```bash
# 更新 SaaS。前提是已将 bk_nodeman 的 SaaS 包放置 src/official_saas/ 下
./bkcli install saas-o bk_nodeman

# 更新后台
./bkcli upgrade bknodeman
```

### 监控平台更新

监控平台区分了 2 个数据库，一个是 `bk_monitorv3`，一个是 `bkmonitorv3_alert`，SaaS 和后台都会读写这 2 个库。SaaS 的 app_code 是 bk_monitorv3，后台模块是 bkmonitorv3。更新时，需要先更新 SaaS，数据库的 schema 更新维护是在 SaaS 完成，权限模型的更新也由 SaaS 控制。每次先更新 SaaS，然后更新后台。

```bash
# 更新 SaaS。前提是已将 bk_monitorv3 的 SaaS 包放置 src/official_saas/ 下
./bkcli install saas-o bk_monitorv3

# 更新后台
./bkcli upgrade bkmonitorv3
```

### 日志平台更新

日志平台 SaaS 的 app_code 是 bk_log_search，后台模块是 bklog。数据库的 schema 更新维护是在 SaaS 完成，权限模型的更新也由 SaaS 控制。每次先更新 SaaS，然后更新后台。

```bash
# 更新 SaaS。前提是已将 bk_log_search 的 SaaS 包放置 src/official_saas/ 下
./bkcli install saas-o bk_log_search

# 更新后台
./bkcli upgrade bklog
```

### agent 插件更新

1. 上传到中控机 src/gse_plugins/ 下
2. 刷新插件包到节点管理中
```bash
./bkcli initdata bknodeman
```