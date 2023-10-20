
# 说明

- 文中所述的目录路径均以默认为主，如与实际有出入，请以升级实际路径为主。
- 如无特殊说明，所述操作均在中控机执行。
- 文档只含模块升级，不含 GSE Agent 升级指引。

# 环境检查

升级前，确认当前的 7.0 环境蓝鲸组件运行正常，通过 kubectl 查看是否有非 Running 状态的 Pod。

```bash
kubectl get pods --all-namespaces | awk '$4!="Running"&& $4!="Completed"&& NR>1'
```

如果环境存在异常，请先解决问题，不要升级。

# 数据备份
目前提供了 MySQL 及 MongoDB 数据库的备份方法。

# 数据库备份
## 备份蓝鲸公共 MySQL
目前蓝鲸公共 mysql 尚未开启 binlog，你可以直接备份。但是建议变更启用 binlog 后备份。

### 未开启 binlog 备份 MySQL（不推荐）

1. 创建 MySQL 备份目录

    ```bash
    install -dv /data/bkmysql_bak
    ```

2. 生成备份脚本

    ```bash
    cat >/data/dbbackup_mysql.sh <<\EOF
    #!/bin/bash
    
    MYSQL_USER=root
    MYSQL_HOST=127.0.0.1
    MYSQL_PASSWD=
    ignoredblist='information_schema|mysql|test|db_infobase|performance_schema|sys'
    dblist="$(mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD -Nse"show databases;"|grep -Ewv "$ignoredblist" | xargs echo)"
    
    mysqldump -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD --skip-opt --create-options --default-character-set=utf8mb4 -R  -E -q -e --single-transaction --no-autocommit --max-allowed-packet=1G  --hex-blob -B $dblist > /tmp/bk_mysql_alldata.sql
    EOF
    ```

3. 替换脚本中的密码

    ```bash
    mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')
    sed -i "s#MYSQL_PASSWD=.*#MYSQL_PASSWD=\"${mysql_passwd}\"#" /data/dbbackup_mysql.sh
    ```

4. 将备份脚本 cp 到 pod 内执行

    ```bash
    kubectl cp -n blueking /data/dbbackup_mysql.sh bk-mysql-mysql-master-0:/tmp/dbbackup_mysql.sh
    kubectl  exec -it -n blueking bk-mysql-mysql-master-0 -- bash /tmp/dbbackup_mysql.sh
    kubectl cp -n blueking bk-mysql-mysql-master-0:/tmp/bk_mysql_alldata.sql /data/bkmysql_bak/bk_mysql_alldata.sql
    
    # 检查备份文件
    grep 'CREATE DATABASE' /data/bkmysql_bak/bk_mysql_alldata.sql
    ```

### 开启 binlog 备份 MySQL （推荐）

该方式会涉及到重启 MySQL，执行前请确认执行期间不会对业务造成影响。

#### 启用 binlog

```bash
cd ~/bkhelmfile/blueking

# 开启 bin-log，请注意在[mysqld]中配置

yq '.master.config' environments/default/mysql-values.yaml.gotmpl  > /tmp/mysql_master_config.txt
sed -i '/\[mysqld\]/a\server-id=1\n\log_bin=/bitnami/mysql/binlog.bin' /tmp/mysql_master_config.txt
yq -n  '.master.config = "'"$(< /tmp/mysql_master_config.txt)"'"' >> environments/default/mysql-custom-values.yaml.gotmpl

# 检查配置
yq '.master.config' environments/default/mysql-custom-values.yaml.gotmpl

# 更新 configmap
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql sync

# 检查配置是否生效
kubectl describe configmaps -n blueking bk-mysql-mysql-master

# 重启 MySQL
kubectl rollout restart statefulset -n blueking bk-mysql-mysql-master

# 等待 MySQL 启动完成后，查看 binlog 是否生效
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -pblueking -e "SHOW VARIABLES LIKE '%log_bin%';"
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -pblueking -e "SHOW MASTER STATUS;"
```

#### 开始备份

1. 创建 MySQL 备份目录

    ```bash
    install -dv /data/bkmysql_bak
    ```

2. 生成备份脚本

    ```bash
    cat >/data/dbbackup_mysql.sh <<\EOF
    #!/bin/bash
    
    MYSQL_USER=root
    MYSQL_HOST=127.0.0.1
    MYSQL_PASSWD=
    ignoredblist='information_schema|mysql|test|db_infobase|performance_schema|sys'
    dblist="$(mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD -Nse"show databases;"|grep -Ewv "$ignoredblist" | xargs echo)"
    
    mysqldump -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWD --skip-opt --create-options --default-character-set=utf8mb4 -R -E -q -e --single-transaction --no-autocommit --master-data=2 --max-allowed-packet=1G --hex-blob -B $dblist > /tmp/bk_mysql_alldata.sql
    EOF
    ```

