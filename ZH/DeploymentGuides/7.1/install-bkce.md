
蓝鲸基础套餐的部署主要分为两个部分：先在中控机部署后台；然后部署流程服务和标准运维 2 个应用。

# 下载所需的资源文件

>**注意**
>
>在部署前，请确保完成了《[准备中控机](prepare-bkctrl.md)》文档。

鉴于目前容器化的软件包数量较多且变动频繁，我们提供了下载脚本。

请在 **中控机** 使用如下命令下载蓝鲸 helmfile 包及公共证书。
``` bash
bkdl-7.1-stable.sh -ur latest base demo
```

这些文件默认放在了 `~/bkce7.1-install/` 目录，接下来的部署过程中，默认工作目录为 `~/bkce7.1-install/blueking/`。

# 部署基础套餐后台
你可按需选择部署方式：
* 如果你希望尽快体验蓝鲸，使用“一键部署”脚本填写域名即可开始部署，请继续往下阅读。
* 如果你打算研究部署细节，请查阅 《[部署步骤详解 —— 后台](manual-install-bkce.md)》 文档。期间需要手动执行 `helmfile` 命令及一些代码片段。

<a id="setup_bkce7-i-base" name="setup_bkce7-i-base"></a>

## 一键脚本部署基础套餐后台

下文中会使用 “一键脚本” 来称呼 `setup_bkce7.sh`，本次用到的参数如下：
1. `-i base`：指定要安装的模块。关键词 `base` 表示基础套餐的后台部分。
2. `--domain BK_DOMAIN`：指定蓝鲸的基础域名（下文也会使用 `BK_DOMAIN` 这个变量名指代）。

>**提示**
>
>当你的内网存在蓝鲸 V6 或更早版本的环境时，请勿复用基础域名。以免 Cookie 冲突，导致频繁提示登录，甚至循环提示登录。
>
>示例：当 V6 环境使用了 `bktencent.com` 时，其访问地址为 `paas.bktencent.com`。V7 环境不能使用 `bkce7.bktencent.com`、 `bktencent.com` 或者 `xx.bkce7.bktencent.com` 作为基础域名。

假设你用于部署蓝鲸的域名为 `bkce7.bktencent.com`，使用如下的命令开始部署:
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请修改为你分配给蓝鲸平台的主域名
cd ~/bkce7.1-install/blueking/  # 进入工作目录
# 检查域名是否符合k8s域名规范，要全部内容匹配才执行脚本，否则提示域名不符合。
patt_domain='[a-z0-9]([-a-z0-9]*[a-z0-9])(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*'
if grep -P "$patt_domain" <<< "$BK_DOMAIN"; then
  scripts/setup_bkce7.sh -i base --domain "$BK_DOMAIN"
else
  echo "BK_DOMAIN($BK_DOMAIN) does not match pattern($patt_domain)."
fi
```

视 CPU 性能及磁盘 IO 性能差异，脚本耗时 15 ~ 35 分钟，请耐心等待。部署成功会高亮提示如下：
``` plain
时间略 [INFO] finish install blueking base-backend
时间略 [INFO] SHOW BKPANEL & BKREPO INITIAL PASSWORD
 helm status -n blueking bk-user
 helm status -n blueking bk-repo
```

>**提示**
>
>**如果部署期间出错，请先查阅 《[问题案例](troubles.md)》文档。**
>
>问题解决后，可重新执行上面的命令。


<a id="manual-install-bkce" name="manual-install-bkce"></a>

## 手动部署基础套餐后台

因篇幅较大，此章节内容拆分到了《[部署步骤详解 —— 后台](manual-install-bkce.md)》文档。


<a id="config-dns" name="config-dns"></a>

# 配置 DNS
k8s 的网络拓扑结构比较复杂，当你从不同的网络区域访问时，需要使用不同的入口地址。

你需要完成如下全部场景的配置：
* k8s pod 内访问蓝鲸，需要配置 coredns。
* 在 k8s node 主机访问蓝鲸，需要配置 k8s node 的 DNS。
* 中控机调用蓝鲸接口，需要配置中控机的 DNS。
* 你在电脑上访问蓝鲸，需要配置用户侧的 DNS。

场景配置细节请查阅本章的各小节。

<a id="hosts-in-coredns" name="hosts-in-coredns"></a>

## 配置 coredns
我们需要确保 k8s 集群的 pod 能解析到蓝鲸域名。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

请继续补充配置如下域名，方便后续使用：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN $BK_DOMAIN
```

