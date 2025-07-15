
蓝鲸基础套餐的部署主要分为两个部分：先在中控机部署后台；然后在浏览器安装并配置 SaaS 。

>**提示**
>
>蓝鲸 7.0 版本于 2023 年 10 月底停止标准维护，不提供单产品更新及补丁修复。于 2024 年 10 月底停止安全修复。<br />
>新用户请直接 [部署 7.1 版本](../7.1/index.md)，存量用户可以 [升级到 7.1 版本](../7.1/v70-upgrade-to-v71.md)。

# 准备工作
## 安装下载脚本
CentOS 支持在当前用户的 `bin` 目录下安装命令：
``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-stable/bkdl-7.0-stable.sh -o ~/bin/bkdl-7.0-stable.sh
chmod +x ~/bin/bkdl-7.0-stable.sh
```

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
node_ips=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')
test -f /root/.ssh/id_rsa || ssh-keygen -N '' -t rsa -f /root/.ssh/id_rsa  # 如果不存在rsa key则创建一个。
# 开始给发现的ip添加ssh key，期间需要您输入各节点的密码。
for ip in $node_ips; do
  ssh-copy-id "$ip" || { echo "failed on $ip."; break; }  # 如果执行失败，则退出
done
```

常见报错：
1. `Host key verification failed.`，且开头提示 `REMOTE HOST IDENTIFICATION HAS CHANGED`: 检查目的主机是否重装过。如果确认没连错机器，可以使用 `ssh-keygen -R IP地址` 命令删除 `known_hosts` 文件里的记录。

## 下载所需的资源文件
鉴于目前容器化的软件包数量较多且变动频繁，我们提供了下载脚本。

请使用如下命令下载蓝鲸基础套餐 helmfile 及公共证书。
``` bash
bkdl-7.0-stable.sh -ur latest base cert
```

网络策略要求：
1. 中控机（部署前文件下载，以及部署开始时下载 charts）：
   1. 需要能访问蓝鲸静态文件分发站点：`https://bkopen-1252002024.file.myqcloud.com`。
   2. 需要能访问蓝鲸 Helm repo：`https://hub.bktencent.com/`。
2. k8s node（部署期间需要联网下载容器镜像）：
   1. 需要能访问 Docker Hub： `https://docker.io` 等。
   2. 需要能访问蓝鲸 Docker registry： `https://hub.bktencent.com/`。


# 部署基础套餐后台
本章节提供了 2 种等价的操作。您可按需选择其中一种：
* 如果您希望尽快体验蓝鲸，使用“一键部署”脚本填写域名即可开始部署，详见本文“一键部署基础套餐后台”章节。
* 如果您打算研究部署细节，期间需要手动执行 `helmfile` 命令及一些代码片段，请查阅 《[分步部署基础套餐后台](install-base-manually.md)》 文档。


<a id="setup_bkce7-i-base" name="setup_bkce7-i-base"></a>

## 一键部署基础套餐后台

下文中会使用 “一键脚本” 来称呼 `setup_bkce7.sh`，本次用到的参数如下：
1. `-i base`：指定要安装的模块。关键词 `base` 表示基础套餐的后台部分。
2. `--domain BK_DOMAIN`：指定蓝鲸的基础域名（下文也会使用 `BK_DOMAIN` 这个变量名指代）。

>**提示**
>
>当你的内网存在蓝鲸 V6 或更早版本的环境时，请勿复用基础域名。以免 Cookie 冲突，导致频繁提示登录，甚至循环提示登录。
>
>示例：当 V6 环境使用了 `bktencent.com` 时，其访问地址为 `paas.bktencent.com`。V7 环境不能使用 `bkce7.bktencent.com`、 `bktencent.com` 或者 `xx.bkce7.bktencent.com` 作为基础域名。

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

脚本耗时 8 ~ 16 分钟，请耐心等待。部署成功会高亮提示 `install finished，clean pods in completed status`。

>**提示**
>
>**如果部署期间出错，请先查阅 《[问题案例](troubles.md)》文档。**
>
>问题解决后，可重新执行上面的命令。


