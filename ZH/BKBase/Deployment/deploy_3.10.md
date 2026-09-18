# 计算平台部署指引

## 适用范围

该文档仅适用于计算平台 3.10 版本

## 说明

1. 部署计算平台前，请确保已部署好蓝鲸社区版 7.1 版本（含基础套餐+容器管理平台+监控日志套餐），部署请参考 [蓝鲸 7.1 部署文档](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/index.md)

## 前置操作

### 软件包下载

TODO：补一下软件包获取方式

### 机器评估

> 初始资源配置默认仅供功能体验，生产环境请以实际为主。

- 部署计算平台套件需要 8 台 16C32G 的服务器。

- 容器化基础组件(开源组件如：MySQL 等)，需要 3 台 16C32G 服务器。

- 计算任务另计，视任务数量而定，各套件的资源需求如下：

| 组件名称 | CPU Limit | Memory Limit |
| --- | --- | --- |
| **基础组件 (容器化体验套件)**  | 36 | 72G |
| **bk-base-lite** | 62 | 100G|
| **bk-base-runner(含 AIOps)** | 16 | 26G |
| **bk-base-lake** | 40 | 78G |
| **bk-base-lab** | 10 | 21G |

- 机器配置（双栈推荐配置）

| 名称 | 版本 | 备注 |
| --- | --- | --- |
|**操作系统**|CentOS Linux release 7.9.2009|
| **kubelet** | 1.23.9 |  |
| **kubectl** | 1.23.9 |  |
| **docker** | 19.03.9 |  |

## 域名解析

- 配置 DNS 解析具体可参考蓝鲸文档（[蓝鲸 7.1 部署文档](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/install-bkce.md)）。
- 核心步骤已整理如下：

### 配置 CoreDNS 解析

```bash
# 进入工作目录
cd ~/bkce7.1-install/blueking
BK_DOMAIN=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq '.domain.bkDomain')
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')

./scripts/control_coredns.sh update "$IP1" bkbase-api.${BK_DOMAIN}
./scripts/control_coredns.sh list
```

### 配置本地 hosts 解析

```bash
BK_DOMAIN=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq '.domain.bkDomain')
INGRESS_HOST_IP=$(kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
INGRESS_WAN_IP=$(ssh $INGRESS_HOST_IP "curl -s ip.sb")

# 请将下述生成的内容，追加至本地的 hosts 文件，或者配置 DNS 解析
cat <<EOF
$INGRESS_WAN_IP jupyterhub.${BK_DOMAIN} queryengine.${BK_DOMAIN} langserver.${BK_DOMAIN}
EOF
```

## 开始部署

### 解压部署脚本

```bash
# 假设计算平台部署脚本已放置 /data 目录
tar xf /data/bkbase-helmfile-3.10.tar.gz -C /data
cd /data/bkbase-helmfile
```

### 生成配置

```bash
# 示例
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq '.domain.bkDomain')
IMAGEREGISTRY=$(yq ea '. as $item ireduce ({}; . * $item )' ~/bkce7.1-install/blueking/environments/default/{values,custom}.yaml | yq '.imageRegistry')

# 如管控的集群 kubeconfig 不在默认路径，请手动指定实际的 kubeconfig 路径
KUBERNETS_CONFIG="/root/.kube/config" 

cd /data/bkbase-helmfile/
bash ./scripts/auto_deploy.sh -g -d $BK_DOMAIN  -k $KUBERNETS_CONFIG -r $IMAGEREGISTRY

# 主要参数说明，其他可选参数说明 bash ./scripts/auto_deploy.sh -h 获取
-k 自定义 kubernetes config 路径
-r 定义 image registry
-d 指定域名
```

### 安装容器化的存储 (仅用于体验)

```bash
bash ./scripts/auto_deploy.sh --install storage
```

### 安装 bk-base-lite

```bash
bash ./scripts/auto_deploy.sh --install lite
```

### 安装 bk-base-runner

```bash
bash ./scripts/auto_deploy.sh --install runner
```

### 安装 bk-base-lake

```bash
bash ./scripts/auto_deploy.sh --install lake
```