>**提示**
>
>“一键部署” 脚本中自动完成了部署时所需的部分域名，《[部署步骤详解 —— 后台](manual-install-bkce.md)》 文档的 “[配置 coredns](manual-install-bkce.md#hosts-in-coredns)” 章节保持和脚本一致。


<a id="hosts-in-k8s-node" name="hosts-in-k8s-node"></a>

## 配置 k8s node 的 DNS
k8s node 需要能从 bkrepo 中拉取镜像。因此需要配置 DNS 。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

请在 **中控机** 执行如下脚本 **生成 hosts 内容**，然后将其追加到所有的 `node` 的 `/etc/hosts` 文件结尾。

``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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
蓝鲸设计为需要通过域名访问使用。所以你需先配置所在内网的 DNS 系统，或修改本机 hosts 文件。然后才能在浏览器访问。

>**注意**
>
>如 k8s 集群重启等原因重新调度，pod 所在 node 发生了变动，需更新 hosts 文件。

你如何访问蓝鲸集群呢？请根据你的场景选择对应的命令获取 IP：
* 你和蓝鲸集群在同一个内网，使用 内网 IP 访问蓝鲸。
  1.  获取 ingress-nginx pod 所在机器的内网 IP，记为 IP1。在 **中控机** 执行如下命令可获取 IP1：
      ``` bash
      IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx \
        -o jsonpath='{.items[0].status.hostIP}')
      ```
* 蓝鲸集群部署在公网，使用 ingress-nginx pod 所在机器的 公网 IP 访问蓝鲸。
  1.  先在 **中控机** 执行如下命令获取 内网 IP：
      ``` bash
      IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx \
        -o jsonpath='{.items[0].status.hostIP}')
      ```
  2.  从中控机登录到 node 上查询公网 IP：
      ``` bash
      IP1=$(ssh "$IP1" 'curl -sSf ip.sb')
      ```
* 蓝鲸集群使用了负载均衡器（包括公网负载均衡）
  1.  需要手动指定负载均衡 IP：
      ``` bash
      IP1=负载均衡IP
      ```
  2.  在负载均衡器配置后端为 ingress-nginx pod 所在机器的内网 IP，端口为 80。

在 **中控机** 执行如下命令生成 hosts 文件的内容：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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
$IP1 lesscode.$BK_DOMAIN  # 可视化开发平台
$IP1 bk-apicheck.$BK_DOMAIN  # apicheck 测试工具
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
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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

本章节命令在 **中控机** 执行，请先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
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
3.  将新生成的 `daemon.json` 分发到全部 k8s node 上的 `/etc/docker/daemon.json`（如果各 node 配置文件路径不同，请自行分批操作。）：
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

<a id="paas-runtimes" name="paas-runtimes"></a>

## 推荐：上传 PaaS runtimes 到制品库
具体操作请查阅《[上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)》文档。

在如下场景下用到：
1. 目前蓝鲸官方 SaaS 包格式为 `image`，如需部署 `package` 格式的 `S-Mart` 包，需要使用到编译工具。
2. 用户通过 PaaS 自行开发 SaaS 时。


<a id="saas-node" name="saas-node"></a>

## 可选：配置 SaaS 专用 node
具体操作请查阅《[配置 SaaS 专用 node](saas-dedicated-node.md)》文档。

在资源充足的情况下，建议单独给 SaaS 分配单独的 `node`。因为 SaaS 部署时，编译会产生高 IO 和高 CPU 消耗。原生 k8s 集群的 io 隔离暂无方案，这样会影响到所在 `node` 的其他 `pod`。


<a id="install-saas" name="install-saas"></a>

# 部署基础套餐 SaaS
在前面部署蓝鲸后台时包含了 开发者中心、配置平台、作业平台 等平台和用户管理、权限中心两个 SaaS。

其他蓝鲸智云官方的 SaaS 应用，比如标准运维、流程服务等需要通过开发者中心来部署。
节点管理虽然实现了 Charts 化改造，无需在开发者中心部署。但存在较多的配置操作，故而依旧放在 SaaS 章节。

>**提示**
>
>部署时 开发者中心 会基于 S-Mart 安装包制作该 SaaS 的 docker 镜像并上传到 bkrepo。<br/>
>你在前面的步骤中已经配置过 DNS 及 docker 服务，期间如有新增 node，可查阅本文 “配置 k8s node 的 DNS” 和 “调整 node 上的 docker 服务” 章节补齐操作。

如同刚才部署后台一般，本章节也提供了 2 种等价的操作。你可按需选择其中一种：
* 我们提供的脚本可完成大部分操作，方便快捷，详见本文“一键部署基础套餐 SaaS” 章节。
* 如需研究 SaaS 部署的细节，请查阅《[部署步骤详解 —— SaaS](manual-install-saas.md)》文档。

<a id="setup_bkce7-i-saas" name="setup_bkce7-i-saas"></a>

## 一键部署基础套餐 SaaS
在 **中控机** 下载所需的文件。
``` bash
bkdl-7.1-stable.sh -ur latest saas  # 下载SaaS安装包及节点管理托管的常用文件
```
如果你计划管控多个云区域的主机，或者管控 32 位操作系统主机，请补充下载完整的待托管文件：
``` bash
bkdl-7.1-stable.sh -ur latest nm_gse_full  # 节点管理托管的全部文件
```

在 **中控机** 使用 “一键部署” 脚本部署基础套餐 SaaS 到生产环境。
部署节点管理：
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


>**注意**
>
>本脚本设计为全新安装 SaaS，如 SaaS 已安装会跳过，因此更新 SaaS 需在 开发者中心 上传 `S-Mart` 包并选择新版本部署。重新安装 SaaS 亦需手动操作。具体操作见《[部署步骤详解 —— SaaS](manual-install-saas.md)》文档。


## 手动部署基础套餐 SaaS
因篇幅较大，此章节内容拆分到了《[部署步骤详解 —— SaaS](manual-install-saas.md)》文档。


<a id="next" name="next"></a>

# 下一步
继续部署：
* [配置节点管理及安装 Agent](config-nodeman.md)
* 此时可以同时开始 [部署容器管理平台](install-bcs.md)

安装 Agent 后，可以 [启动蓝鲸 API 测试工具](run-apicheck.md)。

在部署期间，可以在文档中心查看产品文档。
