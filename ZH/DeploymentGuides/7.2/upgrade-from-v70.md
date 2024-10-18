本文档将指引你将一个 7.0 环境升级到 7.2 版本。主要操作包括：
* 蓝鲸 7.0 产品的升级
* 蓝鲸 7.2 新产品的安装
* 蓝鲸 7.0 所用存储服务的升级


# 整理旧环境
## 版本确认

|NAME                       |CHART                             |APP VERSION   |
|---                        |---                               |---           |
|bcs-services-stack         |bcs-services-stack-1.27.0         |v1.27.0       |
|bk-apigateway              |bk-apigateway-0.4.48-patch.1      |1.1.32-patch.1|
|bk-applog                  |bkapp-log-collection-1.1.2        |1.1.0         |
|bk-auth                    |bkauth-0.0.9                      |0.0.10        |
|bk-ci                      |bk-ci-2.0.68                      |1.9.2         |
|bk-cmdb                    |bk-cmdb-3.11.17                   |3.10.21       |
|bk-console                 |bk-console-0.1.0                  |0.1.0         |
|bk-consul                  |consul-10.6.5                     |1.12.2        |
|bk-elastic                 |elasticsearch-17.5.4              |7.16.2        |
|bk-gse                     |bk-gse-ce-2.0.10                  |2.0.10        |
|bk-iam                     |bkiam-0.1.15                      |1.11.9        |
|bk-iam-saas                |bkiam-saas-0.1.31                 |1.8.24        |
|bk-iam-search-engine       |bkiam-search-engine-0.0.13        |1.0.6         |
|bk-influxdb                |influxdb-4.10.0                   |1.8.6         |
|bk-ingress-nginx           |bk-ingress-nginx-1.0.2            |0.30.0        |
|bk-ingress-rule            |bk-ingress-rule-0.0.4             |0.0.4         |
|bk-job                     |bk-job-0.2.6                      |3.5.1         |
|bk-kafka                   |kafka-15.5.1                      |3.1.0         |
|bk-log-search              |bk-log-search-4.3.7               |4.3.7         |
|bk-mongodb                 |mongodb-10.30.6                   |4.4.10        |
|bk-monitor                 |bk-monitor-3.6.82                 |3.6.3690      |
|bk-mysql                   |mysql-4.5.5                       |5.7.26        |
|bk-nodeman                 |bk-nodeman-2.2.27                 |2.2.27        |
|bk-paas                    |bkpaas3-0.1.3                     |0.1.3         |
|bk-rabbitmq                |rabbitmq-8.24.12                  |3.9.11        |
|bk-redis                   |redis-15.3.3                      |6.2.5         |
|bk-redis-cluster           |redis-cluster-7.4.6               |6.2.6         |
|bk-repo                    |bkrepo-1.1.25                     |1.1.25        |
|bk-ssm                     |bkssm-1.0.5                       |0.1.0         |
|bk-user                    |bk-user-1.3.5                     |v2.4.2        |
|bk-zookeeper               |zookeeper-9.0.4                   |3.8.0         |
|bklog-collector            |bk-log-collector-0.0.9            |7.3.1         |
|bkmonitor-operator         |bkmonitor-operator-stack-3.6.21   |3.6.0         |
|ingress-nginx              |ingress-nginx-3.36.0              |0.49.0        |
|localpv                    |provisioner-2.4.0                 |2.4.0|

## 环境稳定性确认

升级前，确认当前的 7.0 环境蓝鲸组件运行正常，通过 kubectl 查看是否有非就绪状态的 Pod。
``` bash
kubectl get pods --all-namespaces -o json | jq -r '.items[] | select(any(.status.containerStatuses[]; .ready==false and .state.terminated.reason != "Completed")) | "namespace: \(.metadata.namespace) -- pod: \(.metadata.name)"'
```

如果环境存在异常，请先解决问题，不要升级。

## 备份旧环境

请参考 7.0 版本的《[备份当前环境](../7.0/backup.md)》文档完成旧环境备份。

跨版本升级请务必备份。


# 准备新环境

## 下载新的下载脚本

