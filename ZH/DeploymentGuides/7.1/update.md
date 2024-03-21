# 单产品更新
我们在蓝鲸 7.1.0 版本发布后，为部分产品提供了新版本，详见各项目下的更新信息表格。


## 更新节点管理
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 2.3.5 | 2.3.5 |
| 20240320 功能更新 | 2.4.4 | 2.4.4 |

### 20240320 功能更新
本更新为 **功能** 更新，本版本优化了 “Agent 状态” 界面的状态同步速度，**推荐升级**。版本日志见 https://github.com/TencentBlueKing/bk-nodeman/releases/tag/v2.4.4 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-nodeman --version 2.4.4
```
预期输出如下所示（此 chart 内填写的 APP VERSION 有误，以信息表为准）：
>``` plain
>NAME                 CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-nodeman  2.4.4          2.4.4        略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-nodeman charts version 为 `2.4.4`：
``` bash
sed -i 's/bk-nodeman:.*/bk-nodeman: "2.4.4"/' environments/default/version.yaml
grep bk-nodeman environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-nodeman: "2.4.4"
>```

更新 bk-nodeman：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-nodeman sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART                VERSION
>blueking  blueking/bk-nodeman  2.4.4
>```


## 更新 GSE 服务端
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 2.1.3-beta.11 | 2.1.3-beta.11 |
| 20240320 功能更新 | 2.1.5-beta.7 | 2.1.5-beta.7 |

### 20240320 功能更新
本更新为 **功能** 更新，包含一些新的功能。

>**注意**
>
>本升级存在数据变更，回退操作暂未外发文档，请慎重评估是否升级。现阶段此升级仅供部分灰度用户使用。

登录到 **中控机**，先检查当前运行的 bk-apigateway 的版本：
``` bash
helm list -A -l name=bk-apigateway
```
查看 `CHART` 列里的版本号，预期大于等于 `1.12.10`。因为 bk-gse-2.1.3-beta.19 变更了注册到网关的环境变量名，而 bk-apigateway-1.12.10 才允许引用不存在的变量。如版本如低于预期，请参考本文档先更新 bk-apigateway。

更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-gse-ce --version 2.1.5-beta.7
```
预期输出如下所示：
>``` plain
>NAME                CHART VERSION  APP VERSION    DESCRIPTION
>blueking/bk-gse-ce  v2.1.5-beta.7  v2.1.5-beta.7  略
>```

接下来开始升级了。

进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

>**注意**
>
>升级期间可能导致 Pod 漂移到其他主机。

提前记录 Pod 所在主机名，并配置 nodeSelector 规则写入 `environments/default/bkgse-ce-custom-values.yaml.gotmpl`，确保不会调度到其他 node 上。
``` bash
node_gse_data=$(kubectl get pod -A -l app=gse-data -o jsonpath='{.items[0].spec.nodeName}')
node_gse_file=$(kubectl get pod -A -l app=gse-file -o jsonpath='{.items[0].spec.nodeName}')
node_gse_task=$(kubectl get pod -A -l app=gse-cluster -o jsonpath='{.items[0].spec.nodeName}')

touch environments/default/bkgse-ce-custom-values.yaml.gotmpl
yq -i ".nodeSelector = {\"kubernetes.io/os\":\"linux\"} |
.gseData.nodeSelector = {\"kubernetes.io/hostname\": \"$node_gse_data\"} |
.gseFile.nodeSelector = {\"kubernetes.io/hostname\": \"$node_gse_file\"} |
.gseCluster.nodeSelector = {\"kubernetes.io/hostname\": \"$node_gse_task\"}" environments/default/bkgse-ce-custom-values.yaml.gotmpl
```

>**注意**
>
>请严格遵循如下步骤操作。如果遗漏路由迁移步骤，会导致数据中断，补充操作即可。

