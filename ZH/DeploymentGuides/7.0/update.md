# 单产品更新
我们在蓝鲸 7.0.0 版本发布后，为部分产品提供了新版本，详见各项目下的更新信息表格。

在 2023 年 4 月 11 日，我们发布了蓝鲸 7.0.1 版本，仅包含补丁级更新。

## 更新 bk-applog
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 1.1.2 | 1.1.0 |
| 20230914 补丁更新 | 1.1.10 | 1.1.0 |

### 20230914 补丁更新
本版本仅为 **补丁** 更新，修复了一些问题。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bkapp-log-collection --version 1.1.10
```
预期输出如下所示：
>``` plain
>NAME                         	CHART VERSION	APP VERSION	DESCRIPTION
>blueking/bkapp-log-collection	1.1.10       	1.1.0      	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-nodeman charts version 为 `2.2.33`：
``` bash
sed -i 's/bkapp-log-collection:.*/bkapp-log-collection: "1.1.10"/' environments/default/version.yaml
grep bkapp-log-collection environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bkapp-log-collection: "1.1.10"
>```

更新 bk-applog:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-applog apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME        CHART                VERSION
>bk-applog   blueking/bk-applog   1.1.10
>```


## 更新 bk-nodeman
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 2.2.27 | 2.2.27 |
| 20230822 补丁更新 | 2.2.33 | 2.2.33 |

### 20230822 补丁更新
本版本仅为 **补丁** 更新，修复了一些问题。具体变动见 https://github.com/TencentBlueKing/bk-nodeman/releases/tag/v2.2.33 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-nodeman --version 2.2.33
```
预期输出如下所示：
>``` plain
>NAME               	CHART VERSION	APP VERSION	DESCRIPTION
>blueking/bk-nodeman	2.2.33       	2.2.33     	NodeMan is an application that helps operation ...
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-nodeman charts version 为 `2.2.33`：
``` bash
sed -i 's/bk-nodeman:.*/bk-nodeman: "2.2.33"/' environments/default/version.yaml
grep bk-nodeman environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-nodeman: "2.2.33"
>```

更新 bk-nodeman:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-nodeman apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME         CHART                 VERSION
>bk-nodeman   blueking/bk-nodeman   2.2.33
>```


## 更新 bk-console
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 0.1.0 | 0.1.0 |
| 20230822 补丁更新 | 0.1.1-beta.3 | 0.1.1 |

### 20230822 补丁更新
本版本仅为 **补丁** 更新，修复了一些问题。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-console --version 0.1.1-beta.3
```
预期输出如下所示：
>``` plain
>NAME               	CHART VERSION	APP VERSION	DESCRIPTION
>blueking/bk-console	0.1.1-beta.3 	0.1.1      	A Helm chart for Kubernetes
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-console charts version 为 `0.1.1-beta.3`：
``` bash
sed -i 's/bk-console:.*/bk-console: "0.1.1-beta.3"/' environments/default/version.yaml
grep bk-console environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-console: "0.1.1-beta.3"
>```

更新 bk-console:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-console apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME         CHART                 VERSION
>bk-console   blueking/bk-console   0.1.1-beta.3
>```



## 更新流程服务
|  | 软件版本号 |
|--|--|
| 7.0.0 发布 | 2.6.2 |
| 20230822 功能更新 | 2.6.7 |

### 20230822 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/master/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.7.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.7.tar.gz)

参考 《[部署流程服务（bk_itsm）](install-saas-manually.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。


## 更新 bk-cmdb
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 3.11.17 | 3.10.21 |
| 20230822 补丁更新 | 3.11.42 | 3.10.41 |

### 20230822 补丁更新
本版本仅为 **补丁** 更新。主要修复了一些导入问题及界面问题，并对一些逻辑进行了优化。具体变动见 https://github.com/TencentBlueKing/bk-cmdb/blob/v3.10.x/docs/support-file/changelog/release.md 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-cmdb --version 3.11.42
```
预期输出如下所示：
>``` plain
>NAME            	CHART VERSION	APP VERSION	DESCRIPTION
>blueking/bk-cmdb	3.11.42      	3.10.41    	BlueKing Configuration Management DataBase (bk-...
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-cmdb charts version 为 `3.11.42`：
``` bash
sed -i 's/bk-cmdb:.*/bk-cmdb: "3.11.42"/' environments/default/version.yaml
grep bk-cmdb environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-cmdb: "3.11.42"
>```

更新 bk-cmdb:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-cmdb apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART              VERSION
>bk-cmdb   blueking/bk-cmdb   3.11.42
>```


