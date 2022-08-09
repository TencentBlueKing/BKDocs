我们已经提供了“一键脚本”，可以完成本文档的全部内容，建议先阅读《[基础套餐部署](install-bkce.md)》文档。


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
蓝鲸平台均需通过域名访问，为了简化域名配置，我们提供了基础域名的配置项 `domain.bkDomain`（也可使用 `BK_DOMAIN` 这个变量名称呼它）。此配置项用于拼接蓝鲸其他系统的访问域名，也是蓝鲸统一登录所需的 cookie 域名。

而 `domain.bkMainSiteDomain` 则为蓝鲸的主站入口域名，一般配置为 `domain.bkDomain` 相同的值。

如果需要自定义参数，需要新建文件 `environments/default/custom.yaml` （下文简称为 `custom.yaml` 文件），此文件用于对 values.yaml 文件的内容进行覆盖。

例如，需要自定义域名 `bkce7.bktencent.com`，可以使用如下命令生成 `custom.yaml` 文件：
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请修改为您分配给蓝鲸平台的主域名
cd ~/bkhelmfile/blueking/  # 进入工作目录
# 可使用如下命令添加域名。如果文件已存在，请手动编辑。
custom=environments/default/custom.yaml
cat >> "$custom" <<EOF
domain:
  bkDomain: $BK_DOMAIN
  bkMainSiteDomain: $BK_DOMAIN
EOF
```

如果您在公有云上部署蓝鲸，请先完成域名备案，否则会被云服务商依法阻断访问请求。

## 配置容器日志目录
平台组件的后台日志采集用。

请在所有 **k8s node** 上执行此命令，预期输出一致：
``` bash
docker info  | awk -F": " '/Docker Root Dir/{print $2"/containers"}'
```
当上述路径一致时，请编辑中控机的 `custom.yaml` 文件，添加如下配置项：
``` bash
apps:
  bkappFilebeat.containersLogPath: "查询到的路径"
```

我们预期您的 k8s node 具备相同的 docker 配置。如果此路径不一致，请先完成 docker 标准化。

## 添加 charts 仓库
蓝鲸 7.0 软件产品通过 https://hub.bktencent.com/ 进行分发。

请先在 helm 中添加名为 `blueking` 的 charts 仓库：
``` bash
helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
helm repo update
helm repo list
```

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

## 生成 localpv
我们默认使用 local pv provisioner 提供存储。

先确认当前的存储提供者。在 中控机 执行：
``` bash
kubectl get sc
```
预期输出一行，且 `NAME` 列的值为 `local-storage (default)`。

如果 `default` 为其他名字，则说明有其他存储供应服务。则无需使用 `localpv`，可跳过本小节。

蓝鲸默认使用 `/mnt/blueking` 目录作为主目录，请勿修改。
执行如下命令开始创建 pv：
``` bash
# 切换到工作目录
cd ~/bkhelmfile/blueking
helmfile -f 00-localpv.yaml.gotmpl sync
```

如果上面没有报错，则可以查看当前的 pv：
``` bash
kubectl get pv
```
预期可以看到很多行。参考输出如下：
``` text
NAME                CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
local-pv-18c3e0ef   98Gi       RWO            Delete           Available           local-storage            6d8h
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
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl -n ingress-nginx get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bkrepo.$BK_DOMAIN docker.$BK_DOMAIN $BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN bkiam.$BK_DOMAIN apps.$BK_DOMAIN
```

确认注入结果，执行如下命令：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
./scripts/control_coredns.sh list
```
参考输出如下：
``` plain
        10.244.0.5 apps.bkce7.bktencent.com
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
