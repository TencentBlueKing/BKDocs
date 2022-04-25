
蓝鲸基础套餐的部署主要分为两个部分：先在中控机部署后台；然后在浏览器安装并配置 SaaS 。

# 准备工作
## 中控机安装工具
`jq` 用于在中控机解析服务端 API 返回的 json 数据。

在 **中控机** 执行如下命令：
``` bash
yum install -y jq
```
>**注意**
>
>CentOS 7 在 **`epel`源** 提供了 `jq-1.6`。如果提示 `No package jq available.`，请先确保 **`epel`源** 可用。

## 在中控机配置 ssh 免密登录
本文中会提供命令片段方便您部署。部分命令片段会从中控机上调用 `ssh` 在 k8s node 上执行远程命令，所以需提前配置免密登录。

在 **中控机** 执行如下命令：
``` bash
k8s_nodes_ips=$(kubectl get nodes -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')
test -f /root/.ssh/id_rsa || ssh-keygen -N '' -t rsa -f /root/.ssh/id_rsa  # 如果不存在rsa key则创建一个。
# 开始给发现的ip添加ssh key，期间需要您输入各节点的密码。
for ip in $k8s_nodes_ips; do
  ssh-copy-id "$ip" || { echo "failed on $ip."; break; }  # 如果执行失败，则退出
done
```

常见报错：
1. `Host key verification failed.`，且开头提示 `REMOTE HOST IDENTIFICATION HAS CHANGED`: 检查目的主机是否重装过。如果确认没连错机器，可以参考提示（如 `Offending 类型 key in /root/.ssh/known_hosts:行号`）删除 `known_hosts` 文件里的对应行。

# 部署基础套餐后台
如果您希望尽快体验蓝鲸，我们提供了“一键部署” 脚本供您选择。

如果您打算研究部署细节，则可以查阅 《[分步部署基础套餐后台](install-base-manually.md)》 文档。

<a id="setup_bkce7-i-base"></a>

## 一键部署基础套餐后台
下载部署脚本并添加可执行权限：
``` bash
curl -Lo ~/setup_bkce7.sh https://bkopen-1252002024.file.myqcloud.com/ce7/setup_bkce7.0.1.sh && \
  chmod +x ~/setup_bkce7.sh
```

假设您用于部署蓝鲸的域名为 `bkce7.bktencent.com`，使用如下的命令开始部署:
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请修改为所需的域名
~/setup_bkce7.sh -i base --domain "$BK_DOMAIN"
```

`setup_bkce7.sh` 脚本的参数解析:
1. `-i base`：指定要安装的模块。关键词 `base` 表示基础套餐的后台部分。
2. `--domain BK_DOMAIN`：指定蓝鲸的基础域名（下文也会使用 `BK_DOMAIN` 指代）。<br/>k8s 要求域名中的字母为**小写字母**，可以使用如下命令校验（输出结果中会高亮显示符合规范的部分）：`echo "$BK_DOMAIN" | grep -P '[a-z0-9]([-a-z0-9]*[a-z0-9])(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*'` 。

此脚本耗时 15 ~ 30 分钟，请耐心等待。部署成功会高亮提示 `install finished，clean pods in completed status`。

>**提醒**
>
>k8s 所有 `node` 机器均需保持网络畅通，可访问蓝鲸提供的镜像地址。


## 分步部署基础套餐后台
具体操作请查阅 [分步部署基础套餐后台](install-base-manually.md) 。


# 配置 DNS
针对访问场景的不同，我们需要配置不同的 DNS 记录:
* k8s pod 间解析蓝鲸域名，需要 [配置 coredns](#hosts-in-coredns)
* k8s node 从 bkrepo 拉取镜像，安装 GSE Agent，需要 [配置 k8s node 的 DNS](#hosts-in-k8s-node)
* 中控机调用蓝鲸接口，需要 [配置中控机的 DNS](#hosts-in-bk-ctrl)
* 您在电脑上访问蓝鲸，需要 [配置用户侧的 DNS](#hosts-in-user-pc)

为了简化操作，这些步骤皆以 `hosts` 文件为例。

<a id="hosts-in-coredns"></a>

## 配置 coredns
>**提示**
>
>“一键部署” 脚本中自动完成了此步骤，可以跳过本章节。

我们需要确保 k8s 集群的容器内能解析到 ingress controller。

>**注意**
>
>pod 删除重建后，clusterIP 会变动，需刷新 hosts 文件。

因此需要注入 hosts 配置项到 `kube-system` namespace 下的 `coredns` 系列 pod，步骤如下：

``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请和 domain.bkDomain 保持一致.
IP1=$(kubectl -n blueking get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
IP2=$(kubectl -n blueking get svc -l app=bk-ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bkrepo.$BK_DOMAIN docker.$BK_DOMAIN $BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN bkiam.$BK_DOMAIN
./scripts/control_coredns.sh update "$IP2" apps.$BK_DOMAIN
```