## 更新 bcs-services-stack
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 1.27.0 | 1.27.0 |
| 20230511 安全及功能更新 | 1.28.0 | 1.28.0 |

### 20230511 安全及功能更新
本版本包含 **安全** 及 **功能** 更新。我们希望用户尽快更新。

登录到 **中控机**，先检查 bk-apigateway 的版本：
``` bash
helm list -A -l name=bk-apigateway
```
查看 `CHART` 列里的版本号，预期大于等于 `0.4.57`。因为 BCS 依赖新版本的 crd 定义。

待 bk-apigateway 版本满足依赖后，可以开始更新了。如版本如低于预期，请参考本文档先更新 bk-apigateway。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

>**提示**
>
>如需备份数据库，可先查阅 《[访问入口及账户密码汇总](access.md)》文档里关于 BCS 的部分，然后参考如下指引进行备份：
>``` bash
># mysql备份 bcs, bcs-app, bcs-cc, bcsremotecommand 等数据库
>mysqldump -u user -P3306 -p密码 -h主机 DB名 --max_allowed_packet=100M > DB名.sql
># mongo备份整个数据库, 如果希望dump到单个文件，可以使用 --archive 参数，详见 mongodb 文档。
>mongodump mongodb://root:密码@/bcs-mongodb服务地址?authSource=admin
>```

先下载 helmfile 补丁文件：
>**提示**
>
>下载脚本会直接覆盖工作目录下的这些文件：（如果有修改请自行备份。）
> * `03-bcs.yaml.gotmpl`
> * `environments/default/bcs/values.yaml.gotmpl`
> * `scripts/get_bcs_passwd.sh`

``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-stable/bkdl-7.0-stable.sh | bash -s -- -ur 7.0.1 bcs_helmfile_patch=1.28
```

更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bcs-services-stack -l --version 1.28.0
```
预期输出如下所示：
>``` plain
>NAME                           CHART VERSION   APP VERSION DESCRIPTION
>blueking/bcs-services-stack    1.28.0          v1.28.0     A Helm chart for BlueKing Container Service top...
>```

修改 `environments/default/version.yaml` 文件，配置 bcs-services-stack charts version 为 `1.28.0`：
``` bash
sed -i 's/bcs-services-stack:.*/bcs-services-stack: "1.28.0"/' environments/default/version.yaml
grep bcs-services-stack environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bcs-services-stack: "1.28.0"
>```

更新 bcs-services-stack:
``` bash
helmfile -f 03-bcs.yaml.gotmpl sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME                 CHART                         VERSION
>bcs-services-stack   blueking/bcs-services-stack   1.28.0
>```

