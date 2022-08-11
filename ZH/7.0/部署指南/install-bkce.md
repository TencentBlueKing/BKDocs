
蓝鲸基础套餐的部署主要分为两个部分：先在中控机部署后台；然后在浏览器安装并配置 SaaS 。

# 准备工作
## 中控机安装工具
>**提示**
>
>中控机默认工作目录为 `~/bkhelmfile/blueking/`，另有注明除外。


`jq` 用于在中控机解析服务端 API 返回的 json 数据。

在 **中控机** 执行如下命令：
``` bash
yum install -y jq unzip uuid
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

## 下载所需的资源文件
鉴于目前容器化的软件包数量较多且变动频繁，我们提供了下载脚本。

请使用如下命令下载蓝鲸基础套餐 helmfile 及体验证书。
``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-beta/bkdl-7.0-beta.sh | bash -s -- -ur latest base demo
```

网络策略要求：
1. 中控机（部署前文件下载，以及部署开始时下载 charts）：
   1. 需要能访问蓝鲸静态文件分发站点：`https://bkopen-1252002024.file.myqcloud.com`。
   2. 需要能访问蓝鲸 Helm repo：`https://hub.bktencent.com/`。
2. k8s node（部署期间需要联网下载容器镜像）：
   1. 需要能访问 Docker Hub： `https://docker.io` 等。
   2. 需要能访问蓝鲸 Docker registry： `https://hub.bktencent.com/`。


# 部署基础套餐后台
本章节包含了 2 种等价的操作。您可按需选择其中一种：
* 如果您希望尽快体验蓝鲸，使用 “一键部署” 脚本填写域名即可开始部署，详见 [一键部署基础套餐后台](#setup_bkce7-i-base) 章节。
* 如果您打算研究部署细节，期间需要手动执行 `helmfile` 命令及一些代码片段，请查阅 《[分步部署基础套餐后台](install-base-manually.md)》 文档。


<a id="setup_bkce7-i-base" name="setup_bkce7-i-base"></a>

## 一键部署基础套餐后台
假设您用于部署蓝鲸的域名为 `bkce7.bktencent.com`，使用如下的命令开始部署:
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请修改为您分配给蓝鲸平台的主域名
cd ~/bkhelmfile/blueking/  # 进入工作目录
# 检查域名是否符合k8s域名规范，要全部内容匹配才执行脚本，否则提示域名不符合。
patt_domain='[a-z0-9]([-a-z0-9]*[a-z0-9])(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*'
if grep -P "$patt_domain" <<< "$BK_DOMAIN"; then
  scripts/setup_bkce7.sh -i base --domain "$BK_DOMAIN"
else
  echo "BK_DOMAIN($BK_DOMAIN) does not match pattern($patt_domain)."
fi
```

`setup_bkce7.sh` 脚本的参数解析:
1. `-i base`：指定要安装的模块。关键词 `base` 表示基础套餐的后台部分。
2. `--domain BK_DOMAIN`：指定蓝鲸的基础域名（下文也会使用 `BK_DOMAIN` 这个变量名指代）。

脚本耗时 8 ~ 16 分钟，请耐心等待。部署成功会高亮提示 `install finished，clean pods in completed status`。如果部署期间出错，请先参考 [FAQ](faq.md) 文档排查。


## 分步部署基础套餐后台
具体操作请查阅 [分步部署基础套餐后台](install-base-manually.md) 。


# 配置 DNS
k8s 具备比较复杂的网络拓扑，当您从不同的区域访问时，需要使用不同的入口地址。

我们用到的访问场景如下:
* k8s pod 内解析蓝鲸域名，需要 [配置 coredns](#hosts-in-coredns)
* k8s node 从 bkrepo 拉取镜像，安装 GSE Agent，需要 [配置 k8s node 的 DNS](#hosts-in-k8s-node)
* 中控机调用蓝鲸接口，需要 [配置中控机的 DNS](#hosts-in-bk-ctrl)
* 您在电脑上访问蓝鲸，需要 [配置用户侧的 DNS](#hosts-in-user-pc)

为了简化操作，这些步骤皆以 `hosts` 文件为例。

<a id="hosts-in-coredns" name="hosts-in-coredns"></a>

## 配置 coredns
我们需要确保 k8s 集群的 pod 能解析到蓝鲸域名。

>**注意**
>
>pod 删除重建后，clusterIP 会变动，需刷新 hosts 文件。

详细操作步骤见《[分步部署基础套餐后台](install-base-manually.md)》 文档的 “[配置 coredns](install-base-manually.md#hosts-in-coredns)” 章节。

“一键部署” 脚本中自动完成了此步骤，无需重复操作。

<a id="hosts-in-k8s-node" name="hosts-in-k8s-node"></a>

## 配置 k8s node 的 DNS
k8s node 需要能从 bkrepo 中拉取镜像。因此需要配置 DNS 。

>**注意**
>
>pod 删除重建后，clusterIP 会变动，需刷新 hosts 文件。

请在 **中控机** 执行如下脚本 **生成 hosts 内容**，然后将其追加到所有的 `node` 的 `/etc/hosts` 文件结尾（如 pod 经历删除重建，则需要更新 hosts 文件覆盖 pod 相应的域名）。

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl -n ingress-nginx get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
cat <<EOF
$IP1 $BK_DOMAIN
$IP1 bkrepo.$BK_DOMAIN
$IP1 docker.$BK_DOMAIN
$IP1 bknodeman.$BK_DOMAIN
$IP1 apps.$BK_DOMAIN
EOF
```

<a id="hosts-in-bk-ctrl" name="hosts-in-bk-ctrl"></a>

## 配置中控机的 DNS
中控机的 IP 取值有 2 种情况：
* 当中控机独立于 k8s 集群外，需要使用 node 的内网 IP (`hostIP`)：
  ``` bash
  IP1=$(kubectl -n ingress-nginx get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
  ```
  >**注意**
  >
  >如果 Pod 重新调度，所在 node 发生了变动，则需刷新 hosts 文件。
* 当中控机为 k8s 的 master 或 node 时，需要取服务的 `clusterIP`：
  ``` bash
  IP1=$(kubectl -n ingress-nginx get svc -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
  ```
  >**注意**
  >
  >pod 删除重建后，clusterIP 会变动，则需刷新 hosts 文件。

请先根据中控机的角色选择合适的 IP。然后生成 hosts 内容并手动更新到 `/etc/hosts`：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
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
$IP1 apps.$BK_DOMAIN
EOF
```

<a name="hosts-in-user-pc"></a>

## 配置用户侧的 DNS
蓝鲸设计为需要通过域名访问使用。所以您需先配置所在内网的 DNS 系统，或修改本机 hosts 文件。然后才能在浏览器访问。

>**注意**
>
>如 k8s 集群重启等原因重新调度，pod 所在 node 发生了变动，需刷新 hosts 文件。

获取 ingress-nginx pod 所在机器的内网 IP，记为 IP1。在 **中控机** 执行如下命令可获取 IP1：
``` bash
IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx \
  -o jsonpath='{.items[0].status.hostIP}')