``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.2-stable/bkdl-7.2-stable.sh -o ~/bin/bkdl-7.2-stable.sh
chmod +x ~/bin/bkdl-7.2-stable.sh
```

## 配置安装目录变量

在接下来的操作中，我们都会读取这些变量。

升级文档假设 7.0 的 bkhelmfile 目录在 `~/bkhelmfile`，7.2 的 bkhelmfile 目录在 `~/bkce7.2-install`。

``` bash
mkdir ~/bkce7.2-install
INSTALL_DIR=$HOME/bkce7.2-install
OLD_INSTALL_DIR=$HOME/bkhelmfile
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

helm、jq 与 yq 版本均有升级。
``` bash
for _cmd in helm yq jq; do
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

在 7.0 的 安装目录找到以 `custom-values.yaml.gotmpl` 结尾的文件，并复制到 7.2 安装目录下：
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

### 手动迁移 ingress-nginx 的 custom-values 文件

>**提示**
>
>* 如果你使用的不是蓝鲸预置的 `ingress-nginx`，请自行调整配置文件。
>* 如果你使用了蓝鲸预置的 `ingress-nginx`，但是没有配置过 custom-values，或者 **仅配置** 了节点亲和，可以跳过本章节。

在 7.0 版本中，你需要直接编辑 `$OLD_INSTALL_DIR/blueking/00-ingress-nginx.yaml.gotmpl` 文件来自定义 `ingress-nginx`，现在我们提供了独立的 custom-values 文件。
请手动迁移自定义配置到 `$INSTALL_DIR/blueking/environments/default/ingress-nginx-custom-values.yaml.gotmpl`。

## 绑定主机
这些关键服务需要绑定主机，以降低配置变更的成本。

你可以选择主机绑定的方法，此处以 nodeSelector 为例。

### 绑定 bk-zookeeper 所在主机
GSE v1 Agent 需要访问 zk，为了避免 IP 变动导致 Agent 失联，需要绑定主机。

``` bash
touch ./environments/default/zookeeper-custom-values.yaml.gotmpl
node_zookeeper=$(kubectl -n blueking get pods -l app.kubernetes.io/instance=bk-zookeeper -o jsonpath='{.items[0].spec.nodeName}')
yq -i ".nodeSelector = {\"kubernetes.io/hostname\":\"$node_zookeeper\"}" environments/default/bkgse-ce-custom-values.yaml.gotmpl
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

# 蓝鲸 7.0 产品的升级

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

## 升级 ingress-nginx
>**提示**
>
>如果你使用的不是蓝鲸预置的 `ingress-nginx`，可以跳过本章节，自行完成升级。

注意完成上面的“绑定 ingress-nginx 所在主机”章节，可以保持节点 IP 不变，无需重新各处的 DNS 解析或 hosts 文件。
```bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
```

## 蓝鲸预置存储服务
>**提示**
>
>如果你不使用蓝鲸预置存储服务，请自行修改配置。

### 部署 etcd
本次新增了 etcd。如果不使用蓝鲸预置服务，请配置 custom-value。

```bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-etcd sync
```


## 升级蓝鲸基础套餐

### 升级 bk-auth 和 bk-repo

升级的时候，由于 bkrepo localpv 绑定，被调度的 Node 可能会导致 CPU 不足，请升级前先确保充足的资源，或者清理一些 Pod 来释放 CPU。
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth -l name=bk-repo sync
```

### 升级 bk-apigateway
API 网关的 chart 版本有较大变动，需要执行 2 次升级：
* 0.4.x -> 1.12.x 操作基于开发编写的 [API 网关：如何从 chart 0.4.x 迁移到 1.10.x](https://github.com/TencentBlueKing/blueking-apigateway/issues/189) 修改。
* 1.12.x -> 1.13.x 直接升级即可，会自动进行数据迁移

#### bk-apigateway-0.4 升级到 1.12
0.4.x 为 Go 版本网关，不依赖 etcd；1.10.x 后为 apisix 网关，依赖 etcd。切换前需提前准备 etcd 数据。

##### 修改版本号

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `1.12.16`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "1.12.16"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "1.12.16"
>```

##### 配置