如果部署失败请先查阅 《[问题案例](troubles.md#install-bcs)》文档。

接下来需要确保你的电脑能解析新增域名 `bcs-api.$BK_DOMAIN`，操作步骤已经并入《基础套餐部署》文档的 “[配置用户侧的 DNS](install-bkce.md#hosts-in-user-pc)” 章节。

配置成功后，即可在桌面打开 “容器管理平台” 应用了。如果未配置 `bcs-api` 域名，页面会出现报错 `网络错误`。


## 更新 bk-apigateway
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 0.4.48 | 1.1.32 |
| 20230410 安全更新 | 0.4.48-patch.1 | 1.1.32-patch.1 |
| 7.0.1 发布 | 0.4.48-patch.1 | 1.1.32-patch.1 |
| 20230511 安全及功能更新 | 0.4.65-beta.1 | 1.1.47-beta.1 |

### 20230511 安全及功能更新
本版本包含 **安全** 及 **功能** 更新，整体保持兼容，部分功能有微调。因为 BCS-1.28 版本修复安全问题，需要升级到此版本，我们希望用户尽快更新。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-apigateway --version 0.4.65-beta.1
```
预期输出如下所示：
>``` plain
>NAME                  	CHART VERSION 	APP VERSION   	DESCRIPTION
>blueking/bk-apigateway	0.4.65-beta.1   1.1.47-beta.1   A full stack chart for Apigateway Enterprise pr...
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `0.4.65-beta.1`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "0.4.65-beta.1"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "0.4.65-beta.1"
>```

更新 bk-apigateway:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME            CHART                          VERSION
>bk-apigateway   blueking/bk-apigateway   0.4.65-beta.1
>```

### 20230410 安全更新
本版本为 **安全** 补丁更新，基于原代码修复，不涉及功能新增。我们希望用户尽快更新。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-apigateway --version 0.4.48-patch.1
```
预期输出如下所示：
>``` plain
>NAME                  	CHART VERSION 	APP VERSION   	DESCRIPTION
>blueking/bk-apigateway	0.4.48-patch.1	1.1.32-patch.1	A full stack chart for Apigateway Enterprise pr...
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `0.4.48-patch.1`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "0.4.48-patch.1"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "0.4.48-patch.1"
>```

更新 bk-apigateway:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME            CHART                           VERSION
>bk-apigateway   blueking/bk-apigateway   0.4.48-patch.1
>```


## 更新 bk-monitor
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 3.6.76 | 3.6.3062 |
| 20230316 补丁更新 | 3.6.79 | 3.6.3522 |
| 7.0.1 发布 | 3.6.79 | 3.6.3522 |

### 20230316 补丁更新
本版本为补丁更新，主要解决已知问题，增加稳定性及兼容性，不涉及功能新增。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-monitor --version 3.6.79
```
预期输出如下所示：
>``` plain
>NAME                 CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-monitor  3.6.79         3.6.3522     略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-monitor charts version 为 `3.6.79`：
``` bash
sed -i 's/bk-monitor:.*/bk-monitor: "3.6.79"/' environments/default/version.yaml
grep bk-monitor environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-monitor: "3.6.79"
>```

更新 bk-monitor:
``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME            CHART                   VERSION
>bk-bkmonitor    blueking/bk-bkmonitor   3.6.79
>```

接下来开始更新 `bkmonitorbeat` 插件：
``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-stable/bkdl-7.0-stable.sh | bash -s -- -ur latest bkmonitorbeat=2.13.1.269
./scripts/setup_bkce7.sh -u plugin
```
最后在节点管理中更新所有 Agent 的插件到 `2.13.1.269` 版本即可。


## 更新 bk-job

|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.0.0 发布 | 0.2.6 | 3.5.1 |
| 20230310 功能更新 | 0.3.2-rc.3 | 3.6.2-rc.3 |

### 20230310 功能更新
本版本为功能更新，细节见产品内版本日志。亮点功能为：
* 支持滚动执行。
* 支持搜索脚本内容。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-job --version 0.3.2-rc.3
```
预期输出如下所示：
>``` plain
>NAME           	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bk-job	0.3.2-rc.3   	3.6.2-rc.3  	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-job charts version 为 `0.3.2-rc.3`：
``` bash
sed -i 's/bk-job:.*/bk-job: "0.3.2-rc.3"/' environments/default/version.yaml
grep bk-job environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-job: "0.3.2-rc.3"
>```

更新 bk-job：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME     CHART                VERSION
>bk-job   blueking/bk-job   0.3.2-rc.3
>```


## 更新标准运维
|  | 软件版本号 |
|--|--|
| 7.0.0 发布 | 3.25.12 |
| 20230310 功能更新 | 3.26.6 |

### 20230310 功能更新
本更新为功能更新，细节见产品内版本日志。亮点功能为：
* 子流程节点重试、跳过。
* 支持作业平台滚动执行（ 依赖 `bk-job` 软件版本号 `>=3.6.0` ）。

下载适用于蓝鲸 7.0 的安装包：
* [bk_sops-V3.26.6.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_sops/bk_sops-V3.26.6.tar.gz)

参考 《[部署标准运维（bk_sops）](install-saas-manually.md#deploy-bkce-saas-sops)》 文档上传安装包，并部署到生产环境。

>**注意**
>
>标准运维有 4 个模块需要部署。

全部模块部署成功后，即可在桌面访问了。
