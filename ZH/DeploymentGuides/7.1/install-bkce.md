
蓝鲸基础套餐的部署过程大致可以分为 5 个阶段：
1. 完善配置文件
2. 部署存储服务
3. 部署后台服务
4. 完善 SaaS 运行环境
5. 部署 SaaS：流程服务和标准运维

完成后就可以安装 GSE agent 开始使用了。

本文档为快速部署，旨在降低新用户初次部署的门槛。会使用固定的配置文件和内置的存储服务，其他步骤也会针对默认场景提供快速脚本。

如果希望了解部署详情，或者调整部署过程（例如使用已有的存储服务等），可以先从 《[基础套餐部署步骤详解 —— 自定义配置](custom-values.md)》 文档看起。

# 下载所需的资源文件

>**注意**
>
>请确保完成了《[准备中控机](prepare-bkctrl.md)》文档。

鉴于目前容器化的软件包数量较多且变动频繁，我们提供了下载脚本。

请在 **中控机** 使用如下命令下载文件。
``` bash
bkdl-7.1-stable.sh -ur latest base demo nm_gse_full saas scripts
```

这些文件默认放在了 `~/bkce7.1-install/` 目录，接下来的部署过程中，默认工作目录为 `~/bkce7.1-install/blueking/`。

# 快速部署蓝鲸基础套餐
## 可选：配置 docker registry 地址
如果你在内网提供了 registry，可以提前配置环境变量，指示部署脚本使用。

在中控机执行：
``` bash
export REGISTRY=代理IP:端口
```

注意：请提前在 **全部 k8s node** 上为 dockerd 配置 TLS 证书或者 `insecure-registries` 选项。

<a id="setup_bkce7-i-base" name="setup_bkce7-i-base"></a>

## 部署基础套餐后台
“一键脚本”指的是`scripts/setup_bkce7.sh`，我们把一些连续的安装步骤封装到了脚本中，以节约时间。

脚本需要填写如下参数：
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

## 更新 DNS
接下来的操作需要更新 coredns，并在中控机配置解析记录。

### 更新 coredns
我们需要确保 k8s 集群的 pod 能解析到蓝鲸域名。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需更新 hosts 文件。

