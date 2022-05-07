我们已经提供了“一键脚本”，可以完成本文档的全部内容，建议先阅读《[基础套餐部署](install-bkce.md)》文档。

# 下载
在 **中控机** 下载官方提供的  `bkce-helmfile`  包，它包含了  `helmfile`  的二进制（管理并渲染 helm 的 values 来进行轻编排的命令行工具）以及容器化蓝鲸社区版部署的相关 yaml 配置模板。

``` bash
wget -c -O ~/bkce-helmfile.tgz https://bkopen-1252002024.file.myqcloud.com/ce7/bkce-helmfile-7.0.1.tgz
wget -O ~/example_bkce_cert.tgz https://bkopen-1252002024.file.myqcloud.com/ce7/example_bkce_cert.tgz
mkdir -p ~/bkhelmfile && tar xf ~/bkce-helmfile.tgz -C ~/bkhelmfile
tar xf ~/example_bkce_cert.tgz -C ~/bkhelmfile/blueking/environments/default/
cp -a ~/bkhelmfile/bin/helmfile ~/bkhelmfile/bin/helm ~/bkhelmfile/bin/yq /usr/local/bin/ && chmod +x /usr/local/bin/helm* /usr/local/bin/yq
tar xf ~/bkhelmfile/bin/helm-plugin-diff.tgz -C ~/
```

添加公网蓝鲸社区版的  `helm chart repo`  （存放蓝鲸社区版 7.0 的各  `charts`  包），假设 repo 名为 blueking，本文档后续内容均以 blueking repo 来指代；添加开源的 bitnami 的 charts 仓库，也可根据自己需要他添加其他公网的 charts 仓库。

``` bash
helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm repo list
```

# 配置
## 进入工作目录
>**提示**
>
>中控机默认工作目录为 `~/bkhelmfile/blueking/`，另有注明除外。

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
kubectl config set-context --current --namespace=blueking  # 设置k8s默认ns, 方便后续操作.
```

## 配置访问域名

默认的域名在  `environments/default/values.yaml`  文件中，配置项 `domain.bkDomain` 默认值为 `paas.example.com`。它决定了访问蓝鲸平台的一系列子域名，建议修改为您自有的域名。

如果需要自定义参数，需要新建文件  `environments/default/custom.yaml`  ，将需要自定义的配置项从 values.yaml 复制到该文件中，然后进行修改，它的优先级高于默认的 values.yaml。

例如，需要自定义域名 `bkce7.bktencent.com`，可以使用命令：
``` bash
cat <<EOF >> environments/default/custom.yaml
domain:
  bkDomain: bkce7.bktencent.com
EOF
```

如果是在公有云服务上搭建的，配置的域名应为您已经在对应云服务商平台接入备案的域名。

## 生成蓝鲸 app code 对应的 secret
``` bash
./scripts/generate_app_secret.sh ./environments/default/app_secret.yaml
```

## 生成 apigw 所需的 keypair
``` bash
./scripts/generate_rsa_keypair.sh ./environments/default/bkapigateway_builtin_keypair.yaml
```

## 生成 paas 所需的 clusterAdmin
``` bash
./scripts/create_k8s_cluster_admin_for_paas3.sh
```

## 安装默认的storageClass，采取local pv provisioner的charts安装。由于bcs.sh脚本默认安装的环境以及自动做好了 /mnt/blueking 目录的挂载。直接用默认参数安装localpv即可。
``` bash
# 切换到~/bkhelmfile/blueking目录，以下如无指定绝对路径，都是相对于  ~/bkhelmfile/blueking  目录的。
cd ~/bkhelmfile/blueking 
helmfile -f 00-localpv.yaml.gotmpl sync
# 确认
kubectl get sc
```

## 安装 ingress controller
部署默认的 ingress controller:
``` bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
kubectl get pod -o wide -n blueking | grep ingress-nginx-controller  # 检查
```

部署蓝鲸开发者中心专用的 ingress controller：
``` bash
helmfile -f 03-saas-cluster.yaml.gotmpl sync
kubectl get pod -o wide -n blueking | grep bk-ingress-nginx  # 检查
```

<a id="hosts-in-coredns" name="hosts-in-coredns"></a>

## 配置 coredns
我们需要确保 k8s 集群的容器内能解析到蓝鲸域名。

>**注意**
>
>pod 删除重建后，clusterIP 会变动，需刷新 hosts 文件。

因此需要注入 hosts 配置项到 `kube-system` namespace 下的 `coredns` 系列 pod，步骤如下：

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=bkce7.bktencent.com  # 请和 domain.bkDomain 保持一致.
IP1=$(kubectl -n blueking get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
IP2=$(kubectl -n blueking get svc -l app=bk-ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bkrepo.$BK_DOMAIN docker.$BK_DOMAIN $BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN bkiam.$BK_DOMAIN
./scripts/control_coredns.sh update "$IP2" apps.$BK_DOMAIN
```

确认注入结果，执行如下命令：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
./scripts/control_coredns.sh list
```
其输出如下：
``` plain
        10.244.0.4 apps.bkce7.bktencent.com
        10.244.0.5 bkrepo.bkce7.bktencent.com
        10.244.0.5 docker.bkce7.bktencent.com
        10.244.0.5 bkce7.bktencent.com
        10.244.0.5 bkapi.bkce7.bktencent.com
        10.244.0.5 bkpaas.bkce7.bktencent.com
        10.244.0.5 bkiam-api.bkce7.bktencent.com
        10.244.0.5 bkiam.bkce7.bktencent.com
        10.244.0.5 bcs.bkce7.bktencent.com
```

# 部署基础套餐后台

执行部署基础套餐命令（该步骤根据机器环境配置，大概需要 8 ~ 16 分钟）
``` bash
helmfile -f base.yaml.gotmpl sync
```

此时可以新开一个终端下，执行如下命令观察 pod 状态变化：
``` bash
kubectl get pods -n blueking -w
```
等待所有 pod 都变成 `Running` 或 `Completed` 状态。

如果 pod 处于 `Pending` 超过 5 分钟或者处于其他异常状态, 可以先查看详情, 此处以 `bk-mongodb-0` 为例:
``` bash
kubectl describe pods -n blueking bk-mongodb-0
```
观察 `Events`下方的提示信息, 正常情况下为 `<none>`:
``` text
Events:          <none>
```

如果 pod `Crash` 或 `Error`, 建议查看 pod 下全部容器的日志(强烈建议先配置命令行补全, 这样能补齐 pod 里的 container 名).
命令语法如下:
``` bash
kubectl logs -n blueking POD名(建议补全出来) container名(建议补全出来)
```