编写金丝雀发布的配置 /tmp/bkapigateway-values-canary.yaml
```bash
cat > /tmp/bkapigateway-values-canary.yaml <<EOF
registerCrds: false

apigateway:
  bkapiServiceName: ""
# 初始时，不创建新 Pod
  replicaCount: 0
  ingress:
    annotations:
      # 标记此 Ingress 为金丝雀发布
      nginx.ingress.kubernetes.io/canary: "true"
      # API 服务，设置灰度比例，范围：0 ~ 100。初始时，不灰度流量
      nginx.ingress.kubernetes.io/canary-weight: "0"

dashboard:
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/canary: "true"
      # 前端项目，用户手动设置浏览器 Cookies：canary=always，则灰度此用户的请求
      nginx.ingress.kubernetes.io/canary-by-cookie: "canary"
      # 设置权重比例为 100，不灰度前端项目
      # nginx.ingress.kubernetes.io/canary-weight: "100"

dashboardFe:
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/canary: "true"
      # 前端项目，用户手动设置浏览器 Cookies：canary=always，则灰度此用户的请求
      nginx.ingress.kubernetes.io/canary-by-cookie: "canary"
      # 设置权重比例为 100，不灰度前端项目
      # nginx.ingress.kubernetes.io/canary-weight: "100"
EOF
```

导出当前 apigateway 的 values：
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway write-values --output-file-template /tmp/bkapigateway-values.yaml
```

##### 部署金丝雀实例 bk-apigateway-canary
安装金丝雀 release：
```bash
apigw_version=$(yq e '.version.bk-apigateway' environments/default/version.yaml)
helm install bk-apigateway-canary -n blueking --version $apigw_version blueking/bk-apigateway -f /tmp/bkapigateway-values.yaml -f /tmp/bkapigateway-values-canary.yaml --wait
```

等待 canary 的 release 都部署完成。启动 bash：
```bash
## 检查 bk-esb 组件数据，并将其同步到 apigateway
# 进入 dashboard 容器
dashboard_pod_name=$(kubectl get pod -n blueking -l app.kubernetes.io/component=dashboard,app.kubernetes.io/instance=bk-apigateway-canary -o jsonpath='{.items[*].metadata.name}')
dashboard_namespace=$(kubectl get pod -n blueking -l app.kubernetes.io/component=dashboard,app.kubernetes.io/instance=bk-apigateway-canary -o jsonpath='{.items[*].metadata.namespace}')
kubectl exec -n $dashboard_namespace -it $dashboard_pod_name -- bash
```
在 bash 中，执行如下命令：
```bash
# 拆分组件：检查组件中同一 path 是否存在 method=""，及其它方法的组件，此类组件需要拆分或调整
# 执行过程中：部分组件直接修改，部分组件会要求确认。
python manage.py split_component_method
# 同步 bk-esb 组件到 apigateway（预期 3 分钟左右）
python manage.py sync_to_gateway_and_release
# 同步组件权限数据到 apigateway（无任何输出）
python manage.py sync_esb_permissions_to_gateway
## 同步 dashboard 数据到 etcd
# 执行 django command，将网关数据同步到 etcd
python manage.py sync_releases_to_shared_micro_gateway_parallel
```
执行完毕后，如果没有报错，即可退出 bash。

##### 部署新 bk-apigateway
执行完成后，更新 bk-apigateway：
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

升级成功后，删除中间辅助的 canary release：
```bash
helm uninstall -n $dashboard_namespace bk-apigateway-canary
```

#### bk-apigateway-1.12 升级到 1.13

修改 `environments/default/version.yaml` 文件，配置 bk-apigateway charts version 为 `1.13.20`：
``` bash
sed -i 's/bk-apigateway:.*/bk-apigateway: "1.13.20"/' environments/default/version.yaml
grep bk-apigateway environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-apigateway: "1.13.20"
>```

更新 bk-apigateway：
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

### 升级第二层组件

```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
```

#### 迁移权限中心数据

由于权限中心在本次版本中新增了 RBAC 相关的接入功能, 对用户组鉴权数据做了较大的变更 所以升级前，需要使用数据迁移。
请跟随本文完成升级操作。

>**提示**
>
>此章节基于产品升级文档编写： [权限中心 V3 后台 从 <1.11.9 升级到 >=1.12.x](https://bk.tencent.com/docs/markdown/ZH/IAM/IntegrateGuide/HowTo/OPS/Upgrade.md)

下载迁移脚本
```bash
curl -L -o scripts/migrate_subject_system_group.py https://bkopen-1252002024.file.myqcloud.com/ce/3c2955e/migrate_subject_system_group.py

