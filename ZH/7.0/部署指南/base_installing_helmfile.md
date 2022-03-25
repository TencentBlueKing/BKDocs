

# 下载
在 **中控机** 下载官方提供的  `bkce-helmfile`  包，它包含了  `helmfile`  的二进制（管理并渲染helm的values来进行轻编排的命令行工具）以及容器化蓝鲸社区版部署的相关yaml配置模板。

``` bash
wget -c -O ~/bkce-helmfile.tgz http://bkopen-1252002024.file.myqcloud.com/ce7/bkce-helmfile.tgz
wget -O ~/example_bkce_cert.tgz http://bkopen-1252002024.file.myqcloud.com/ce7/example_bkce_cert.tgz
mkdir -p ~/bkhelmfile && tar xf ~/bkce-helmfile.tgz -C ~/bkhelmfile
tar xf ~/example_bkce_cert.tgz -C ~/bkhelmfile/blueking/environments/default/
cp -a ~/bkhelmfile/bin/helmfile ~/bkhelmfile/bin/helm ~/bkhelmfile/bin/yq /usr/local/bin/ && chmod +x /usr/local/bin/helm* /usr/local/bin/yq
tar xf ~/bkhelmfile/bin/helm-plugin-diff.tgz -C ~/
```

添加公网蓝鲸社区版的  `helm chart repo`  （存放蓝鲸社区版7.0的各  `charts`  包），假设repo名为 blueking，本文档后续内容均以blueking repo来指代；添加开源的bitnami的charts仓库，也可根据自己需要他添加其他公网的chart仓库。

``` bash
helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm repo list
```

# 配置
## 进入工作目录
本文默认工作目录为 `~/bkhelmfile/blueking/`，另有注明除外。
`
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
kubectl config set-context --current --namespace=blueking  # 设置k8s默认ns, 方便后续操作.
```

## 配置访问域名

默认的域名在  `environments/default/values.yaml`  文件中，配置项 `domain.bkDomain` 默认值为 `paas.example.com`。它决定了访问蓝鲸平台的一系列子域名，建议修改为您自有的域名。

如果需要自定义参数，需要新建文件  `environments/default/custom.yaml`  ，将需要自定义的配置项从values.yaml复制到该文件中，然后进行修改，它的优先级高于默认的values.yaml。

例如，需要自定义域名 `bkce7.bktencent.com`，可以使用命令：
``` bash
cat <<EOF >> environments/default/custom.yaml
domain:
  bkDomain: bkce7.bktencent.com
EOF
```

如果是在公有云服务上搭建的，配置的域名应为您已经在对应云服务商平台接入备案的域名。

## 生成蓝鲸app code对应的secret
``` bash
./scripts/generate_app_secret.sh ./environments/default/app_secret.yaml
```

## 生成apigw所需的keypair
``` bash
./scripts/generate_rsa_keypair.sh ./environments/default/bkapigateway_builtin_keypair.yaml
```

## 生成paas所需的clusterAdmin
``` bash
./scripts/create_k8s_cluster_admin_for_paas3.sh
```

## 安装ingress controller
``` bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync

# 获取ingress controller pod运行的节点信息
kubectl get pod -o wide -n blueking | grep ingress-nginx-controller
```

## 集群内DNS解析
我们需要确保一些域名能解析到ingress controller。

因此需要注入hosts配置项到coredns，步骤如下：

``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请和 domain.bkDomain 保持一致.
IP1=$(kubectl -n blueking get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
IP2=$(kubectl -n blueking get svc -l app=bk-ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bkrepo.$BK_DOMAIN docker.$BK_DOMAIN $BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN bkiam.$BK_DOMAIN
./scripts/control_coredns.sh update "$IP2" apps.$BK_DOMAIN
```

确认注入结果，执行如下命令：
```
kubectl describe configmap coredns -n kube-system
```
其输出中应该包含如下内容：
```
Name:         coredns
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Data
====
Corefile:
----
.:53 {
    略
    hosts {
        10.0.0.4 bkrepo.bkce7.bktencent.com
        10.0.5.4 docker.bkce7.bktencent.com
        10.0.0.4 bkce7.bktencent.com
        10.0.0.4 bkapi.bkce7.bktencent.com
        10.0.0.4 bkpaas.bkce7.bktencent.com
        10.0.0.4 bkiam-api.bkce7.bktencent.com
        10.0.5.4 bkiam.bkce7.bktencent.com
        fallthrough
    }
    略
```

# 部署基础套餐后台

执行部署基础套餐命令（该步骤根据机器环境配置，大概需要8-16分钟）
``` bash
helmfile -f base.yaml.gotmpl sync
```

此时可以新开一个终端下，执行如下命令观察pod状态变化：
``` bash
kubectl get pods -n blueking -w
```
等待所有pod都变成Running或Completed状态。

如果pod处于 `Pending` 超过5分钟或者处于异常状态, 可以查看详情, 此处以 `bk-mongodb-0` 为例:
``` bash
kubectl describe pods -n blueking bk-mongodb-0
```
观察 `Events`下方的提示信息, 正常情况下为 `<none>`:
``` text
Events:          <none>
```

如果pod `Crash` 或 `Error`, 建议查看pod下全部容器的日志(强烈建议先配置命令行补全, 这样能补齐pod里的container名).
命令语法如下:
```
kubectl logs -n blueking POD名(建议补全出来) container名(建议补全出来)
```