## 分步部署基础套餐后台
具体操作请查阅 [分步部署基础套餐后台](install-base-manually.md) 。


# 配置 DNS
k8s 的网络拓扑结构比较复杂，当您从不同的网络区域访问时，需要使用不同的入口地址。

您需要完成如下全部场景的配置：
* k8s pod 内访问蓝鲸，需要配置 coredns。
* 在 k8s node 主机访问蓝鲸，需要配置 k8s node 的 DNS。
* 中控机调用蓝鲸接口，需要配置中控机的 DNS。
* 您在电脑上访问蓝鲸，需要配置用户侧的 DNS。

场景配置细节请查阅本章的各小节。

<a id="hosts-in-coredns" name="hosts-in-coredns"></a>

## 配置 coredns
我们需要确保 k8s 集群的 pod 能解析到蓝鲸域名。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

请继续补充配置如下域名，方便后续使用：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN $BK_DOMAIN
```

>**提示**
>
>“一键部署” 脚本中自动完成了部署时所需的部分域名，《[分步部署基础套餐后台](install-base-manually.md)》 文档的 “[配置 coredns](install-base-manually.md#hosts-in-coredns)” 章节保持和脚本一致。


<a id="hosts-in-k8s-node" name="hosts-in-k8s-node"></a>

## 配置 k8s node 的 DNS
k8s node 需要能从 bkrepo 中拉取镜像。因此需要配置 DNS 。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

请在 **中控机** 执行如下脚本 **生成 hosts 内容**，然后将其追加到所有的 `node` 的 `/etc/hosts` 文件结尾。

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
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
  IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
  ```
  >**注意**
  >
  >如果 Pod 重新调度，所在 node 发生了变动，则需更新 hosts 文件。
* 当中控机为 k8s 的 master 或 node 时，需要取服务的 `clusterIP`：
  ``` bash
  IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
  ```
  >**注意**
  >
  >当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

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
$IP1 bknodeman.$BK_DOMAIN
$IP1 apps.$BK_DOMAIN
EOF
```

<a id="hosts-in-user-pc" name="hosts-in-user-pc"></a>

## 配置用户侧的 DNS
蓝鲸设计为需要通过域名访问使用。所以您需先配置所在内网的 DNS 系统，或修改本机 hosts 文件。然后才能在浏览器访问。

>**注意**
>
>如 k8s 集群重启等原因重新调度，pod 所在 node 发生了变动，需更新 hosts 文件。

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
if [ -z "$BK_DOMAIN" ] || [ -z "$IP1" ]; then
  echo "请先赋值 BK_DOMAIN 及 IP1."
else
  echo "# bkce7 hosts配置项，ingress-nginx pod所在的主机变动后需更新。"
  cat <<EOF | sed 's/ *#.*//'
$IP1 $BK_DOMAIN  # 蓝鲸桌面
$IP1 bkrepo.$BK_DOMAIN  # 蓝鲸制品库
$IP1 bkpaas.$BK_DOMAIN  # 开发者中心
$IP1 bkuser.$BK_DOMAIN  # 用户管理
$IP1 bkuser-api.$BK_DOMAIN  # 用户管理
$IP1 bkapi.$BK_DOMAIN  # 开发者中心 API 网关
$IP1 apigw.$BK_DOMAIN  # 开发者中心 API 管理
$IP1 bkiam.$BK_DOMAIN  # 权限中心
$IP1 bkiam-api.$BK_DOMAIN  # 权限中心
$IP1 cmdb.$BK_DOMAIN  # 配置平台
$IP1 job.$BK_DOMAIN  # 作业平台
$IP1 jobapi.$BK_DOMAIN  # 作业平台
$IP1 bknodeman.$BK_DOMAIN  # 节点管理
$IP1 apps.$BK_DOMAIN  # SaaS 入口：标准运维、流程服务等
$IP1 bcs.$BK_DOMAIN  # 容器管理平台
$IP1 bcs-api.$BK_DOMAIN  # 容器管理平台
$IP1 bklog.$BK_DOMAIN  # 日志平台
$IP1 bkmonitor.$BK_DOMAIN  # 监控平台
$IP1 devops.$BK_DOMAIN  # 持续集成平台-蓝盾
EOF
fi
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

一共需要准备 3 项：
1. 确保 node 能拉取 SaaS 镜像
2. 可选：上传 PaaS runtimes 到 bkrepo
3. 可选：配置 SaaS 专用 node

如需快速体验，可以先跳过可选步骤。对应章节的导语中有简介及使用场景，请按需部署。

<a id="k8s-node-docker-insecure-registries" name="k8s-node-docker-insecure-registries"></a>

## 确保 node 能拉取 SaaS 镜像

从蓝鲸 7.0 开始，PaaS 默认使用 `image` 格式的 `S-Mart` 包，部署过程中需要访问 bkrepo 提供的 docker registry 服务（入口域名为前面章节中配置的 `docker.$BK_DOMAIN`）。

k8s 运行时默认使用 https 协议拉取镜像，所以需要额外操作确保正常拉取镜像。

如果你的运行时为 `dockerd`，请根据你预期的场景选择对应章节：
* 场景一：调整 dockerd 使用 http 协议访问 registry（推荐做法，步骤见下）
* 场景二：配合 dockerd 默认行为（不提供操作步骤，请阅读对应章节获取提示）
>**注意**
>
>如果你的运行时为 `containerd`，不能直接照搬下面的命令，需自行研究。注意二者配置文件格式不同。

### 场景一：调整 dockerd 使用 http 协议访问 registry

docker 服务端支持使用 http 协议拉取镜像，但需要调整配置项。

本章节命在 **中控机** 执行，请先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
```