chmod +x scripts/migrate_subject_system_group.py
```
执行迁移：
```bash
bkiam_saas_podname=$(kubectl get pod -n blueking -l app.kubernetes.io/instance=bk-iam-saas,app.kubernetes.io/name=bkiam-saas,appModule=api -o jsonpath='{.items[0].metadata.name}')
# 将迁移脚本放入pod
kubectl cp scripts/migrate_subject_system_group.py -n blueking $bkiam_saas_podname:/app/
# 安装迁移脚本所需的依赖
kubectl exec -it -n blueking $bkiam_saas_podname -- pip3 install PyMySQL

# 开始执行
mysql_host=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.host')
mysql_port=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.port')
mysql_user=root
mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.2-install/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')

kubectl exec -it -n blueking $bkiam_saas_podname -- python3 /app/migrate_subject_system_group.py -H ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p ${mysql_passwd} -D bkiam migrate

# 检查
kubectl exec -it -n blueking $bkiam_saas_podname -- python3 /app/migrate_subject_system_group.py -H ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p ${mysql_passwd} -D bkiam check
```

### 升级 bk-gse
#### bk-gse 配置变更
bk-gse 的配置项不兼容的变更：`gseData.config.netdev` 变为 `gseData.config.netDeviceName`，取值是网卡名。

gseData 会读取该网卡的流量参数，基于流量做负载均衡。一般是内网网卡名 (默认为 `eth0`)，请以实际的网卡名称进行修改。

#### bk-gse-ce-2.0 升级到 2.1.5
>**注意**
>
>升级期间可能导致 Pod 漂移到其他主机。请务必完成前面的 “绑定 bk-gse 所在主机” 章节。

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


### 升级 bk-paas
bk-paas 的配置项调整比较大，最主要的是将 workloads 模块的配置合并到 apiserver 中。

新增 bkpaas-app-operator，默认部署在 bkpaas-app-operator-system 命名空间下。

#### bk-paas 配置变更

新增 externalDatabase.workloads 配置，如果在 7.0 部署中自定义配置了 bk-paas 的数据库，则需要自行处理这个配置项。在 `environments/default/bkpaas3-custom-values.yaml.gotmpl` 中新增对应的 externalDatabase.workloads 配置，如无自定义可跳过该步骤。


#### 部署 bk-paas

卸载旧版本的 bk-paas：
```bash
./scripts/uninstall.sh -y bk-paas
```

安装新版本的 bkpaas-app-operator 和 bk-paas：
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bkpaas-app-operator -l name=bk-paas sync
```

bk-paas 安装过程主要 job `bkpaas3-apiserver-init-data` 会耗时较长，可以观察它的日志输出
```bash
kubectl logs -n blueking -l job-name=bkpaas3-apiserver-init-data-1 -f
```

### 升级第三层的其他组件

更新第三层的组件其他
```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=third,name!=bk-paas,name!=bkpaas-app-operator,name!=bk-gse sync
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
# 部署 cmdb SaaS（后续去掉wget部分）
wget bk_cmdb_saas.tgz # 重命名放置在 ../saas/bk_cmdb_saas.tgz
./scripts/setup_bkce7.sh -i bk_cmdb_saas
```

### 升级第四层-作业平台
作业平台 3.9.3 版本默认使用基于蓝鲸制品库的 **全局配置** 方案，升级后将展示默认界面。

用户此前通过页面【平台管理-全局设置-平台信息】配置的数据（title/footer/助手链接等）需要 **迁移数据** 且启用 **全局配置** 功能，方可恢复显示。

提前保存旧的版本号：
``` bash
JOB_OLD_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')
```

先关闭作业平台对接 GSE Agent v2 的功能开关：
```bash
touch ./environments/default/bkjob-custom-values.yaml.gotmpl
yq -i '.job.features.gseV2.enabled = false' ./environments/default/bkjob-custom-values.yaml.gotmpl
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
```