确认注入结果，执行如下命令：
``` bash
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

<a id="hosts-in-k8s-node"></a>

## 配置 k8s node 的 DNS
k8s node 需要能从 bkrepo 中拉取镜像。因此需要配置 DNS 。

>**注意**
>
>pod 删除重建后，clusterIP 会变动，需刷新 hosts 文件。

请在 **中控机** 执行如下脚本 **生成 hosts 内容**，然后将其追加到所有的 `node` 的 `/etc/hosts` 文件结尾（如 pod 经历删除重建，则需要更新 hosts 文件覆盖 pod 相应的域名）。

``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请和 domain.bkDomain 保持一致.
IP1=$(kubectl -n blueking get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
IP2=$(kubectl -n blueking get svc -l app=bk-ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
cat <<EOF
$IP1 $BK_DOMAIN
$IP1 bkrepo.$BK_DOMAIN
$IP1 docker.$BK_DOMAIN
$IP2 apps.$BK_DOMAIN
EOF
```

<a id="hosts-in-bk-ctrl"></a>

## 配置中控机的 DNS
当中控机为 k8s 集群的成员时，可以参考 “配置 k8s node 的 DNS” 章节改为取 `clusterIP`。
>**注意**
>
>pod 删除重建后，clusterIP 会变动，则需刷新 hosts 文件。

获取 clusterIP：
``` bash
IP1=$(kubectl -n blueking get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
IP2=$(kubectl -n blueking get svc -l app=bk-ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
```

当中控机非 k8s 集群成员时，需要使用 node 的内网 IP (`hostIP`)。
>**注意**
>
>如果 Pod 重新调度，所在 node 发生了变动，则需刷新 hosts 文件。

获取内网 IP：
``` bash
IP1=$(kubectl -n blueking get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP2=$(kubectl -n blueking get pods -l app=bk-ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
```

请先根据中控机的角色选择合适的 IP。然后生成 hosts 内容并手动更新到 `/etc/hosts`：
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请和 domain.bkDomain 保持一致.
# 生成hosts内容
cat <<EOF
$IP1 $BK_DOMAIN
$IP1 bkrepo.$BK_DOMAIN
$IP1 docker.$BK_DOMAIN
$IP1 bkpaas.$BK_DOMAIN
$IP1 bkuser.$BK_DOMAIN
$IP1 bkuser-api.$BK_DOMAIN
$IP1 bkapi.$BK_DOMAIN
$IP1 apigw.$BK_DOMAIN
$IP1 bkiam.$BK_DOMAIN
$IP1 bkiam-api.$BK_DOMAIN
$IP1 cmdb.$BK_DOMAIN
$IP1 job.$BK_DOMAIN
$IP1 jobapi.$BK_DOMAIN
$IP2 apps.$BK_DOMAIN
EOF
```

<a id="hosts-in-user-pc"></a>

## 配置用户侧的 DNS
蓝鲸设计为需要通过域名访问使用。所以您需先配置所在内网的 DNS 系统，或修改本机 hosts 文件。

>**注意**
>
>如 k8s 集群重启等原因重新调度，pod 所在 node 发生了变动，需刷新 hosts 文件。

在 **中控机** 执行如下命令即可获得 hosts 文件的参考内容（如果有新增 node，记得提前更新 ssh 免密）：
``` bash
cd ~/bkhelmfile/blueking/  # 进入蓝鲸helmfile目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 默认从配置中提取, 也可自行赋值