然后按步骤操作：
>**注意**
>
>下面的步骤均使用 docker 默认的配置文件路径： `/etc/docker/daemon.json` 。如果你的 k8s dockerd 配置文件路径不同，请注意修改。

1.  获取当前配置文件作为模板。接下来会使用此文件模板覆盖全部 node 上的对应路径，如果各 node 配置文件内容不同，请自行分批获取模板。
    * 如果中控机不是 k8s master，建议从 master 上获取：
      ``` bash
      # 取第一台master的ip
      first_master=$(kubectl get nodes -l node-role.kubernetes.io/master -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
      scp "$first_master":/etc/docker/daemon.json daemon.json.orig
      ```
    * 如果中控机是 master：
      ``` bash
      cp /etc/docker/daemon.json daemon.json.orig
      ```
2.  生成新的配置文件：
    ``` bash
    BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
    jq --arg k "insecure-registries" --arg v "docker.$BK_DOMAIN" 'if .[$k]|index($v) then . else .[$k]+=[$v] end' daemon.json.orig | tee daemon.json
    ```
3.  检查内容无误后，即可将 `daemon.json` 分发到全部 k8s node 上的 `/etc/docker/daemon.json`（如果各 node 配置文件路径不同，请自行分批操作。）：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    now=$(date +%Y%m%d-%H%M%S)
    for ip in $all_nodes; do
      ssh "$ip" "cp /etc/docker/daemon.json /etc/docker/daemon.json.bak-$now"
      scp daemon.json "$ip":/etc/docker/daemon.json
      ssh "$ip" "diff /etc/docker/daemon.json /etc/docker/daemon.json.bak-$now"
    done
    ```
4.  然后通知 docker 服务重载配置文件。在中控机执行如下命令可以通知全部 node 上的 docker 服务：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    for ip in $all_nodes; do
      ssh "$ip" "systemctl reload dockerd.service || systemctl reload docker.service"
    done
    ```
    视 docker 部署方式差异，docker 服务名有 `docker.service` 和 `dockerd.service` 两种情况。
    当下一步检查发现未生效时，可能是配置文件异常，可以登录到 node 上检查服务的 journal：`journalctl -xeu docker服务的名字`。
