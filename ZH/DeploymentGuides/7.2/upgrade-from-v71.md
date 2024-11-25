
本文档将指引你将一个 7.1 环境升级到 7.2 版本。主要操作包括：
* 蓝鲸 7.1 产品的升级
* 蓝鲸 7.2 新产品的安装
* 蓝鲸 7.1 所用存储服务的升级


# 整理旧环境
## 版本确认
在中控机执行 `helm list -A`，检查 release 对应的 chart 版本，建议更新后开始大版本升级。

| Release 名                 | CHART 及版本                             | 软件版本       |
| ---                        | ---                                     | ---           |
| bcs-services-stack         | bcs-services-stack-1.28.2-beta.2        | 1.28.2-beta.2 |
| bk-apigateway              | bk-apigateway-1.12.16                   | 1.12.16       |
| bk-applog                  | bkapp-log-collection-1.1.10             | 1.1.0         |
| bk-auth                    | bkauth-0.0.11                           | 0.0.13        |
| bk-ci                      | bk-ci-3.0.10-beta.2                     | 2.0.0-beta.34 |
| bk-cmdb                    | bk-cmdb-3.12.3                          | 3.11.3        |
| bk-console                 | bk-console-0.1.3-beta.3                 | v0.1.3-beta.2 |
| bk-consul                  | consul-10.6.5                           | 1.12.2        |
| bk-elastic                 | elasticsearch-17.5.4                    | 7.16.2        |
| bk-etcd                    | etcd-8.5.0                              | 3.5.4         |
| bk-gse                     | bk-gse-ce-v2.1.5-beta.7                 | 2.1.5-beta.7  |
| bk-iam                     | bkiam-0.2.10                            | v1.12.11      |
| bk-iam-saas                | bkiam-saas-0.2.28                       | v1.10.22      |
| bk-iam-search-engine       | bkiam-search-engine-0.1.3               | v1.1.3        |
| bk-influxdb                | influxdb-4.10.0                         | 1.8.6         |
| bk-ingress-nginx           | bk-ingress-nginx-1.1.0                  | 1.3.0         |
| bk-ingress-rule            | bk-ingress-rule-0.0.4                   | 0.0.4         |
| bk-job                     | bk-job-0.4.6-rc.1                       | 3.7.6-rc.1    |
| bk-kafka                   | kafka-15.5.1                            | 3.1.0         |
| bk-log-search              | bk-log-search-4.6.6                     | 4.6.6         |
| bk-mongodb                 | mongodb-10.30.6                         | 4.4.10        |
| bk-monitor                 | bk-monitor-3.8.9                        | 3.8.9         |
| bk-mysql                   | mysql-4.5.5                             | 5.7.26        |
| bk-nodeman                 | bk-nodeman-2.4.4                        | 2.4.4         |
| bk-paas                    | bkpaas3-1.1.1-beta.2                    | 1.1.1-beta.1  |
| bk-rabbitmq                | rabbitmq-8.24.12                        | 3.9.11        |
| bk-redis                   | redis-15.3.3                            | 6.2.5         |
| bk-redis-cluster           | redis-cluster-7.4.6                     | 6.2.6         |
| bk-repo                    | bkrepo-1.3.16-beta.4                    | 1.3.16-beta.4 |
| bk-ssm                     | bkssm-1.0.8                             | 1.0.12        |
| bk-user                    | bk-user-1.4.14-beta.10                  | 2.5.4-beta.10 |
| bk-zookeeper               | zookeeper-9.0.4                         | 3.8.0         |
| bklog-collector            | bk-log-collector-0.1.6                  | 7.5.1-rc158   |
| bkmonitor-operator         | bkmonitor-operator-stack-3.6.113        | 3.6.0         |
| bkpaas-app-operator        | bkpaas-app-operator-1.1.0-beta.16       | 1.1.0-beta.35 |
| ingress-nginx              | ingress-nginx-4.2.5                     | 1.3.1         |
| localpv                    | provisioner-2.4.0                       | 2.4.0         |

## 环境稳定性确认

请确保旧环境可以稳定运行。升级期间，部分产品会在线迁移数据。如果环境异常，会导致升级过程异常，且无法恢复。

## 备份旧环境

请参考 7.1 版本的《[备份当前环境](../7.1/backup.md)》文档完成旧环境备份。

跨版本升级请务必备份。