# 获取 ingress-controller pod所在机器的公网ip，记为$IP1
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx \
  -o jsonpath='{.items[0].status.hostIP}')
# 获取外网ip
IP1=$(ssh $IP1 'curl -sSf ip.sb')
# 获取 bk-ingress-controller pod所在机器的公网ip，记为$IP2，它负责SaaS应用的流量代理。
IP2=$(kubectl get pods -n blueking -l app.kubernetes.io/name=bk-ingress-nginx \
  -o jsonpath='{.items[0].status.hostIP}')
# 获取外网ip
IP2=$(ssh $IP2 'curl -sSf ip.sb')
# 人工检查取值
echo "BK_DOMAIN=$BK_DOMAIN IP1=$IP1 IP2=$IP2"
# 输出hosts
cat <<EOF
$IP1 $BK_DOMAIN
$IP1 bkrepo.$BK_DOMAIN
$IP1 bkpaas.$BK_DOMAIN
$IP1 bkuser.$BK_DOMAIN
$IP1 bkuser-api.$BK_DOMAIN
$IP1 bkapi.$BK_DOMAIN
$IP1 apigw.$BK_DOMAIN
$IP1 bkiam.$BK_DOMAIN
$IP1 bkiam-api.$BK_DOMAIN
$IP1 cmdb.$BK_DOMAIN
$IP1 job.$BK_DOMAIN
$IP1 jobapi.$BK_DOMAIN
$IP2 apps.$BK_DOMAIN
EOF
```

# 访问蓝鲸
## 获取 PaaS 登录账户及密码
在 **中控机** 执行如下命令获取登录账户:

``` bash
kubectl get cm -n blueking bk-user-api-general-envs -o go-template='user={{.data.INITIAL_ADMIN_USERNAME}}{{"\n"}}password={{ .data.INITIAL_ADMIN_PASSWORD }}{{"\n"}}'
```
其输出如下：
``` plain
user=用户名
password=密码
```

## 浏览器访问
在 **中控机** 执行如下命令获取访问地址：
``` bash
cd ~/bkhelmfile/blueking/  # 进入蓝鲸helmfile目录
BK_DOMAIN=$(cat environments/default/{values,custom}.yaml 2>/dev/null | yq e '.domain.bkDomain' -)  # 读取默认或自定义域名
echo "http://$BK_DOMAIN"
```
浏览器访问上述地址即可。记得提前配置本地 DNS 服务器或修改本机的 hosts 文件。

# 准备 SaaS 运行环境
>**注意**
>
>SaaS 部署时需要访问 bkrepo 提供的 docker 服务，请先完成 “[配置 k8s node 的 DNS](#hosts-in-k8s-node)” 章节。

<a id="k8s-node-docker-insecure-registries"></a>

## 调整 node 上的 docker 服务
PaaS 支持 `image` 格式的 `S-Mart` 包，部署过程中需要访问 bkrepo 提供的 docker registry 服务。

因为 docker 默认使用 https 协议访问 registry，因此需要额外配置。一共有 2 种配置方案：
1. 配置 docker 使用 http 访问 registry（推荐使用，步骤见下文）。
2. 配置 docker 使用 https 访问 registry（暂无文档，请根据如下提示自行研究）：
   1. 用户购买了商业证书： 仅在 bkrepo 配置 docker 域名的证书即可。
   2. 用户自签的证书： 需要在 bkrepo 配置 docker 域名的证书，且在 node 添加自签证书到操作系统 CA 库并重启 docker 服务。

### 配置 docker 使用 http 访问 registry
在 SaaS 专用 node （如未配置专用 node，则为全部 node ）上执行命令生成新的配置文件：
``` bash
BK_DOMAIN="bkce7.bktencent.com"  # 请按需修改
cat /etc/docker/daemon.json | jq '.["insecure-registries"]+=["docker.'$BK_DOMAIN'"]'
```

检查内容无误后，即可将上述内容写入此 node 上的 `/etc/docker/daemon.json`。如果这些 node 的配置文件相同，您可以在中控机生成新文件后批量替换。

然后 reload docker 服务使之生效：
``` bash
systemctl reload docker
```

检查确认已经生效：
``` bash
docker info
```

预期可看到新添加的 `docker.$BK_DOMAIN` ，如果没有，请检查 docker 服务是否成功 reload：
``` yaml
 Insecure Registries:
  docker.bkce7.bktencent.com
  127.0.0.0/8