1.  先在蓝鲸 k8s 集群的 default namespace 中，启动一个新版本 gse 镜像的 pod，来监听 channelid 路由（此处使用蓝鲸预置的 zk 服务，如为独立部署请按需调整）：
    ``` bash
    gse_zk_token=$(helm get values -n blueking bk-gse | yq '.externalZookeeper.token')
    kubectl run watch-gse-channelid --restart=Never --image hub.bktencent.com/blueking/bk-gse-server-ce:v2.1.5-beta.7 --command -- /data/bkce/gse/server/bin/route_migrate --v1-zk-host bk-zookeeper.blueking:2181 --v1-zk-token "${gse_zk_token}" --v2-zk-host bk-zookeeper.blueking:2181 --v2-zk-token "${gse_zk_token}" -c watch-v1-to-v2
    ```
2.  上一步运行后，pod 会持续监听旧 channelid 中的新增 zk 节点变动，并转化写入到 v2 的路径下。确保变更过程中，新增的 dataid 信息不会遗漏。接着运行一个一次性命令，来同步存量的 channelid 到新的 v2 路径下：
    ``` bash
    gse_zk_token=$(helm get values -n blueking bk-gse | yq '.externalZookeeper.token')
    kubectl run tmp-gse-channelid --env="gse_zk_token=$gse_zk_token" -it --image hub.bktencent.com/blueking/bk-gse-server-ce:v2.1.5-beta.7 bash
    # 进入交互式shell后，运行以下命令。耐心等待。
    /data/bkce/gse/server/bin/route_migrate --v1-zk-host bk-zookeeper.blueking:2181 --v1-zk-token "${gse_zk_token}" --v2-zk-host bk-zookeeper.blueking:2181 --v2-zk-token "${gse_zk_token}" -c v1-to-v2
    ```
3.  待上述命令执行完毕后，检查 `logs/bk-gse-route-migrate-system.INFO` 文件结尾 `make migrate from 1.0 to 2.0 done (1.0 route 数量1 streamto 3, 2.0 route 数量2 streamto 3 success, cost 秒数 seconds`，确保 2 个数量一致，如果不一致，可以重复执行。或检查 `bk-gse-route-migrate-system.ERROR` 文件内容。
4.  按正常的升级 helm chart 的方法，升级到 gse v2.1.5 版本以上。
    修改 `environments/default/version.yaml` 文件，配置 bk-gse-ce charts version 为 `v2.1.5-beta.7`：
    ``` bash
    sed -i 's/bk-gse-ce:.*/bk-gse-ce: "v2.1.5-beta.7"/' environments/default/version.yaml
    grep bk-gse-ce environments/default/version.yaml  # 检查修改结果
    ```
    预期输出：
    >``` yaml
    >  bk-gse-ce: "v2.1.5-beta.7"
    >```

    更新 bk-gse：
    ``` bash
    helmfile -f base-blueking.yaml.gotmpl -l name=bk-gse sync
    ```

    等待命令执行完毕，结尾输出如下即为更新成功：
    >``` plain
    >UPDATED RELEASES:
    >NAME      CHART             VERSION
    >blueking  blueking/bk-gse-ce  　
    >```
5.  确认数据上报正常后，可以删除上面 1，2 步创建的 pod。

升级了服务端后，然后升级节点管理到 2.4.4 版本，最终升级 GSE Agent。


## 更新权限中心
bkiam
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 0.2.5 | 1.12.6 |
| 20240320 补丁更新 | 0.2.10 | 1.12.11 |

bkiam-saas
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 0.2.15 | 1.10.9 |
| 20240320 补丁更新 | 0.2.28 | 1.10.22 |

bkiam-search-engine
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 0.1.2 | 1.1.2 |
| 20240320 补丁更新 | 0.1.3 | 1.1.3 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见：
* https://github.com/TencentBlueKing/bk-iam/releases/tag/v1.12.11
* https://github.com/TencentBlueKing/bk-iam-saas/releases/tag/v1.10.22
* https://github.com/TencentBlueKing/bk-iam-search-engine/releases/tag/v1.1.3

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bkiam --version 0.2.10
helm search repo bkiam-saas --version 0.2.28
helm search repo bkiam-search-engine --version 0.1.3
```
预期输出如下所示（此处汇总展示）：
>``` plain
>NAME                          CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bkiam                0.2.10         v1.12.11     略
>blueking/bkiam-saas           0.2.28         v1.10.22     略
>blueking/bkiam-search-engine  0.1.3          v1.1.3       略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件中的版本号：
``` bash
sed -i -e 's/bkiam:.*/bkiam: "0.2.10"/' -e 's/bkiam-saas:.*/bkiam-saas: "0.2.28"/' -e 's/bkiam-search-engine:.*/bkiam-search-engine: "0.1.3"/' environments/default/version.yaml
grep bkiam environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bkiam: "0.2.10"
>  bkiam-saas: "0.2.28"
>  bkiam-search-engine: "0.1.3"
>```

