# 单产品更新
我们在蓝鲸 7.1.0 版本发布后，为部分产品提供了新版本，详见各项目下的更新信息表格。

## 更新蓝鲸运维开发平台（可视化开发平台）
|  | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 1.0.11 |
| 20231227 安全更新 | 1.0.14-beta.1 |

本更新为 **安全** 更新，包含安全问题及普通问题修复，我们希望用户尽快更新。

下载适用于蓝鲸 7.x 的安装包：
* [bk_lesscode-V1.0.14-beta.1.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_lesscode/bk_lesscode-V1.0.14-beta.1.tar.gz)

参考 《[更新安装包](manual-install-saas.md#更新安装包)》文档上传安装包，无需调整环境变量，直接选择新版本部署到生产环境。

部署成功后，即可在桌面访问了。


## 更新 bk-apigateway
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 1.12.1 | 1.12.1 |
| 20231031 补丁更新 | 1.12.7 | 1.12.7 |

### 20231031 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。
具体变动见：
* https://github.com/TencentBlueKing/blueking-apigateway/releases/tag/v1.12.7
* https://github.com/TencentBlueKing/blueking-apigateway-operator/releases/tag/v1.12.4

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-apigateway --version 1.12.7
```
预期输出如下所示：
>``` plain
>NAME                 	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bk-apigateway	1.12.7  	1.12.7    	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `1.12.7`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "1.12.7"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "1.12.7"
>```

更新 bk-apigateway：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME           CHART                   VERSION
>bk-apigateway  blueking/bk-apigateway  1.12.7
>```


## 更新 bkmonitor-operator
>**提示**
>
>bkmonitor-operator 的核心为 bkmonitorbeat 插件，请注意同时升级 GSE 插件版本。

|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 3.6.84 | 3.14.1190 |
| 20231031 补丁更新 | 3.6.92 | 3.20.1261 |

### 20231031 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bkmonitor-operator-stack --version 3.6.92
```
预期输出如下所示（此 chart 内填写的 APP VERSION 有误，以信息表为准）：
>``` plain
>NAME                            	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bkmonitor-operator-stack	3.6.92  	3.6.0    	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bkmonitor-operator-stack charts version 为 `3.6.92`：
``` bash
sed -i 's/bkmonitor-operator-stack:.*/bkmonitor-operator-stack: "3.6.92"/' environments/default/version.yaml
grep bkmonitor-operator-stack environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bkmonitor-operator-stack: "3.6.92"
>```

更新 bkmonitor-operator-stack：
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME                      CHART                              VERSION
>bkmonitor-operator-stack  blueking/bkmonitor-operator-stack  3.6.92
>```


## 更新 GSE 插件
bkmonitorbeat（请留意一并升级 bkmonitor-operator release）：
|  | 软件版本号 |
|--|--|
| 7.1.2 发布 | 3.14.1190 |
| 20231031 补丁更新 | 3.20.1261 |

bk-collector:
|  | 软件版本号 |
|--|--|
| 7.1.2 发布 | 0.30.1193 |
| 20231031 补丁更新 | 0.34.1292 |

### 20231031 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。

在中控机下载插件包：
``` bash
bkdl-7.1-stable.sh -ur latest bkmonitorbeat=3.20.1261 bk-collector=0.34.1292
```
并上传到节点管理：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u plugin
```

在蓝鲸桌面打开 节点管理 应用，默认位于 “节点管理” 界面，侧栏选择 “插件包”。点击插件名字，即可看到新的版本号。

升级 bkmonitorbeat：
1. 确认“插件包”展示的版本正确。
2. 进入“插件状态”界面，选择运行旧插件的 Agent。点击 “安装/更新” 按钮，选择插件为 bkmonitorbeat，开始升级。

当然，也可以参考节点管理产品文档了解 “插件部署” 功能，实现自动升级。

升级 bk-collector：<br />
监控平台会定期检查 bk-collector 版本，并调用节点管理发起更新。此更新并不紧急，如果依旧希望主动安装，可以阅读 [《监控部署文档》的 “安装 bk-collector” 章节](./install-co-suite.md#安装%20bk-collector)。

## 更新流程服务
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.6.6 |
| 20230822 补丁更新 | 2.6.7 |
| 7.1.2 发布 | 2.6.7 |
| 20231227 安全更新 | 2.6.8 |

### 20231227 安全更新
本更新为 **安全** 更新，包含安全问题及普通问题修复，我们希望用户尽快更新。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/master/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.8.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.8.tar.gz)

参考 《[部署流程服务（bk_itsm）](manual-install-saas.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。

### 20230822 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/master/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.7.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.7.tar.gz)

参考 《[部署流程服务（bk_itsm）](manual-install-saas.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。


## 更新 GSE Agent
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.1.2-beta.20 |
| 20230808 补丁更新 | 2.1.3-beta.3 |

### 20230808 补丁更新
本次主要修复了 job 普通用户传输文件时丢失可执行权限的问题。

登录到 **中控机**，下载 GSE Agent 2.1.3-beta.3 版本：
``` bash
bkdl-7.1-stable.sh -ur latest gsec=2.1.3-beta.3
```

上传 Agent 到 节点管理：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u agent
```

随后访问“节点管理”，在 “Agent 状态”界面勾选待升级的 Agent，展开“批量”菜单，选择“升级”，即可进入升级界面。

遵循界面指引完成升级过程，等待 Agent 上报新的版本号，即升级完成。


## 更新 bk-user

|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.0 发布 | 1.4.14-beta.1 | 2.5.4-beta.1 |
| 20230815 功能更新 | 1.4.14-beta.7 | 2.5.4-beta.7 |

### 20230815 功能更新
本版本为问题修复。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-user --version 1.4.14-beta.7
```
预期输出如下所示：
>``` plain
>NAME            	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bk-user	1.4.14-beta.7	v2.5.4-beta.7  	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-user charts version 为 `1.4.14-beta.7`：
``` bash
sed -i 's/bk-user:.*/bk-user: "1.4.14-beta.7"/' environments/default/version.yaml
grep bk-user environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-user: "1.4.14-beta.7"
>```

更新 bk-user：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-user apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART              VERSION
>bk-user   blueking/bk-user   1.4.14-beta.7
>```