```

## 可选：上传 PaaS runtimes 到 bkrepo
具体操作请查阅《[上传 PaaS runtimes 到 bkrepo](paas-upload-runtimes.md)》文档。

在如下场景下用到：
1. 目前蓝鲸官方 SaaS 包格式为 `image`，如需部署 `package` 格式的 `S-Mart` 包，需要使用到编译工具。
2. 用户通过 PaaS 自行开发 SaaS 时。

## 可选：配置 SaaS 专用 node
具体操作请查阅《[配置 SaaS 专用 node](saas-dedicated-node.md)》文档。

在资源充足的情况下，建议单独给 SaaS 分配单独的 `node`。因为 SaaS 部署时，编译会产生高 IO 和高 CPU 消耗。原生 k8s 集群的 io 隔离暂无方案，这样会影响到所在 `node` 的其他 `pod`。

# 部署基础套餐 SaaS
在前面部署蓝鲸后台时包含了 PaaS（开发者中心）、配置平台、作业平台 等平台和用户管理、权限中心两个 SaaS。

其他社区版官方的 SaaS 应用，比如标准运维、节点管理、流程服务等需要通过开发者中心来部署。

为了方便您快速体验，我们扩展了 “一键部署” 脚本，现在可以支持 SaaS 的初次安装 以及部署前设置了。
如 SaaS 已安装会跳过，因此更新 SaaS 需查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档上传 `S-Mart` 包并选择新版本部署。

<a id="setup_bkce7-i-saas"></a>

## 一键部署基础套餐 SaaS
>**注意**
>
>1. 先完成 “[配置 k8s node 的 DNS](#hosts-in-k8s-node)” 章节。
>2. 然后完成 “[调整 node 上的 docker 服务](#k8s-node-docker-insecure-registries)” 章节。

使用 `-i saas` 可以安装全部 SaaS 到生产环境：
``` bash
~/setup_bkce7.sh -i saas
```

此步骤总耗时 18 ~ 27 分钟。每个 SaaS 部署不超过 10 分钟，如果超时请参考 《[FAQ](faq.md)》文档的 “[部署 SaaS 在“执行部署前置命令”阶段报错](faq.md#saas-deploy-prehook)” 章节排查。

也可以只安装单个 SaaS（目前支持 itsm sops nodeman gsekit lesscode ）：
``` bash
~/setup_bkce7.sh -i nodeman  # 安装节点管理到生产环境, -i nodeman@stag 则为预发布环境
```

如下操作未能在脚本中实现，请您查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档的“[SaaS 部署后的设置](install-saas-manually.md#post-install-bk-saas)”章节手动操作：
1. bk_lesscode 配置独立域名。
2. bk_nodeman 配置 GSE 环境管理；上传 gse 插件包。

## 手动部署基础套餐 SaaS
请查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档。

# 给 node 安装 gse agent
>**提示**
>
>需要先部署 “节点管理（bk_nodeman）”并 “配置 GSE 环境管理”。才能安装 agent。

需要给集群的全部 node （包括 master ）机器安装 gse agent。

用途：
1. job 依赖 agent 做文件分发。
2. 容器监控需要通过 node 上的 gse agent 完成监控。

常见报错：
1. `[script] agent(PID:NNN) is not connect to gse server`，请检查 “配置 GSE 环境管理” 章节的配置是否正确。
2. `命令返回非零值：exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.$BK_DOMAIN; Unknown error`，请检查目标主机的 DNS 配置是否正确，也可临时添加 hosts 记录解决解析问题。或参考 “配置 GSE 环境管理” 章节配置 agent url 为 k8s node IP。