更新 helm release：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam -l name=bk-iam-saas -l name=bk-iam-search-engine sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME                  CHART                         VERSION
>bk-iam-search-engine  blueking/bkiam-search-engine  0.1.3
>bk-iam                blueking/bkiam                0.2.10
>bk-iam-saas           blueking/bkiam-saas           0.2.28
>```


## 更新配置平台
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 3.12.2 | 3.11.2 |
| 20240320 补丁更新 | 3.12.3 | 3.11.3 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见 https://github.com/TencentBlueKing/bk-cmdb/blob/v3.11.x/docs/support-file/changelog/release.md 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-cmdb --version 3.12.3
```
预期输出如下所示：
>``` plain
>NAME              CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-cmdb  3.12.3         3.11.3       略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-cmdb charts version 为 `3.12.3`：
``` bash
sed -i 's/bk-cmdb:.*/bk-cmdb: "3.12.3"/' environments/default/version.yaml
grep bk-cmdb environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-cmdb: "3.12.3"
>```

更新 bk-cmdb：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-cmdb sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART             VERSION
>blueking  blueking/bk-cmdb  3.12.3
>```


## 更新作业平台
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 0.4.6-rc.1 | 3.7.6-rc.1 |
| 20240320 功能更新 | 0.5.8-rc.1 | 3.8.8-rc.1 |

### 20240320 功能更新
本更新为 **功能** 更新。版本日志见 https://github.com/Tencent/bk-job/releases/tag/v3.8.8-rc.1 。

>**提示**
>
>为了和蓝鲸 6.2 版本对齐，蓝鲸 7.1 版本的作业平台也升级为 3.8，并维护到 2024 年 10 月。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-job --version 0.5.8-rc.1
```
预期输出如下所示：
>``` plain
>NAME             CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-job  0.5.8-rc.1     3.8.8-rc.1   略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-job charts version 为 `0.5.8-rc.1`：
``` bash
sed -i 's/bk-job:.*/bk-job: "0.5.8-rc.1"/' environments/default/version.yaml
grep bk-job environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-job: "0.5.8-rc.1"
>```

修改 `environments/default/bkjob-custom-values.yaml.gotmpl` 文件，去掉 `job.features.gseV2.strategy` 配置项：
``` bash
touch environments/default/bkjob-custom-values.yaml.gotmpl
yq -i '.job.features.gseV2.strategy=null' environments/default/bkjob-custom-values.yaml.gotmpl
yq .job.features.gseV2 environments/default/bkjob-custom-values.yaml.gotmpl  # 检查修改结果
```
确认输出如下：
``` yaml
strategy: null
```