# 准备新环境
## 下载新的下载脚本

``` 　
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.2-stable/bkdl-7.2-stable.sh -o ~/bin/bkdl-7.2-stable.sh
chmod +x ~/bin/bkdl-7.2-stable.sh
```

## 配置安装目录变量

在接下来的操作中，我们都会读取这些变量。

升级文档假设 7.1 的 bkhelmfile 目录在 `~/bkce7.1-install`，7.2 的 bkhelmfile 目录在 `~/bkce7.2-install`。

>**注意**
>
>如有变动，请自行调整赋值。

``` bash
INSTALL_DIR=$HOME/bkce7.2-install
OLD_INSTALL_DIR=$HOME/bkce7.1-install
# 修改 .bashrc
bashrc=$HOME/.bashrc
if grep -qxF "export INSTALL_DIR=\"${INSTALL_DIR%/}\"" "$bashrc"; then
  echo "$bashrc is up-to-date."
elif grep -qE "^export INSTALL_DIR=" "$bashrc"; then
  sed -ri 's|export INSTALL_DIR=.*|export INSTALL_DIR="'"${INSTALL_DIR%/}"'"|' "$bashrc"
else
  tee -a "$bashrc" <<<"export INSTALL_DIR=\"${INSTALL_DIR%/}\""
fi
# 重新加载变量
source "$bashrc"
echo "INSTALL_DIR=\"$INSTALL_DIR\"".
```

## 下载新的 bkhelmfile 包

在 7.2 版本中，默认安装目录更换为了 `~/bkce7.2-install`，当然你也可以使用 `-i` 参数或者环境变量 `INSTALL_DIR` 来修改。

我们先在 **中控机** 下载新的 bkhelmfile 包（不下载证书，从旧安装目录迁移）：
``` bash
bkdl-7.2-stable.sh -r latest bkce
```

下载成功后，最新的 helmfile 和默认配置在 `$INSTALL_DIR/blueking` 目录下，SaaS 包在 `$INSTALL_DIR/saas` 目录下。


## 其他工具

我们先在 **中控机** 下载新的工具包：
``` bash
bkdl-7.2-stable.sh -r latest tools
```

helm 版本有升级。
``` bash
for _cmd in helm; do
  cp -v "${INSTALL_DIR:-INSTALL_DIR-not-set}/bin/$_cmd" /usr/local/bin/
done
```

# 配置
我们先迁移部分旧的配置文件。然后重新配置。

## 从旧 bkhelmfile 目录迁移配置及文件
我们此前推荐你修改 custom-values 文件来实现自定义配置，故此处会仅迁移这些文件。

>**注意**
>
>如果你曾经修改了 values 文件，则此方法不适用，需要自行迁移。

### 全局 custom-values

``` bash
cp -v "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/custom.yaml" "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/environments/default/custom.yaml"
```

### 复制其他的 custom-values 文件

在 7.1 的 安装目录找到以 `custom-values.yaml.gotmpl` 结尾的文件，并复制到 7.2 安装目录下：
``` bash
find ${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/ -name "*custom-values.yaml.gotmpl" -printf "cp -v ${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/%P ${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/environments/default/%P\n" | bash
```


### 复制证书

``` bash
cp -va "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/cert/" "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/environments/default/"
```

### 复制生成的凭据文件

``` bash
while read f; do
  command cp -v "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/$f" "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/$f"
done <<EOF
environments/default/app_secret.yaml
environments/default/bcs/auto-generated-secrets.yaml
environments/default/bcs/ipv6-custom.yaml.gotmpl
environments/default/bkapigateway_builtin_keypair.yaml
environments/default/paas3_initial_cluster.yaml
EOF
```

### 复制一键脚本的 redis 上传记录

``` bash
command cp -v "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/saas/saas_install_step" "${INSTALL_DIR:-INSTALL_DIR-not-set}/saas/saas_install_step"
```

## 调整配置项

### 修改 mysql 主机名

由于 7.2 默认指向 mysql8 ，这里需要临时配置 values 指向当前的 mysql5.7 版本
``` bash
yq -i '.mysql.host = "bk-mysql-mysql"' environments/default/custom.yaml
yq -i '.apps.mysql.host = "bk-mysql-mysql.blueking.svc.cluster.local"' environments/default/custom.yaml
```