3. 替换脚本中的密码

    ```bash
    mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')
    sed -i "s#MYSQL_PASSWD=.*#MYSQL_PASSWD=\"${mysql_passwd}\"#" /data/dbbackup_mysql.sh
    ```

4. 将备份脚本 cp 到 pod 内执行

    ```bash
    sed -i "s#MYSQL_PASSWD=.*#MYSQL_PASSWD=\"${mysql_passwd}\"#" /data/dbbackup_mysql.sh
    kubectl cp -n blueking /data/dbbackup_mysql.sh bk-mysql-mysql-master-0:/tmp/dbbackup_mysql.sh
    kubectl  exec -it -n blueking bk-mysql-mysql-master-0 -- bash /tmp/dbbackup_mysql.sh
    kubectl cp -n blueking bk-mysql-mysql-master-0:/tmp/bk_mysql_alldata.sql /data/bkmysql_bak/bk_mysql_alldata.sql
    
    # 检查备份文件
    grep 'CREATE DATABASE' /data/bkmysql_bak/bk_mysql_alldata.sql
    ```

## 备份公共 MongoDB

```bash
install -dv mongodb_bak

mongodb_user=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mongodb.rootUsername')
mongodb_password=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mongodb.rootPassword')

kubectl exec -it -n blueking bk-mongodb-0 -- mongodump -u $mongodb_user -p $mongodb_password --oplog --gzip --out /tmp/mongodb_bak
kubectl cp -n blueking bk-mongodb-0:/tmp/mongodb_bak /data/mongodb_bak
```

## 其他数据库
推荐你自行备份其他的数据库，命名空间及 Pod 名如下：
``` plain
bcs-system bcs-mongodb-随机ID
bcs-system bcs-mysql-0
blueking bk-ci-kubernetes-manager-mysql-0
blueking bk-ci-mongodb-0
blueking bk-ci-mysql-0
blueking bk-codecc-mongodb-0
blueking bk-mongodb-0
blueking bk-mysql-mysql-master-0
```

# 前置准备
## 备份部署脚本
备份当前的 bkhelmfile 目录
```bash
cp -a -r ~/bkhelmfile ~/bkhelmfile-$(date +%Y%m%d-%H%M%S).bak
```

## 安装蓝鲸下载脚本
鉴于目前容器化的软件包数量较多，我们提供了下载脚本帮助你下载文件并制备安装目录。