更新 bk-job：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART            VERSION
>blueking  blueking/bk-job  0.5.8-rc.1
>```

如果 Pod 出现 `CrashBackoffLoop` 状态，请检查日志中是否出现 `Unsupported toggle strategy ResourceScopeToggleStrategy`，此报错请参考上文修改配置后重新 sync release，其他报错请检查问题案例。


## 更新标准运维
|  | 软件版本号 |
|--|--|
| 7.1.2 发布 | 3.28.14 |
| 20240320 补丁更新 | 3.28.16 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见 https://github.com/TencentBlueKing/bk-sops/releases/tag/V3.28.16 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_sops-V3.28.16.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_sops/bk_sops-V3.28.16.tar.gz)

参考 《[部署标准运维（bk_sops）](manual-install-saas.md#deploy-bkce-saas-sops)》 文档上传安装包，并部署到生产环境。

>**注意**
>
>标准运维有 4 个模块需要部署。

全部模块部署成功后，即可在桌面访问了。

## 更新蓝盾平台
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 3.0.10-beta.2 | 2.0.0-beta.34 |
| 20240320 补丁更新 | 3.0.10-beta.3 | 2.0.2 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见 https://github.com/TencentBlueKing/bk-ci/blob/master/CHANGELOG/CHANGELOG-2.0.md 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-ci --version 3.0.10-beta.3
```
预期输出如下所示：
>``` plain
>NAME            CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-ci  3.0.10-beta.3  2.0.2        略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-ci charts version 为 `3.0.10-beta.3`：
``` bash
sed -i 's/bk-ci:.*/bk-ci: "3.0.10-beta.3"/' environments/default/version.yaml
grep bk-ci environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-ci: "3.0.10-beta.3"
>```

更新 bk-ci：
``` bash
helmfile -f 03-bkci.yaml.gotmpl sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART           VERSION
>blueking  blueking/bk-ci  3.0.10-beta.3
>```


## 更新监控平台
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 3.8.2 | 3.8.2 |
| 20240320 补丁更新 | 3.8.4 | 3.8.4 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-monitor --version 3.8.4
```
预期输出如下所示：
>``` plain
>NAME                 CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-monitor  3.8.4          3.8.4        略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-monitor charts version 为 `3.8.4`：
``` bash
sed -i 's/bk-monitor:.*/bk-monitor: "3.8.4"/' environments/default/version.yaml
grep bk-monitor environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-monitor: "3.8.4"
>```

更新 bk-monitor：
``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART                VERSION
>blueking  blueking/bk-monitor  3.8.4
>```


## 更新蓝鲸运维开发平台
|  | 软件版本号 |
|--|--|
| 7.1.2 发布 | 1.0.11 |
| 20231227 安全更新 | 1.0.14-beta.1 |
| 20240320 补丁更新 | 1.0.16 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。

下载适用于蓝鲸 7.x 的安装包：
* [bk_lesscode-V1.0.16.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_lesscode/bk_lesscode-V1.0.16.tar.gz)