5.  检查确认已经生效：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    for ip in $all_nodes; do
      echo "=== config in $ip: ==="
      ssh "$ip" "docker info | sed -n '/Insecure Registries:/,/^ [^ ]/p'"
    done
    ```
    预期输出如下所示，可看到新添加的 `docker.$BK_DOMAIN` ：
    ``` yaml
     Insecure Registries:
      docker.bkce7.bktencent.com
      127.0.0.0/8
     Registry Mirrors:
    ```

全部 node 配置成功后，即可继续部署。如果检查发现部分 node 没有生效，请登录到对应 node 逐步操作排查原因。

### 场景二：配合 docker 服务默认行为
如果希望使用 https 协议访问 registry。则需要变更 ingress-nginx，并更新各 node 证书库。确保 node 和 registry 间能成功建立 SSL 连接。

>**提示**
>
>此场景未经完整测试，仅简述技术要点，具体步骤请自行研究。欢迎你在社区分享经验。

第一步需要调整 ingress-nginx，为 `docker.$BK_DOMAIN` 域名启用 SSL 并配置证书。

然后根据你的证书情况检查全部 node（包括 master）：
* 如果你为 `docker.$BK_DOMAIN` 域名购买了商业证书，则系统预置了 root CA，无需额外操作。如果依旧提示证书不可信，可以先尝试更新 node 所在系统的根证书包（CentOS 7 使用 `yum install ca-certificates` 命令更新）。
* 如使用了自签的证书，则：
  1. 为 node 添加自签证书（PEM 格式）的 root CA 到此路径：`/etc/docker/cert./docker.$BK_DOMAIN/ca.crt`。（建议一并更新操作系统 root CA 数据库。）
  2. 重启 node 上的 docker 服务。

>**提示**
>
>docker ssl 的更多配置可以参考 [docker 官方文档](https://docs.docker.com/engine/security/certificates/)。

## 可选：上传 PaaS runtimes 到 bkrepo
具体操作请查阅《[上传 PaaS runtimes 到 bkrepo](paas-upload-runtimes.md)》文档。

在如下场景下用到：
1. 目前蓝鲸官方 SaaS 包格式为 `image`，如需部署 `package` 格式的 `S-Mart` 包，需要使用到编译工具。
2. 用户通过 PaaS 自行开发 SaaS 时。

## 可选：配置 SaaS 专用 node
具体操作请查阅《[配置 SaaS 专用 node](saas-dedicated-node.md)》文档。

在资源充足的情况下，建议单独给 SaaS 分配单独的 `node`。因为 SaaS 部署时，编译会产生高 IO 和高 CPU 消耗。原生 k8s 集群的 io 隔离暂无方案，这样会影响到所在 `node` 的其他 `pod`。

# 部署基础套餐 SaaS
在前面部署蓝鲸后台时包含了 开发者中心、配置平台、作业平台 等平台和用户管理、权限中心两个 SaaS。

其他蓝鲸智云官方的 SaaS 应用，比如标准运维、流程服务等需要通过开发者中心来部署。
节点管理虽然实现了 Charts 化改造，无需在开发者中心部署。但存在较多的配置操作，故而依旧放在 SaaS 章节。

>**提示**
>
>部署时 开发者中心 会基于 S-Mart 安装包制作该 SaaS 的 docker 镜像并上传到 bkrepo。<br/>
>您在前面的步骤中已经配置过 DNS 及 docker 服务，期间如有新增 node，可查阅本文 “配置 k8s node 的 DNS” 和 “调整 node 上的 docker 服务” 章节补齐操作。

如同刚才部署后台一般，本章节也提供了 2 种等价的操作。您可按需选择其中一种：
* 我们提供的脚本可完成大部分操作，方便快捷，详见本文“一键部署基础套餐 SaaS” 章节。
* 如需研究 SaaS 部署的细节，请查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档。

<a id="setup_bkce7-i-saas" name="setup_bkce7-i-saas"></a>

## 一键部署基础套餐 SaaS
在 **中控机** 下载所需的文件。
``` bash
bkdl-7.0-stable.sh -ur latest saas  # 下载SaaS安装包及节点管理托管的常用文件
```
如果你计划管控多个云区域的主机，或者管控 32 位操作系统主机，请补充下载完整的待托管文件：
``` bash
bkdl-7.0-stable.sh -ur latest nm_gse_full  # 节点管理托管的全部文件
```

在 **中控机** 使用 “一键部署” 脚本部署基础套餐 SaaS 到生产环境。
部署节点管理。可顺带上传待托管文件：
``` bash
scripts/setup_bkce7.sh -i nodeman
```
部署流程服务：
``` bash
scripts/setup_bkce7.sh -i itsm
```
部署标准运维：
``` bash
scripts/setup_bkce7.sh -i sops
```

此步骤总耗时 18 ~ 27 分钟。每个 SaaS 部署不超过 10 分钟，如果遇到问题请先查阅 《[问题案例](troubles.md)》文档。

部分 SaaS 需要后续配置，暂时无法在脚本中实现，需您查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档的“[SaaS 部署后的设置](install-saas-manually.md#post-install-bk-saas)”章节手动操作：
<!--
1. bk_lesscode 配置独立域名。
-->
1. bk_nodeman 配置 GSE 环境管理。

>**注意**
>
>本脚本设计为全新安装 SaaS，如 SaaS 已安装会跳过，因此更新 SaaS 需查阅《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档在 开发者中心 上传 `S-Mart` 包并选择新版本部署。重新安装 SaaS 亦需手动操作。


## 手动部署基础套餐 SaaS
因篇幅较大，此章节内容拆分到了《[手动部署基础套餐 SaaS](install-saas-manually.md)》文档。


<a id="k8s-node-install-gse-agent" name="k8s-node-install-gse-agent"></a>

# 给 node 安装 gse agent
>**注意**
>
>使用 “一键脚本” 部署基础套餐 SaaS 时，无法自动 [配置 GSE 环境管理](install-saas-manually.md#post-install-bk-nodeman-gse-env)，请务必手动配置。

需要给集群的 “全部 node”（包括 `master`） 安装 gse agent，并放入《蓝鲸》业务。

agent 用途：
1. job 依赖 `node` 上的 gse agent 进行文件分发。节点管理安装插件时也是通过 job 分发。
2. 容器监控需要通过 `node` 上的 gse agent 完成监控。

因为蓝鲸智云 v6 和 v7 仅为部署形态差异，各产品软件版本会保持一致。故请参考 《[安装蓝鲸 Agent（直连区域）](../../NodeMan/2.2/UserGuide/QuickStart/DefaultAreaInstallAgent.md)》 文档安装 agent。

在节点管理的 “普通安装” 界面，选择 **业务为《蓝鲸》**，云区域为 “直连区域”，安装通道及接入点均使用默认值。
>**提示**
>
>如果误选了《资源池》业务，可等待 agent 安装完毕。然后回到蓝鲸桌面，访问 “配置平台”，进入 “资源” —— “主机” 界面。<br />
>全选刚才新安装的主机，点击 “分配到” 按钮，选择 “业务空闲机池”。在弹窗中选择 《蓝鲸》 业务，点击 “确定” 按钮。完成后可点击顶部导航进入 “业务” 界面，左上角切换业务为 《蓝鲸》，即可看到这批主机。

当安装 agent 完成后，您可以参考 《[插件管理](../../NodeMan/2.2/UserGuide//Feature/Plugin.md)》 文档为所有 agent 批量安装 `bkmonitorbeat` 和 `bkunifylogbeat` 插件，以便使用监控及日志功能。

常见报错：
1. `[script] agent(PID:NNN) is not connect to gse server`，请检查 “配置 GSE 环境管理” 章节的配置是否正确。
2. `命令返回非零值：exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.$BK_DOMAIN; Unknown error`，请检查目标主机的 DNS 配置是否正确，也可临时添加 hosts 记录解决解析问题。或参考 “配置 GSE 环境管理” 章节配置 agent url 为 k8s node IP。
3. `ERROR setup_agent FAILED process check: agentWorker not found (node type:agent)`，agent 启动失败。如果是先添加的 k8s node，然后安装 agent 会遇到此问题。可先行取消调度此 node，然后驱逐所有 pod，并删除主机的 `/var/run/ipc.state.report` 目录。然后先安装 agent，再将 node 加回集群。
