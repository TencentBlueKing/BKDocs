# 单产品更新
我们在蓝鲸 7.1.0 版本发布后，为部分产品提供了新版本，详见各项目下的更新信息表格。

## 更新流程服务
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.6.6 |
| 20230822 补丁更新 | 2.6.7 |

### 20230822 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/master/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.7.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.7.tar.gz)

参考 《[部署流程服务（bk_itsm）](install-saas-manually.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。


## GSE Agent
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