升级：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
```

#### 作业平台迁移数据
本章节基于 [作业平台升级说明](https://github.com/TencentBlueKing/bk-job/blob/master/UPGRADE.md) 修改。

迁移过程中，会自动进行如下的任务：
1. 3.7.0 版本上线新版主机选择器。存量的作业模板/执行方案/定时任务/IP 白名单中的主机数据需添加 hostId，并迁移对所有业务生效的 IP 白名单数据。
2. 3.9.3 版本默认使用基于蓝鲸制品库的 **全局配置** 方案，升级后将展示默认界面。用户此前通过页面【平台管理-全局设置-平台信息】配置的数据（title/footer/助手链接等）需要 **迁移数据** 且启用 **全局配置** 功能，方可恢复显示。

执行升级工具后，会完成上述任务，并生成平台信息全局配置文件： base.js。
``` bash
# 获取更新后的 job appVersion
JOB_NEW_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')
# 执行前，请确保下述两个变量的值为非空。如果你没有单独更新过job，OLD_VERSION 一般为 3.5.x
echo $JOB_OLD_VERSION $JOB_NEW_VERSION
# 运行 upgrader 的 pod
kubectl run -n blueking --image-pull-policy=Always --image="hub.bktencent.com/dev/blueking/job-migration:$JOB_NEW_VERSION" bk-job-upgrader -- sleep infinity
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

先将新包放在 `/root/bkce7.2-install/saas` 目录上（后续删掉该部分）

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


#### 节点管理升级 gse agent
目前 GSE v1 agent 不提供升级。

#### 节点管理升级 gse 插件
目前 GSE v1 agent plugins 不提供升级。


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

bcs-1.28 新增了 `bcs-api.$BK_DOMAIN` 域名，需要先注册到 coredns：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bcs-api.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

开始更新：
``` bash
helmfile -f 03-bcs.yaml.gotmpl sync
```

## 升级监控日志平台

### 升级监控平台

```bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

### 升级日志平台

```bash
helmfile -f 04-bklog-search.yaml.gotmpl sync
```

### 更新监控日志采集器
更新蓝鲸所在 k8s 集群的监控和日志采集器：
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
helmfile -f 04-bklog-collector.yaml.gotmpl sync
```

## 升级持续集成套餐

此次升级包括产品自带公共组件（mysql、rabbitmq、redis）升级

### 升级蓝盾
>**注意**
>
>蓝盾从 1.7 升级到 3.0，可能存在风险。待重新验证后，更新本章节。

升级持续集成平台
```bash
helmfile -f 03-bkci.yaml.gotmpl sync
```

#### 数据迁移

>3.0 相对于 1.x 的版本，权限从对接权限中心 v3 升级到对接权限中心 rbac，对鉴权数据做了较大的变更。所以升级后, 需要迁移权限。

蓝盾 MySQL 执行：
```bash
# 进入蓝盾 MySQL
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-mysql|awk '{print $1}') -- mysql -uroot -pblueking

# 删除冲突
DELETE FROM devops_ci_auth.T_AUTH_IAM_CALLBACK WHERE RESOURCE IN ("experience_task", "experience_group");
```
蓝盾 auth Pod 执行：
```bash
# 进入 auth pod
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-auth|awk '{print $1}') -- bash

# 数据迁移
curl -XPOST http://127.0.0.1/api/op/auth/migrate/allToRbac
```
迁移结果检查：
```bash
# 进入蓝盾 MySQL
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-mysql|awk '{print $1}') -- mysql -uroot -pblueking

# 检查结果
select * from devops_ci_auth.T_AUTH_MIGRATION\G
```
说明：
- `status` 有三个值，0-迁移中,1-迁移成功,2-迁移失败
- 迁移中的项目不要访问，请求可能会报资源不存在

迁移后可以登录至蓝盾页面检查老项目权限是否正常。

#### 蓝盾优化项
请阅读文档 《[部署持续集成套餐](install-ci-suite.md)》。


### 部署代码检查系统（可选）

请阅读文档 《[部署持续集成套餐](install-ci-suite.md)》。

# 蓝鲸 7.2 新产品的安装
在 7.2 中，我们引入了一些新的产品。

## 部署消息通知中心
请阅读文档 《[部署消息通知中心](install-notice.md)》。

## 部署服务配置中心
请阅读文档 《[部署服务配置中心](install-bscp.md)》。


# 蓝鲸 7.0 所用存储服务的升级
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