```
如果您不是直接通过内网 IP 访问蓝鲸，则需调整 IP1 的赋值：
* 如果需要使用公网 IP 访问，可手动赋值 `IP1=公网IP`，或者使用如下命令从中控机登录到 node 上查询公网 IP：`IP1=$(ssh "$IP1" 'curl -sSf ip.sb')`。
* 如果使用了负载均衡，可手动赋值 `IP1=负载均衡IP`。

在 **中控机** 执行如下命令生成 hosts 文件的内容：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
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
$IP1 apps.$BK_DOMAIN
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
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
echo "http://$BK_DOMAIN"
```
浏览器访问上述地址即可。记得提前配置本地 DNS 服务器或修改本机的 hosts 文件。

# 准备 SaaS 运行环境
>**注意**
>
>SaaS 部署时需要访问 bkrepo 提供的 docker 服务，请先完成 “[配置 k8s node 的 DNS](#hosts-in-k8s-node)” 章节。

<a id="k8s-node-docker-insecure-registries" name="k8s-node-docker-insecure-registries"></a>

## 调整 node 上的 docker 服务
PaaS v3 开始支持 `image` 格式的 `S-Mart` 包，部署过程中需要访问 bkrepo 提供的 docker registry 服务。

因为 docker 默认使用 https 协议访问 registry，因此需要额外配置。一共有 2 种配置方案：
1. 配置 docker 使用 http 访问 registry（推荐使用，步骤见下文）。
2. 配置 docker 使用 https 访问 registry（暂无文档，请根据如下提示自行研究）：
   1. 用户购买了商业证书： 仅在 bkrepo 配置 docker 域名的证书即可。
   2. 用户自签的证书： 需要在 bkrepo 配置 docker 域名的证书，且在 node 添加自签证书到操作系统 CA 库并重启 docker 服务。

### 配置 docker 使用 http 访问 registry
在 SaaS 专用 node （如未配置专用 node，则为全部 node ）上执行命令生成新的配置文件：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
cat /etc/docker/daemon.json | jq '.["insecure-registries"]+=["docker.'$BK_DOMAIN'"]'
```

检查内容无误后，即可将上述内容写入此 node 上的 `/etc/docker/daemon.json`。如果这些 node 的配置文件相同，您可以在中控机生成新文件后批量替换。

在 node 上检查修改后的配置文件：
``` bash
jq -r  '."insecure-registries"' /etc/docker/daemon.json
```
预期显示如下（如果显示 `null` 或 `[]`，则说明未修改）：
``` json
[
  "docker.bkce7.bktencent.com"
]
```

然后在 node 上 reload docker 服务使修改生效：
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

节点管理实现了 Charts 化改造，但是需要配置 DNS 后方可上传文件。

其他蓝鲸智云官方的 SaaS 应用，比如标准运维、流程服务等需要通过开发者中心来部署。

为了方便您快速体验，我们扩展了 “一键部署” 脚本，实现了 SaaS 的 **全新安装** 以及 **部署前设置**。

<a id="setup_bkce7-i-saas" name="setup_bkce7-i-saas"></a>

## 一键部署基础套餐 SaaS
>**提示**
>
>部署时 开发者中心 会基于 S-Mart 安装包制作该 SaaS 的 docker 镜像并上传到 bkrepo。<br/>
>您刚才已经完成了 “[配置 k8s node 的 DNS](#hosts-in-k8s-node)” 和 “[调整 node 上的 docker 服务](#k8s-node-docker-insecure-registries)” 章节。<br/>
>如果在此期间您有新增 k8s node，则需在新 node 上完成上述章节的操作。

在 **中控机** 使用 “一键部署” 脚本部署基础套餐 SaaS 到生产环境：
``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-beta/bkdl-7.0-beta.sh | bash -s -- -ur latest saas  # 下载SaaS安装包及节点管理托管的常用文件
scripts/setup_bkce7.sh -i nodeman  # 节点管理charts化后使用单独的命令。可上传待托管文件。
scripts/setup_bkce7.sh -i saas
```

此步骤总耗时 18 ~ 27 分钟。每个 SaaS 部署不超过 10 分钟，如果超时请参考 《[FAQ](faq.md)》文档的 “[部署 SaaS 在“执行部署前置命令”阶段报错](faq.md#saas-deploy-prehook)” 章节排查。

部分 SaaS 需要后续配置，暂时无法在脚本中实现，需您查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档的“[SaaS 部署后的设置](install-saas-manually.md#post-install-bk-saas)”章节手动操作：
1. bk_lesscode 配置独立域名。
2. bk_nodeman 配置 GSE 环境管理。

>**注意**
>
>本脚本设计为全新安装 SaaS，如 SaaS 已安装会跳过，因此更新 SaaS 需查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档在 开发者中心 上传 `S-Mart` 包并选择新版本部署。重新安装 SaaS 亦需手动操作。


## 手动部署基础套餐 SaaS
如需了解 SaaS 的完整部署步骤或配置节点管理托管的全部文件等，请查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档。


<a id="k8s-node-install-gse-agent" name="k8s-node-install-gse-agent"></a>

# 给 node 安装 gse agent
>**注意**
>
>使用 “一键脚本” 部署基础套餐 SaaS 时，无法自动 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env)，请务必手动配置。

需要给集群的 “全部 node”（包括 `master`） 安装 gse agent。

用途：
1. job 依赖 `node` 上的 gse agent 进行文件分发。节点管理安装插件时也是通过 job 分发。
2. 容器监控需要通过 `node` 上的 gse agent 完成监控。

>**提示**
>
>如有添加新的 k8s `node` 或 `master`，需为其安装 gse agent。

常见报错：
1. `[script] agent(PID:NNN) is not connect to gse server`，请检查 “配置 GSE 环境管理” 章节的配置是否正确。
2. `命令返回非零值：exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.$BK_DOMAIN; Unknown error`，请检查目标主机的 DNS 配置是否正确，也可临时添加 hosts 记录解决解析问题。或参考 “配置 GSE 环境管理” 章节配置 agent url 为 k8s node IP。