请继续补充配置如下域名，方便后续使用：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN
```

<a id="hosts-in-bk-ctrl" name="hosts-in-bk-ctrl"></a>

### 配置中控机 DNS

请在中控机执行如下脚本更新 `/etc/hosts` 文件，可安全重复运行：
``` bash
./scripts/dns-helper.sh lan | ./scripts/update-hosts-file.sh /etc/hosts /etc/hosts
```

## 部署节点管理

### 部署 nodeman
执行如下命令部署 bk-nodeman release，给 admin 桌面添加应用，并上传 Agent 和插件包：
``` bash
scripts/setup_bkce7.sh -i nodeman
```
整个过程耗时 5 ~ 10 分钟。

## 准备 SaaS 运行环境

一共需要准备 3 项：
1. 确保 node 能拉取 SaaS 镜像
2. 推荐：上传 PaaS runtimes 到 bkrepo
3. 可选：配置 SaaS 专用 node

<a id="k8s-node-docker-insecure-registries" name="k8s-node-docker-insecure-registries"></a>

### 确保 node 能拉取 SaaS 镜像
在快速部署环节，我们假设全部 node 都可能用作 SaaS 运行环境。且默认使用 http 访问 bkrepo docker。

请提前在中控机配置 ssh 免密登录，然后执行如下脚本自动修改 dockerd 配置，添加制品库 docker 服务的域名解析及 insecure-registries 配置项：
``` bash
scripts/docker-insecure.sh
```

>**提示**
>
>如果希望了解具体的配置步骤，请查阅部署详解里的 《[确保 node 能拉取 SaaS 镜像](saas-node-pull-images.md)》 文档。

<a id="paas-runtimes" name="paas-runtimes"></a>

### 推荐：上传 PaaS runtimes 到制品库
具体操作请查阅《[上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)》文档。

在如下场景下用到：
1. 目前蓝鲸官方 SaaS 包格式为 `image`，如需部署 `package` 格式的 `S-Mart` 包，需要使用到编译工具。
2. 用户通过 PaaS 自行开发 SaaS 时。


<a id="saas-node" name="saas-node"></a>

### 可选：配置 SaaS 专用 node
具体操作请查阅《[配置 SaaS 专用 node](saas-dedicated-node.md)》文档。

在资源充足的情况下，建议单独给 SaaS 分配单独的 `node`。因为 SaaS 部署时，编译会产生高 IO 和高 CPU 消耗，而原生 k8s 集群暂无 IO 隔离方案，会影响到所在 `node` 的其他 `pod`。


<a id="install-saas" name="install-saas"></a>
<a id="setup_bkce7-i-saas" name="setup_bkce7-i-saas"></a>

## 部署基础套餐 SaaS
部署蓝鲸智云官方的 SaaS 应用：流程服务 和 标准运维。

>**提示**
>
>你也可以跟随 《[部署步骤详解 —— SaaS](manual-install-saas.md)》文档，在浏览器中访问开发者中心部署这些 SaaS。

每个 SaaS 部署不超过 10 分钟，如果遇到问题请先查阅 《[问题案例](troubles.md)》文档。

>**注意**
>
>本脚本设计为全新安装 SaaS，如 SaaS 已安装，会自动跳过。你可以给脚本加上 `-f` 参数强制重新安装，例如重新安装流程服务： `scripts/setup_bkce7.sh -i itsm -f`。

### 部署流程服务
执行如下命令即可：
``` bash
scripts/setup_bkce7.sh -i itsm
```
### 部署标准运维
执行如下命令即可：
``` bash
scripts/setup_bkce7.sh -i sops
```

# 访问蓝鲸

## 配置本地 pc 的 hosts 文件
你从哪访问蓝鲸，就需要确保对应设备可以解析蓝鲸域名。最快捷的办法就是修改 hosts 文件。

更多复杂场景，可以阅读《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

### 在中控机生成 hosts 文件内容
请参考连接方式在中控机执行脚本，获取 hosts 内容。
* 当你能直接访问到 ingress-nginx 的内网 IP 时，使用如下参数生成 hosts 文件：
``` bash
./scripts/dns-helper.sh lan
```
* 当你从公网访问，或者办公区到机房有统一的访问网关时，需要指定 IP：
``` bash
./scripts/dns-helper.sh ingress-nginx的公网IP或者代理IP
```

### 在 pc 上修改 hosts 文件
请在本地 pc 上以管理员权限打开 hosts 文件，粘贴上面生成的内容。

具体操作可自行搜索 “`hosts文件怎么修改`”。

>**注意**
>
>当保存 hosts 文件后，如果浏览器访问提示 无法解析域名（Chrome 浏览器提示的错误码： `dns_probe_finished_nxdomain`)，请刷新本地 DNS 缓存，具体操作请自行搜索 “`刷新dns缓存命令`”。


## 浏览器访问
在 **中控机** 执行如下命令获取访问地址及登录信息：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
echo "访问地址： http://$BK_DOMAIN  （如浏览器报错 NXDOMAIN，请配置hosts）"; \
kubectl get cm -n blueking bk-user-api-general-envs -o go-template='用户： {{.data.INITIAL_ADMIN_USERNAME}}{{"\n"}}密码： {{ .data.INITIAL_ADMIN_PASSWORD }}{{"\n"}}'
```
浏览器访问上述地址即可。


<a id="next" name="next"></a>

# 下一步
继续部署：
* [配置节点管理及安装 Agent](config-nodeman.md)
* 此时可以同时开始 [部署容器管理平台](install-bcs.md)

安装 Agent 后，可以 [启动蓝鲸 API 测试工具](run-apicheck.md)。

在部署期间，可以在文档中心查看产品文档。