### 安装 bk-base-lab

```bash
bash ./scripts/auto_deploy.sh --install lab
```

### 部署 SaaS

#### 上传 SaaS 安装包

```bash
# 确认获取到 SaaS 包与文件记录的是否一致
yq '.version.bkBaseDataweb' environments/default/version.yaml
```

#### 上传 SaaS 包

前往 PaaS 平台 -> 开发者中心 -> 创建应用 -> 普通应用 -> 选择 【S-mart 应用】部署，点击上传即可。

#### 添加环境变量

- 返回开发者中心首页，选择【计算平台】，在【应用引擎】-> 【环境配置】中配置变量下述变量，并将其选择应用到【所有环境】。

```bash
# 请以实际的域名为主，这里以蓝鲸基础环境的demo域名进行阐述
BK_DOMAIN=bkce7.bktencent.com

# 配置 langserver 环境变量,用来指向 langserver 服务的地址，格式为：ws://langserver.${BK_DOMAIN}/v3/langserver
BKAPP_LANG_SERVER_PROD_WS=ws://langserver.${BK_DOMAIN}/v3/langserver

# 配置 domain 环境变量，该环境变量主要用于读写国际化 cookie 的地址,请注意变量前面的点
BK_PLAT_DOMAIN=".$BK_DOMAIN" 

# 配置节点管理地址环境变量，指定节点管理跳转地址，注意以'/'结尾
BKAPP_BK_NODEMAN_HOST="bknodeman.$BK_DOMAIN/"

# 配置蓝鲸登录地址环境变量
BKAPP_LOGIN_OA_URL="http://${BK_DOMAIN}/login/"

# 计算平台运行环境变量，可选版本 bk-base-<lite | runner | lake | aiops >
# 该变量值如何确定：根据后台部署的模块来去确定，如：只部署了 helmfile_lite，那么该值为 bk-base-lite，依次类推变更该值。
# 这里假设部署了完整的计算平台套件
BKAPP_PLATFORM=bk-base-aiops
```

#### 开始部署 SaaS

【应用引擎】->【部署管理】-【生产环境】，选择对应的部署分支 (版本) 进行部署。

### 其余环境变量说明

```bash
BKAPP_BK_CC_HOST // 蓝鲸平台地址， 页面中点击 “申请权限地址” 会跳转的页面
SUPERSET_URL // SuperSet 的地址，SuperSet 通过内嵌 iframe 实现，此处即 iframe 指向的地址
GRAFANA_URL // Grafana 的地址，Grafana 通过内嵌 iframe 实现，此处即 iframe 指向的地址
STATIC_URL // 静态资源地址，用于前端静态资源的请求，
BKAPP_LOGIN_OA_URL // 登录、登出跳转地址
LANG_SERVER_PROD_WS // 生产环境数据查询 Language Server 地址，必须是 Websocket 链接地址
LANG_SERVER_DEV_WS // 开发环境数据查询 Language Server 地址，必须是 Websocket 链接地址
CE_SITE_URL // CE 平台跳转地址
MODELFLOW_URL // 管理模型的 HostUrl， 必须以 "/" 结尾， 比如 "https://xxxx.xxx.com/"
PLATFORM // 发布平台、版本， 不同的平台相关配置不同
BK_ITSM_HOST // ISTM 的 HostUrl, 必须以 "/" 结尾， 比如 "https://xxxx.xxx.com/"
BKAPP_USER_LIST_URL // [获取用户列表] API 地址透传, 完整的 url 地址，以 "/" 结尾
BKAPP_APIGATEWAY_BKDATA_API_URL // API Gateway 地址，完整的 url 地址， 以 "/" 结尾
BKAPP_ASSISTANT_ID // 企业微信助手号 ID, 用以直接拉起企业微信助手
BK_PLAT_DOMAIN // 该环境变量主要用于读写国际化 cookie 的地址，中心规定统一为二级域名，比如'a.b.c.com', 这里填写'.c.com'
BKAPP_BK_NODEMAN_HOST // 节点管理跳转地址，以'/'结尾
```