参考 《[更新安装包](manual-install-saas.md#更新安装包)》文档上传安装包，无需调整环境变量，直接选择新版本部署到生产环境。

部署成功后，即可在桌面访问了。


### 20231227 安全更新
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
| 20240320 补丁更新 | 1.12.16 | 1.12.16 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见：
* https://github.com/TencentBlueKing/blueking-apigateway/releases/tag/v1.12.16
* https://github.com/TencentBlueKing/blueking-apigateway-operator/releases/tag/v1.12.7

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-apigateway --version 1.12.16
```
预期输出如下所示：
>``` plain
>NAME                    CHART VERSION  APP VERSION  DESCRIPTION
>blueking/bk-apigateway  1.12.16        v1.12.16     略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `1.12.16`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "1.12.16"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "1.12.16"
>```

更新 bk-apigateway：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART                   VERSION
>blueking  blueking/bk-apigateway  1.12.16
>```


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
>bkmonitor-operator 的核心为 bkmonitorbeat 插件，请注意同时升级“节点管理”中托管的插件。

|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.2 发布 | 3.6.84 | 3.14.1190 |
| 20231031 补丁更新 | 3.6.92 | 3.20.1261 |
| 20240307 功能更新 | 3.6.104 | 3.28.1542 |

### 20240307 功能更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bkmonitor-operator-stack --version 3.6.104
```
预期输出如下所示：
>``` plain
>NAME                            	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bkmonitor-operator-stack	3.6.104  	3.6.0    	略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bkmonitor-operator-stack charts version 为 `3.6.104`：
``` bash
sed -i 's/bkmonitor-operator-stack:.*/bkmonitor-operator-stack: "3.6.104"/' environments/default/version.yaml
grep bkmonitor-operator-stack environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bkmonitor-operator-stack: "3.6.104"
>```

更新 bkmonitor-operator-stack：
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME                      CHART                              VERSION
>bkmonitor-operator-stack  blueking/bkmonitor-operator-stack  3.6.104
>```

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
预期输出如下所示：
>``` plain
>NAME                            	CHART VERSION	APP VERSION 	DESCRIPTION
>blueking/bkmonitor-operator-stack	3.6.92  	  3.6.0    	略
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
| 20240307 功能更新 | 3.28.1542 |

bk-collector:
|  | 软件版本号 |
|--|--|
| 7.1.2 发布 | 0.30.1193 |
| 20231031 补丁更新 | 0.34.1292 |
| 20240307 功能更新 | 0.42.1516 |

### 20240307 功能更新
本更新为 **功能** 更新，并包含了问题修复和代码优化。

在中控机下载插件包：
``` bash
bkdl-7.1-stable.sh -ur latest bkmonitorbeat=3.28.1542 bk-collector=0.42.1516
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

### 20231031 补丁更新
本更新为 **补丁** 更新，包含问题修复和代码优化。

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
| 20240307 补丁更新 | 2.6.11 |

### 20240307 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。版本日志见 https://github.com/TencentBlueKing/bk-itsm/blob/V2.6.11/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.11.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.11.tar.gz)

参考 《[部署流程服务（bk_itsm）](manual-install-saas.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。

### 20231227 安全更新
本更新为 **安全** 更新，包含安全问题及普通问题修复，我们希望用户尽快更新。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/V2.6.8/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.8.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.8.tar.gz)

参考 《[部署流程服务（bk_itsm）](manual-install-saas.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。

### 20230822 补丁更新
本更新为 **补丁** 更新，包含问题修复和逻辑优化。具体变动见 https://github.com/TencentBlueKing/bk-itsm/blob/V2.6.7/docs/RELEASE.md 。

下载适用于蓝鲸 7.x 的安装包：
* [bk_itsm-V2.6.7.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.7.tar.gz)

参考 《[部署流程服务（bk_itsm）](manual-install-saas.md#deploy-bkce-saas-itsm)》 文档上传安装包，并部署到生产环境。

部署成功后，即可在桌面访问了。


## 更新 GSE Agent
gse client
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.1.2-beta.20 |
| 20230808 补丁更新 | 2.1.3-beta.3 |
| 7.1.1 发布 | 2.1.3-beta.11 |
| 20240320 补丁更新 | 2.1.5-beta.7 |
gse proxy
|  | 软件版本号 |
|--|--|
| 7.1.0 发布 | 2.1.2-beta.20 |
| 7.1.1 发布 | 2.1.3-beta.11 |
| 20240320 补丁更新 | 2.1.5-beta.7 |

### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复及稳定性优化。

登录到 **中控机**，下载 GSE Agent 2.1.5-beta.7 版本：
``` bash
bkdl-7.1-stable.sh -ur latest gsec=2.1.5-beta.7 gsep=2.1.5-beta.7
```

上传 Client 和 Proxy 到 节点管理：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u agent
./scripts/setup_bkce7.sh -u proxy
```

随后访问“节点管理”，在 “Agent 状态”界面勾选待升级的 Agent，展开“批量”菜单，选择“升级”，即可进入升级界面。

遵循界面指引完成升级过程，等待 Agent 上报新的版本号，即升级完成。


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


## 更新用户管理
|  | chart 版本号 | 软件版本号 |
|--|--|--|
| 7.1.0 发布 | 1.4.14-beta.1 | 2.5.4-beta.1 |
| 20230815 补丁更新 | 1.4.14-beta.7 | 2.5.4-beta.7 |
| 20240320 补丁更新 | 1.4.14-beta.15 | 2.5.4-beta.13 |


### 20240320 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。版本日志见 https://github.com/TencentBlueKing/bk-user/releases/tag/v2.5.4-beta.13 。

登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-user --version 1.4.14-beta.15
```
预期输出如下所示：
>``` plain
>NAME              CHART VERSION   APP VERSION    DESCRIPTION
>blueking/bk-user  1.4.14-beta.15  2.5.4-beta.13  略
>```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-user charts version 为 `1.4.14-beta.15`：
``` bash
sed -i 's/bk-user:.*/bk-user: "1.4.14-beta.15"/' environments/default/version.yaml
grep bk-user environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-user: "1.4.14-beta.15"
>```

更新 bk-user：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-user sync
```

等待命令执行完毕，结尾输出如下即为更新成功：
>``` plain
>UPDATED RELEASES:
>NAME      CHART             VERSION
>blueking  blueking/bk-user  1.4.14-beta.15
>```

### 20230815 补丁更新
本更新为 **补丁** 更新，包含一些问题修复。

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