此脚本无需提供给所有用户，所以我们把它安装到 `~/bin` 目录下：
``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh -o ~/bin/bkdl-7.1-stable.sh
chmod +x ~/bin/bkdl-7.1-stable.sh
```

## 配置安装目录变量
在接下来的操作中，我们都会读取这些变量。

升级文档假设 7.0 的 bkhelmfile 目录在 `~/bkhelmfile/`，7.1 的 bkhelmfile 目录在 `~/bkce7.1-install`。

``` bash
INSTALL_DIR=$HOME/bkce7.1-install/
OLD_INSTALL_DIR=$HOME/bkhelmfile/
```

## 下载新的 bkhelmfile 包
在 7.1 版本中，默认安装目录更换为了 ` ~/bkce7.1-install`，当然你也可以使用 `-i` 参数或者环境变量 `INSTALL_DIR` 来修改。

我们先在 **中控机** 下载新的 bkhelmfile 包及公共证书：
```bash
# 下载成功后，最新的 helmfile 和默认配置在 ~/bkce7.1-install/blueking 目录下，SaaS 包在 ~/bkce7.1-install/saas 目录下
bkdl-7.1-stable.sh -r latest bkce
```

## 更新 helm repo 缓存

```bash
cd ~/bkhelmfile/blueking
helm repo update blueking
```

## 升级 yq 命令
我们在 7.1 升级了 yq 的版本，请重新安装。

先检查 `yq` 版本：
``` bash
yq --version
```
如果输出为：
>``` plain
>yq (https://github.com/mikefarah/yq/) version v4.30.6
>```

说明已经是最新版本，可以跳过本章节。如果版本较低，请继续操作。

因为前面 `bkdl-7.1-stable.sh bkce` 时已经连带下载了 `yq_cmd`，故此时可以直接复制文件：
``` bash
command cp -v "${INSTALL_DIR:-INSTALL_DIR-not-set}/bin/yq" /usr/local/bin/
```

复制完成后你可以再次检查 `yq` 命令的版本。

## 从旧 bkhelmfile 目录迁移文件
我们推荐你修改 custom-values 文件来实现自定义配置。如果你直接修改了预置的 values 文件，请自行迁移变动内容到新安装目录下的 custom-values 文件，**切勿直接覆盖** 新 values 文件。

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

### 全局 custom-values
``` bash
cp -v "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/custom.yaml" "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/environments/default/custom.yaml"
```

### 复制其他的 custom-values 文件
我们找到以 `custom-values.yaml.gotmpl` 结尾的文件进行复制：
``` bash
find ${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/ -name "*custom-values.yaml.gotmpl" -printf "cp -v ${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/blueking/environments/default/%P ${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/environments/default/%P\n" | bash
```

### 手动迁移 ingress-nginx 的 custom-values 文件
在 7.0 版本中，你需要直接编辑 `$OLD_INSTALL_DIR/blueking/00-ingress-nginx.yaml.gotmpl` 文件来自定义 `ingress-nginx`，现在我们提供了独立的 custom-values 文件。

请手动迁移自定义配置到 `$INSTALL_DIR/blueking/environments/default/ingress-nginx-custom-values.yaml.gotmpl`。

## 配置升级所需的 custom-values
### GSE Agent 版本
在 7.1 版本，默认 GSE Agent 版本已经变为了 `v2` 协议。

所以需要先配置全局的版本，告知各产品目前使用的是 `v1` 版本的 GSE Agent。

编辑 全局 custom-values 文件，新增配置：
```bash
# 进入新的工作目录
cd "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/"
yq -i '.gse.version = "v1"' environments/default/custom.yaml
```

>**提示**
>
>如果 yq 命令提示语法错误，请先完成前面的 “升级 yq 命令” 章节。

### 推荐：固定 ingress-nginx 的节点
>**提示**
>
>如果你使用了蓝鲸提供的 `ingress-nginx`，则稍后升级时，可能导致节点变动，引发配置的 hosts 无效。

先检查确认只有一个 `ingress-nginx`：
``` bash
kubectl get pod -Al app.kubernetes.io/name=ingress-nginx
```

获取之前的 nodeName：
``` bash
ingress_nginx_nodename=$(kubectl get pod -Al app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].spec.nodeName}')
yq -i ".affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0] = {\"key\": \"kubernetes.io/hostname\", \"operator\": \"In\", \"values\": [\"$ingress_nginx_nodename\"]}" environments/default/ingress-nginx-custom-values.yaml.gotmpl
```
检查生成的配置文件格式是否正确：
``` bash
yq environments/default/ingress-nginx-custom-values.yaml.gotmpl
```

### 复制一键脚本的 redis 上传记录
``` bash
command cp -v "${OLD_INSTALL_DIR:-OLD_INSTALL_DIR-not-set}/saas/saas_install_step" "${INSTALL_DIR:-INSTALL_DIR-not-set}/saas/saas_install_step"
```

# 开始升级
接下来的升级操作都在新的 bkhelmfile 目录下进行：
``` bash
# 进入新的工作目录
cd "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/"
```

## ingress-nginx
推荐完成“固定 ingress-nginx 的节点”章节，可以保持节点 IP 不变。

```bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
```

## 蓝鲸内置存储服务
存储服务基本没有变动，本次新增了 etcd。

### 部署 etcd

```bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-etcd sync
```

## 升级蓝鲸基础套餐
### 升级 bkauth/bkrepo
升级的时候，由于 bkrepo localpv 绑定，被调度的 Node 可能会导致 CPU 不足，请升级前先确保充足的资源，或者清理一些 Pod 来释放 CPU。

```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth -l name=bk-repo sync
```

### 升级 bkapigateway

详细细节请参考 [API网关：如何从 chart 0.4.x 迁移到 1.10.x](https://github.com/TencentBlueKing/blueking-apigateway/issues/189)

1. 准备金丝雀发布的 /tmp/bkapigateway-values-canary.yaml

    ```yaml
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

2. 导出新版 apigateway 的 values：

    ```bash
    helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway write-values --output-file-template /tmp/bkapigateway-values.yaml
    ```

3. 安装金丝雀 release：

    ```bash
    apigw_version=$(yq e '.version.bk-apigateway' environments/default/version.yaml)

    helm install bk-apigateway-canary -n blueking --version $apigw_version blueking/bk-apigateway -f /tmp/bkapigateway-values.yaml -f /tmp/bkapigateway-values-canary.yaml --wait
    ```

4. 等待 canary 的 release 都部署完成。再执行以下命令：

    ```bash
    ## 检查 bk-esb 组件数据，并将其同步到 apigateway
    # 进入 dashboard 容器
    dashboard_pod_name=$(kubectl get pod -n blueking -l app.kubernetes.io/component=dashboard,app.kubernetes.io/instance=bk-apigateway-canary -o jsonpath='{.items[*].metadata.name}')

    dashboard_namespace=$(kubectl get pod -n blueking -l app.kubernetes.io/component=dashboard,app.kubernetes.io/instance=bk-apigateway-canary -o jsonpath='{.items[*].metadata.namespace}')

    kubectl exec -n $dashboard_namespace -it $dashboard_pod_name -- bash
    ```
    在新的 bash 窗口中，执行如下命令：
    ``` bash
    # 拆分组件：检查组件中同一 path 是否存在 method=""，及其它方法的组件，此类组件需要拆分或调整
    # 执行过程中：部分组件直接修改，部分组件会要求确认。
    # 注意：该命令执行成功后，没有任何输出。
    python manage.py split_component_method

    # 同步 bk-esb 组件到 apigateway（预期 3 分钟左右）
    python manage.py sync_to_gateway_and_release

    # 同步组件权限数据到 apigateway（无任何输出）
    python manage.py sync_esb_permissions_to_gateway

    ## 同步 dashboard 数据到 etcd
    # 执行 django command，将网关数据同步到 etcd
    python manage.py sync_releases_to_shared_micro_gateway
    ```
    执行完毕后，如果没有报错，即可退出 bash。

5. 执行完成后，更新 bkapigateway：

    ```bash
    helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
    ```

6. 升级成功后，删除中间辅助的 canary release：

    ```bash
    helm uninstall -n $dashboard_namespace bk-apigateway-canary
    ```

### 升级第二层组件

```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
```

#### 权限中心升级操作

由于权限中心在本次版本中新增了 RBAC 相关的接入功能, 对用户组鉴权数据做了较大的变更 所以升级前，需要使用数据迁移。

请跟随本文完成升级操作。

下载迁移脚本

```bash
curl -L -o scripts/migrate_subject_system_group.py https://bkopen-1252002024.file.myqcloud.com/ce/3c2955e/migrate_subject_system_group.py

chmod +x scripts/migrate_subject_system_group.py
```

执行迁移

```bash
bkiam_saas_podname=$(kubectl get pod -n blueking -l app.kubernetes.io/instance=bk-iam-saas,app.kubernetes.io/name=bkiam-saas,appModule=api -o jsonpath='{.items[0].metadata.name}')
# 将迁移脚本放入pod
kubectl cp scripts/migrate_subject_system_group.py -n blueking $bkiam_saas_podname:/app/
# 安装迁移脚本所需的依赖
kubectl exec -it -n blueking $bkiam_saas_podname -- pip3 install PyMySQL

# 开始执行
mysql_host=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.host')
mysql_port=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.port')
mysql_user=root
mysql_passwd=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkhelmfile/blueking/environments/default/{values,custom}.yaml | yq ea '.mysql.rootPassword')

kubectl exec -it -n blueking $bkiam_saas_podname -- python3 /app/migrate_subject_system_group.py -H ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p ${mysql_passwd} -D bkiam migrate


# 检查
kubectl exec -it -n blueking $bkiam_saas_podname -- python3 /app/migrate_subject_system_group.py -H ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p ${mysql_passwd} -D bkiam check
```

>**提示**
>
>此章节基于产品升级文档编写： [权限中心 V3 后台 从 <1.11.9 升级到 >=1.12.x](../../IAM/IntegrateGuide/HowTo/OPS/Upgrade.md)

### 升级第三层的组件

#### 变更须知

1. bkgse 的配置项不兼容的变更：gseData.config.netdev 变为 gseData.config.netDeviceName 取值是网卡名，gseData 会读取该网卡的流量参数，基于流量做负载均衡。一般是内网网卡名 (默认为 `eth0`),如有出入，请以实际的网卡名称进行修改。

2. bkpaas3 的配置项调整比较大，最主要的是将 workloads 模块的配置合并到 apiserver 中。新增 externalDatabase.workloads 配置，如果在 7.0 部署中自定义配置了 bkpaas3 的数据库，则需要自行处理这个配置项。在 `environments/default/bkpaas3-custom-values.yaml.gotmpl` 中新增对应的 externalDatabase.workloads 配置，如无自定义可跳过该步骤。

3. 新增了一个模块 bkpaas-app-operator，默认部署在 bkpaas-app-operator-system 命名空间下，可以通过 `custom.yaml` 新增 `paas.appOperator.namesapce` 配置项来修改命名空间。如修改需要可跳过该步骤

4. 处理完需要自定义的配置后，可以开始更新第三层的组件，但是先排除掉 bk-paas(开发者中心）

    ```bash
    helmfile -f base-blueking.yaml.gotmpl -l seq=third,name!=bk-paas sync
    ```

5. 卸载旧版本的 bk-paas

    ```bash
    ./scripts/uninstall.sh -y bk-paas
    ```

6. 安装新版本的 bk-paas

    ```bash
    helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync
    ```

7. bk-paas 安装过程主要 job ` bkpaas3-apiserver-init-data` 会耗时较长，可以观察它的日志输出

    ```bash
    kubectl logs -n blueking -l job-name=bkpaas3-apiserver-init-data-1 -f
    ```

8. 更新 paas runtimes：[上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)。

### 升级第四层-作业平台
提前保存旧的版本号：
``` bash
JOB_OLD_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')
```

新增自定义配置，先关闭作业平台对接 GSE Agent v2 的功能开关：

```bash
touch ./environments/default/bkjob-custom-values.yaml.gotmpl
yq -i '.job.features.gseV2.enabled = false' ./environments/default/bkjob-custom-values.yaml.gotmpl
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
```

跑升级后置命令（作业平台 3.5 ->3.7，需要运行）

作业平台详细升级说明可查看 [作业平台升级说明](https://github.com/TencentBlueKing/bk-job/blob/master/UPGRADE.md)，相关命令请以下述为主，文档仅提供参考，请知悉。

```bash
# 获取更新后的 job appVersion
JOB_NEW_VERSION=$(helm ls -n blueking -o json | jq -r '.[] | select(.name=="bk-job") | .app_version')

# 执行前，请确保下述两个变量的值为非空
echo $JOB_OLD_VERSION $JOB_NEW_VERSION

# 运行 upgrader 的 pod
kubectl run -n blueking --image-pull-policy=Always --image="hub.bktencent.com/blueking/job-migration:$JOB_NEW_VERSION" bk-job-upgrade　-- sleep infinity

# 确认 pod 变成 Running 状态
kubectl wait -n blueking --for=condition=ready pod bk-job-upgrader

# 生成升级所需的配置文件
kubectl exec -n blueking bk-job-upgrader -- cat ./upgrader.properties.tpl | bash ./scripts/get_job_upgrade_env.sh | kubectl exec -i -n blueking bk-job-upgrader -- /bin/bash -c 'cat > ./upgrader.properties'

# 确认下生成的配置文件内容合乎预期
kubectl exec -n blueking bk-job-upgrader -- cat ./upgrader.properties

# 执行升级作业
# 执行完成命令后，终端输出的日志种的结尾几行有 "All xx upgradeTasks finished successfully" 字样则表示升级成功
kubectl exec -n blueking -i bk-job-upgrader -- ./runUpgrader.sh $JOB_OLD_VERSION $JOB_NEW_VERSION

# 升级完成后，删除 pod
kubectl delete -n blueking pod bk-job-upgrader
```

### 升级第五层-节点管理
```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync
```
如果提示 `bkrepo没有 blueking 项目，请检查bkrepo安装是否正确`，请检查更新中控机 hosts，可能之前部署 ingress-nginx 导致节点 IP 变动。

### 升级 SaaS

更新标准运维：
```bash
./scripts/setup_bkce7.sh -i sops -f
```

更新 itsm：
```bash
./scripts/setup_bkce7.sh -i itsm -f
```

## 升级容器管理平台
如果有自建集群需求，需要根据 [部署容器管理平台](./install-bcs.md)，更新标准运维模板。

确保 `bcs-api.$BK_DOMAIN` 域名的解析，先更新 coredns：
```bash  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bcs-api.$BK_DOMAIN
./scripts/control_coredns.sh list
```
用户侧也需要配置这些域名，操作步骤已经并入 《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

开始更新：
```bash
helmfile -f 03-bcs.yaml.gotmpl sync
```

## 升级监控日志平台
### 升级监控平台

```bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

升级后操作

```bash
pod_name=$(kubectl get pod -n blueking -l process=api,app.kubernetes.io/instance=bk-monitor -o name | head -1)
kubectl exec -it $pod_name -n blueking -- python manage.py iam_upgrade_action_v2
```
成功后会输出以下字样：`Congratulations! IAM upgrade successfully!!!`。

### 升级日志平台

```bash
helmfile -f 04-bklog-search.yaml.gotmpl sync
```
