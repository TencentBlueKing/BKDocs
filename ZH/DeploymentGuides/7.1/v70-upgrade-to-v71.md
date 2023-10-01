# 社区版 7.0 - 7.1 升级指引

>**注意**
>
>目前用户反馈升级指引存在一些问题，请等待文档重新整理后查阅。


## 说明

- 文中所述的目录路径均以默认为主，如与实际有出入，请以升级实际路径为主。
- 如无特殊说明，所述操作均在中控机执行。
- 文档只含模块升级，不含 GSE Agent 升级指引

## 前置准备

### 下载新版本

参考[全新部署文档](./prepare-bkctrl.md)

```bash
# 下载成功后，最新的 helmfile 和默认配置在 ~/bkce7.1-install/blueking 目录下，SaaS 包在 ~/bkce7.1-install/saas 目录下
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh | bash -s -- -ur 7.1.2 bkce demo
```

## 数据备份

### MySQL 备份

根据实际部署情况，备份数据库，参考二进制（待补充）

## 环境检查

升级前，确认当前的 7.0 环境蓝鲸组件运行正常，通过 kubectl 查看是否有非 Running 状态的 Pod。

```bash
kubectl get pods --all-namespaces | awk '$4!="Running"&& $4!="Completed"&& NR>1'
```

### 部署脚本备份

备份当前的 bkhelmfile 目录

```bash
cp -a -r ~/bkhelmfile ~/bkhelmfile_$(date +%Y%m%d%H%M)
```

## 整合 helmfile 目录

升级文档假设 7.0 的 helmfile 目录在 `~/bkhelmfile/`，7.1 的 helmfile 目录在 `~/bkce7.1-install`

1. 如果 7.0 版本部署的时候，没有使用 `environments/default/custom.yaml` 来自定义配置，而是直接修改了 `environments/default/values.yaml`，升级前请自行将这部分自定义配置挪到 `environments/default/custom.yaml` 。

2. 更新当前的 helmfile 目录

    ```bash
    # 请注意，将对应的目录替换为实际目录，不要省略目录末尾 / 。
    rsync -av ~/bkce7.1-install/blueking/ ~/bkhelmfile/blueking/
    ```

3. 升级 yq 二进制版本，确保版本号为 v4.30.6

    ```bash
    curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh | bash -s -- -ur 7.1.2 yq_cmd

    cp -a /usr/local/bin/yq /usr/local/bin/yq.bak
    cp -f ~/bkce7.1-install/bin/yq /usr/local/bin/
    yq --version
    ```

4. 增加自定义配置，先使用gse v1版本，在custom.yaml中，新增配置：

    ```bash
    yq -i '.gse.version = "v1"' ~/bkhelmfile/blueking/environments/default/custom.yaml
    ```

## 开始更新

### 更新平台组件

以下步骤均在更新后的  `~/bkhelmfile/blueking` 目录下执行：

#### 更新repo 仓库

```bash
cd ~/bkhelmfile/blueking
helm repo update blueking
```

#### 更新 ingress-controller

更新 ingress-controller 后会飘到其他 Node上，需要根据部署文档 [配置用户侧DNS](./install-bkce.md) 获取当前的 Node 外网 IP ，来修改 hosts 文件或者配置 DNS 解析。

```bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
```

#### 部署 etcd

```bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-etcd sync
```

#### 更新 bkauth/bkrepo

升级的时候，由于bkrepo localpv绑定，被调度的 Node 可能会导致 CPU 不足，请升级前先确保充足的资源，或者清理一些 Pod 来释放 CPU

```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth -l name=bk-repo sync
```

#### 更新 bkapigateway

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

5. 执行完成后，更新 bkapigateway：

    ```bash
    helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
    ```

6. 升级成功后，删除中间辅助的 canary release：

    ```bash
    helm uninstall -n $dashboard_namespace bk-apigateway-canary
    ```

### 更新第二层组件

```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
```

#### 权限中心升级操作

由于权限中心在本次版本中新增了 RBAC 相关的接入功能, 对用户组鉴权数据做了较大的变更 所以升级前，需要使用数据迁移。详细请阅 [权限中心 V3 后台 从 <1.11.9 升级到 >=1.12.x](../../IAM/IntegrateGuide/HowTo/OPS/Upgrade.md)，升级步骤已整理放置下述命令中，描述中的链接仅供参考，请知悉。

- 下载迁移脚本

    ```bash
    curl -L -o /data/migrate_subject_system_group.py https://bkopen-1252002024.file.myqcloud.com/ce/3c2955e/migrate_subject_system_group.py

    chmod +x /data/migrate_subject_system_group.py

    bkiam_saas_podname=$(kubectl get pod -n blueking -l app.kubernetes.io/instance=bk-iam-saas,app.kubernetes.io/name=bkiam-saas,appModule=api  -o jsonpath='{.items[0].metadata.name}')
    kubectl cp /data/migrate_subject_system_group.py -n blueking $bkiam_saas_podname:/app/
    ```

- 执行迁移

```bash
# 安装依赖
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

### 更新第三层的组件

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

8. 更新 paas runtimes

    ```bash
    # 参考该命令输出的 kubectl run，直接执行该命令即可
    helm status -n blueking bk-paas
    ```

### 更新第四层-作业平台

新增自定义配置，先关闭作业平台对接V2的功能开关：

```bash
yq -n '.job.features.gseV2.enabled = false' >> ./environments/default/bkjob-custom-values.yaml.gotmpl
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
```

### 更新第五层-节点管理

```bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync
```

### 更新 SaaS

1. 更新标准运维：

    ```bash
    cp ~/bkce7.1-install/saas/bk_sops.tgz ~/bkhelmfile/saas/
    ./scripts/setup_bkce7.sh -i sops -f
    ```

2. 更新 itsm

    ```bash
    cp ~/bkce7.1-install/saas/bk_itsm.tgz ~/bkhelmfile/saas/
    ./scripts/setup_bkce7.sh -i itsm -f
    ```

### 更新容器管理平台

参考全新 [部署容器平台文档](./install-bcs.md)

主要注意点：

1. 如果有自建集群需求，需要根据上述全新部署文档，更新标准运维模板。
2. 确保 bcs-api.$BK_DOMAIN 的域名解析

    ```bash  # 进入工作目录
    BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
    IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
    ./scripts/control_coredns.sh update "$IP1" bcs-api.$BK_DOMAIN
    ./scripts/control_coredns.sh list 
    ```

3. 开始更新

    ```bash
    helmfile -f 03-bcs.yaml.gotmpl sync
    ```

### 更新监控平台

```bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

升级后操作

```bash
pod_name=$(kubectl get pod -n blueking -l process=api,app.kubernetes.io/instance=bk-monitor -o name | head -1)
kubectl exec -it $pod_name -n blueking -- python manage.py iam_upgrade_action_v2
# 成功后会输出以下字样："Congratulations! IAM upgrade successfully!!!"
```

### 更新日志平台

```bash
helmfile -f 04-bklog-search.yaml.gotmpl sync
```
