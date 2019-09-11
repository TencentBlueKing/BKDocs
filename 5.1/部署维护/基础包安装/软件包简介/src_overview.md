## 软件包内容概述

解压 `bkce_src-xx.tar.gz` 安装包后，`src` 即为软件包目录，存放了蓝鲸基础平台、官方 SaaS 包、开源组件等内容。

```bash
[root@nginx-1 src]# tree -F -L 1
.
├── bkdata/
├── bknetwork/
├── blueking.env
├── cert/
├── cmdb/
├── ENTERPRISE
├── fta/
├── gse/
├── job/
├── license/
├── MD5
├── miniweb/
├── official_saas/
├── open_paas/
├── paas_agent/
├── service/
└── VERSION
```

### 软件包内容说明

蓝鲸基础平台及 SaaS 详细说明请参考 [产品白皮书](https://bk.tencent.com/docs/)，开源组件版本和配置方式可参考 [附录](../../附录/开源组件版本/version.md)。

- **VERSION**：社区版版本号文件。
- **ENTERPRISE**：代号文件，社区版默认都是 **blueking**。
- **MD5**：MD5 校验文件。
- **blueking.env**：证书环境变量。
- **cert/**：放置证书文件的目录。
- **license/**：鉴权服务器。
- **miniweb/**：空目录，安装时会动态生成一些脚本和配置文件到这里。
- **service/**：开源组件存放目录。
- **open_paas/**：PaaS 后台。
- **paas_agent/**：SaaS 部署后台。
- **official_saas/**：官方 SaaS 包，可以在后台一键部署蓝鲸官方 SaaS。
- **cmdb/**：配置平台后台。
- **job/**：作业平台后台。
- **gse/**：管控平台后台。
- **bkdata**：数据平台基础模块存放路径，包含 dataapi，databus，monitor 三个子工程。
- **dataapi/**：数据平台 API 接口服务。
- **databus/**：数据平台总线服务。
- **monitor/**：蓝鲸监控后台服务。
- **fta**：故障自愈后台。
- **bknetwork**：网络管理 SaaS 的后台模块。


### 软件包目录结构

请按照目录结构检查对应文件目录是否存在：

> **Note：** .pip 是 pip 源的配置文件，由于兼容前后版本，在软件包和部署脚本包多个地方都存在，可以忽略。社区版 V5.1 版本的 pip 源配置文件整合到 install 目录中。

```bash
[root@nginx-1 src]# tree -F -L 1
.
├── bkdata/
├── bknetwork/
├── blueking.env
├── cert/
├── cmdb/
├── ENTERPRISE
├── fta/
├── gse/
├── job/
├── license/
├── MD5
├── miniweb/
├── official_saas/
├── open_paas/
├── paas_agent/
├── service/
└── VERSION
```

上面这层目录称为模块，模块下面会有子工程，称为 `project` ，比如 BKDATA 模块下：

```bash
[root@nginx-1 bkdata]# tree -F -L 1 . support-files/
.
├── dataapi/
├── databus/
├── monitor/
└── support-files/
support-files/
├── pkgs/
├── README.md
├── scripts/
├── sql/
└── templates/
```

这里重点介绍下 `support-files/` 目录：

- **pkgs**： 存放依赖包，比如 Python 工程的 pip 包。

- **scripts**： 存放该模块依赖的工具脚本、crontab 记录等。

- **sql**： 存放初始或者升级时用到的 sql 文件。

- **templates**： 存放模块的模板文件，安装时会替换里面的 类似 `__VAR_NAME__`： 形式的变量。
