# 单产品更新
我们在推出 7.0.0 版本后，对其中部分平台进行了更新。


## 更新 bk-apigateway
|  | chart version | app version |
|--|--|--|
| 7.0.0 | 0.4.48 | 1.1.32 |
| 本次更新 | 0.4.48-patch.1 | 1.1.32-patch.1 |

本版本为 **安全** 补丁更新，基于原代码修复，不涉及功能新增。我们希望用户尽快更新。

登录到 **中控机**，先更新 helm 仓库：
``` bash
helm repo update
```
使用 `helm search repo bk-apigateway -l --devel` 命令确认版本信息，预期输出含有如下的行：
``` plain
NAME                  	CHART VERSION 	APP VERSION   	DESCRIPTION
blueking/bk-apigateway	0.4.48-patch.1	1.1.32-patch.1	A full stack chart for Apigateway Enterprise pr...
```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `0.4.48-patch.1`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "0.4.48-patch.1"/' environments/default/version.yaml
```
检查修改结果： `grep bk-apigateway environments/default/version.yaml`，预期输出：
``` yaml
  bk-apigateway: "0.4.48-patch.1"
```

更新 bk-apigateway:
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
``` plain
UPDATED RELEASES:
NAME            CHART                           VERSION
bk-apigateway   blueking/bk-apigateway   0.4.48-patch.1
```


## 更新 bk-monitor
|  | chart version | app version |
|--|--|--|
| 7.0.0 | 3.6.76 | 3.6.3062 |
| 本次更新 | 3.6.79 | 3.6.3522 |

本版本为补丁更新，主要解决已知问题，增加稳定性及兼容性，不涉及功能新增。

登录到 **中控机**，先更新 helm 仓库：
``` bash
helm repo update
```
使用 `helm search repo bk-monitor -l` 命令确认版本信息，预期输出含有如下的行：
``` plain
NAME           	    CHART VERSION	APP VERSION 	DESCRIPTION
blueking/bk-monitor	3.6.79       	3.6.3522  	    略
```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-monitor charts version 为 `3.6.79`：
``` bash
sed -i 's/bk-monitor:.*/bk-monitor: "3.6.79"/' environments/default/version.yaml
```
检查修改结果： `grep bk-monitor environments/default/version.yaml`，预期输出：
``` yaml
  bk-monitor: "3.6.79"
```

更新 bk-monitor:
``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
``` plain
UPDATED RELEASES:
NAME            CHART                   VERSION
bk-bkmonitor    blueking/bk-bkmonitor   3.6.79
```

接下来开始更新 `bkmonitorbeat` 插件：
``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-stable/bkdl-7.0-stable.sh | bash -s -- -ur latest bkmonitorbeat=2.13.1.269
./scripts/setup_bkce7.sh -u plugin
```
然后在节点管理中更新所有 Agent 的插件到 `2.13.1.269` 版本。


## 更新 bk-job

|  | chart version | app version |
|--|--|--|
| 7.0.0 | 0.2.6 | 3.5.1 |
| 本次更新 | 0.3.2-rc.3 | 3.6.2-rc.3 |

本版本为功能更新，细节见产品内版本日志。亮点功能为：
* 支持滚动执行。
* 支持搜索脚本内容。

登录到 **中控机**，先更新 helm 仓库：
``` bash
helm repo update
```
使用 `helm search repo bk-job -l --devel` 命令确认版本信息，预期输出含有如下的行：
``` plain
NAME           	CHART VERSION	APP VERSION 	DESCRIPTION
blueking/bk-job	0.3.2-rc.3   	3.6.2-rc.3  	略
```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-job charts version 为 `0.3.2-rc.3`：
``` bash
sed -i 's/bk-job:.*/bk-job: "0.3.2-rc.3"/' environments/default/version.yaml
```
检查修改结果： `grep bk-job environments/default/version.yaml`，预期输出：
``` yaml
  bk-job: "0.3.2-rc.3"
```

更新 bk-job：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
``` plain
UPDATED RELEASES:
NAME     CHART                VERSION
bk-job   blueking/bk-job   0.3.2-rc.3
```


## 更新标准运维

本更新为功能更新，细节见产品内版本日志。亮点功能为：
* 子流程节点重试、跳过。
* 支持作业平台滚动执行。

下载适用于蓝鲸 7.0 的安装包：
* [bk_sops-V3.26.6.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_sops/bk_sops-V3.26.6.tar.gz)

参考 《[部署标准运维（bk_sops）](install-saas-manually.md#deploy-bkce-saas-sops)》 文档上传安装包，并部署到生产环境。

>**注意**
>
>标准运维有 4 个模块需要部署。

全部模块部署成功后，即可在桌面访问了。
