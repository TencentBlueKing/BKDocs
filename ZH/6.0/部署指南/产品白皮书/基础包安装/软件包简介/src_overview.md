# 软件包内容概述

解压 `bkce_src-6.0.x.tgz` 安装包后，`src` 即为软件包目录，存放了蓝鲸基础平台、官方 SaaS 包、开源组件等内容。

## 软件包目录结构

请按照目录结构检查对应文件目录是否存在，版本号会随着每次更新而变更，请以官网下载的实际版本号为准：

```bash
[root@VM-0-1 src]# pwd
/data/src
[root@VM-0-1 src]# tree -F -L 1
.
├── bkiam_ce-1.x.xtgz
├── bklog_ce-4.x.x-bkofficial.tgz
├── bkmonitorv3_ce-3.x.x-bkofficial.tgz
├── bknodeman_ce-2.x.x-bkofficial.tgz
├── bkssm_ce-1.x.x.tgz
├── blueking.env
├── cmdb_ce-3.x.x.tgz
├── COMMON_VERSION
├── fta_solutions_ce-5.x.x.tar.gz
├── gse_ce-3.x.x.tgz
├── gse_plugins/
├── java8.tgz
├── job_ce-3.x.x.x.tgz
├── license_ce-3.x.x.tgz
├── MD5
├── official_saas/
├── open_paas_ce-2.x.x-bkofficial.tgz
├── paas_agent_ce-3.x.x.tgz
├── usermgr_ce-2.x.x-bkofficial.tar.gz
├── VERSION
└── yum/
```

上面这层目录称为模块，模块下面会有子工程，称为 `project` ，比如 open_paas 模块下：

```bash
[root@nginx-1 open_paas]# pwd
/data/src/open_paas
[root@nginx-1 open_paas]# tree -F -L 1 . support-files/
.
├── apigw/
├── appengine/
├── bin/
├── cert/
├── esb/
├── login/
├── paas/
├── projects.yaml
├── release.md
├── support-files/
└── VERSION
support-files/
├── bkiam/
├── pkgs/
├── sql/
└── templates/
```

这里重点说明下 `support-files/` 目录：

- **bkiam**: 存放初始化权限文件。
- **pkgs**： 存放依赖包，比如 Python 工程的 pip 包。
- **sql**： 存放初始或者升级时用到的 sql 文件。
- **templates**： 存放模块的模板文件，安装时会替换里面的 类似 `__VAR_NAME__`： 形式的变量。

## 软件包内容说明

蓝鲸基础平台及 SaaS 详细说明请参考 [产品白皮书](https://bk.tencent.com/docs/)，开源组件版本和配置方式可参考版本日志。

- **bkiam：** 权限中心后台
- **bklog：** 日志平台后台
- **bkmonitorv3：** 监控平台后台
- **bknodeman：** 节点管理后台
- **bkssm：** 凭证管理后台
- **blueking.env：** 证书环境变量
- **cert：** 证书文件目录
- **cmdb：** 配置平台后台
- **COMMON_VERSION：** 开源组件包版本号
- **fta：** 故障自愈后台
- **gse：** 管控平台后台
- **gse_plugins：** 采集器官方插件目录
- **image：** SaaS 镜像目录
- **java8.tgz：** java 文件
- **job：** 作业平台后台
- **license：** 鉴权服务
- **MD5：** MD5 校验文件
- **official_saas：** 官方 SaaS 包
- **open_paas：** PaaS 后台
- **paas_agent：** SaaS 部署后台
- **python：** 蓝鲸定制 Python 解释器
- **usermgr：** 用户管理后台
- **VERSION：** 社区版版本号
- **yum：** 开源组件 RPM 包