### 增补 app secret
生成 新版 cmdb 接入 apigateway 的网关组件的 rsa key 密钥对
``` bash
./scripts/generate_rsa_keypair.sh environments/default/bkapigateway_builtin_keypair.yaml
```

## 绑定主机
这些关键服务需要绑定主机，以降低配置变更的成本。

你可以选择主机绑定的方法，此处以 nodeSelector 为例。

### 绑定 bk-zookeeper 所在主机
GSE v1 Agent 需要访问 zk，为了避免 IP 变动导致 Agent 失联，需要绑定主机。虽然 7.1 全新安装使用了 GSE V2 agent，建议也顺便绑定下。

``` bash
touch ./environments/default/zookeeper-custom-values.yaml.gotmpl
node_zookeeper=$(kubectl -n blueking get pods -l app.kubernetes.io/instance=bk-zookeeper -o jsonpath='{.items[0].spec.nodeName}')
yq -i ".nodeSelector = {\"kubernetes.io/hostname\":\"$node_zookeeper\"}" ./environments/default/zookeeper-custom-values.yaml.gotmpl
```

### 绑定 ingress-nginx 所在主机
跨版本升级可能引入新的域名，建议浏览器访问前检查 《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

``` bash
touch ./environments/default/ingress-nginx-custom-values.yaml.gotmpl
node_ingress=$(kubectl -n ingress-nginx get pods -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.nodeName}')
yq -i ".controller.nodeSelector = {\"kubernetes.io/hostname\":\"$node_ingress\"}" environments/default/ingress-nginx-custom-values.yaml.gotmpl
```

### 绑定 bk-gse 所在主机
升级期间可能导致 Pod 漂移到其他主机，引发 Agent 失联。为了规避此情况，可以绑定 pod 到当前主机，确保不会调度到其他 node 上。

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

# 蓝鲸 7.1 产品的升级

>**提示**
>
>接下来的升级操作都在 **新安装目录** 下进行。

## 进入新的工作目录

``` bash
# 进入新的工作目录
cd "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/"
```

## 更新 helm repo 缓存

新版本的 chart 都有升级，更新缓存后才能下载到。
``` bash
helm repo update blueking
```

## 升级蓝鲸基础套餐

### 升级第一层组件

先删除 API 网关旧 job
``` bash
kubectl -n blueking delete job bk-apigateway-wait-storages
```
升级
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=first sync
```

### 升级第二层组件

``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
```

### 升级第三层的组件

确保 gse_server 以及 gse_agent 都是新装的 `v2` 版本，且大于等于 `v2.1.5-beta.7`。（升级方法请查阅 [《单产品更新》文档 的 “bk-gse-ce-2.1.5-beta.7” 章节](../7.1/updates/202403.md#bk-gse-ce-2.1.5-beta.7)。

检查 gse 版本：
``` bash
helm list -n blueking | grep gse
```

预期输出如下所示：
``` plain
bk-gse   blueking 	中间略	deployed	bk-gse-ce-v2.1.5-beta.7  	v2.1.5-beta.7
```

升级
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=third sync
```

### 新装 bk_cmdb_saas
bkcmdb 在 7.2 中将产品侧的业务场景（SaaS）和 cmdb 的通用能力（后台）进行拆分，新增了部署 cmdb saas 步骤。

删除旧版 cmdb 图标：
``` bash
# 获取 mysql 密码
mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')
kubectl exec bk-mysql-mysql-master-0 -- bash -c "mysql -uroot -p$mysql_passwd -e 'DELETE FROM open_paas.console_analysis_appuserecord WHERE app_id=(SELECT id FROM open_paas.paas_app WHERE code=\"bk_cmdb\");'"
kubectl exec bk-mysql-mysql-master-0 -- bash -c "mysql -uroot -p$mysql_passwd -e 'DELETE FROM open_paas.console_desktop_userapp WHERE app_id=(SELECT id FROM open_paas.paas_app WHERE code=\"bk_cmdb\");'"
kubectl exec bk-mysql-mysql-master-0 -- bash -c "mysql -uroot -p$mysql_passwd -e 'DELETE FROM open_paas.paas_app WHERE code=\"bk_cmdb\";'"
```

安装新的蓝鲸配置平台 SaaS：
``` bash
./scripts/setup_bkce7.sh -i bk_cmdb_saas
```

### 升级第四层-作业平台

7.2.0 引用的 bk-job-0.6.6-beta.5 存在 bug，需要修改版本号为 `0.6.6-beta.6`。
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
sed -i 's/bk-job:.*/bk-job: "0.6.6-beta.6"/' environments/default/version.yaml
```

作业平台 3.9.3 版本默认使用基于蓝鲸制品库的 **全局配置** 方案，升级后将展示默认界面。

用户此前通过页面【平台管理-全局设置-平台信息】配置的数据（title/footer/助手链接等）需要 **迁移数据** 且启用 **全局配置** 功能，方可恢复显示。

提前保存旧的版本号：
``` bash
JOB_OLD_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')
```

升级：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
```

#### 作业平台迁移数据
执行升级工具后，会生成平台信息全局配置文件： base.js。
``` bash
# 获取更新后的 job appVersion
JOB_NEW_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')
# 执行前，请确保下述两个变量的值为非空。如果你没有单独更新过job，OLD_VERSION 一般为 3.7.x
echo $JOB_OLD_VERSION $JOB_NEW_VERSION
# 运行 upgrader 的 pod
kubectl run -n blueking --image-pull-policy=Always --image="hub.bktencent.com/blueking/job-migration:$JOB_NEW_VERSION" bk-job-upgrader -- sleep infinity
# 等待 pod 启动完成（ready），会输出pod/bk-job-upgrader condition met
kubectl wait -n blueking --for=condition=ready pod bk-job-upgrader
# 生成升级所需的配置文件。新版蓝鲸默认部署的是轻量化作业平台，需要将配置文件对应的 job-manage 与 job-crontab 的 host 进行修改
kubectl exec -n blueking bk-job-upgrader -- cat ./upgrader.properties.tpl | bash ./scripts/get_job_upgrade_env.sh | sed -re 's/job-(manage|crontab)/job-assemble/' | kubectl exec -i -n blueking bk-job-upgrader -- /bin/bash -c 'tee ./upgrader.properties'
# 执行完成命令后，终端输出的日志种的结尾几行有 "All xx upgradeTasks finished successfully" 字样则表示升级成功
kubectl exec -n blueking -i bk-job-upgrader -- ./runUpgrader.sh $JOB_OLD_VERSION $JOB_NEW_VERSION
```

先将 base.js 文件保存到中控机安装目录下的 `bk-config` 目录：
``` bash
basejs_path=../bk-config/$(helm get values -n blueking bk-job -a | yq '.bkSharedBaseJsPath // "/bk_job/base.js"')
mkdir -p $(dirname "$basejs_path")
kubectl cp blueking/bk-job-upgrader:/data/job/exec/base.js "$basejs_path"
# 文件复制完毕，即可删除 pod
kubectl delete -n blueking pod bk-job-upgrader
```

#### 作业平台启用全局配置
后续须将前面生成的 base.js 导入到制品库或者推送到 CDN，然后按需配置 job 的 values：`bkSharedBaseJsPath`，页面方可正常显示自定义内容。

完整操作请查阅 《[启用蓝鲸全局配置](config-bk-config.md)》文档。

### 上传新的 PaaS Runtimes

下载新的 paas runtimes
``` bash
bkdl-7.2-stable.sh -ur paas3-1.1 -C ce7/paas-runtimes node=16.16.0
```

上传 paas runtimes
``` bash
source <(kubectl get secret -n blueking bkpaas3-apiserver-bkrepo-envs -o json | jq -r '.data.BLOBSTORE_BKREPO_CONFIG|@base64d|gsub(", ";"\n")|gsub("[{}]";"")')
# 搜索文件列表上传
while read filepath; do
  bucket="${filepath#../paas-runtimes/}"
  bucket="${bucket%%/*}"
  remote="/${filepath#../paas-runtimes/*/}"
  remote="${remote%/*}/"
  scripts/bkrepo_tool.sh -u "$USERNAME" -p "$PASSWORD" -P "$PROJECT" -i "$ENDPOINT/generic" -n "$bucket" -X PUT -O -R "$remote" -T "$filepath"
  sleep 1
done < <(find ../paas-runtimes/ -mindepth 2 -type f)
```

### 升级 SaaS

下载安装包
在 **中控机** 运行：
``` bash
bkdl-7.2-stable.sh -ur latest saas lesscode
```

更新标准运维：
``` bash
./scripts/setup_bkce7.sh -i sops -f
```
更新流程服务：
``` bash
./scripts/setup_bkce7.sh -i itsm -f
```
更新运维开发平台：
``` bash
./scripts/setup_bkce7.sh -i lesscode -f
```

### 升级第五层-节点管理

``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync
```
如果提示 `bkrepo没有 blueking 项目，请检查bkrepo安装是否正确`，请检查更新中控机 hosts，可能之前部署 ingress-nginx 导致节点 IP 变动。

下载并上传 gse_agent 到制品库：
``` bash
bkdl-7.2-stable.sh -r latest gse_agent
./scripts/setup_bkce7.sh -u agent
```

下载并上传 gse_proxy 到制品库：
``` bash
bkdl-7.2-stable.sh -r latest gse_proxy
./scripts/setup_bkce7.sh -u proxy
```

下载并上传 插件包 到制品库：
``` bash
bkdl-7.2-stable.sh -r latest gse_plugins_freq
./scripts/setup_bkce7.sh -u plugin
```

#### 节点管理升级 gse agent

请先登录到蓝鲸桌面，打开“节点管理”应用。

默认即是 “节点管理” —— “Agent 状态” 界面。

勾选需要升级的主机，点击“批量”按钮展开操作菜单，选择“升级”即可。

#### 节点管理升级 gse 插件

进入 “节点管理” —— “插件状态” 界面。

勾选需要升级的主机，点击“安装/更新”按钮，在弹出的“批量插件操作”小窗选择待升级的插件。点击“下一步”跟随页面指引操作即可。

每次只能升级一种插件。选择其他插件重复上述操作，直至全部升级完成。


## 升级容器管理平台

需保证当前 helm 命令版本为 v3.12.3：
``` bash
helm version
```
预期输出如下：
``` plain
version.BuildInfo{Version:"v3.12.3", GitCommit:"3a31588ad33fe3b89af5a2a54ee1d25bfe6eaa5e", GitTreeState:"clean", GoVersion:"go1.20.7"}
```

bcsRedisPassword 在 1.29 中已去除，需要手动删除：
``` bash
kubectl -n bcs-system delete bkgatewayresources datamanager-grpc
kubectl -n bcs-system delete bkgatewayresources datamanager-http
```

bcs-services-stack-app 与 bcs-ui ingress 冲突，需要手动删除：

``` bash
kubectl -n bcs-system delete ingress bcs-services-stack-app
```

bcs-services-stack-1.29 以上的版本 CPU 使用率偏高问题已解决，需要重新启用消息队列：
``` bash
yq -i '.bcs-storage.storage.messageQueue.enabled=true | .global.storage.messageQueue.enabled=true' environments/default/bcs-custom-values.yaml.gotmpl
```

开始更新：
``` bash
helmfile -f 03-bcs.yaml.gotmpl sync
```

## 升级监控日志平台

### 升级监控平台

``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

### 升级日志平台

``` bash
helmfile -f 04-bklog-search.yaml.gotmpl sync
```

### 更新监控日志采集器
更新蓝鲸所在 k8s 集群的监控和日志采集器：
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
helmfile -f 04-bklog-collector.yaml.gotmpl sync
```

## 升级持续集成套餐

### 升级蓝盾

新版本需要先新增或修改部署 values 配置：
``` bash
sed -ri.bak '/kubernetes-manager/,/kaniko-project/d' environments/default/bkci/bkci-custom-values.yaml.gotmpl
```

升级：
``` bash
helmfile -f 03-bkci.yaml.gotmpl sync
```

### 升级代码检查系统

升级：
``` bash
helmfile -f 03-bkcodecc.yaml.gotmpl sync
```

更新之后，asyncreport 以及 deoccjob 组件需要下线旧的工作负载：
``` bash
kubectl -n blueking scale --replicas=0 deployment bk-codecc-asyncreport
kubectl -n blueking scale --replicas=0 deployment bk-codecc-codeccjob
```

# 蓝鲸 7.2 新产品的安装
在 7.2 中，我们引入了一些新的产品。

## 部署消息通知中心
请阅读文档 《[部署消息通知中心](install-notice.md)》。

## 部署服务配置中心
请阅读文档 《[部署服务配置中心](install-bscp.md)》。

# 蓝鲸 7.1 所用存储服务的升级
## 升级公共组件

### 升级 Redis
有 2 个 release：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis -l name=bk-redis-cluster sync
```

redis-cluster 滚动更新后，需要重启管控平台：
``` bash
kubectl get deploy | awk '/bk-gse/{print $1}' | xargs -n1 kubectl rollout restart deployment
```

### 升级 RabbitMQ

新版 RabbitMQ 部署对应的 secret 新增了 `rabbitmq-password` key，需在线调整配置：
``` bash
rabbitmq_password=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.rabbitmq.password')
kubectl patch secrets -p '{"data": {"rabbitmq-password": "'"$rabbitmq_password"'"}}' bk-rabbitmq

# 检查
kubectl get secret bk-rabbitmq -ojsonpath='{.data.rabbitmq-password}'
```

继续升级 RabbitMQ
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-rabbitmq sync
```

### 升级 Kafka
``` bash
helmfile -f monitor-storage.yaml.gotmpl -l name=bk-kafka sync
```

### 升级 MySQL

蓝鲸 7.2 默认使用的是 MySQL 8.0。

大致步骤如下
- 部署 `bk-mysql8`
- 迁移 db 数据
- 修改 values 指向 mysql8
- 重新部署基础套餐
- 重新部署监控日志套餐组件
- 修改 saas 增强服务配置
- 重新部署 saas
- 停掉 `bk-mysql` 服务 （v5.7）
- 卸载并清理 mysql 5.7

#### 部署 MySQL 8
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql8 sync
```
#### 迁移数据
这里需要再跑一遍备份数据并将新的备份数据导入 bk-mysql8
``` bash
# 备份数据
kubectl  exec -it -n blueking bk-mysql-mysql-master-0 -- bash /tmp/dbbackup_mysql.sh
# 导出文件
kubectl cp -n blueking bk-mysql-mysql-master-0:/tmp/bk_mysql_alldata.sql /data/bkmysql_bak/bk_mysql_alldata_new.sql
# 获取当前mysql8 密码
mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')
# 导入文件
kubectl cp -n blueking /data/bkmysql_bak/bk_mysql_alldata_new.sql bk-mysql8-0:/tmp/bk_mysql_alldata_new.sql
# 导入数据，注意存储空间是否充足。
kubectl exec -it bk-mysql8-0 -- bash -c "mysql -uroot -p$mysql_passwd < /tmp/bk_mysql_alldata_new.sql" # 该命令运行时间较长，耐心等待一下
```

#### 调整配置
修改 values 指向 `bk-mysql8`
``` bash
yq -i '.mysql.host = "bk-mysql8"' environments/default/custom.yaml
yq -i '.apps.mysql.host = "bk-mysql8.blueking.svc.cluster.local"' environments/default/custom.yaml
```

#### 重新部署基础套餐组件
``` bash
# 先删掉当前作业平台的 job
kubectl delete job -l app.kubernetes.io/component=job-migration
# 部署基础套餐
helmfile -f base-blueking.yaml.gotmpl apply
# 重启paas-app-operator
kubectl -n bkpaas-app-operator-system rollout restart deployment bkpaas-app-operator-controller-manager
```

#### 重新部署监控日志套餐组件
``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl apply
helmfile -f 04-bklog-search.yaml.gotmpl apply
```

#### 修改 saas 增强服务 配置
``` bash
# 该命令会对绑定到 mysql 的 saas 批量修改 host
kubectl -n blueking exec -it deploy/bkpaas3-svc-mysql-web -- bash -c "python manage.py reset_ins_config --host bk-mysql8.blueking.svc.cluster.local --no-dry-run"
kubectl -n blueking exec -it deploy/bkpaas3-svc-mysql-web -- bash -c "python manage.py loaddata data/fixtures/services.json"
kubectl -n blueking exec -it deploy/bkpaas3-svc-mysql-web -- bash -c "python manage.py loaddata data/fixtures/plans.json"
```

#### 重新部署 saas
``` bash
# 部署saas
./scripts/setup_bkce7.sh -i sops -f
./scripts/setup_bkce7.sh -i itsm -f
./scripts/setup_bkce7.sh -i lesscode -f
```

#### 停掉 bk-mysql 服务
``` bash
kubectl scale --replicas=0 statefulset bk-mysql-mysql-master
```
#### 卸载并清理 mysql 5.7
>**注意**
>
>确保产品更新后功能使用正常，数据正常方可执行该步骤。

使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.2-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-mysql
```
